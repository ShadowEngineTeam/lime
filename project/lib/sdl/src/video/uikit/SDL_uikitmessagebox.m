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

#ifdef SDL_VIDEO_DRIVER_UIKIT

#include "SDL_uikitvideo.h"
#include "SDL_uikitwindow.h"

// Display a UIKit message box

static bool s_showingMessageBox = false;

bool UIKit_ShowingMessageBox(void)
{
    return s_showingMessageBox;
}

static void UIKit_WaitUntilMessageBoxClosed(const SDL_MessageBoxData *messageboxdata, int *clickedindex)
{
    *clickedindex = messageboxdata->numbuttons;

    @autoreleasepool {
        // Run the main event loop until the alert has finished
        // Note that this needs to be done on the main thread
        s_showingMessageBox = true;
        while ((*clickedindex) == messageboxdata->numbuttons) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        s_showingMessageBox = false;
    }
}

static BOOL UIKit_ShowMessageBoxAlertController(const SDL_MessageBoxData *messageboxdata, int *buttonID)
{
    int i;
    int __block clickedindex = messageboxdata->numbuttons;
    UIWindow *window = nil;
    UIWindow *alertwindow = nil;

    if (![UIAlertController class]) {
        return NO;
    }

    UIAlertController *alert;
    alert = [UIAlertController alertControllerWithTitle:@(messageboxdata->title)
                                                message:@(messageboxdata->message)
                                         preferredStyle:UIAlertControllerStyleAlert];

    for (i = 0; i < messageboxdata->numbuttons; i++) {
        UIAlertAction *action;
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        const SDL_MessageBoxButtonData *sdlButton;

        if (messageboxdata->flags & SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT) {
            sdlButton = &messageboxdata->buttons[messageboxdata->numbuttons - 1 - i];
        } else {
            sdlButton = &messageboxdata->buttons[i];
        }

        if (sdlButton->flags & SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT) {
            style = UIAlertActionStyleCancel;
        }

        action = [UIAlertAction actionWithTitle:@(sdlButton->text)
                                          style:style
                                        handler:^(UIAlertAction *alertAction) {
                                          clickedindex = (int)(sdlButton - messageboxdata->buttons);
                                        }];
        [alert addAction:action];

        if (sdlButton->flags & SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT) {
            alert.preferredAction = action;
        }
    }

    if (messageboxdata->window) {
        SDL_UIKitWindowData *data = (__bridge SDL_UIKitWindowData *)messageboxdata->window->internal;
        window = data.uiwindow;
    }

    if (window == nil || window.rootViewController == nil) {
        if (@available(iOS 13.0, tvOS 13.0, *)) {
            UIWindowScene *scene = UIKit_GetActiveWindowScene();
            if (scene) {
                alertwindow = [[UIWindow alloc] initWithWindowScene:scene];
            }
        }
        if (!alertwindow) {
#ifdef SDL_PLATFORM_VISIONOS
            alertwindow = [[UIWindow alloc] init];
#else
            alertwindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
#endif
        }
        alertwindow.rootViewController = [UIViewController new];
        alertwindow.windowLevel = UIWindowLevelAlert;

        window = alertwindow;

        [alertwindow makeKeyAndVisible];
    }

    [window.rootViewController presentViewController:alert animated:YES completion:nil];
    UIKit_WaitUntilMessageBoxClosed(messageboxdata, &clickedindex);

    if (alertwindow) {
        alertwindow.hidden = YES;
    }

    UIKit_ForceUpdateHomeIndicator();

    *buttonID = messageboxdata->buttons[clickedindex].buttonID;
    return YES;
}

typedef struct UIKit_ShowMessageBoxData
{
    const SDL_MessageBoxData *messageboxdata;
    int *buttonID;
    bool result;
} UIKit_ShowMessageBoxData;

static void SDLCALL UIKit_ShowMessageBoxMainThreadCallback(void *userdata)
{
    @autoreleasepool {
        UIKit_ShowMessageBoxData *data = (UIKit_ShowMessageBoxData *) userdata;
        data->result = UIKit_ShowMessageBoxAlertController(data->messageboxdata, data->buttonID);
    }
}

#ifdef SDL_PLATFORM_IOS
static UIWindow *s_asyncAlertWindow = nil;

