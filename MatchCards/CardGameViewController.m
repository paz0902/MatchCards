//
//  CardGameViewController.m
//  MatchCards
//
//  Created by Paz Patel on 9/27/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "CardGameViewController.h"
//#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *)deck {
    NSLog(@"NEW DECK PLEASE");
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
    //return [[PlayingCardDeck alloc] init];
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length]){
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *card = [self.deck drawRandomCard];
        [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
        //[sender setTitle:@"A♠︎" forState:UIControlStateNormal];
        NSLog(@"Card contents %@", card.contents);
        //[sender setTitle:@"ASPADES" forState:UIControlStateNormal];
        [sender setTitle:card.contents forState:UIControlStateNormal];
        
    }
    self.flipCount++;
    
}

@end
