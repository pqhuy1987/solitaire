//
//  Manager.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-2.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
@interface Manager : NSObject
{
    NSMutableArray* _array;
}

@property (nonatomic, retain)NSMutableArray* array;
DECLARE_SINGLETON_FOR_CLASS(Manager)

-(void)load;
-(void)save;
@end
