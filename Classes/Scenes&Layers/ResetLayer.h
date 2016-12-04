//
//  ResetLayer.h
//  Solitaire
//
//  Created by 张朴军 on 13-8-22.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AlertLayer.h"
#import "LevelManager.h"
@interface ResetLayer : AlertLayer
{
    CCMenu*     _menu;
    GameModes   _mode;
}

+(id)layerWithMode:(GameModes)mode;

@end
