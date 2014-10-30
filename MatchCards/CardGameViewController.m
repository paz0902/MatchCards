//
//  CardGameViewController.m
//  MatchCards
//
//  Created by Paz Patel on 9/27/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (nonatomic, strong) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *newdealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchNumber;
@property (weak, nonatomic) IBOutlet UILabel *lastMove;
@property (weak, nonatomic) IBOutlet UISlider *lastMoveSlider;
@property (nonatomic) NSInteger currentGameModeIndex;

@end

@implementation CardGameViewController
- (IBAction)selectgameMode:(UISegmentedControl *)sender {
    // store in variable so when we 'redeal' we can choose the last selected option
    self.currentGameModeIndex = [sender selectedSegmentIndex];
    NSLog(@"currentGameModeIndex:%ld", (long)self.currentGameModeIndex);
    [self.game setGameMode:([sender titleForSegmentAtIndex:self.currentGameModeIndex].integerValue)];
}

- (CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

//abstract
- (Deck *)createDeck {
    return nil;
}

- (NSInteger)getCurrentGameModeIndex{
    if (!self.currentGameModeIndex){
        self.currentGameModeIndex = 0;
    }
    return self.currentGameModeIndex;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    
    [self updateUI];
    for (int i = 0; i < [self.matchNumber numberOfSegments]; i++){
        [self.matchNumber setEnabled:NO forSegmentAtIndex:i];
    }
}


- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons){
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backGroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    int lastindex = [self.game.lastMove count] - 1;
    NSString *status = @"Last Move";
    if (lastindex >= 0){
        status = self.game.lastMove[lastindex];
    }
    //Ensure label looks enabled
    [self.lastMove setAlpha:1];
    self.lastMove.text = status;
}

- (NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backGroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}
- (IBAction)newDealButton:(UIButton *)sender {
    self.game = nil;
    //enable the option to choose number of cards to match
    for (int i = 0; i < [self.matchNumber numberOfSegments]; i++){
        [self.matchNumber setEnabled:YES forSegmentAtIndex:i];
    }
    // Select the "2" card option as default
    [self.matchNumber setSelectedSegmentIndex:0];
    // Put slider back in middle
    [self.lastMoveSlider setValue:0.5];
    // Make sure label is back to normal
    [self.lastMove setAlpha:1];
    self.matchNumber.selectedSegmentIndex = self.currentGameModeIndex;
    [self.game setGameMode:([self.matchNumber titleForSegmentAtIndex:self.currentGameModeIndex].integerValue)];
    [self updateUI];
}
- (IBAction)sliderMoved:(UISlider *)sender {
    int lastMoveSegments = [self.game.lastMove count] - 1;
    if (lastMoveSegments == 0){
        self.lastMove.text = self.game.lastMove[0];
        
        
    } else if (lastMoveSegments > 0){
        int move_index = roundf([sender value] * lastMoveSegments);
        self.lastMove.text = self.game.lastMove[move_index];
    } else {
        self.lastMove.text = @"Stop Sliding!";
    }
    // Make the label look faded because it displays past results
    [self.lastMove setAlpha:0.6];
}

-(void) viewDidLoad {
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"backgroundView.png"]];
    [super viewDidLoad];
}
@end
