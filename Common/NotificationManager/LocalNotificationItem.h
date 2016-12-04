//
//  LocalNotificationItem.h
//  Bacteria Dash
//
//  Created by 张朴军 on 13-7-15.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationItem : NSObject
{
    BOOL        _enabled;
}

@property (nonatomic, assign)BOOL enabled;

+(id)notification;
-(void)schedule;
-(void)clean;

@end