static int UIKit_DefaultButtonID(const SDL_MessageBoxData *messageboxdata)
{
    int result = (messageboxdata->numbuttons > 0) ? messageboxdata->buttons[0].buttonID : 0;
    for (int i = 0; i < messageboxdata->numbuttons; i++) {
        if (messageboxdata->buttons[i].flags & (SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT | SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT)) {
            result = messageboxdata->buttons[i].buttonID;
            break;
        }
    }
    return result;
}

static void SDLCALL UIKit_ShowMessageBoxAsyncMainThreadCallback(void *userdata)
{
    @autoreleasepool {
        UIKit_ShowMessageBoxData *data = (UIKit_ShowMessageBoxData *)userdata;
        const SDL_MessageBoxData *messageboxdata = data->messageboxdata;

        data->result = false;

        if (![UIAlertController class] || s_showingMessageBox || messageboxdata->numbuttons <= 0) {
            return;
        }

        UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@(messageboxdata->title)
                                                message:@(messageboxdata->message)
                                         preferredStyle:UIAlertControllerStyleAlert];

        for (int i = 0; i < messageboxdata->numbuttons; i++) {
            const SDL_MessageBoxButtonData *sdlButton;
            UIAlertActionStyle style = UIAlertActionStyleDefault;

            if (messageboxdata->flags & SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT) {
                sdlButton = &messageboxdata->buttons[messageboxdata->numbuttons - 1 - i];
            } else {
                sdlButton = &messageboxdata->buttons[i];
            }

            if (sdlButton->flags & SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT) {
                style = UIAlertActionStyleCancel;
            }

            UIAlertAction *action =
                [UIAlertAction actionWithTitle:@(sdlButton->text)
                                         style:style
                                       handler:^(UIAlertAction *alertAction) {
                                         // Resume the game loop and drop the alert window.
                                         s_showingMessageBox = false;
                                         s_asyncAlertWindow.hidden = YES;
                                         s_asyncAlertWindow = nil;
                                         UIKit_ForceUpdateHomeIndicator();
                                       }];
            [alert addAction:action];

            if (sdlButton->flags & SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT) {
                alert.preferredAction = action;
            }
        }

        UIWindow *alertwindow = nil;
        if (@available(iOS 13.0, *)) {
            UIWindowScene *scene = UIKit_GetActiveWindowScene();
            if (scene) {
                alertwindow = [[UIWindow alloc] initWithWindowScene:scene];
            }
        }
        if (!alertwindow) {
            alertwindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        alertwindow.rootViewController = [UIViewController new];
        alertwindow.windowLevel = UIWindowLevelAlert;
        s_asyncAlertWindow = alertwindow;

        // Pause the animation callback; the button handler (or a failed present) resumes it.
        s_showingMessageBox = true;

        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow *w = s_asyncAlertWindow;
            if (w == nil || w.rootViewController == nil) {
                s_showingMessageBox = false;
                return;
            }
            [w makeKeyAndVisible];
            [w.rootViewController presentViewController:alert animated:YES completion:nil];
        });

        data->result = true;
    }
}

static bool UIKit_ShowMessageBoxAsync(const SDL_MessageBoxData *messageboxdata, int *buttonID)
{
    UIKit_ShowMessageBoxData data = { messageboxdata, buttonID, false };

    if (buttonID) {
        *buttonID = UIKit_DefaultButtonID(messageboxdata);
    }

    if (!SDL_RunOnMainThread(UIKit_ShowMessageBoxAsyncMainThreadCallback, &data, true)) {
        return false;
    }
    if (!data.result) {
        return SDL_SetError("Could not show message box.");
    }
    return true;
}

bool UIKit_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonID)
{
    // iOS 26's run loop tolerates the blocking nested-run-loop path; older iOS freezes on it.
    if (@available(iOS 26.0, *)) {
        UIKit_ShowMessageBoxData data = { messageboxdata, buttonID, false };
        if (!SDL_RunOnMainThread(UIKit_ShowMessageBoxMainThreadCallback, &data, true)) {
            return false;
        } else if (!data.result) {
            return SDL_SetError("Could not show message box.");
        }
        return true;
    }
    return UIKit_ShowMessageBoxAsync(messageboxdata, buttonID);
}
#else
bool UIKit_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonID)
{
    UIKit_ShowMessageBoxData data = { messageboxdata, buttonID, false };
    if (!SDL_RunOnMainThread(UIKit_ShowMessageBoxMainThreadCallback, &data, true)) {
        return false;
    } else if (!data.result) {
        return SDL_SetError("Could not show message box.");
    }
    return true;
}
#endif

#endif // SDL_VIDEO_DRIVER_UIKIT
