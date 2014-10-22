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
        NSLog(@"myarray: %@", _lastMove);
    }
    return self;
}

static const int MISMATCH_PENALTY = -2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSLog(@"Game Mode:%lu", (unsigned long)self.gameMode);
    NSLog(@"array: %@", self.lastMove);
    NSLog(@"lastMove Count1-> %d", [self.lastMove count]);
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            NSLog(@"LastMove Count-> %d", [self.lastMove count]);
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
                    NSLog(@"Before matchScore:%d", matchScore);
                    matchScore += [self matchRemainingCards:[NSMutableArray arrayWithArray:cardsChosen]];
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
                                self.score += MISMATCH_PENALTY;
                                [self.lastMove addObject:[NSString stringWithFormat:@"No Match in %@ %@. Lose %d points!",
                                                          card.contents,
                                                          [self getAllCardContents:cardsChosen],
                                                          MISMATCH_PENALTY]];
                            } //no match for loop
                        
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
        NSLog(@"A CARD CONTENTS:%@", acard.contents);
        [card_contents addObject:acard.contents];
    }
    //NSArray *array = [[NSArray alloc] initWithArray:card_contents];
    //NSArray *array = [NSArray arrayWithArray:card_contents];
    //NSLog(@"MY SPECIAL ARRAY %@", array);
    //allcontents = [array compcomponentsJoinedByString:@" "];
    allcontents = [card_contents componentsJoinedByString:@" "];
    NSLog(@"allcontents: %@", allcontents);
    return allcontents;
}

-(NSInteger)matchRemainingCards:(NSMutableArray *)otherCards{
    int score = 0;
    if ([otherCards count] > 1){
        Card *firstCard = [otherCards firstObject];
        [otherCards removeObjectAtIndex:0];
        score += [firstCard match:otherCards];
        NSLog(@"remaining score:%d", score);
        [self matchRemainingCards:otherCards];
    }
    return score;
}


-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end