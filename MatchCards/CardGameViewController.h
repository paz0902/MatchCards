//
//  CardGameViewController.h
//  MatchCards
//
//  Created by Paz Patel on 9/27/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// For subclasses
- (Deck *)createDeck; //abstract

@end
