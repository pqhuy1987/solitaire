//
//  FinishStack.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-6-18.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "FinishStack.h"
#import "AudioManager.h"
@implementation FinishStack

-(CGRect)availableArea
{
    CGRect rect;
    rect.origin.x = self.position.x - _cardSize.width * 0.5;
    rect.origin.y = self.position.y + _cardSize.height * 0.5;
    rect.size.width = _cardSize.width;
    rect.size.height = -_cardSize.height;
    return rect;
}

-(void)addCard:(Card*)card Animated:(BOOL)isAnimated DelayTime:(float)delay Duration:(float)duration
{
    if(card == NULL)
        return;
    if(isAnimated)
    {
        CGPoint target = self.position;
        CCDelayTime* delayTime = [CCDelayTime actionWithDuration:delay];
        CCMoveTo*   move = [CCMoveTo actionWithDuration:duration position:target];
        CCCallBlock* call = [CCCallBlock actionWithBlock:^{
            [card.parent reorderChild:card z:self.zOrder + self.cards.count];
            [[AudioManager sharedAudioManager] playEffect:@"transfer.mp3"];
        }];
        CCSequence* sequence = [CCSequence actions:delayTime, move, call, nil];
        [card runAction:sequence];
        [self.cards addObject:card];
    }
    else
    {
        card.position = self.position;
        [card.parent reorderChild:card z:self.zOrder + self.cards.count];
        [self.cards addObject:card];
    }
}

-(BOOL)canConnectWithStack:(CardStack*)stack
{
    if(stack.cards.count != 1)
        return NO;
    
    if(self.cards.count == 0)
    {
        Card* top = [stack.cards objectAtIndex:0];
        if(top.point == CardPoint_A)
            return YES;
        else
            return NO;
    }
    
    Card* card =  [self.cards lastObject];
    if(card)
    {
        Card* top = [stack.cards objectAtIndex:0];
        if(card.point == top.point - 1)
        {
            if(card.kind == top.kind)
                return YES;
        }
    }
    return NO;
}

-(BOOL)canConnectWithCard:(Card*)card
{
    if(self.cards.count == 0)
    {
        if(card.point == CardPoint_A)
            return YES;
        else
            return NO;
    }
    
    Card* tail =  [self.cards lastObject];
    if(tail)
    {
        if(tail.point == card.point - 1)
        {
            if(tail.kind == card.kind)
                return YES;
        }
    }
    return NO;
}

-(void)addStack:(CardStack*)stack Duration:(float)duration
{
    if(stack.cards.count == 0)
        return;
    CGPoint target;
    
    
    for (Card* card in stack.cards)
    {
        [self.cards addObject:card];
        target = self.position;
        int zOrder = self.zOrder + self.cards.count - 1;
        
        if(card == stack.cards.lastObject)
        {
            if(CGPointEqualToPoint(card.position, target))
            {
                CCMoveTo*   move = [CCMoveTo actionWithDuration:duration position:target];
                CCCallBlock* call = [CCCallBlock actionWithBlock:^{
                    [card.parent reorderChild:card z:zOrder];
                }];
                CCSequence* sequence = [CCSequence actions:move, call, nil];
                [card runAction:sequence];
            }
            else
            {
                CCMoveTo*   move = [CCMoveTo actionWithDuration:duration position:target];
                CCCallBlock* call = [CCCallBlock actionWithBlock:^{
                    [card.parent reorderChild:card z:zOrder];
                    [[AudioManager sharedAudioManager] playEffect:@"transfer.mp3"];
                }];
                CCSequence* sequence = [CCSequence actions:move, call, nil];
                [card runAction:sequence];
            }
        }
        else
        {
            CCMoveTo*   move = [CCMoveTo actionWithDuration:duration position:target];
            CCCallBlock* call = [CCCallBlock actionWithBlock:^{
                [card.parent reorderChild:card z:zOrder];
            }];
            CCSequence* sequence = [CCSequence actions:move, call, nil];
            [card runAction:sequence];
        }
    }
    
    [stack removeAllChildrenWithCleanup:YES];
}

-(CGPoint)tailPostion
{
    CGPoint target = self.position;
    return target;
}

@end
