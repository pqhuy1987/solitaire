//
//  LevelInfo.h
//  unblock
//
//  Created by 张朴军 on 12-12-25.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelInfo : NSObject
{
    float     _score;
    float     _time;
    float     _moves;
    float     _rounds;
    float     _wons;
}

@property (nonatomic, assign) float score;
@property (nonatomic, assign) float time;
@property (nonatomic, assign) float moves;
@property (nonatomic, assign) float rounds;
@property (nonatomic, assign) float wons;

+(id)info;

@end
