//
//  PauseLayer.h
//  Solitaire
//
//  Created by 张朴军 on 13-8-14.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AlertLayer.h"
#import "LevelManager.h"
@interface PauseLayer : AlertLayer
{
    CCMenu*     _menu;
}

+(id)layer;

@end
