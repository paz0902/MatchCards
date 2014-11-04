//
//  SetCard.h
//  MatchCards
//
//  Created by Paz Patel on 11/3/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic) NSString *symbol;
@property (nonatomic) NSString *shading;
@property (nonatomic) NSString *color;

+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validShading;
+ (NSArray *)validColor;

@end
