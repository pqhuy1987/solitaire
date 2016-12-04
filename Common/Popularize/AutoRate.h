//
//  AutoRate.h
//  unblock
//
//  Created by 张朴军 on 13-1-16.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
@interface AutoRate : NSObject <UIAlertViewDelegate>
{
    bool    hadVote_;
    int     maxShowTimes_;
    int     showTimes_;
    int     showDelay_;
    int     requestTimes_;
}

DECLARE_SINGLETON_FOR_CLASS(AutoRate)

-(void)rate;
-(BOOL)wiiRate;
-(void)save;
-(void)load;

@end
