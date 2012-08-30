//
//  SWPlayer.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWPlayer.h"

@implementation SWPlayer

+ (SWPlayer *)playerWithName:(NSString *)name
{
    SWPlayer *player = [SWPlayer new];
    player.name = name;
    player.currentSquareIndex = 0;
    return player;
}

@end
