//
//  NotificationManager.h
//  Bacteria Dash
//
//  Created by 张朴军 on 13-7-15.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "EnergyNotification.h"
#import "LongTimeNotification.h"

typedef enum
{
    Notification_Energy = 0,
    Notification_LongTime,
}NotificationID;

@interface NotificationManager : NSObject
{
    NSMutableArray* _notifications;
}

@property (nonatomic, retain)NSMutableArray* notifications;

DECLARE_SINGLETON_FOR_CLASS(NotificationManager);


-(BOOL)notificationIsEnable:(NotificationID)notification_id;
-(void)setNotificationIsEnable:(BOOL) enabled ID:(NotificationID)notification_id;


-(void)schedule;
-(void)clean;

-(void)load;
-(void)save;

@end
