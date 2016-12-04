//
//  PopStack.h
//  Solitaire
//
//  Created by 张朴军 on 13-8-7.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "CardStack.h"

@interface PopStack : CardStack
{
    int _drawn;
}

@property (nonatomic, assign)int drawn;

@end
