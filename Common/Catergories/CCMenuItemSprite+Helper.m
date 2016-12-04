//
//  CCMenuItemSprite+Helper.m
//  MineSweeper
//
//  Created by 张朴军 on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCMenuItemSprite+Helper.h"
#import "CCSprite.h"
@implementation CCMenuItemSprite (Helper)

+(CCMenuItemSprite *)itemFromOneFile:(NSString*)file Postion:(CGPoint)position target:(id)target selector:(SEL)selector
{
    CCMenuItemSprite* item = nil;
    CCSprite *item_D = [CCSprite spriteWithFile:file];
    CCSprite *item_H = [CCSprite spriteWithFile:file];
    item_H.color = ccc3(192, 192, 192);
    
    CCSprite *item_Dis = [CCSprite spriteWithFile:file];
    item_Dis.color = ccc3(128, 128, 128);
    
    item = [CCMenuItemSprite itemWithNormalSprite:item_D selectedSprite:item_H disabledSprite:item_Dis target:target selector:selector];
    
    item.position = position;
    return item;
}

+(CCMenuItemSprite *)itemDefault:(NSString *)file_D Selected:(NSString *)file_S Postion:(CGPoint)position target:(id)target selector:(SEL)selector
{
    CCMenuItemSprite* item = nil;
    
    CCSprite *item_D = [CCSprite spriteWithFile:file_D];
    CCSprite *item_H = [CCSprite spriteWithFile:file_S];
 
    CCSprite *item_Dis = [CCSprite spriteWithFile:file_D];
    item_Dis.color = ccc3(128, 128, 128);
    
    item = [CCMenuItemSprite itemWithNormalSprite:item_D selectedSprite:item_H disabledSprite:item_Dis target:target selector:selector];
    item.position = position;
    return item;
}


@end
