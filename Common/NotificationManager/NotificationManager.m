//
//  NotificationManager.m
//  Bacteria Dash
//
//  Created by 张朴军 on 13-7-15.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "NotificationManager.h"
#import "UserDefault.h"
@implementation NotificationManager
SYNTHESIZE_SINGLETON_FOR_CLASS(NotificationManager)

@synthesize notifications = _notifications;
-(id)init
{
    if(self = [super init])
    {
        bool level_data = [[UserDefault sharedUserDefault] boolForKey:@"NotificationManagerData"];
        if(level_data == false)
        {
            [[UserDefault sharedUserDefault] setBool:YES forKey:@"NotificationManagerData"];
            [[UserDefault sharedUserDefault] setBool:YES forKey:@"Notification_Energy"];
            [[UserDefault sharedUserDefault] setBool:YES forKey:@"Notification_LongTime"];
        }
        self.notifications = [NSMutableArray arrayWithCapacity:1];
        
        EnergyNotification* energy = [EnergyNotification notification];
        LongTimeNotification* longTime = [LongTimeNotification notification];
        
        [self.notifications addObject:energy];
        [self.notifications addObject:longTime];
    }
    return self;
}

-(void)dealloc
{
    self.notifications = nil;
    [super dealloc];
}

-(BOOL)notificationIsEnable:(NotificationID)notification_id
{
    LocalNotificationItem* item = [self.notifications objectAtIndex:notification_id];
    return item.enabled;
}
-(void)setNotificationIsEnable:(BOOL) enabled ID:(NotificationID)notification_id
{
    LocalNotificationItem* item = [self.notifications objectAtIndex:notification_id];
    item.enabled = enabled;
}

-(void)clean
{
    for (LocalNotificationItem* item in self.notifications)
    {
        [item clean];
    }
}

-(void)schedule
{
    for (LocalNotificationItem* item in self.notifications)
    {
        [item schedule];
    }
}

-(void)load
{
    EnergyNotification* energy = (EnergyNotification*)[self.notifications objectAtIndex:Notification_Energy];
    energy.enabled = [[UserDefault sharedUserDefault] boolForKey:@"Notification_Energy"];
    
    LongTimeNotification* longTime = (LongTimeNotification*)[self.notifications objectAtIndex:Notification_LongTime];
    longTime.enabled = [[UserDefault sharedUserDefault] boolForKey:@"Notification_LongTime"];
}

-(void)save
{
    EnergyNotification* energy = (EnergyNotification*)[self.notifications objectAtIndex:Notification_Energy];
    [[UserDefault sharedUserDefault] setBool:energy.enabled forKey:@"Notification_Energy"];
    
    LongTimeNotification* longTime = (LongTimeNotification*)[self.notifications objectAtIndex:Notification_LongTime];
    [[UserDefault sharedUserDefault] setBool:longTime.enabled forKey:@"Notification_LongTime"];
}
@end
