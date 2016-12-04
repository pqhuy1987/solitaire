//
//  Card.h
//  Card
//
//  Created by 张朴军 on 13-5-9.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CommonDefine.h"
typedef enum
{
    CardKind_Diamond = 0,
    CardKind_Club,
    CardKind_Heart,
    CardKind_Spade,
}CardKind;

typedef enum
{
    CardPoint_A = 1,
    CardPoint_2,
    CardPoint_3,
    CardPoint_4,
    CardPoint_5,
    CardPoint_6,
    CardPoint_7,
    CardPoint_8,
    CardPoint_9,
    CardPoint_10,
    CardPoint_J,
    CardPoint_Q,
    CardPoint_K,
}CardPoint;

typedef enum
{
    CardLightKind_None = 0,
    CardLightKind_Yellow,
    CardLightKind_Blue,
}CardLightKinds;

@interface Card : CCSprite
{
    CardKind    _kind;
    CardPoint   _point;
    BOOL        _isCovered;
    BOOL        _willCovered;
    
    CCSprite*   _yellow;
    CCSprite*   _blue;
    
    CardLightKinds _light;
    
#ifdef DEBUG_MODE
    CCLabelTTF* _zOrderLabel;
#endif
}
@property (nonatomic, assign)CardKind   kind;
@property (nonatomic, assign)CardPoint  point;
@property (nonatomic, assign)BOOL       isCovered;
@property (nonatomic, assign)BOOL       willCovered;

@property (nonatomic, retain)CCSprite*  yellow;
@property (nonatomic, retain)CCSprite*  blue;
@property (nonatomic, assign)CardLightKinds  light;
@property (nonatomic, assign)int        cardID;

+(id)cardWithKind:(CardKind)kind Point:(CardPoint)point isCovered:(BOOL)isCovered;

-(void)setIsCovered:(BOOL)isCovered Animated:(BOOL)isAnimated DelayTime:(float)delay Duration:(float)duration;

-(BOOL)differentColorWith:(Card*)card;

@end
