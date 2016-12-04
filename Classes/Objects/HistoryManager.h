//
//  HistoryManager.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-6-20.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
@interface HistoryManager : NSObject
{
    NSMutableArray* _history;
}

@property (nonatomic, retain)NSMutableArray* history;

DECLARE_SINGLETON_FOR_CLASS(HistoryManager)

-(void)pushSteps:(NSArray*)steps;

-(void)load;
-(void)save;
@end
