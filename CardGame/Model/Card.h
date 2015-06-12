//
//  Card.h
//  CardGame
//
//  Created by Hengzhi Yao on 6/9/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(strong,nonatomic) NSString *contents;

@property(nonatomic,getter=isChosen) BOOL chosen;
@property(nonatomic,getter=isMatched) BOOL matched;


- (int) match: (NSArray *)otherCards;

@end
