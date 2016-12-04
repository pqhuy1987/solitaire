//
//  Tip.h
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-7-5.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tip : NSObject 
{
    int _pickStack;
    int _pickIndex;
    
    int _dropStack;
    
    int _priority;
}

@property (nonatomic, assign)int pickStack;
@property (nonatomic, assign)int pickIndex;
@property (nonatomic, assign)int dropStack;
@property (nonatomic, assign)int priority;

+(id)tip;

-(NSComparisonResult)compare:(Tip *)otherObject;

@end
