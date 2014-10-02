//
//  PlayingCard.m
//  MatchCards
//
//  Created by Paz Patel on 9/30/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSLog(@"%@%d", self.suit, self.rank);
    //NSLog(@"rankstring:%@", rankStrings[self.rank]);
    NSArray *rankStrings = [PlayingCard rankStrings];
    //NSArray *rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    //return [NSString stringWithFormat:@"%@%d", self.suit, self.rank];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    //NSLog(@"Valid Suits");
    //return @[@"H",@"D",@"C",@"S"];
    return @[@"♥︎", @"♦︎", @"♣︎", @"♠︎"];
}

- (void)setSuit:(NSString *)suit {
    //NSLog(@"setSuit %@", suit);
    if ([[PlayingCard validSuits] containsObject:suit ]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank{
    //NSLog(@"setRank %d", rank);
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
