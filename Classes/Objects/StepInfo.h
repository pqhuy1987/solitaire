//
//  StepInfo.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-6-5.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    StepType_Transfer = 0,
    StepType_Flip,
    StepType_Deliver,
    StepType_Pop,
    StepType_Swap,
}StepType;

@interface StepInfo : NSObject <NSCoding>
{
    int         _pickIndex;
    int         _dropIndex;
    int         _cardTag;
    int         _stepID;
    float       _score;
    StepType    _type;
}

@property (nonatomic, assign)int pickIndex;
@property (nonatomic, assign)int dropIndex;
@property (nonatomic, assign)int cardTag;
@property (nonatomic, assign)int stepID;
@property (nonatomic, assign)float score;
@property (nonatomic, assign)StepType type;
+(id)info;

@end
