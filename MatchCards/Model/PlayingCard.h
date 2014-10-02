//
//  PlayingCard.h
//  MatchCards
//
//  Created by Paz Patel on 9/30/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
