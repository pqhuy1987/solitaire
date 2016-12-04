//
//  CCFlipXRightOver.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-12.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "CCFlipXRightOver.h"

@implementation CCFlipXRightOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kCCTransitionOrientationRightOver];
}
@end
