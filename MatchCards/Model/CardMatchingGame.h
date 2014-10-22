//
//  CardMatchingGame.h
//  MatchCards
//
//  Created by Paz Patel on 10/9/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

//If 0 - match 2 cards
//If 1 - match 3 cards
// Default will be 0, for 2 card match
@property (nonatomic) NSUInteger gameMode;
@property (nonatomic, strong) NSMutableArray *lastMove;


@end
