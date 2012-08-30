//
//  SWMatch.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWMatch.h"

@implementation SWMatch

+ (SWMatch *)matchWithBoard:(SWBoard *)board
{
    SWMatch *newMatch = [SWMatch new];
    newMatch.board = board;
    newMatch.players = [[NSMutableArray alloc] init];
    return newMatch;
}

@end
