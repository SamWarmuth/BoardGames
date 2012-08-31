//
//  SWGameSetupViewController.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWMatch.h"

@interface SWGameSetupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tv;
@property (nonatomic, strong) NSMutableArray *players;

- (IBAction)addPlayerPressed:(id)sender;
- (IBAction)startGamePressed:(id)sender;

@end
