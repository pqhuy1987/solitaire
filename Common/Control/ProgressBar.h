//
//  ProgressBar.h
//  Fruit Connections Cut
//
//  Created by 张朴军 on 13-4-7.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{
    ProgressBarDirect_L2R = 0,
    ProgressBarDirect_R2L,
    ProgressBarDirect_T2B,
    ProgressBarDirect_B2T,
}ProgressBarDirect;
@interface ProgressBar : CCNode
{
    CCSprite*           _back;
    CCSprite*           _front;
    CCSprite*           _vernier;
    ProgressBarDirect   _direct;
    float                 _max;
    float                 _min;
    float                 _value;
    CGRect              _area;
    CGRect              _frontRect;
    ccColor3B           _color;
}

@property (nonatomic, retain)CCSprite* back;
@property (nonatomic, retain)CCSprite* front;
@property (nonatomic, retain)CCSprite* vernier;
@property (nonatomic, assign)ProgressBarDirect direct;
@property (nonatomic, assign)float    max;
@property (nonatomic, assign)float    min;
@property (nonatomic, assign)float    value;
@property (nonatomic, assign)ccColor3B color;

+(id)progressbarWithBack:(CCSprite*)back Front:(CCSprite*)front Vernier:(CCSprite*)vernier Direct:(ProgressBarDirect)direct;

@end
