//
//  SWPlayer.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPlayer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIView *token;
@property NSInteger currentSquareIndex;

+ (SWPlayer *)playerWithName:(NSString *)name;

@end
