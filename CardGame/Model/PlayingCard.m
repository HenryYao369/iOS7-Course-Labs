//
//  PlayingCard.m
//  CardGame
//
//  Created by Hengzhi Yao on 6/9/15.
//  Copyright (c) 2015 Hengzhi Yao. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int) match:(NSArray *)otherCards{
    
    int score = 0;
    
    if ([otherCards count]==1) {
        PlayingCard *otherCard = [otherCards firstObject];
        score = [self matchTwoCards:otherCard];
        
    }
    
    if ([otherCards count] == 2) {
        PlayingCard *firstCard = [otherCards firstObject], *secondCard = [otherCards lastObject];
        
        if (firstCard.rank == secondCard.rank && secondCard.rank == self.rank && self.rank == firstCard.rank) {
            score = 16;
        }else if ([firstCard.suit isEqualToString:self.suit] && [secondCard.suit isEqualToString:self.suit] && [firstCard.suit isEqualToString:secondCard.suit]){
            score = 4;
        }
        else {
            score = MAX(MAX([self matchTwoCards:firstCard], [self matchTwoCards:secondCard]), [firstCard  matchTwoCards:secondCard])  ;
            
        }
        
    }
    
    
    
    return score;
}

// the match method in the past.
//- (int) matchPast:(NSArray *)otherCards{ // match 2 cards
//    int score = 0;
//    
//    if ([otherCards count]==1) {
//        PlayingCard *otherCard = [otherCards firstObject];
//        if (otherCard.rank == self.rank) {
//            score = 4;
//        }else if([otherCard.suit isEqualToString:self.suit]){
//            score = 1;
//        }
//        
//    }
//    
//    return score;
//}

- (int) matchTwoCards:(PlayingCard *)otherCard{ // match 2 cards
    int score = 0;
    
    if (otherCard.rank == self.rank) {
        score = 4;
    }else if([otherCard.suit isEqualToString:self.suit]){
        score = 1;
    }
    
    return score;
}


- (NSString *)contents{
    
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide BOTH setter and getter

+ (NSArray *) validSuits{
    return @[@"♥︎",@"♦︎",@"♣︎",@"♠︎"];
}

+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}


- (void) setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}


- (NSString *)suit{
    return _suit ? _suit : @"?";
}


+ (NSUInteger) maxRank{
    return [[self rankStrings] count] -1;
}

- (void) setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
