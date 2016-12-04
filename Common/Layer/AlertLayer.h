//
//  AlertLayer.h
//  MoveTheJewel
//
//  Created by 张朴军 on 13-3-5.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define AlertLayerHandlerPriority       kCCMenuHandlerPriority - 1
#define AlertLayerMenuHandlerPriority   AlertLayerHandlerPriority - 1

@interface AlertLayer : CCLayerColor
{
    CCNode* bg_;
    CCNode* diag_;
}

@property (nonatomic, readonly)CCNode* bg;
@property (nonatomic, readonly)CCNode* diag;

+(id)layer;

@end
