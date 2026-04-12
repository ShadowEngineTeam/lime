/*
  Simple DirectMedia Layer
  Copyright (C) 1997-2026 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/
#include "SDL_internal.h"

#ifdef SDL_PROCESS_POSIX

#include <dirent.h>
#include <fcntl.h>
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

#include "../SDL_sysprocess.h"
#include "../../io/SDL_iostream_c.h"

#define READ_END 0
#define WRITE_END 1

struct SDL_ProcessData {
    pid_t pid;
};

static void CleanupStream(void *userdata, void *value)
{
    SDL_Process *process = (SDL_Process *)value;
    const char *property = (const char *)userdata;

    SDL_ClearProperty(process->props, property);
}

static bool SetupStream(SDL_Process *process, int fd, const char *mode, const char *property)
{
    // Set the file descriptor to non-blocking mode
    fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK);

    SDL_IOStream *io = SDL_IOFromFD(fd, true);
    if (!io) {
        return false;
    }

    SDL_SetPointerPropertyWithCleanup(SDL_GetIOProperties(io), "SDL.internal.process", process, CleanupStream, (void *)property);
    SDL_SetPointerProperty(process->props, property, io);
    return true;
}

static void IgnoreSignal(int sig)
{
    struct sigaction action;

    sigaction(SIGPIPE, NULL, &action);
#ifdef HAVE_SA_SIGACTION
    if (action.sa_handler == SIG_DFL && (void (*)(int))action.sa_sigaction == SIG_DFL) {
#else
    if (action.sa_handler == SIG_DFL) {
#endif
        action.sa_handler = SIG_IGN;
        sigaction(sig, &action, NULL);
    }
}

static bool CreatePipe(int fds[2])
{
    if (pipe(fds) < 0) {
        return false;
    }

    // Make sure the pipe isn't accidentally inherited by another thread creating a process
    fcntl(fds[READ_END], F_SETFD, fcntl(fds[READ_END], F_GETFD) | FD_CLOEXEC);
    fcntl(fds[WRITE_END], F_SETFD, fcntl(fds[WRITE_END], F_GETFD) | FD_CLOEXEC);

    // Make sure we don't crash if we write when the pipe is closed
    IgnoreSignal(SIGPIPE);

    return true;
}

static bool GetStreamFD(SDL_PropertiesID props, const char *property, int *result)
{
    SDL_IOStream *io = (SDL_IOStream *)SDL_GetPointerProperty(props, property, NULL);
    if (!io) {
        SDL_SetError("%s is not set", property);
        return false;
    }

    int fd = (int)SDL_GetNumberProperty(SDL_GetIOProperties(io), SDL_PROP_IOSTREAM_FILE_DESCRIPTOR_NUMBER, -1);
    if (fd < 0) {
        SDL_SetError("%s doesn't have SDL_PROP_IOSTREAM_FILE_DESCRIPTOR_NUMBER available", property);
        return false;
    }

    *result = fd;
    return true;
}

// Helper to close unused file descriptors in the child process
static void CloseUnusedFileDescriptors(void)
{
    int maxfd = (int)sysconf(_SC_OPEN_MAX);
    for (int fd = STDERR_FILENO + 1; fd < maxfd; ++fd) {
        int flags = fcntl(fd, F_GETFD);
        if (flags < 0) {
            continue;
        }
        // Close if not already CLOEXEC
        if (!(flags & FD_CLOEXEC)) {
            close(fd);
        }
    }
}

bool SDL_SYS_CreateProcessWithProperties(SDL_Process *process, SDL_PropertiesID props)
{
    char * const *args = SDL_GetPointerProperty(props, SDL_PROP_PROCESS_CREATE_ARGS_POINTER, NULL);
    SDL_Environment *env = SDL_GetPointerProperty(props, SDL_PROP_PROCESS_CREATE_ENVIRONMENT_POINTER, SDL_GetEnvironment());
    char **envp = NULL;
    const char *working_directory = SDL_GetStringProperty(props, SDL_PROP_PROCESS_CREATE_WORKING_DIRECTORY_STRING, NULL);
    SDL_ProcessIO stdin_option = (SDL_ProcessIO)SDL_GetNumberProperty(props, SDL_PROP_PROCESS_CREATE_STDIN_NUMBER, SDL_PROCESS_STDIO_NULL);
    SDL_ProcessIO stdout_option = (SDL_ProcessIO)SDL_GetNumberProperty(props, SDL_PROP_PROCESS_CREATE_STDOUT_NUMBER, SDL_PROCESS_STDIO_INHERITED);
    SDL_ProcessIO stderr_option = (SDL_ProcessIO)SDL_GetNumberProperty(props, SDL_PROP_PROCESS_CREATE_STDERR_NUMBER, SDL_PROCESS_STDIO_INHERITED);
    bool redirect_stderr = SDL_GetBooleanProperty(props, SDL_PROP_PROCESS_CREATE_STDERR_TO_STDOUT_BOOLEAN, false) &&
                           !SDL_HasProperty(props, SDL_PROP_PROCESS_CREATE_STDERR_NUMBER);
    int stdin_pipe[2] = { -1, -1 };
    int stdout_pipe[2] = { -1, -1 };
    int stderr_pipe[2] = { -1, -1 };
    int fd = -1;

    // Keep the malloc() before exec() so that an OOM won't run a process at all
    envp = SDL_GetEnvironmentVariables(env);
    if (!envp) {
        return false;
    }

    SDL_ProcessData *data = SDL_calloc(1, sizeof(*data));
    if (!data) {
        SDL_free(envp);
        return false;
    }
    process->internal = data;

    // Background processes don't have access to the terminal
    if (process->background) {
        if (stdin_option == SDL_PROCESS_STDIO_INHERITED) {
            stdin_option = SDL_PROCESS_STDIO_NULL;
        }
        if (stdout_option == SDL_PROCESS_STDIO_INHERITED) {
            stdout_option = SDL_PROCESS_STDIO_NULL;
        }
        if (stderr_option == SDL_PROCESS_STDIO_INHERITED) {
            stderr_option = SDL_PROCESS_STDIO_NULL;
        }
    }

    // Create pipes if needed
    if (stdin_option == SDL_PROCESS_STDIO_APP) {
        if (!CreatePipe(stdin_pipe)) {
            goto fail;
        }
    }
    if (stdout_option == SDL_PROCESS_STDIO_APP) {
        if (!CreatePipe(stdout_pipe)) {
            goto fail;
        }
    }
    if (stderr_option == SDL_PROCESS_STDIO_APP) {
        if (!CreatePipe(stderr_pipe)) {
            goto fail;
        }
    }

    // Fork the process
    pid_t pid = fork();
    if (pid < 0) {
        SDL_SetError("fork() failed: %s", strerror(errno));
        goto fail;
    }

    if (pid == 0) {
        // Child Process
        if (process->background) {
            setsid();
        }

        // Change working directory if specified
        if (working_directory) {
            if (chdir(working_directory) != 0) {
                _exit(127);
            }
        }

        // Close unused file descriptors
        CloseUnusedFileDescriptors();

        // Setup stdin
        switch (stdin_option) {
        case SDL_PROCESS_STDIO_REDIRECT:
            if (!GetStreamFD(props, SDL_PROP_PROCESS_CREATE_STDIN_POINTER, &fd)) {
                _exit(127);
            }
            if (dup2(fd, STDIN_FILENO) < 0) {
                _exit(127);
            }
            break;
        case SDL_PROCESS_STDIO_APP:
            if (dup2(stdin_pipe[READ_END], STDIN_FILENO) < 0) {
                _exit(127);
            }
            break;
        case SDL_PROCESS_STDIO_NULL:
            if (open("/dev/null", O_RDONLY) != STDIN_FILENO) {
                _exit(127);
            }
            break;
        default:
            break;
        }

        // Setup stdout
        switch (stdout_option) {
        case SDL_PROCESS_STDIO_REDIRECT:
            if (!GetStreamFD(props, SDL_PROP_PROCESS_CREATE_STDOUT_POINTER, &fd)) {
                _exit(127);
            }
            if (dup2(fd, STDOUT_FILENO) < 0) {
                _exit(127);
            }
            break;
        case SDL_PROCESS_STDIO_APP:
            if (dup2(stdout_pipe[WRITE_END], STDOUT_FILENO) < 0) {
                _exit(127);
            }
            break;
        case SDL_PROCESS_STDIO_NULL:
            if (open("/dev/null", O_WRONLY) != STDOUT_FILENO) {
                _exit(127);
            }
            break;
        default:
            break;
        }

        // Setup stderr
        if (redirect_stderr) {
            if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
                _exit(127);
            }
        } else {
            switch (stderr_option) {
            case SDL_PROCESS_STDIO_REDIRECT:
                if (!GetStreamFD(props, SDL_PROP_PROCESS_CREATE_STDERR_POINTER, &fd)) {
                    _exit(127);
                }
                if (dup2(fd, STDERR_FILENO) < 0) {
                    _exit(127);
                }
                break;
            case SDL_PROCESS_STDIO_APP:
                if (dup2(stderr_pipe[WRITE_END], STDERR_FILENO) < 0) {
                    _exit(127);
                }
                break;
            case SDL_PROCESS_STDIO_NULL:
                if (open("/dev/null", O_WRONLY) != STDERR_FILENO) {
                    _exit(127);
                }
                break;
            default:
                break;
            }
        }

        // Close pipe ends in child
        if (stdin_option == SDL_PROCESS_STDIO_APP) {
            close(stdin_pipe[READ_END]);
        }
        if (stdout_option == SDL_PROCESS_STDIO_APP) {
            close(stdout_pipe[WRITE_END]);
        }
        if (stderr_option == SDL_PROCESS_STDIO_APP) {
            close(stderr_pipe[WRITE_END]);
        }

        // Execute
        execvp(args[0], args);
        _exit(127); // exec failed
    }

    // Parent Process
    data->pid = pid;
    SDL_SetNumberProperty(process->props, SDL_PROP_PROCESS_PID_NUMBER, data->pid);

    // Close pipe ends in parent
    if (stdin_option == SDL_PROCESS_STDIO_APP) {
        close(stdin_pipe[READ_END]);
        if (!SetupStream(process, stdin_pipe[WRITE_END], "wb", SDL_PROP_PROCESS_STDIN_POINTER)) {
            close(stdin_pipe[WRITE_END]);
        }
    }

    if (stdout_option == SDL_PROCESS_STDIO_APP) {
        close(stdout_pipe[WRITE_END]);
        if (!SetupStream(process, stdout_pipe[READ_END], "rb", SDL_PROP_PROCESS_STDOUT_POINTER)) {
            close(stdout_pipe[READ_END]);
        }
    }

    if (stderr_option == SDL_PROCESS_STDIO_APP) {
        close(stderr_pipe[WRITE_END]);
        if (!SetupStream(process, stderr_pipe[READ_END], "rb", SDL_PROP_PROCESS_STDERR_POINTER)) {
            close(stderr_pipe[READ_END]);
        }
    }

    SDL_free(envp);
    return true;

fail:
    if (stdin_pipe[READ_END] >= 0) {
        close(stdin_pipe[READ_END]);
    }
    if (stdin_pipe[WRITE_END] >= 0) {
        close(stdin_pipe[WRITE_END]);
    }
    if (stdout_pipe[READ_END] >= 0) {
        close(stdout_pipe[READ_END]);
    }
    if (stdout_pipe[WRITE_END] >= 0) {
        close(stdout_pipe[WRITE_END]);
    }
    if (stderr_pipe[READ_END] >= 0) {
        close(stderr_pipe[READ_END]);
    }
    if (stderr_pipe[WRITE_END] >= 0) {
        close(stderr_pipe[WRITE_END]);
    }
    SDL_free(envp);
    return false;
}

bool SDL_SYS_KillProcess(SDL_Process *process, bool force)
{
    int ret = kill(process->internal->pid, force ? SIGKILL : SIGTERM);
    if (ret == 0) {
        return true;
    } else {
        return SDL_SetError("Could not kill(): %s", strerror(errno));
    }
}

bool SDL_SYS_WaitProcess(SDL_Process *process, bool block, int *exitcode)
{
    int wstatus = 0;
    int ret;
    pid_t pid = process->internal->pid;

    if (process->background) {
        // We can't wait on the status, so we'll poll to see if it's alive
        if (block) {
            while (kill(pid, 0) == 0) {
                SDL_Delay(10);
            }
        } else {
            if (kill(pid, 0) == 0) {
                return false;
            }
        }
        *exitcode = 0;
        return true;
    } else {
        ret = waitpid(pid, &wstatus, block ? 0 : WNOHANG);
        if (ret < 0) {
            return SDL_SetError("Could not waitpid(): %s", strerror(errno));
        }

        if (ret == 0) {
            SDL_ClearError();
            return false;
        }

        if (WIFEXITED(wstatus)) {
            *exitcode = WEXITSTATUS(wstatus);
        } else if (WIFSIGNALED(wstatus)) {
            *exitcode = -WTERMSIG(wstatus);
        } else {
            *exitcode = -255;
        }

        return true;
    }
}

void SDL_SYS_DestroyProcess(SDL_Process *process)
{
    SDL_IOStream *io;

    io = (SDL_IOStream *)SDL_GetPointerProperty(process->props, SDL_PROP_PROCESS_STDIN_POINTER, NULL);
    if (io) {
        SDL_CloseIO(io);
    }

    io = (SDL_IOStream *)SDL_GetPointerProperty(process->props, SDL_PROP_PROCESS_STDOUT_POINTER, NULL);
    if (io) {
        SDL_CloseIO(io);
    }

    io = (SDL_IOStream *)SDL_GetPointerProperty(process->props, SDL_PROP_PROCESS_STDERR_POINTER, NULL);
    if (io) {
        SDL_CloseIO(io);
    }

    SDL_free(process->internal);
}

#endif // SDL_PROCESS_POSIX
