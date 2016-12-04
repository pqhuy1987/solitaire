//
//  Commodity.m
//  MoveTheJewel
//
//  Created by 张朴军 on 13-1-30.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "Commodity.h"

@implementation Commodity

@synthesize amount = amount_;
@synthesize price = price_;
@synthesize productID = productID_;

+(id)commodityWithProductID:(NSString*)product_id Price:(float)price Amount:(int)amount
{
    return [[[self alloc] initWithProductID:product_id Price:price Amount:amount] autorelease];
}

-(id)initWithProductID:(NSString*)product_id Price:(float)price Amount:(int)amount
{
    if(self = [super init])
    {
        self.productID = product_id;
        price_ = price;
        amount_ = amount;
    }
    return self;
}

-(void)dealloc
{
    self.productID = nil;
    [super dealloc];
}

@end
