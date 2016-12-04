//
//  Commodity.h
//  MoveTheJewel
//
//  Created by 张朴军 on 13-1-30.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commodity : NSObject
{
    int         amount_;
    float       price_;
    NSString*   productID_;
}
@property (nonatomic, readonly)int amount;
@property (nonatomic, readonly)float price;
@property (nonatomic, copy)NSString* productID;

+(id)commodityWithProductID:(NSString*)product_id Price:(float)price Amount:(int)amount;

@end
