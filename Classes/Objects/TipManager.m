//
//  TipManager.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-5.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "TipManager.h"
#import "cocos2d.h"
@implementation TipManager

@synthesize tips = _tips;

+(id)tipManager
{
    return [[[self alloc] init] autorelease];
}

-(id)init
{
    if(self = [super init])
    {
        self.tips = [NSMutableArray array];
    }
    return self;
}

-(void)dealloc
{
    self.tips = nil;
    [super dealloc];
}

-(void)sort
{
    NSArray* array = [NSArray array];
    array =  [self.tips sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
             {
                 Tip* first = (Tip*)a;
                 Tip* second = (Tip*)b;
                 return [first compare:second];
             }];
    
    self.tips = [NSMutableArray arrayWithArray:array];
    
    for (Tip* tip in self.tips)
    {
        CCLOG(@"Pick %d From %d To %d Prioity:%d",tip.pickStack,tip.pickIndex,tip.dropStack,tip.priority);
    }
}

-(Tip *)nextTip
{
    if(self.tips.count > 0)
    {
        _tipIndex = (_tipIndex + 1) % self.tips.count;
        Tip* tip = [self.tips objectAtIndex:_tipIndex];
        return tip;
    }
    return nil;
}

@end
