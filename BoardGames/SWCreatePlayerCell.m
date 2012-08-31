//
//  SWCreatePlayerCell.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWCreatePlayerCell.h"

@implementation SWCreatePlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changedSelectedPokemon:(UISegmentedControl *)segControl
{
    NSLog(@"New poketype: %d", segControl.selectedSegmentIndex);
    self.player.pokemonType = (SWPokemonType)segControl.selectedSegmentIndex;
    [self.player createToken];
}

- (IBAction)changedSelectedColor:(UISegmentedControl *)segControl
{
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor orangeColor], [UIColor blackColor]];
    self.player.tokenColor = [colors objectAtIndex:segControl.selectedSegmentIndex];
    [self.player setTokenColorIndex:segControl.selectedSegmentIndex];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"start editing.");
    UITableView *tv = (UITableView *)self.superview;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         tv.frame = CGRectMake(0, 0, 320, 200);
                         [tv scrollRectToVisible:self.frame animated:TRUE];
                     }
                     completion:nil];
    return TRUE;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *finishedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.player.name = finishedText;
    NSLog(@"player name is now %@", finishedText);
    return TRUE;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (void)updateUI
{
    if (!self.player) return;
    self.playerNameField.text = self.player.name;
    self.pokemonTypeControl.selectedSegmentIndex = (NSInteger)self.player.pokemonType;
    self.tokenColorControl.selectedSegmentIndex = self.player.tokenColorIndex;
    
}

@end
