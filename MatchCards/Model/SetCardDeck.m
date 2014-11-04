//
//  SetCardDeck.m
//  MatchCards
//
//  Created by Paz Patel on 11/3/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSUInteger validNum = 1; validNum <= [SetCard maxNumber]; validNum++) {
            for (NSString *validSym in [SetCard validSymbols]){
                for (NSString *validShade in [SetCard validShading]){
                    for (NSString *validCol in [SetCard validColor]){
                        SetCard *card = [[SetCard alloc] init];
                        card.number = validNum;
                        card.symbol = validSym;
                        card.shading = validShade;
                        card.color = validCol;
                        [self addCard:card];
                        
                    } //valid color
                }//valid shade
            }//valid symbol
        }//valid number
    }//if self
    return self;
}


@end
