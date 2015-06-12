//
//  PlayingCard.h
//  CardGame
//
//  Created by Hengzhi Yao on 6/9/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;



@end
