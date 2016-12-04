//
//  Item.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-2.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "Item.h"

@implementation Item
@synthesize index = _index;
@synthesize value = _value;
@synthesize blank = _blank;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_index forKey:@"Index"];
    [aCoder encodeFloat:_value forKey:@"Value"];
    [aCoder encodeBool:_blank forKey:@"Blank"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        _index = [aDecoder decodeIntForKey:@"Index"];
        _value = [aDecoder decodeFloatForKey:@"Value"];
        _blank = [aDecoder decodeBoolForKey:@"Blank"];
    }
    return  self;
}

-(id)init
{
    if(self = [super init])
    {
        _index = arc4random() % 10;
        _value = (arc4random() % 1000) / 100.0f;
        _blank = arc4random() % 2;
    }
    return self;
}

@end
