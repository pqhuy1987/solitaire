//
//  PuzzleRecord.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-1.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "PuzzleRecord.h"
#import "UserDefault.h"
#import "GameScene.h"
@implementation PuzzleRecord

@synthesize statics = _statics;
@synthesize delivers = _delivers;
@synthesize finishes = _finishes;
@synthesize mode = _mode;
@synthesize hasRecord = _hasRecord;

@synthesize score = _score;
@synthesize time = _time;
@synthesize factor = _factor;
@synthesize move = _move;

SYNTHESIZE_SINGLETON_FOR_CLASS(PuzzleRecord)

-(id)init
{
    if(self = [super init])
    {
        
        bool level_data = [[UserDefault sharedUserDefault] boolForKey:@"PuzzleRecordData"];
        if(level_data==false)
        {
            [[UserDefault sharedUserDefault] setBool:true forKey:@"PuzzleRecordData"];
            NSMutableArray* statics = [NSMutableArray array];
            for (int i = 0; i < 7; i++)
            {
                StackRecord* record = [[[StackRecord alloc] init] autorelease];
                [statics addObject:record];
            }
            
            [[UserDefault sharedUserDefault] setObject:statics forKey:@"PuzzleStatic"];
            
            NSMutableArray* deliver = [NSMutableArray array];
            for (int i = 0; i < 2; i++)
            {
                StackRecord* record = [[[StackRecord alloc] init] autorelease];
                [deliver addObject:record];
            }
            [[UserDefault sharedUserDefault] setObject:deliver forKey:@"PuzzleDeliver"];
            
            NSMutableArray* finish = [NSMutableArray array];
            for (int i = 0; i < 4; i++)
            {
                StackRecord* record = [[[StackRecord alloc] init] autorelease];
                [finish addObject:record];
            }
            [[UserDefault sharedUserDefault] setObject:finish forKey:@"PuzzleFinish"];
            
            [[UserDefault sharedUserDefault] setInteger:GameMode_Continue forKey:@"PuzzleMode"];
            [[UserDefault sharedUserDefault] setBool:NO forKey:@"PuzzleRecord"];
            
            [[UserDefault sharedUserDefault] setFloat:0 forKey:@"PuzzleRecordScore"];
            [[UserDefault sharedUserDefault] setFloat:0 forKey:@"PuzzleRecordTime"];
            [[UserDefault sharedUserDefault] setFloat:0 forKey:@"PuzzleRecordFactor"];
            [[UserDefault sharedUserDefault] setFloat:0 forKey:@"PuzzleRecordMove"];
        }
    }
    return self;
}

-(void)dealloc
{
    self.statics = nil;
    self.delivers = nil;
    self.finishes = nil;
    [super dealloc];
}

-(void)load
{
    self.statics = [[UserDefault sharedUserDefault] objectForKey:@"PuzzleStatic"];
    self.delivers = [[UserDefault sharedUserDefault] objectForKey:@"PuzzleDeliver"];
    self.finishes = [[UserDefault sharedUserDefault] objectForKey:@"PuzzleFinish"];
    
    _mode = [[UserDefault sharedUserDefault] integerForKey:@"PuzzleMode"];
    _hasRecord = [[UserDefault sharedUserDefault] boolForKey:@"PuzzleRecord"];
    
    _time = [[UserDefault sharedUserDefault] floatForKey:@"PuzzleRecordTime"];
    _score = [[UserDefault sharedUserDefault] floatForKey:@"PuzzleRecordScore"];
    _factor = [[UserDefault sharedUserDefault] floatForKey:@"PuzzleRecordFactor"];
    _move   = [[UserDefault sharedUserDefault] floatForKey:@"PuzzleRecordMove"];
}

-(void)save
{
    [[UserDefault sharedUserDefault] setObject:self.statics forKey:@"PuzzleStatic"];
    [[UserDefault sharedUserDefault] setObject:self.delivers forKey:@"PuzzleDeliver"];
    [[UserDefault sharedUserDefault] setObject:self.finishes forKey:@"PuzzleFinish"];
    
    [[UserDefault sharedUserDefault] setInteger:_mode forKey:@"PuzzleMode"];
    [[UserDefault sharedUserDefault] setBool:_hasRecord forKey:@"PuzzleRecord"];
    
    [[UserDefault sharedUserDefault] setFloat:_score forKey:@"PuzzleRecordScore"];
    [[UserDefault sharedUserDefault] setFloat:_time forKey:@"PuzzleRecordTime"];
    [[UserDefault sharedUserDefault] setFloat:_factor forKey:@"PuzzleRecordFactor"];
    [[UserDefault sharedUserDefault] setFloat:_move forKey:@"PuzzleRecordMove"];
}

-(void)clear
{
    for (int i = 0; i < 7; i++)
    {
        StackRecord* record = [self.statics objectAtIndex:i];
        for (int j = 0; j < 52; j++)
        {
            [record setCard:-1 AtIndex:j];
        }
    }
    
    for (int i = 0; i < 2; i++)
    {
        StackRecord* record = [self.delivers objectAtIndex:i];
        for (int j = 0; j < 52; j++)
        {
            [record setCard:-1 AtIndex:j];
        }
    }
    
    for (int i = 0; i < 4; i++)
    {
        StackRecord* record = [self.finishes objectAtIndex:i];
        for (int j = 0; j < 52; j++)
        {
            [record setCard:-1 AtIndex:j];
        }
    }
}

-(void)PrintOut
{
    for (int i = 0; i < 7; i++)
    {
        CCLOG(@"\nStack:%d",i);
        StackRecord* record = [self.statics objectAtIndex:i];
        
        for (int j = 0; j < 52; j++)
        {
            int tag = [record cardAtIndex:j];
            if(tag != -1)
            {
                GameScene* scene = [GameScene sharedGameScene];
                Card* card = [scene getCardByTag:tag];
                NSString* string = @"Uncovered";
                if([record coveredAtIndex:j])
                {
                    string = @"Covered";
                }
                CCLOG(@"%@ %@",card,string);
            }
            else
                break;
        }
    }
    
    for (int i = 0; i < 2; i++)
    {
        CCLOG(@"\nDeliver:%d",i);
        StackRecord* record = [self.delivers objectAtIndex:i];
        
        for (int j = 0; j < 52; j++)
        {
            int tag = [record cardAtIndex:j];
            if(tag != -1)
            {
                GameScene* scene = [GameScene sharedGameScene];
                Card* card = [scene getCardByTag:tag];
                NSString* string = @"Uncovered";
                if([record coveredAtIndex:j])
                {
                    string = @"Covered";
                }
                CCLOG(@"%@ %@",card,string);
            }
            else
                break;
        }
    }
    
    for (int i = 0; i < 4; i++)
    {
        CCLOG(@"\nFinish:%d",i);
        StackRecord* record = [self.finishes objectAtIndex:i];
        
        for (int j = 0; j < 52; j++)
        {
            int tag = [record cardAtIndex:j];
            if(tag != -1)
            {
                GameScene* scene = [GameScene sharedGameScene];
                Card* card = [scene getCardByTag:tag];
                NSString* string = @"Uncovered";
                if([record coveredAtIndex:j])
                {
                    string = @"Covered";
                }
                CCLOG(@"%@ %@",card,string);
            }
            else
                break;
        }
    }
}

@end
