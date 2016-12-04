//
//  TitleScene.h
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-3.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCMenuItemSpriteWithLabel.h"
#import "AdjustLayer.h"

typedef enum
{
    TitleSceneState_Title = 0,
    TitleSceneState_Option,
}TitleSceneState;
@interface TitleScene : AdjustLayer
{
    CCNode*     _title;
    CCNode*     _option;
    TitleSceneState _state;
    BOOL        _ready;
    

}

@property (nonatomic, retain)CCNode* title;
@property (nonatomic, retain)CCNode* option;
@property (nonatomic, assign)TitleSceneState state;
@property (nonatomic, assign)BOOL ready;

+(CCScene *) scene;


@end
