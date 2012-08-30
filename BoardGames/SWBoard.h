//
//  SWBoard.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWBoardSquare.h"

@interface SWBoard : NSObject

@property (nonatomic, strong) UIImage *boardImage;
@property (nonatomic, strong) NSMutableArray *squares;

+ (SWBoard *)boardWithImage:(UIImage *)image;
+ (SWBoard *)boardWithPlistNamed:(NSString *)name;

@end
