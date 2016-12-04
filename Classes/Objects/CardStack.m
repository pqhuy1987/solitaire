//
//  CardStack.m
//  Card
//
//  Created by 张朴军 on 13-5-9.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import "CardStack.h"
#import "Card.h"
#import "GameScene.h"
#import "AudioManager.h"
@implementation CardStack

@synthesize cards   = _cards;
@synthesize gap     = _gap;
@synthesize index = _index;
+(id)cardStack
{
    return [self node];
}

-(id)init
{
    if(self = [super init])
    {
        self.cards =[CCArray arrayWithCapacity:10];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            _cardSize = CGSizeMake(92, 132);
            
            _gap    = CGSizeMake(0, -48);
            _maxGap = CGSizeMake(0, -48);
            _area   = CGSizeMake(0, -500);
        }
        else
        {
            _cardSize = CGSizeMake(46, 66);
            _gap    = CGSizeMake(0, -24);
            _maxGap = CGSizeMake(0, -24);
            _area   = CGSizeMake(0, -250);
            
            CGSize screen = [[CCDirector sharedDirector] winSize];
            if(screen.height == 568)
            {
                _area   = CGSizeMake(0, -338);
            }
        }
        
        
    }
    return self;
}

-(void)dealloc
{
    self.cards = nil;
    [super dealloc];
}

-(CGRect)availableArea
{
    CGRect rect;
    
    if(self.cards.count > 0)
    {
        rect.origin.x = self.position.x - _cardSize.width * 0.5;
        rect.origin.y = self.position.y + _cardSize.height * 0.5;
        rect.size.width = _cardSize.width;
        
        rect.size.height = 0;
        for (Card* card in self.cards)
        {
            if(card.isCovered || card.willCovered)
            {
                rect.size.height = rect.size.height - card.contentSize.height * COVERED_CARD_GAP_RATIO;
            }
            else
            {
                rect.size.height = rect.size.height + _gap.height;
            }
        }
        rect.size.height = rect.size.height - (_cardSize.height + _gap.height);
    }
    else
    {
        rect.origin.x = self.position.x - _cardSize.width * 0.5;
        rect.origin.y = self.position.y + _cardSize.height * 0.5;
        rect.size.width = _cardSize.width;
        rect.size.height = -_cardSize.height;
        
    }
    return rect;
}

-(BOOL)needAdjust;
{
    CGSize newGap = _gap;
    CGSize area;
    CGPoint start = self.position;
    int covereds = 0;
    for (Card* card in self.cards)
    {
        if(card.isCovered || card.willCovered)
        {
            start.y = start.y - card.contentSize.height * COVERED_CARD_GAP_RATIO;
            covereds++;
        }
        else
            break;
    }
    
    area.width = _area.width;
    area.height = _area.height - (start.y - self.position.y);
    
    if(self.cards.count - covereds > 0)
    {
        newGap.width = area.width / (self.cards.count - covereds);
        newGap.height = area.height / (self.cards.count - covereds);
    }
    
    
    if(ABS(newGap.width)  > ABS(_maxGap.width))
        newGap.width = _maxGap.width;
    if (ABS(newGap.height) > ABS(_maxGap.height) )
        newGap.height = _maxGap.height;
    
    BOOL needAdjust = NO;
    if(_gap.width != newGap.width || _gap.height != newGap.height)
    {
        _gap = newGap;
        needAdjust = YES;
    }
    return needAdjust;
}

-(CGPoint)tailPostion
{
    CGPoint target = self.position;
    for (Card* card in self.cards)
    {
        if(card == [self.cards lastObject])
        {
            break;
        }
        if(card.isCovered || card.willCovered)
        {
            target.y = target.y - card.contentSize.height * COVERED_CARD_GAP_RATIO;
        }
        else
        {
            target.y = target.y + _gap.height;
        }
    }
    return target;
}

-(void)updateCardsAnimate:(BOOL)isAnimated DelayTime:(float)delay
{
    [self needAdjust];
    {
        int i = 0;
        CGPoint target = self.position;
        for (Card* card in self.cards)
        {
            if(!CGPointEqualToPoint(card.position,target))
            {
                if(isAnimated)
                {
                    CCDelayTime* delayTime = [CCDelayTime actionWithDuration:delay];
                    CCMoveTo*   move = [CCMoveTo actionWithDuration:ADJUST_DURATION position:target];
                    CCCallBlock* call = [CCCallBlock actionWithBlock:^{[card.parent reorderChild:card z:self.zOrder + i];}];
                    CCSequence* sequence = [CCSequence actions:delayTime, move, call, nil];
                    [card runAction:sequence];
                }
                else
                {
                    [card.parent reorderChild:card z:self.zOrder + i];
                    card.position = target;
                }
            }
            i++;
            if(card.isCovered || card.willCovered)
            {
                target.y = target.y - card.contentSize.height * COVERED_CARD_GAP_RATIO;
            }
            else
            {
                target.y = target.y + _gap.height;
            }
        }
    }
}

