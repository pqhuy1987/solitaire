//
//  SlideBar.m
//  Fruit Connections Cut
//
//  Created by 张朴军 on 13-4-7.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "SlideBar.h"

@implementation SlideBar

-(void)setValueAccordToPosition:(CGPoint)p
{
    int newValue;
    switch (_direct)
    {
        case ProgressBarDirect_L2R:
            newValue = (p.x / _frontRect.size.width) * (_max - _min) + _min;
            self.value = newValue;
            break;
        case ProgressBarDirect_R2L:
            newValue = ((_frontRect.size.width - p.x) / _frontRect.size.width) * (_max - _min) + _min;
            self.value = newValue;
            break;
        case ProgressBarDirect_T2B:
            newValue = ((_frontRect.size.height - p.y) / _frontRect.size.height) * (_max - _min) + _min;
            self.value = newValue;
            break;
        case ProgressBarDirect_B2T:
            newValue = (p.y / _frontRect.size.height) * (_max - _min) + _min;
            self.value = newValue;
            break;
    }
}

-(void)onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
	[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
	[super onExit];
}

-(void)setHandlerPriority:(NSInteger)newPriority
{
    [[[CCDirector sharedDirector] touchDispatcher] setPriority:newPriority forDelegate:self];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint p = [self convertTouchToNodeSpace:touch];
    
    if(CGRectContainsPoint(_area, p))
    {
        [self setValueAccordToPosition:p];
        return YES;
    }
    
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint p = [self convertTouchToNodeSpace:touch];
    
    if(CGRectContainsPoint(_area, p))
    {
        [self setValueAccordToPosition:p];
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

@end
