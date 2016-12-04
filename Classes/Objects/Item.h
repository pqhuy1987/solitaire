//
//  Item.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-2.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>
{
    int     _index;
    float   _value;
    BOOL    _blank;
}

@property (nonatomic, assign)int index;
@property (nonatomic, assign)float value;
@property (nonatomic, assign)BOOL blank;

@end
