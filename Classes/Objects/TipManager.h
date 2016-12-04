//
//  TipManager.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-5.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tip.h"
@interface TipManager : NSObject
{
    NSMutableArray* _tips;
    int             _tipIndex;
}

@property (nonatomic, retain)NSMutableArray* tips;
@property (nonatomic, assign)int tipIndex;

+(id)tipManager;
-(void)sort;
-(Tip*)nextTip;
@end
