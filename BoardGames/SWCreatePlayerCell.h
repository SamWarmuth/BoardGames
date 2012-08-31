//
//  SWCreatePlayerCell.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWMatch.h"
@interface SWCreatePlayerCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *playerNameField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *pokemonTypeControl, *tokenColorControl;
@property (nonatomic, strong) IBOutlet UIButton *deletePlayerButton;
@property (nonatomic, strong) SWPlayer *player;

- (void)updateUI;
- (IBAction)changedSelectedPokemon:(UISegmentedControl *)segControl;
- (IBAction)changedSelectedColor:(UISegmentedControl *)segControl;



@end
