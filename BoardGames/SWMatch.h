//
//  SWMatch.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWBoard.h"
#import "SWPlayer.h"

@interface SWMatch : NSObject

@property (nonatomic, strong) SWBoard *board;
@property (nonatomic, strong) NSMutableArray *players;
@property NSInteger turnNumber; //a round is all players, a turn is each player. e.g. with 3 players, the 6th turn is the last turn of the 2nd round.

+ (SWMatch *)matchWithBoard:(SWBoard *)board;

@end
