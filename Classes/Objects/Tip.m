//
//  Tip.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-5.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "Tip.h"
#import "GameScene.h"
#import "StaticStack.h"
#import "Card.h"
@implementation Tip

@synthesize pickStack = _pickStack;
@synthesize pickIndex = _pickIndex;
@synthesize dropStack = _dropStack;
@synthesize priority = _priority;

+(id)tip
{
    return [[[self alloc] init] autorelease];
}

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(NSComparisonResult)compare:(Tip *)otherObject
{
    return otherObject.priority - self.priority;
}

@end
