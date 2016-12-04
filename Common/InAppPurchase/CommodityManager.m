//
//  CommodityManager.m
//  unblock
//
//  Created by 张朴军 on 13-1-18.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "CommodityManager.h"
#import "InAppPurchaseManager.h"
#import "IdentifieManager.h"
#import "cocos2d.h"
#import "UserDefault.h"
#import "SecurityUtil.h"
@implementation CommodityManager

@synthesize lifeData = _lifeData;
@synthesize timer = _timer;
@synthesize recoverTime = _recoverTime;
@synthesize date = _date;
@synthesize hadRated = _hadRated;
SYNTHESIZE_SINGLETON_FOR_CLASS(CommodityManager)

-(id)init
{
    if(self = [super init])
    {
        bool level_data = [[UserDefault sharedUserDefault] boolForKey:@"CommodityManagerData"];
        if(level_data==false)
        {
            NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
            [[UserDefault sharedUserDefault] setBool:true forKey:@"CommodityManagerData"];
            
            NSData *encryptedData = [SecurityUtil encryptAESDataInt:5];
            [[UserDefault sharedUserDefault] setObject:encryptedData     forKey:@"Commodity_Life"];
            [[UserDefault sharedUserDefault] setObject:date   forKey:@"Commodity_Date"];
            [[UserDefault sharedUserDefault] setFloat:0      forKey:@"Commodity_RecoverTime"];
            [[UserDefault sharedUserDefault] setBool:NO      forKey:@"Commodity_Rated"];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(verifyPurchase:) name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)dealloc
{
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

-(void)verifyPurchase:(NSNotification*)notify
{
//    NSDictionary *userInfo  = [notify userInfo];
//    SKPaymentTransaction* transaction = [userInfo objectForKey:@"transaction"];
//    
//    if([transaction.payment.productIdentifier isEqualToString:[[IdentifieManager sharedIdentifieManager] IdentiferOfProduct:Product_Hint_10]])
//    {
//        self.life = self.life + [[IdentifieManager sharedIdentifieManager] AmountOfProduct:Product_Hint_10];
//        [self save];
//    }
//    if([transaction.payment.productIdentifier isEqualToString:[[IdentifieManager sharedIdentifieManager] IdentiferOfProduct:Product_Hint_55]])
//    {
//        self.life = self.life + [[IdentifieManager sharedIdentifieManager] AmountOfProduct:Product_Hint_55];
//        [self save];
//    }
//    
//    if([transaction.payment.productIdentifier isEqualToString:[[IdentifieManager sharedIdentifieManager] IdentiferOfProduct:Product_Hint_125]])
//    {
//        self.life = self.life + [[IdentifieManager sharedIdentifieManager] AmountOfProduct:Product_Hint_125];
//        [self save];
//    }
//    
//    if([transaction.payment.productIdentifier isEqualToString:[[IdentifieManager sharedIdentifieManager] IdentiferOfProduct:Product_Hint_280]])
//    {
//        self.life = self.life + [[IdentifieManager sharedIdentifieManager] AmountOfProduct:Product_Hint_280];
//        [self save];
//    }
}

-(float)fullEnergyInterval
{
    float interval = 0;
    if([self life] < MAX_ENERGY)
    {
        interval = _recoverTime + (MAX_ENERGY - [self life] - 1) * RECOVER_MINUTE * 60;
    }
    return interval;
}

-(int)life
{
    return [SecurityUtil decryptAESDataInt:self.lifeData];
}

-(void)setLife:(int)life
{
    if(life < 0)
        life = 0;
    
    self.lifeData = [SecurityUtil encryptAESDataFloat:life];
    
    if([self life] < MAX_ENERGY)
    {
        if (_recoverTime <= 0)
        {
            _recoverTime = RECOVER_MINUTE * 60;
        }
    }
    else
    {
        _recoverTime = 0;
    }
}

-(void)load
{
    self.lifeData = [[UserDefault sharedUserDefault] objectForKey:@"Commodity_Life"];
    _recoverTime = [[UserDefault sharedUserDefault] floatForKey:@"Commodity_RecoverTime"];
    self.date = [[UserDefault sharedUserDefault] objectForKey:@"Commodity_Date"];
    self.hadRated =  [[UserDefault sharedUserDefault] boolForKey:@"Commodity_Rated"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval delta = [date timeIntervalSinceDate:self.date];
   
    self.date = date;
    if([self life] < MAX_ENERGY)
    {
        _recoverTime -= delta;
        if(_recoverTime <= 0)
        {
            _recoverTime = 0;
            [self setLife:[self life] + 1];
            
            while ([self life] < MAX_ENERGY && delta >= RECOVER_MINUTE * 60)
            {
                delta -= RECOVER_MINUTE * 60;
                [self setLife:[self life] + 1];
            }
            
            if([self life] < MAX_ENERGY)
            {
                _recoverTime = RECOVER_MINUTE * 60 - delta;
            }
        }
    }

    CCLOG(@"Energy:%d Time:%d",[self life],(int)_recoverTime);
}

-(void)update:(NSTimer *) timer
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval delta = [date timeIntervalSinceDate:self.date];
    self.date = date;
    
    if(_recoverTime > 0)
    {
        _recoverTime -= delta;
        if(_recoverTime <= 0)
        {
            [self setLife:[self life] + 1];
        }
    }
}

-(void)save
{
    [[UserDefault sharedUserDefault] setObject:self.lifeData     forKey:[NSString stringWithFormat:@"Commodity_Life"]];
    [[UserDefault sharedUserDefault] setFloat:_recoverTime forKey:@"Commodity_RecoverTime"];
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    [[UserDefault sharedUserDefault] setObject:date   forKey:@"Commodity_Date"];
    [[UserDefault sharedUserDefault] setBool:self.hadRated      forKey:@"Commodity_Rated"];
}


@end
