//
//  SettingLayer.h
//  Solitaire
//
//  Created by 穆暮 on 14-5-19.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "AlertLayer.h"

@interface SettingLayer : AlertLayer
{
    CCMenu*     _menu;
    BOOL        _isReady;
}

+(id)layerWithPosition:(CGPoint)point;

@end
