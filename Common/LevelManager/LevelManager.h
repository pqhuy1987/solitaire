//
//  LevelManager.h
//  unblock
//
//  Created by 张朴军 on 12-12-25.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "LevelInfo.h"

#define MAX_LEVELS        1

typedef enum
{
    GameMode_One = 0,
    GameMode_Three,
    GameMode_Continue,
    GameMode_Total,
}GameModes;

@interface LevelManager : NSObject
{
    NSMutableArray* _levels;
    GameModes       _mode;
    BOOL            _isTimeEnable;
    
}

@property (nonatomic, retain)NSMutableArray* levels;
@property (nonatomic, assign)GameModes mode;
@property (nonatomic, assign)BOOL isTimeEnable;

@property (nonatomic, assign)int BackgroundID;
@property (nonatomic, assign)int CardID;

DECLARE_SINGLETON_FOR_CLASS(LevelManager)





-(void)setBestScore:(float)score forMode:(GameModes)mode;
-(float)bestScoreForMode:(GameModes)mode;

-(void)setBestTime:(float)time forMode:(GameModes)mode;
-(float)bestTimeForMode:(GameModes)mode;

-(void)setMoves:(float)moves forMode:(GameModes)mode;
-(float)movesForMode:(GameModes)mode;

-(void)setRounds:(float)rounds forMode:(GameModes)mode;
-(float)roundsForMode:(GameModes)mode;

-(void)setWons:(float)wons forMode:(GameModes)mode;
-(float)wonsForMode:(GameModes)mode;


-(void)load;
-(void)save;
-(void)test;
@end
