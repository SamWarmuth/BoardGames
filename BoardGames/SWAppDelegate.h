//
//  SWAppDelegate.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTVBoardViewController.h"
@interface SWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) NSMutableArray *windows;
@property (strong, nonatomic) UIWindow *window;

- (UIWindow *)createWindowForScreen:(UIScreen *)screen;
- (void)addViewController:(UIViewController *)controller toWindow:(UIWindow *)window;
- (void)screenDidConnect:(NSNotification *) notification;
- (void)screenDidDisconnect:(NSNotification *) notification;

- (BOOL)externalDisplayConnected;
@end
