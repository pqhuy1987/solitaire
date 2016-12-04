//
//  AbandonLayer.h
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-7-10.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "AlertLayer.h"
#import "LevelManager.h"

typedef enum
{
    AbandonType_HOME = 0,
    AbandonType_REPLAY,
}AbandonType;

@interface AbandonLayer : AlertLayer
{
    CCMenu*     _menu;
    GameModes   _mode;
    AbandonType _type;
}

@property (nonatomic, assign)id delegate;

+(id)layerWithMode:(GameModes)mode Type:(AbandonType)type;


@end
