//
//  LevelManager.m
//  unblock
//
//  Created by 张朴军 on 12-12-25.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import "LevelManager.h"
#import "LevelInfo.h"
#import "cocos2d.h"
#import "UserDefault.h"
@implementation LevelManager

@synthesize levels = _levels;
@synthesize mode = _mode;
@synthesize isTimeEnable = _isTimeEnable;

SYNTHESIZE_SINGLETON_FOR_CLASS(LevelManager)

-(id)init
{
    if(self = [super init])
    {
        for (int i = 0; i < 2; i++)
        {
            if(![[UserDefault sharedUserDefault] objectForKey:[NSString stringWithFormat:@"LevelBestScore_%d",i]])
            {
                [[UserDefault sharedUserDefault] setFloat:0 forKey:[NSString stringWithFormat:@"LevelBestScore_%d",i]];
            }
            
            if(![[UserDefault sharedUserDefault] objectForKey:[NSString stringWithFormat:@"LevelMove_%d",i]])
            {
                [[UserDefault sharedUserDefault] setFloat:0 forKey:[NSString stringWithFormat:@"LevelMove_%d",i]];
            }
            
            if(![[UserDefault sharedUserDefault] objectForKey:[NSString stringWithFormat:@"LevelBestTime_%d",i]])
            {
                [[UserDefault sharedUserDefault] setFloat:0 forKey:[NSString stringWithFormat:@"LevelBestTime_%d",i]];
            }
            
            if(![[UserDefault sharedUserDefault] objectForKey:[NSString stringWithFormat:@"LevelRounds_%d",i]])
            {
                [[UserDefault sharedUserDefault] setFloat:0 forKey:[NSString stringWithFormat:@"LevelRounds_%d",i]];
            }
            
            if(![[UserDefault sharedUserDefault] objectForKey:[NSString stringWithFormat:@"LevelWons_%d",i]])
            {
                [[UserDefault sharedUserDefault] setFloat:0 forKey:[NSString stringWithFormat:@"LevelWons_%d",i]];
            }
        }
        
        if(![[UserDefault sharedUserDefault] objectForKey:@"LevelGameMode"])
        {
            [[UserDefault sharedUserDefault] setInteger:GameMode_One forKey:@"LevelGameMode"];
        }
        
        if(![[UserDefault sharedUserDefault] objectForKey:@"LevelIsTimeEnable"])
        {
            [[UserDefault sharedUserDefault] setBool:YES forKey:@"LevelIsTimeEnable"];
        }
        
        
        if(![[UserDefault sharedUserDefault] objectForKey:@"LevelBackgroundID"])
        {
            [[UserDefault sharedUserDefault] setInteger:0 forKey:@"LevelBackgroundID"];
        }
        
        if(![[UserDefault sharedUserDefault] objectForKey:@"LevelCardID"])
        {
            [[UserDefault sharedUserDefault] setInteger:0 forKey:@"LevelCardID"];
        }
        
    
        self.levels = [NSMutableArray array];
        for (int i = 0; i < 2; i++)
        {
            LevelInfo* info = [LevelInfo info];
            [self.levels addObject:info];
        }
    }
    return self;
}

-(void)dealloc
{
    self.levels = nil;
    [super dealloc];
}

-(void)setBestScore:(float)score forMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        info.score = score;
    }
}
-(float)bestScoreForMode:(GameModes)mode;
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        return info.score;
    }
    return 0;
}

-(void)setBestTime:(float)time forMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        info.time = time;
    }
}
-(float)bestTimeForMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        return info.time;
    }
    return 0;
}

-(void)setMoves:(float)moves forMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        info.moves = moves;
    }
}
-(float)movesForMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        return info.moves;
    }
    return 0;
}

-(void)setRounds:(float)rounds forMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        info.rounds = rounds;
    }
}
-(float)roundsForMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        return info.rounds;
    }
    
    return  0;
}

-(void)setWons:(float)wons forMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        info.wons = wons;
    }
}
-(float)wonsForMode:(GameModes)mode
{
    LevelInfo* info = [self.levels objectAtIndex:mode];
    if(info)
    {
        return info.wons;
    }
    return 0;
}

-(void)load
{
    for (int i = 0; i < 2; i++)
    {
        LevelInfo* info = [self.levels objectAtIndex:i];
        info.score = [[UserDefault sharedUserDefault] floatForKey:[NSString stringWithFormat:@"LevelBestScore_%d",i]];
        info.time = [[UserDefault sharedUserDefault] floatForKey:[NSString stringWithFormat:@"LevelBestTime_%d",i]];
        info.rounds = [[UserDefault sharedUserDefault] floatForKey:[NSString stringWithFormat:@"LevelRounds_%d",i]];
        info.wons = [[UserDefault sharedUserDefault] floatForKey:[NSString stringWithFormat:@"LevelWons_%d",i]];
        info.moves = [[UserDefault sharedUserDefault] floatForKey:[NSString stringWithFormat:@"LevelMove_%d",i]];
    }
    
    _mode = [[UserDefault sharedUserDefault] integerForKey:@"LevelGameMode"];
    _isTimeEnable = [[UserDefault sharedUserDefault] boolForKey:@"LevelIsTimeEnable"];
    
    self.BackgroundID = [[UserDefault sharedUserDefault] integerForKey:@"LevelBackgroundID"];
    self.CardID = [[UserDefault sharedUserDefault] integerForKey:@"LevelCardID"];
}

-(void)test
{

}
-(void)save
{
    for (int i = 0; i < 2; i++)
    {
        LevelInfo* info = [self.levels objectAtIndex:i];
        [[UserDefault sharedUserDefault] setFloat:info.score forKey:[NSString stringWithFormat:@"LevelBestScore_%d",i]];
        [[UserDefault sharedUserDefault] setFloat:info.time forKey:[NSString stringWithFormat:@"LevelBestTime_%d",i]];
        [[UserDefault sharedUserDefault] setFloat:info.rounds forKey:[NSString stringWithFormat:@"LevelRounds_%d",i]];
        [[UserDefault sharedUserDefault] setFloat:info.wons forKey:[NSString stringWithFormat:@"LevelWons_%d",i]];
        [[UserDefault sharedUserDefault] setFloat:info.moves forKey:[NSString stringWithFormat:@"LevelMove_%d",i]];
    }
    
    [[UserDefault sharedUserDefault] setInteger:_mode forKey:@"LevelGameMode"];
    [[UserDefault sharedUserDefault] setBool:_isTimeEnable forKey:@"LevelIsTimeEnable"];
    
    [[UserDefault sharedUserDefault] setInteger:self.BackgroundID forKey:@"LevelBackgroundID"];
    [[UserDefault sharedUserDefault] setInteger:self.CardID forKey:@"LevelCardID"];
}

@end