-(void)addCard:(Card*)card Animated:(BOOL)isAnimated DelayTime:(float)delay Duration:(float)duration
{
    if(card == NULL)
        return;
    [self.cards addObject:card];
    int i = 0;
    CGPoint target = [self tailPostion];
    if(isAnimated)
    {
        
        int zOrder = self.zOrder + self.cards.count - 1;
        
        
        CCDelayTime* delayTime = [CCDelayTime actionWithDuration:delay];
        
        CCMoveTo*   move = [CCMoveTo actionWithDuration:duration position:target];
        CCCallBlock* call = [CCCallBlock actionWithBlock:^{
            [card.parent reorderChild:card z:zOrder];
            [[AudioManager sharedAudioManager] playEffect:@"transfer.mp3"];
            
        }];
        CCSequence* sequence = [CCSequence actions:delayTime, move, call, nil];
        [card runAction:sequence];
    }
    else
    {
        [card.parent reorderChild:card z:self.zOrder + i];
        card.position = target;
    }
}

-(void)addStack:(CardStack*)stack Duration:(float)duration
{
    if(stack.cards.count == 0)
        return;
    CGPoint target;
    
    
    for (Card* card in stack.cards)
    {
        [self.cards addObject:card];
        target = [self tailPostion];
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


-(BOOL)canPickAtIndex:(int)index
{
    BOOL canPick = NO;
    Card* firstCard = [self.cards objectAtIndex:index];
    if(firstCard)
    {
        canPick = !firstCard.isCovered;
    }
    
    return canPick;
}

-(BOOL)pickUpAtIndex:(int)index ToStack:(CardStack *)stack
{
    BOOL canPick = [self canPickAtIndex:index];
    if (canPick)
    {
        CCArray* array = [CCArray array];
        for (int i = index; i < self.cards.count; i++)
        {
            Card* card = [self.cards objectAtIndex:i];
            [card.parent reorderChild:card z:GameNodeZOrder_Top + i];
            [stack.cards addObject:card];
            [array addObject:card];
        }
        //[stack updateCardsAnimate:YES DelayTime:0];
        //[[AudioManager sharedAudioManager] playEffect:@"transfer.mp3"];
        for (Card* card in array)
        {
            [self.cards removeObject:card];
        }
    }
    return canPick;
}

-(BOOL)pickWithTouch:(UITouch*)touch ToStack:(CardStack *)stack;
{
    CGPoint p = [self convertTouchToNodeSpace:touch];
    CGSize screen = [[CCDirector sharedDirector] winSize];
    if(screen.height == 568)
    {
        p.y = p.y - 44;
    }
    
    CGPoint top = [self convertToNodeSpace:ccp(self.position.x - _cardSize.width * 0.5, self.position.y + _cardSize.height * 0.5)] ;
    
    CGRect rect;
    rect.origin.x = top.x;
    rect.origin.y = top.y;
    rect.size.width = _cardSize.width;
    for (int i = 0; i < self.cards.count; i++)
    {
        Card* card = [self.cards objectAtIndex:i];
        
        if(i < self.cards.count - 1)
        {
            if(card.isCovered || card.willCovered)
            {
                rect.size.height = -_cardSize.height * COVERED_CARD_GAP_RATIO;
            }
            else
            {
                rect.size.height = _gap.height;
            }
        }
        else
            rect.size.height = -_cardSize.height;
        
        
        if(CGRectContainsPoint(rect, p))
        {
            [self pickUpAtIndex:i ToStack:stack];
            return YES;
        }
        
        if(card.isCovered || card.willCovered)
        {
            rect.origin.y = rect.origin.y -_cardSize.height * COVERED_CARD_GAP_RATIO;
        }
        else
        {
            rect.origin.y = rect.origin.y + _gap.height;
        }
    }
    
    return NO;
}

-(void)setPosition:(CGPoint)position
{
    CGPoint delta = ccpSub(position, self.position);
    
    for (Card* card in self.cards)
    {
        if(card)
            card.position = ccpAdd(card.position, delta);
    }
    [super setPosition:position];
}

-(BOOL)canConnectWithStack:(CardStack*)stack
{
    if(self.cards.count == 0)
    {
        Card* top = [stack.cards objectAtIndex:0];
        if(top.point == CardPoint_K)
            return YES;
        else
            return NO;
    }
    
    if(stack.cards.count == 0)
        return NO;
    
    Card* card =  [self.cards lastObject];
    if(card)
    {
        Card* top = [stack.cards objectAtIndex:0];
        if(card.point == top.point + 1)
        {
            if([card differentColorWith:top])
                return YES;
        }
    }
    return NO;
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

-(void)reorderCards
{
    for (int i = 0; i < self.cards.count; i++)
    {
        Card* card = [self.cards objectAtIndex:i];
        [card.parent reorderChild:card z:i];
    }
}

@end
