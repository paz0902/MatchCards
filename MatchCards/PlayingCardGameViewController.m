//
//  PlayingCardGameViewController.m
//  MatchCards
//
//  Created by Paz Patel on 10/29/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

@end
