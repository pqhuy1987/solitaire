//
//  Manager.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-2.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "Manager.h"
#import "UserDefault.h"
#import "Item.h"
@implementation Manager
@synthesize array = _array;

SYNTHESIZE_SINGLETON_FOR_CLASS(Manager)

-(id)init
{
    if(self = [super init])
    {
        bool level_data = [[UserDefault sharedUserDefault] boolForKey:@"TestManagerData"];
        if(level_data==false)
        {
            NSMutableArray* array = [NSMutableArray array];
            for (int i = 0; i < 10; i++)
            {
                Item* item = [[[Item alloc] init] autorelease];
                [array addObject:item];
                NSLog(@"Create: %d,%f,%d",item.index,item.value,item.blank);
            }
            [[UserDefault sharedUserDefault] setBool:true forKey:@"TestManagerData"];
            [[UserDefault sharedUserDefault] setObject:array forKey:@"Array"];
            
        }
    }
    return self;
}

-(void)dealloc
{
    self.array = nil;
    [super dealloc];
}

-(void)load
{
    self.array = [[UserDefault sharedUserDefault] objectForKey:@"Array"];
    
    for (Item* item  in self.array)
    {
         NSLog(@"Load: %d,%f,%d",item.index,item.value,item.blank);
    }
}

-(void)save
{
    [[UserDefault sharedUserDefault] setObject:self.array forKey:@"Array"];
}


@end
