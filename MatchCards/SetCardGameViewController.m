//
//  SetCardGameViewController.m
//  MatchCards
//
//  Created by Paz Patel on 11/3/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()


@end

@implementation SetCardGameViewController

- (Deck *)createDeck{
    return [[SetCardDeck alloc] init];
}

- (void)updateButtonTitleUI:(UIButton *)cardButton :(SetCard *) card{
    NSString *cardText = [self titleForCard:card];
    [cardButton setTitle:cardText forState:UIControlStateNormal];
    [cardButton setAttributedTitle:[self attributedTitleForCard:card :cardText] forState:UIControlStateNormal];
    
}

- (NSString *)titleForCard:(SetCard *)card{
    
    NSMutableString *cardtext = [[NSMutableString alloc] initWithString:@""];
    if (card.isChosen){
        //NSMutableString *cardtext = [NSMutableString stringWithCapacity:card.number];
        for (int i = 0; i < card.number; i++){
            [cardtext appendString:card.symbol];
        }
    }
    return cardtext;
}

- (NSMutableAttributedString *)attributedTitleForCard:(SetCard *)card :(NSString *)cardText{
    NSMutableAttributedString *cardTextAttributes = [[NSMutableAttributedString alloc] initWithString:cardText];
    
    NSDictionary *cardColors = @{@"red" : [UIColor redColor],
                                 @"green": [UIColor greenColor],
                                 @"blue": [UIColor blueColor]};
    ///NSDictionary *cardShading = @{@"solid": [NSNumber numberWithInt:0],
      //                            @"open": [NSNumber numberWithInt:5]};
    NSDictionary *cardShading = @{@"solid": @0,
                                  @"open": @5};
    if (card.isChosen){
        UIColor *fontColor = [UIColor blackColor]; //default to black
        NSRange cardRange = NSMakeRange(0, [cardText length]);
        if ([cardColors objectForKey:card.color]){
            fontColor = [cardColors objectForKey:card.color];
        }
        //set shade for color
        if ([card.shading isEqualToString:@"shade"]){
            fontColor = [fontColor colorWithAlphaComponent:0.5];
        }
        //set color
        [cardTextAttributes setAttributes:@{NSForegroundColorAttributeName:fontColor} range:cardRange];
        
        if ([cardShading objectForKey:card.shading]){
            NSLog(@"PAZ");
            //NSInteger strokewidth = [NSNumber numberWithInt:[cardShading objectForKey:card.shading]];
            //NSLog(@"@d stroke width", strokewidth);
            [cardTextAttributes addAttribute: NSStrokeWidthAttributeName
                                       value:[cardShading objectForKey:card.shading]
                                       range:cardRange];
        }
    }
    return cardTextAttributes;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
