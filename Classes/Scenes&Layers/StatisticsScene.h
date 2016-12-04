//
//  StatisticsScene.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-8-3.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AdjustLayer.h"
#import "LevelManager.h"
@interface StatisticsScene : AdjustLayer
{
    CCSprite*   _window;
    CCMenuItemToggle* _one;
    CCMenuItemToggle* _three;

    CCLabelTTF* _bestScore;
    CCLabelTTF* _bestMoves;
    CCLabelTTF* _gamesPlayed;
    CCLabelTTF* _won;
    CCLabelTTF* _percentage;
    
    GameModes   _mode;
}

+(CCScene *) scene;

-(void)loadDataForMode:(GameModes)mode;

@end
