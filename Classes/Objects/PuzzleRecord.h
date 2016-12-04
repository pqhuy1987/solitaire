//
//  PuzzleRecord.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-1.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackRecord.h"
#import "LevelManager.h"
@interface PuzzleRecord : NSObject
{
    NSMutableArray* _statics;
    NSMutableArray* _delivers;
    NSMutableArray* _finishes;
    GameModes       _mode;
    BOOL            _hasRecord;
    
    float           _time;
    float           _score;
    float           _factor;
    float           _move;
}

@property (nonatomic, retain)NSMutableArray* statics;
@property (nonatomic, retain)NSMutableArray* delivers;
@property (nonatomic, retain)NSMutableArray* finishes;
@property (nonatomic, assign)GameModes mode;
@property (nonatomic, assign)BOOL hasRecord;

@property (nonatomic, assign)float time;
@property (nonatomic, assign)float score;
@property (nonatomic, assign)float factor;
@property (nonatomic, assign)float move;

DECLARE_SINGLETON_FOR_CLASS(PuzzleRecord)

-(void)load;
-(void)save;
-(void)PrintOut;
-(void)clear;
@end
