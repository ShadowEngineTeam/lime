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
// On iOS the game loop is driven by a CADisplayLink (SDL_SetiOSAnimationCallback), and the
// message box is requested from inside that callback. Presenting an alert + spinning a nested
// run loop (UIKit_WaitUntilMessageBoxClosed) from that context does NOT deliver the alert's
// touch events on iOS < 26 -- the box appears but its buttons are frozen, locking the app.
//
// So on iOS < 26 we present WITHOUT blocking: build the alert now (copying everything out of
// messageboxdata, which the caller may free once we return), pause the game loop via
// s_showingMessageBox (doLoop honors UIKit_ShowingMessageBox()), and present on a later main
// run-loop iteration -- outside the display-link call stack -- so the alert receives touches
// normally. The result is reported as the default action since we cannot wait for the choice.
static bool UIKit_ShowMessageBoxAsync(const SDL_MessageBoxData *messageboxdata, int *buttonID)
{
    if (![UIAlertController class]) {
        return false;
    }

    // Report the default action up front; messageboxdata may be gone after we return.
    if (buttonID) {
        *buttonID = (messageboxdata->numbuttons > 0) ? messageboxdata->buttons[0].buttonID : 0;
        for (int i = 0; i < messageboxdata->numbuttons; i++) {
            if (messageboxdata->buttons[i].flags & (SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT | SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT)) {
                *buttonID = messageboxdata->buttons[i].buttonID;
                break;
            }
        }
    }

    // Resolve (or create) the presenting window now, while messageboxdata is still valid.
    UIWindow *window = nil;
    if (messageboxdata->window) {
        SDL_UIKitWindowData *data = (__bridge SDL_UIKitWindowData *)messageboxdata->window->internal;
        window = data.uiwindow;
    }

    __block UIWindow *alertwindow = nil;
    if (window == nil || window.rootViewController == nil) {
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
        window = alertwindow;
        [alertwindow makeKeyAndVisible];
    }

    // Build the alert, copying all strings/values out of messageboxdata.
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
                                     // The alert dismisses itself; resume the game loop and
                                     // drop the temporary alert window if we created one.
                                     s_showingMessageBox = false;
                                     if (alertwindow) {
                                         alertwindow.hidden = YES;
                                         alertwindow = nil;
                                     }
                                   }];
        [alert addAction:action];

        if (sdlButton->flags & SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT) {
            alert.preferredAction = action;
        }
    }

    UIViewController *presenter = window.rootViewController;

    // Only pause the loop if the alert can actually be dismissed (a button clears the flag).
    if (messageboxdata->numbuttons > 0) {
        s_showingMessageBox = true;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [presenter presentViewController:alert animated:NO completion:nil];
    });

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
