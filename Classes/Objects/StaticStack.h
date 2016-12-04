//
//  StaticStack.h
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-14.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "CardStack.h"

@interface StaticStack : CardStack

-(BOOL)canConnectWithCard:(Card*)card;

@end
