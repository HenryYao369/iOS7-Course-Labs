//
//  ViewController.m
//  CardGame
//
//  Created by Hengzhi Yao on 6/7/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@property (weak, nonatomic) IBOutlet UISwitch *isThreeControlOutlet;
@property (nonatomic) BOOL isThree;

@end

@implementation ViewController

-(CardMatchingGame *) game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}


- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)switchTwoOrThree:(UISwitch *)sender {
    self.isThree = sender.isOn;
//    if (self.isThree) {
//        NSLog(@"3");
//    }
//    else NSLog(@"2");
    
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    self.isThreeControlOutlet.enabled = FALSE;
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    
    if (!self.isThree) {
        [self.game chooseCardAtIndex:chosenButtonIndex];

    }
    else{
        [self.game chooseCardAtIndex:chosenButtonIndex isThreeMode:YES];
    }
    
    [self updateUI];

    
}

- (IBAction)reDealButton:(UIButton *)sender {
    
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    
    self.isThreeControlOutlet.enabled = true;
    [self updateUI];
    
}

- (void) updateUI{
    
    for (UIButton *cardButton in self.cardButtons) {
        
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score]; // 作业：MVC!
        
    }
    
}

- (NSString *) titleForCard:(Card *)card{
    return card.isChosen? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed: card.isChosen? @"cardfront" : @"cardback"];
    
}


@end








