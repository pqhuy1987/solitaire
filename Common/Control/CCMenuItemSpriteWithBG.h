//
//  CCMenuItemSpriteWithBG.h
//  ColorFlow
//
//  Created by 张朴军 on 13-3-6.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCMenuItemSpriteWithBG : CCMenuItemSprite
{
    CCSprite*   frontD_;
    CCSprite*   frontH_;
    CCSprite*   frontDis_;
    
}
@property (nonatomic, retain)CCSprite* frontD;
@property (nonatomic, retain)CCSprite* frontH;
@property (nonatomic, retain)CCSprite* frontDis;

+(CCMenuItemSpriteWithBG*)itemFromBGFile:(NSString*)bg_file File:(NSString*)file Postion:(CGPoint)position target:(id)target selector:(SEL)selector;

@end
