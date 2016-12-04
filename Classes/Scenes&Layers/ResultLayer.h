//
//  ResultLayer.h
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-7-9.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "AlertLayer.h"
#import "LevelManager.h"
@interface ResultLayer : AlertLayer
{
    CCMenu*     _menu;
    GameModes   _mode;
    BOOL        _needStamp;
}

+(id)layerWithMode:(GameModes)mode;

@end
