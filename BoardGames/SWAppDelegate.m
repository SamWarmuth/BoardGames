//
//  SWAppDelegate.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWAppDelegate.h"
#import "SWTVBoardViewController.h"

@implementation SWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow    *newWindow    = nil;
    NSArray     *_screens   = nil;
    
    self.windows = [[NSMutableArray alloc] init];
    
    _screens = [UIScreen screens];
    for (UIScreen *screen in _screens){
        if (screen == [UIScreen mainScreen]){
            [newWindow makeKeyAndVisible];
            continue;
        }

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        SWTVBoardViewController *boardViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWTVBoardViewController"];
        NSLog(@"aaa%@", NSStringFromCGRect([screen bounds]));
        boardViewController.view.frame = [screen bounds];
        newWindow = [self createWindowForScreen:screen];
        [self addViewController:boardViewController toWindow:newWindow];
        
        // If you don't do this here, you will get the "Applications are expected to have a root view controller" message.

        
    }
    
    // Register for notification
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(screenDidConnect:)
												 name:UIScreenDidConnectNotification
											   object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(screenDidDisconnect:)
												 name:UIScreenDidDisconnectNotification
											   object:nil];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Unregister for notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidConnectNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidDisconnectNotification object:nil];
}


#pragma mark -
#pragma mark Private methods

- (UIWindow *) createWindowForScreen:(UIScreen *)screen {
    UIWindow    *newWindow    = nil;
    
    // Do we already have a window for this screen?
    for (UIWindow *window in self.windows){
        if (window.screen == screen){
            newWindow = window;
        }
    }
    // Still nil? Create a new one.
    if (newWindow == nil){
        newWindow = [[UIWindow alloc] initWithFrame:[screen bounds]];
        [newWindow setScreen:screen];
        [self.windows addObject:newWindow];
    }
    
    return newWindow;
}

- (void) addViewController:(UIViewController *)controller toWindow:(UIWindow *)window {
    [window setRootViewController:controller];
    [window setHidden:NO];
}

- (void) screenDidConnect:(NSNotification *) notification {
    UIWindow                    *newWindow            = nil;
    
    
    NSLog(@"Screen connected");
    UIScreen *screen = [notification object];
    
    if (screen == [UIScreen mainScreen]){
        [newWindow makeKeyAndVisible];
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    SWTVBoardViewController *boardViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWTVBoardViewController"];
    NSLog(@"aaa%@", NSStringFromCGRect([screen bounds]));
    boardViewController.view.frame = [screen bounds];
    newWindow = [self createWindowForScreen:screen];
    [self addViewController:boardViewController toWindow:newWindow];
}

- (void) screenDidDisconnect:(NSNotification *) notification {
    UIScreen    *_screen    = nil;
    
    NSLog(@"Screen disconnected");
    _screen = [notification object];
    
    // Find any window attached to this screen, remove it from our window list, and release it.
    for (UIWindow *newWindow in self.windows){
        if (newWindow.screen == _screen){
            NSUInteger windowIndex = [self.windows indexOfObject:newWindow];
            [self.windows removeObjectAtIndex:windowIndex];
        }
    }
    return;
}

@end
