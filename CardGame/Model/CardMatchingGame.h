//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Hengzhi Yao on 6/11/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount: (NSUInteger)count
                         usingDeck: (Deck *)deck;



- (Card *) cardAtIndex: (NSUInteger)index;
-(void) chooseCardAtIndex: (NSUInteger)index;

-(void) chooseCardAtIndex: (NSUInteger)index
              isThreeMode: (BOOL)isThreeMode;



@property (nonatomic,readonly) NSInteger score;


@end
