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

@property (strong, nonatomic) IBOutlet UILabel *hintLabel;


@property (weak, nonatomic) IBOutlet UISwitch *isThreeControlOutlet;
@property (nonatomic) BOOL isThree;


// For displaying hintLabel
@property (strong,nonatomic) Card *prevCard,*prevCard2;
@property (nonatomic) int prevScore;

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
    
    self.prevCard = nil;
    self.prevCard2 = nil;
//    if (self.isThree) {
//        NSLog(@"3");
//    }
//    else NSLog(@"2");
    
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    self.isThreeControlOutlet.enabled = FALSE;
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    

    self.prevScore = (int)self.game.score;
    
    
    if (!self.isThree) {
        [self.game chooseCardAtIndex:chosenButtonIndex];
      
        
        //update hintLabel
        Card *card = [self.game cardAtIndex:chosenButtonIndex];
        
        if (self.prevCard == nil) {
            self.hintLabel.text = card.contents;
            self.prevCard = card;
        }
        else{
            if (self.prevCard == card) {
                self.hintLabel.text = [@"cancel to choose" stringByAppendingString: card.contents];
                self.prevCard = nil;
            }
            else{// prevCard != card && prevCard != nil
                
                if (self.game.score - self.prevScore > 0) {
                    self.hintLabel.text =
                    // 注意连接字符串方法：stringWithFormat @"%@%@%@",a,b,c
                    [NSString stringWithFormat:@"Matched %@%@ for %ld scores.",self.prevCard.contents,card.contents,self.game.score - self.prevScore+1];
                    
                    self.prevCard = nil;
                }
                else {
                    self.hintLabel.text =
                    [NSString stringWithFormat:@"%@%@ don't match! %ld points penalty.",self.prevCard.contents,card.contents,self.prevScore - self.game.score -1];
                    
                    self.prevCard = card;
                }
                
                
                
            }// prevCard != card && prevCard != nil
            
        }

    }
    else{
        
        [self.game chooseCardAtIndex:chosenButtonIndex isThreeMode:YES];
        
        //update hintLabel
        Card *card = [self.game cardAtIndex:chosenButtonIndex];
        
        
        if (self.prevCard == card) {
            self.hintLabel.text = [@"cancel to choose" stringByAppendingString: card.contents];
            self.prevCard = nil;
        }
        else if(self.prevCard2 == card){
            self.hintLabel.text = [@"cancel to choose" stringByAppendingString: card.contents];
            self.prevCard2 = nil;
        }
        else if (self.prevCard == nil || self.prevCard2==nil) {
            self.hintLabel.text = card.contents;
            
            if (self.prevCard == nil) {
                self.prevCard = card;
            }else self.prevCard2 = card;
            
        }
        else{// prevCard != card && prevCard != nil
            
            
            if (self.game.score - self.prevScore > 0) {
                self.hintLabel.text =
                [NSString stringWithFormat:@"Matched %@%@%@ for %ld scores.",self.prevCard.contents,self.prevCard2.contents,card.contents,self.game.score - self.prevScore+1];
                
                self.prevCard = nil;
                self.prevCard2 = nil;
            }
            else {
                self.hintLabel.text =
                [NSString stringWithFormat:@"%@%@%@ don't match! %ld points penalty.",self.prevCard.contents,self.prevCard2.contents,card.contents,self.prevScore - self.game.score -1];
                
                self.prevCard = card;
                self.prevCard2 = nil;
            }
 
            
        }// prevCard != card && prevCard != nil
    
    }
    
    
    
    

    
    
    
    [self updateUI];

    
}


- (void) updateUI{
    
//    NSArray *prevCards;
//    Card *prevCard;
    
    for (UIButton *cardButton in self.cardButtons) {
        
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
        
//        self.hintLabel.text = [NSString stringWithFormat:<#(NSString *), ...#>];
        
    }
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score]; // 作业：MVC!
    
}

- (NSString *) titleForCard:(Card *)card{
    return card.isChosen? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed: card.isChosen? @"cardfront" : @"cardback"];
    
}




- (IBAction)reDealButton:(UIButton *)sender {
    
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    
    self.isThreeControlOutlet.enabled = true;
    [self updateUI];
    
}


@end








