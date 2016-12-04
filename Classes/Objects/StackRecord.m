//
//  StackRecord.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-1.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "StackRecord.h"

@implementation StackRecord

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    for (int i = 0; i < 52; i++)
    {
        [aCoder encodeInt32:_card[i] forKey:[NSString stringWithFormat:@"Card_%d",i]];
        [aCoder encodeBool:_covered[i] forKey:[NSString stringWithFormat:@"Covered_%d",i]];
    }
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        for (int i = 0; i < 52; i++)
        {
           _card[i] = [aDecoder decodeInt32ForKey:[NSString stringWithFormat:@"Card_%d",i]];
            _covered[i] = [aDecoder decodeBoolForKey:[NSString stringWithFormat:@"Covered_%d",i]];
        }
    }
    return  self;
}

-(id)init
{
    if(self = [super init])
    {
        for (int i = 0; i < 52; i++)
        {
            _card[i] = -1;
            _covered[i] = NO;
        }
    }
    return self;
}

-(void)setCard:(char)card AtIndex:(int)index
{
    _card[index] = card;
}

-(char)cardAtIndex:(int)index
{
    return _card[index];
}

-(void)setCovered:(BOOL)covered AtIndex:(int)index
{
    _covered[index] = covered;
}

-(BOOL)coveredAtIndex:(int)index
{
    return _covered[index];
}

@end
