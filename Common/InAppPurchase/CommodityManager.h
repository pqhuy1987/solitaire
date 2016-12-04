//
//  CommodityManager.h
//  unblock
//
//  Created by 张朴军 on 13-1-18.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"

#define MAX_ENERGY 5
#define RECOVER_MINUTE 5
@interface CommodityManager : NSObject
{
    NSData*     _lifeData;
    float       _recoverTime;
    NSDate*     _date;
    NSTimer*    _timer;
    
    BOOL        _hadRated;
    
}

@property (nonatomic, copy)NSData* lifeData;
@property (nonatomic, assign)float recoverTime;
@property (nonatomic, retain)NSDate* date;
@property (nonatomic, retain)NSTimer* timer;
@property (nonatomic, assign)BOOL hadRated;

DECLARE_SINGLETON_FOR_CLASS(CommodityManager)

-(int)life;
-(void)setLife:(int)life;

-(void)load;
-(void)save;

-(float)fullEnergyInterval;
@end
