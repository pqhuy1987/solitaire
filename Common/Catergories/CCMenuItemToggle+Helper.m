//
//  CCMenuItemToggle+Helper.m
//  MineSweeper
//
//  Created by 张朴军 on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCMenuItemToggle+Helper.h"
#import "CCSprite.h"
#import "CCMenuItemColorLabel.h"
@implementation CCMenuItemToggle (Helper)


+(CCMenuItemToggle *)switchWithOneFile:(NSString *)file Position:(CGPoint) position Target:(id)t selector:(SEL)sel
{
    CCMenuItemToggle* toggle = nil;
    
    CCSprite *Off_D = [CCSprite spriteWithFile:file];
    Off_D.color = ccc3(128, 128, 128);
    CCSprite *Off_H = [CCSprite spriteWithFile:file];
    Off_H.color = ccc3(64, 64, 64);
    CCMenuItemSprite *btOff = [CCMenuItemSprite itemWithNormalSprite:Off_D selectedSprite:Off_H];
    
    
    CCSprite *On_D = [CCSprite spriteWithFile:file];
    CCSprite *On_H = [CCSprite spriteWithFile:file];
    On_H.color = ccc3(192, 192, 192);
    CCMenuItemSprite *btOn = [CCMenuItemSprite itemWithNormalSprite:On_D selectedSprite:On_H];

    toggle = [CCMenuItemToggle itemWithTarget:t selector:sel items:btOff,btOn,nil];
    toggle.position = position;
    
    return toggle;
}

+(CCMenuItemToggle *)switchWithOffFile:(NSString *)offFile OnFile:(NSString *)onFile Position:(CGPoint)position Target:(id)t selector:(SEL)sel
{
    CCMenuItemToggle* toggle = nil;
    
    CCSprite *Off_D = [CCSprite spriteWithFile:offFile];
    CCSprite *Off_H = [CCSprite spriteWithFile:offFile];
    Off_H.color = ccc3(192, 192, 192);
    CCMenuItemSprite *btOff = [CCMenuItemSprite itemWithNormalSprite:Off_D selectedSprite:Off_H];
    
    CCSprite *On_D = [CCSprite spriteWithFile:onFile];
    CCSprite *On_H = [CCSprite spriteWithFile:onFile];
    On_H.color = ccc3(192, 192, 192);
    CCMenuItemSprite *btOn = [CCMenuItemSprite itemWithNormalSprite:On_D selectedSprite:On_H];
    
    toggle = [CCMenuItemToggle itemWithTarget:t selector:sel items:btOff,btOn,nil];
    toggle.position = position;
    
    return toggle;
}



+(CCMenuItemToggle *)switchWithOnDefault:(NSString *)onDefault OnSelected:(NSString *)onSelected OffDefault:(NSString *)offDefault  OffSelected:(NSString *)offSelected Position:(CGPoint)position Target:(id)t selector:(SEL)sel
{
    CCMenuItemToggle* toggle = nil;
    
    CCSprite *Off_D = [CCSprite spriteWithFile:offDefault];
    CCSprite *Off_H = [CCSprite spriteWithFile:offSelected];
    CCMenuItemSprite *btOff = [CCMenuItemSprite itemWithNormalSprite:Off_D selectedSprite:Off_H];
    
    CCSprite *On_D = [CCSprite spriteWithFile:onDefault];
    CCSprite *On_H = [CCSprite spriteWithFile:onSelected];
    CCMenuItemSprite *btOn = [CCMenuItemSprite itemWithNormalSprite:On_D selectedSprite:On_H];
    
    toggle = [CCMenuItemToggle itemWithTarget:t selector:sel items:btOff,btOn,nil];
    toggle.position = position;
    return toggle;
}


@end
