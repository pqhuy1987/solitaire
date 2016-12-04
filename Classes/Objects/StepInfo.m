//
//  StepInfo.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-6-5.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "StepInfo.h"
#import "GameScene.h"
@implementation StepInfo

@synthesize pickIndex = _pickIndex;
@synthesize dropIndex = _dropIndex;
@synthesize score = _score;
@synthesize cardTag = _cardTag;
@synthesize stepID = _stepID;
@synthesize type = _type;
+(id)info
{
    return [[[self alloc] init] autorelease];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_pickIndex forKey:@"PickIndex"];
    [aCoder encodeInt:_dropIndex forKey:@"DropIndex"];
    [aCoder encodeInt:_cardTag forKey:@"CardTag"];
    [aCoder encodeInt:_stepID forKey:@"StepID"];
    [aCoder encodeFloat:_score forKey:@"Score"];
    [aCoder encodeValueOfObjCType:@encode(GameModes) at:&_type];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        _pickIndex = [aDecoder decodeIntForKey:@"PickIndex"];
        _dropIndex = [aDecoder decodeIntForKey:@"DropIndex"];
        _cardTag = [aDecoder decodeIntForKey:@"CardTag"];
        _stepID = [aDecoder decodeIntForKey:@"StepID"];
        _score = [aDecoder decodeFloatForKey:@"Score"];
        [aDecoder decodeValueOfObjCType:@encode(GameModes) at:&_type];
    }
    return  self;
}

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(NSString *)description
{
    GameScene* scene = [GameScene sharedGameScene];
    Card* card = [scene getCardByTag:_cardTag];
    switch (_type)
    {
        case StepType_Transfer:
            return [NSString stringWithFormat:@"%@: From %d -> To %d Card:%@",@"Transfer", _pickIndex, _dropIndex,card];
            break;
        case StepType_Flip:
            return [NSString stringWithFormat:@"%@: From %d -> To %d Card:%@",@"Flip", _pickIndex, _dropIndex,card];
            break;
        case StepType_Deliver:
            return [NSString stringWithFormat:@"%@: From %d -> To %d Card:%@",@"Deliver", _pickIndex, _dropIndex,card];
            break;
        case StepType_Pop:
            return [NSString stringWithFormat:@"%@: From %d -> To %d Card:%@",@"Pop", _pickIndex, _dropIndex,card];
            break;
        case StepType_Swap:
            return [NSString stringWithFormat:@"%@: From %d -> To %d Card:%@",@"Swap", _pickIndex, _dropIndex,card];
            break;
    }
    
    return nil;
}

@end
