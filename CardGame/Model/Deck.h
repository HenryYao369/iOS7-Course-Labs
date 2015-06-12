//
//  Deck.h
//  CardGame
//
//  Created by Hengzhi Yao on 6/9/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;
- (Card *) drawRandomCard;

@end
