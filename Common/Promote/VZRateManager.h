//
//  AutoRate.h
//  unblock
//
//  Created by 张朴军 on 13-1-16.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZCommonDefine.h"
@interface VZRateManager : NSObject <UIAlertViewDelegate>
{
    bool    _hadVote;
    int     _maxShowTimes;
    int     _showTimes;
    int     _showDelay;
    int     _requestTimes;
}

@property (nonatomic, strong)NSMutableDictionary* dictionary;

@property (nonatomic, assign)id delegate;
@property (nonatomic, assign)SEL ratedCallBackFunc;

VZ_DECLARE_SINGLETON_FOR_CLASS(VZRateManager)

-(BOOL)wiiRemind;
-(void)remind;

-(void)rate;



-(void)save;
-(void)load;

@end
