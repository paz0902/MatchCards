//
//  SetCard.m
//  MatchCards
//
//  Created by Paz Patel on 11/3/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    if ([otherCards count] > 0){
        score = score + 1;
    }
    return score;
}

- (NSString *)contents {
    //NSArray *rankStrings = [SetCard rankStrings];
    //return [rankStrings[self.rank] stringByAppendingString:self.suit];
    NSString *bob = [NSString stringWithFormat:@"%d %@ %@ %@", self.number, self.symbol, self.shading, self.color];
    return bob;
}

// Game symbols are 1 or 2 or 3
+ (NSUInteger)maxNumber{
    //return @[@1, @2, @3];
    return 3;
}


+ (NSArray *)validSymbols{
    return @[@"◼︎", @"▲", @"●"];
}

+ (NSArray *)validShading{
    return @[@"solid", @"shade", @"open"];
}

+ (NSArray *)validColor{
    return @[@"red", @"green", @"blue"];
}

@end
