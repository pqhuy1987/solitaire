//
//  DeliverStack.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-16.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "DeliverStack.h"

@implementation DeliverStack

@synthesize drawn = _drawn;

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
        CCCallBlock* call = [CCCallBlock actionWithBlock:^{[card.parent reorderChild:card z:self.zOrder + self.cards.count];}];
        CCSequence* sequence = [CCSequence actions:delayTime, move, call, nil];
        [card runAction:sequence];
        [self.cards addObject:card];
    }
    else
    {
        [self.cards addObject:card];
        card.position = self.position;
        [card.parent reorderChild:card z:self.zOrder + self.cards.count];
    }
}

-(CGPoint)tailPostion
{
    CGPoint target = self.position;
    return target;
}

@end
