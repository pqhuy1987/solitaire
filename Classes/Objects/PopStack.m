//
//  PopStack.m
//  Solitaire
//
//  Created by 张朴军 on 13-8-7.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "PopStack.h"
#import "AudioManager.h"
@implementation PopStack

@synthesize drawn = _drawn;

-(id)init
{
    if(self = [super init])
    {
        self.cards =[CCArray arrayWithCapacity:10];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            _cardSize = CGSizeMake(88, 112);
            
            
            _gap    = CGSizeMake(28, 0);
            _maxGap = CGSizeMake(28, 0);
            _area   = CGSizeMake(84, 0);
        }
        else
        {
            _cardSize = CGSizeMake(44, 56);
            
            
            _gap    = CGSizeMake(14, 0);
            _maxGap = CGSizeMake(14, 0);
            _area   = CGSizeMake(42, 0);
            
            CGSize screen = [[CCDirector sharedDirector] winSize];
            if(screen.height == 568)
            {
                _area   = CGSizeMake(0, -348);
            }
        }
        
        
    }
    return self;
}


-(CGRect)availableArea
{
    CGRect rect;
    rect.origin.x = self.position.x - _cardSize.width * 0.5 + (_gap.width * (_drawn - 1));
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


-(void)updateCardsAnimate:(BOOL)isAnimated DelayTime:(float)delay
{
    CGPoint target = self.position;
    int count = self.cards.count;
    for (int i = 0; i < count; i++)
    {
        
        if(i < count - _drawn)
        {
            target = self.position;
        }
        else
        {
            target = ccp(self.position.x + _gap.width * (_drawn - (count - i)), self.position.y + _gap.height * (_drawn - (count - i)));
        }
        
        Card* card = [self.cards objectAtIndex:i];
        
        if(!CGPointEqualToPoint(card.position,target))
        {
            if(isAnimated)
            {
                CCDelayTime* delayTime = [CCDelayTime actionWithDuration:delay];
                CCMoveTo*   move = [CCMoveTo actionWithDuration:ADJUST_DURATION position:target];
                CCCallBlock* call = [CCCallBlock actionWithBlock:^{
                    [card.parent reorderChild:card z:self.zOrder + i];
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
        else
        {
            [card.parent reorderChild:card z:self.zOrder + i];
        }
    }
    
}

-(CGPoint)tailPostion
{
    CGPoint target = self.position;
    return target;
}

@end
