//
//  Card.h
//  MatchCards
//
//  Created by Paz Patel on 9/30/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
