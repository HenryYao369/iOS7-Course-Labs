//
//  ViewController.h
//  CardGame
//
//  Created by Hengzhi Yao on 6/7/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController


//protected
// for subclasses
- (Deck *)createDeck; // abstract
@end

