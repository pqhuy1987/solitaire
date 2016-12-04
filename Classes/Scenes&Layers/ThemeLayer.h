//
//  ThemeLayer.h
//  Solitaire
//
//  Created by 穆暮 on 14-5-19.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "AlertLayer.h"

@interface ThemeLayer : AlertLayer
{
    CCMenu*     _menu;
    
    CCMenuItemToggle* _btBG0;
    CCMenuItemToggle* _btBG1;
    CCMenuItemToggle* _btBG2;
    CCMenuItemToggle* _btBG3;
    
    CCMenuItemToggle* _btCard0;
    CCMenuItemToggle* _btCard1;
    CCMenuItemToggle* _btCard2;
    CCMenuItemToggle* _btCard3;
    CCMenuItemToggle* _btCard4;
    CCMenuItemToggle* _btCard5;
}

@property (nonatomic, assign)int backgroundID;
@property (nonatomic, assign)int cardID;

+(id)layer;

@end
