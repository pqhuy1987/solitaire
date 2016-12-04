//
//  Card.m
//  Card
//
//  Created by 张朴军 on 13-5-9.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import "Card.h"
#import "CommonDefine.h"
#import "AudioManager.h"
@implementation Card

@synthesize kind = _kind;
@synthesize point = _point;
@synthesize isCovered = _isCovered;
@synthesize willCovered = _willCovered;

@synthesize yellow = _yellow;
@synthesize blue = _blue;
@synthesize light = _light;

+(id)cardWithKind:(CardKind)kind Point:(CardPoint)point isCovered:(BOOL)isCovered
{
    return [[[self alloc] initWithKind:kind Point:point isCovered:isCovered] autorelease];
}

-(id)initWithKind:(CardKind)kind Point:(CardPoint)point isCovered:(BOOL)isCovered
{
    if (self = [super init])
    {
        _kind = kind;
        _point = point;
        _isCovered = isCovered;
        [self updateSelf];
        
        
        self.yellow = [CCSprite spriteWithSpriteFrameName:@"hint2.png"];
        [self addChild:self.yellow];
        self.yellow.position = ccp(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        
        self.blue = [CCSprite spriteWithSpriteFrameName:@"hint1.png"];
        [self addChild:self.blue];
        self.blue.position = ccp(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        self.light = CardLightKind_None;
    }
    return self;
}

-(void)dealloc
{
    self.yellow = nil;
    self.blue = nil;
    [super dealloc];
}

-(void)setLight:(CardLightKinds)light
{
    switch (light)
    {
        case CardLightKind_None:
            self.yellow.visible = NO;
            self.blue.visible = NO;
            _light = light;
            break;
        case CardLightKind_Yellow:
            self.yellow.visible = YES;
            self.blue.visible = NO;
            _light = light;
            break;
        case CardLightKind_Blue:
            self.yellow.visible = NO;
            self.blue.visible = YES;
            _light = light;
            break;
    }
}

-(void)setKind:(CardKind)kind
{
    if (_kind == kind)
        return;
    switch (kind)
    {
        case CardKind_Diamond:
            _kind = kind;
            [self updateSelf];
            break;
        case CardKind_Club:
            _kind = kind;
            [self updateSelf];
            break;
        case CardKind_Heart:
            _kind = kind;
            [self updateSelf];
            break;
        case CardKind_Spade:
            _kind = kind;
            [self updateSelf];
            break;
        default:
            CCLOG(@"Wrong Kind for Card!");
            break;
    }
}

-(void)setCardID:(int)cardID
{
    switch (cardID)
    {
        case 0:
            _cardID = cardID;
            break;
        case 1:
            _cardID = cardID;
            break;
        case 2:
            _cardID = cardID;
            break;
        case 3:
            _cardID = cardID;
            break;
        case 4:
            _cardID = cardID;
            break;
        case 5:
            _cardID = cardID;
            break;

        default:
            break;
    }
    
    [self updateSelf];
}

-(void)setPoint:(CardPoint)point
{
    if (_point == point)
        return;
    
    if (point >= CardPoint_A && point <= CardPoint_K)
    {
        _point = point;
        [self updateSelf];
    }
    else
        CCLOG(@"Wrong Point for Card!");
}

-(void)setIsCovered:(BOOL)isCovered
{
    if (_isCovered == isCovered)
        return;
    _isCovered = isCovered;
    [self updateSelf];
}

-(void)setIsCovered:(BOOL)isCovered Animated:(BOOL)isAnimated DelayTime:(float)delay Duration:(float)duration
{
    if(isAnimated)
    {
        
        _willCovered = YES;
        CCDelayTime* delayTime = [CCDelayTime actionWithDuration:delay];
        CCOrbitCamera *scaleDown = [CCOrbitCamera actionWithDuration:duration * 0.5 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
        CCCallBlock* call = [CCCallBlock actionWithBlock:^{[self setIsCovered:isCovered];}];
        CCOrbitCamera *scaleUp = [CCOrbitCamera actionWithDuration:duration * 0.5 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
        CCCallBlock* call2 = [CCCallBlock actionWithBlock:^{_willCovered = NO; }];
        CCSequence* sequence = [CCSequence actions:delayTime, scaleDown, call, scaleUp, call2, nil];
        [self runAction:sequence];
    }
    else
    {
        [self setIsCovered:isCovered];
    }
}

#ifdef DEBUG_MODE

-(void)updateSelf
{
    NSString* fileName = nil;
    
    if (_point >= CardPoint_A && _point <= CardPoint_K)
    {
        
        switch (_kind)
        {
            case CardKind_Diamond:
                fileName = [NSString stringWithFormat:@"diamond_%d.png",_point];
                break;
            case CardKind_Club:
                fileName = [NSString stringWithFormat:@"club_%d.png",_point];
                break;
            case CardKind_Heart:
                fileName = [NSString stringWithFormat:@"heart_%d.png",_point];
                break;
            case CardKind_Spade:
                fileName = [NSString stringWithFormat:@"spade_%d.png",_point];
                break;
            default:
                CCLOG(@"Wrong Kind for Card!");
                break;
        }
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame* frame = [frameCache spriteFrameByName:fileName];
        [self setDisplayFrame:frame];
    }
    else
        CCLOG(@"Wrong Point for Card!");
    
    if(_isCovered)
    {
        self.color = ccc3(128, 128, 128);
    }
    else
    {
        self.color = ccWHITE;
    }
    
}

#else

-(void)updateSelf
{
    NSString* fileName = nil;
    if(_isCovered)
    {
        fileName = [NSString stringWithFormat:@"back_%d.png",_cardID];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame* frame = [frameCache spriteFrameByName:fileName];
        [self setDisplayFrame:frame];
    }
    else
    {
        if (_point >= CardPoint_A && _point <= CardPoint_K)
        {
        
            switch (_kind)
            {
                case CardKind_Diamond:
                    fileName = [NSString stringWithFormat:@"diamond_%d.png",_point];
                    break;
                case CardKind_Club:
                    fileName = [NSString stringWithFormat:@"club_%d.png",_point];
                    break;
                case CardKind_Heart:
                    fileName = [NSString stringWithFormat:@"heart_%d.png",_point];
                    break;
                case CardKind_Spade:
                    fileName = [NSString stringWithFormat:@"spade_%d.png",_point];
                    break;
                default:
                    CCLOG(@"Wrong Kind for Card!");
                    break;
            }
            CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [frameCache spriteFrameByName:fileName];
            [self setDisplayFrame:frame];
        }
        else
            CCLOG(@"Wrong Point for Card!");
    }
}

-(BOOL)differentColorWith:(Card *)card
{
    switch (_kind)
    {
        case CardKind_Diamond:
            if(card.kind == CardKind_Spade || card.kind == CardKind_Club)
                return YES;
            break;
        case CardKind_Club:
            if(card.kind == CardKind_Diamond || card.kind == CardKind_Heart)
                return YES;
            break;
        case CardKind_Heart:
            if(card.kind == CardKind_Club || card.kind == CardKind_Spade)
                return YES;
            break;
        case CardKind_Spade:
            if(card.kind == CardKind_Diamond || card.kind == CardKind_Heart)
                return YES;
            break;
        
    }
    return NO;
}

-(NSString *)description
{
    NSString* string = nil;
    switch (_kind)
    {
        case CardKind_Diamond:
            string = @"Diamond";
            break;
        case CardKind_Club:
            string = @"Club";
            break;
        case CardKind_Heart:
            string = @"Heart";
            break;
        case CardKind_Spade:
            string = @"Spade";
            break;
        
    }
    
    if(_point > CardPoint_10)
    {
        if(_point == CardPoint_J)
            string = [NSString stringWithFormat:@"%@ J",string];
        if(_point == CardPoint_Q)
            string = [NSString stringWithFormat:@"%@ Q",string];
        if(_point == CardPoint_K)
            string = [NSString stringWithFormat:@"%@ K",string];
    }
    else if(_point > CardPoint_A)
    {
        string = [NSString stringWithFormat:@"%@ %d",string,_point];
    }
    else
    {
        string = [NSString stringWithFormat:@"%@ A",string];
    }
    return string;
}
#endif

@end
