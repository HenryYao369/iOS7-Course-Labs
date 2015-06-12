//
//  Deck.m
//  CardGame
//
//  Created by Hengzhi Yao on 6/9/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import "Deck.h"

@interface Deck() // previous: Card() --caused errors!!

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

//@synthesize cards = _cards;

- (NSMutableArray *) cards{
    if (!_cards) _cards =  [[NSMutableArray alloc]init]; // lazy instantiation
    return _cards;
}


- (void) addCard:(Card *)card atTop:(BOOL)atTop{

    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }

}

- (void) addCard:(Card *)card{

[self addCard: card atTop:NO];

}

- (Card *) drawRandomCard{
    
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
   
 
    return randomCard;
}


@end
