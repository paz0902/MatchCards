//
//  CardMatchingGame.m
//  MatchCards
//
//  Created by Paz Patel on 10/9/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if (!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    NSLog(@"NEW GAME:%lu", (unsigned long)count);
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }

        }
        [self setGameMode:2];
        _lastMove = [[NSMutableArray alloc] init];
    }
    return self;
}

static const int MISMATCH_PENALTY = -2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            [self.lastMove addObject:[NSString stringWithFormat:@"Flipped Back %@", card.contents]];
        } else {
                //See how many cards have been selected
                NSMutableArray *cardsChosen = [[NSMutableArray alloc] init];
                //[cardsChosen addObject:card];
                for (Card *otherCard in self.cards){
                    if (otherCard.isChosen && !otherCard.isMatched){
                        [cardsChosen addObject:otherCard];
                    }
                } //end loop to see how many cards have been selected
                // See if the number selected matches the game mode we are playing
                // +1 from cardsChosen because we are not counting the card we just selected
                // as part of the cardsChose
                if (([cardsChosen count] + 1) == self.gameMode){
                    NSLog(@"We can do some matches!");
                    int matchScore = [card match:cardsChosen];
                    NSLog(@"Score is %d after comparing %@ against %@", matchScore, card.contents, [self getAllCardContents:cardsChosen]);
                    int remaining_card_match = [self matchRemainingCards:[NSMutableArray arrayWithArray:cardsChosen]:0];
                    NSLog(@"Score for comparing other cards with each other:%d", remaining_card_match);
                    matchScore += remaining_card_match;
                    NSLog(@"After matchScore:%d", matchScore);
                    if (matchScore){
                        NSLog(@"We have some sort of match");
                        card.matched = YES;
                        for (Card *chosenCard in cardsChosen){
                            chosenCard.matched = YES;
                        }
                        self.score += matchScore;
                        [self.lastMove addObject:[NSString stringWithFormat:@"MATCHED %@ %@ for %d points!",
                                                  card.contents,
                                                  [self getAllCardContents:cardsChosen],
                                                  matchScore]];
                    } else {
                            NSLog(@"We got no match");
                            for (Card *chosenCard in cardsChosen){
                                chosenCard.chosen = NO;
                            } //no match for loop
                            int penalty = MISMATCH_PENALTY * self.gameMode;
                            self.score += penalty;
                            [self.lastMove addObject:[NSString stringWithFormat:@"No Match in %@ %@. Lose %d points!",
                                                    card.contents,
                                                    [self getAllCardContents:cardsChosen],
                                                    penalty ]];
                        
                      } //else number of cards selected matches game mode
                    
                } else {
                    if ([cardsChosen count] > 0){
                        [self.lastMove addObject:[NSString stringWithFormat:@"Card %@ Selected Along With %@",
                                                  card.contents,
                                                  [self getAllCardContents:cardsChosen]]];
                    } else {
                        [self.lastMove addObject:[NSString stringWithFormat:@"Card %@ Selected", card.contents]];
                    }
                  }//card if not chosen or matched
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
          } //else card not match not chosen
    } //if card not matched
    
} //end of function

-(NSString *)getAllCardContents:(NSMutableArray *)thecards{
    NSString *allcontents = @"";
    NSMutableArray *card_contents = [[NSMutableArray alloc] init];
    //NSArray *cc = [card_contents cop]
    for (Card *acard in thecards){
        [card_contents addObject:acard.contents];
    }
    allcontents = [card_contents componentsJoinedByString:@" "];
    return allcontents;
}

-(NSInteger)matchRemainingCards:(NSMutableArray *)otherCards :(NSInteger)localscore{
    int subscore = 0;
    NSLog(@"localscore pre:%d subscore pre:%d", localscore, subscore);
    if ([otherCards count] > 1){
        Card *firstCard = [otherCards firstObject];
        NSLog(@"first card is now:%@", firstCard.contents);
        [otherCards removeObjectAtIndex:0];
        subscore = [firstCard match:otherCards];
        NSLog(@"Matching first card:%@ with %@", firstCard.contents, [self getAllCardContents:otherCards]);
        NSLog(@"Gives result of %d", subscore);
        localscore = subscore;
        NSLog(@"localscore middle:%d subscore:%d", localscore, subscore);
        subscore += [self matchRemainingCards:otherCards :localscore];
    }
    NSLog(@"localscore post:%d subscore:%d", localscore, subscore);
    return subscore;
}


-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
