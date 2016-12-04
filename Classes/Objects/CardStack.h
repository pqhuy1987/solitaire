//
//  CardStack.h
//  Card
//
//  Created by 张朴军 on 13-5-9.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Card.h"

#define COVERED_CARD_GAP_RATIO 0.15
#define FLIP_DURATION   0.15
#define DELIVER_DURATION   0.15
#define STACK_DURATION 0.15
#define SHIFT_DURATION   0.15
#define ADJUST_DURATION 0.15

@interface CardStack : CCNode
{
    CCArray*    _cards;
    CGSize      _cardSize;
    CGSize      _gap;
    CGSize      _maxGap;
    CGSize      _area;
    int         _index;
}

@property (nonatomic, retain)CCArray* cards;
@property (nonatomic, assign)CGSize gap;
@property (nonatomic, assign)int index;
+(id)cardStack;

-(void)addCard:(Card*)card Animated:(BOOL)isAnimated DelayTime:(float)delay Duration:(float)duration;
-(void)updateCardsAnimate:(BOOL)isAnimated DelayTime:(float)delay;
-(BOOL)pickUpAtIndex:(int)index ToStack:(CardStack *)stack;
-(void)addStack:(CardStack*)stack Duration:(float)duration;
-(CGRect)availableArea;
-(BOOL)pickWithTouch:(UITouch*)touch ToStack:(CardStack *)stack;
-(BOOL)canPickAtIndex:(int)index;
-(BOOL)canConnectWithStack:(CardStack*)stack;
-(BOOL)checkOpenNewCard;

@end
