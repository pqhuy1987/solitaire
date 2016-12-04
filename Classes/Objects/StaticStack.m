//
//  StaticStack.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-14.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "StaticStack.h"
#import "GameScene.h"
#import "AudioManager.h"
@implementation StaticStack

-(BOOL)checkForFinish
{
    if(self.cards.count < 13)
        return NO;
    Card* last = (Card*)[self.cards lastObject];
    int j = 0;
    for (int i = self.cards.count - 1; i >= 0; i--)
    {
        
        Card* temp = [self.cards objectAtIndex:i];
        
        if (temp.point != CardPoint_A + j || temp.isCovered || last.kind != temp.kind)
        {
            return NO;
        }
        if(CardPoint_A + j == CardPoint_K)
            return YES;
        j++;
        
    }
    return NO;
}

-(void)addCard:(Card*)card Animated:(BOOL)isAnimated DelayTime:(float)delay Duration:(float)duration
{
    if(card == NULL)
        return;
    [super addCard:card Animated:isAnimated DelayTime:delay Duration:duration];
    CCDelayTime* delayTime = [CCDelayTime actionWithDuration:duration + delay];
    CCSequence* sequence = [CCSequence actions:delayTime,  nil];
    [self runAction:sequence];
}

-(BOOL)checkOpenNewCard
{
    Card* card =  [self.cards lastObject];
    if(card)
    {
        if(card.isCovered)
        {
            [card setIsCovered:NO Animated:YES DelayTime:0 Duration:FLIP_DURATION];
            return YES;
        }
    }
    return NO;
}



-(void)addStack:(CardStack *)stack Duration:(float)duration
{
    [super addStack:stack Duration:duration + ADJUST_DURATION];
}

-(void)updateCardsAnimate:(BOOL)isAnimated DelayTime:(float)delay
{
    [super updateCardsAnimate:isAnimated DelayTime:delay];
    
//    BOOL canPick = YES;
//    for (int i = self.cards.count - 1; i >= 0; i--)
//    {
//        if(canPick)
//        {
//            if(![self canPickAtIndex:i])
//            {
//                canPick = NO;
//                Card* card = [self.cards objectAtIndex:i];
//                card.color = ccc3(192, 192, 192);
//            }
//            else
//            {
//                Card* card = [self.cards objectAtIndex:i];
//                card.color = ccc3(255, 255, 255);
//            }
//                
//        }
//        else
//        {
//            Card* card = [self.cards objectAtIndex:i];
//            
//                card.color = ccc3(192, 192, 192);
//            
//        }
//    }
}

-(BOOL)canConnectWithCard:(Card*)card
{
    if(self.cards.count == 0)
    {
        if(card.point == CardPoint_K)
            return YES;
        else
            return NO;
    }
    
    Card* tail =  [self.cards lastObject];
    if(tail)
    {
        
        if(tail.point == card.point + 1)
        {
            if([tail differentColorWith:card])
                return YES;
        }
    }
    return NO;
}

@end
