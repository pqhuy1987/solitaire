//
//  StackRecord.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-1.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackRecord : NSObject <NSCoding>
{
    char _card[52];
    BOOL _covered[52];
}

-(void)setCard:(char)card AtIndex:(int)index;
-(char)cardAtIndex:(int)index;

-(void)setCovered:(BOOL)covered AtIndex:(int)index;
-(BOOL)coveredAtIndex:(int)index;
@end
