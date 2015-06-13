//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Hengzhi Yao on 6/11/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

//@property (nonatomic) int previousChosenCardCount;
//@property (nonatomic,strong) Card *previousChosenCard;

@end


@implementation CardMatchingGame

-(NSMutableArray *) cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++) {
            Card * randomCard = [deck drawRandomCard];
            
            if (randomCard) {
                 [self.cards addObject:randomCard];
            }
            else{
                self = nil;
                break;
            }
           
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void) chooseCardAtIndex: (NSUInteger)index
              isThreeMode: (BOOL)isThreeMode{
    
//    [self chooseCardAtIndex:index];
    Card *card = [self cardAtIndex:index];
    
    int previousChosenCardCount = 0;
    Card *previousChosenCard;
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }
        else{
            for (Card *otherCard in self.cards) {
                
                
                if ( !otherCard.isMatched && otherCard.isChosen) {
                    
                    if (previousChosenCardCount == 1) {
                        int matchScore = [card match :@[otherCard,previousChosenCard]];
                        
                        //do sth
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            previousChosenCard.matched = YES;
                            otherCard.matched = YES;
                            card.matched = YES;
                        }
                        else{
                            self.score -= MISMATCH_PENALTY;
                            previousChosenCard.chosen = NO;
                            otherCard.chosen = NO;
                            
                        }
                        
                        // set status
                        previousChosenCardCount = 0;
                        break;
                    }
                    else{ //previousChosenCardCount == 0
                        previousChosenCardCount++;
                        previousChosenCard = otherCard;
                    }
                    
                }
                
                
            }// for
            
            self.score -= COST_TO_CHOOSE;            
            card.chosen = YES;
        }
    
        
        
    }
    
}

-(void) chooseCardAtIndex:(NSUInteger)index{
    
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }
        else{
            for (Card *otherCard in self.cards) {
                if (!otherCard.isMatched && otherCard.isChosen) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
                
            }// for
            
            self.score -= COST_TO_CHOOSE;
        
            card.chosen = YES;
        }
        
    }
    
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return index < [self.cards count] ? self.cards[index] : nil;
    
}



@end
