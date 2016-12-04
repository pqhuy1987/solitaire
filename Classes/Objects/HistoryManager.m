//
//  HistoryManager.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-6-20.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "HistoryManager.h"
#import "UserDefault.h"
@implementation HistoryManager
@synthesize history = _history;
SYNTHESIZE_SINGLETON_FOR_CLASS(HistoryManager)

-(id)init
{
    if(self = [super init])
    {
        bool level_data = [[UserDefault sharedUserDefault] boolForKey:@"HistoryManagerData"];
        if(level_data==false)
        {
            NSMutableArray* array = [NSMutableArray array];
            [[UserDefault sharedUserDefault] setBool:true forKey:@"HistoryManagerData"];
            [[UserDefault sharedUserDefault] setObject:array forKey:@"History_History"];
        }
        self.history = [NSMutableArray array];
    }
    return self;
}

-(void)dealloc
{
    self.history = nil;
    [super dealloc];
}

-(void)load
{
    self.history = [[UserDefault sharedUserDefault] objectForKey:@"History_History"];
}

-(void)save
{
    [[UserDefault sharedUserDefault] setObject:self.history forKey:@"History_History"];
}

-(void)pushSteps:(NSArray *)steps
{
    [self.history addObjectsFromArray:steps];
}
@end
