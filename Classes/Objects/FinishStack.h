//
//  FinishStack.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-6-18.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "CardStack.h"

@interface FinishStack : CardStack


-(BOOL)canConnectWithCard:(Card*)card;

@end
