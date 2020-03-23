#include "../util.hpp"
#include "../logger.hpp"

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate> {
}
- (void)applicationDidFinishLaunching:(NSNotification *)notification;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app;
@end

void stopApplication(void) {
    [[NSApplication sharedApplication] stop:nil];
}

@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"NO"];
    [alert addButtonWithTitle:@"YES"];
    [alert setMessageText:@"An error occurred which has caused Streamlabs OBS to close. Don't worry! If you were streaming or recording, that is still happening in the background.\
    \n\nWhenever you're ready, we can relaunch the application, however this will end your stream / recording session.\
    \n\nClick the Yes button to keep streaming / recording.\
    \n\nClick the No button to stop streaming / recording."];
    [alert setAlertStyle:NSAlertStyleCritical];

    NSModalResponse response = [alert runModal];

    if (response == NSAlertFirstButtonReturn) {
        stopApplication();
    } else if (response == NSAlertSecondButtonReturn) {
        NSAlert *alert2 = [[NSAlert alloc] init];
        [alert2 addButtonWithTitle:@"OK"];
        [alert2 setMessageText:@"Your stream / recording session is still running in the background. Whenever you're ready, click the OK button below to end your stream / recording and relaunch the application."];
        [alert2 setAlertStyle:NSAlertStyleCritical];

        if ([alert2 runModal] == NSAlertFirstButtonReturn) {
            stopApplication();
        }
    }
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    return NO;
}
@end

void Util::runTerminateWindow(void) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *del = [[AppDelegate alloc] init];
        app.delegate = del;
        [app run];
    }
}