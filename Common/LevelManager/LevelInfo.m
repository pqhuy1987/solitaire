//
//  LevelInfo.m
//  unblock
//
//  Created by 张朴军 on 12-12-25.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import "LevelInfo.h"

@implementation LevelInfo

@synthesize score = _score;
@synthesize time = _time;
@synthesize moves = _moves;
@synthesize rounds = _rounds;
@synthesize wons = _wons;


+(id)info
{
    return [[[self alloc] init] autorelease];
}
-(id)init
{
    if(self = [super init])
    {
        self.score = 0;
        self.time = 0;
        self.rounds = 0;
        self.moves = 0;
        self.wons = 0;
    }
    return self;
}

@end
