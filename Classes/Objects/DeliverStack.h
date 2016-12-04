//
//  DeliverStack.h
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-16.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "CardStack.h"

@interface DeliverStack : CardStack
{
    int     _drawn;
}

@property (nonatomic, assign)int drawn;

@end
