//
//  Card.m
//  MatchCards
//
//  Created by Paz Patel on 9/30/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "Card.h"

@interface Card()
@end

@implementation Card


- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end