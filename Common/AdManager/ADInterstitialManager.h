//
//  ADInterstitialManager.h
//  IconTest
//
//  Created by 张朴军 on 13-10-10.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"

#import <GoogleMobileAds/GoogleMobileAds.h>
#import <iAd/iAd.h>


typedef NS_ENUM(NSUInteger, ADInterstitial)
{
    ADInterstitial_None       = 0,
    ADInterstitial_IAD        = 1,
    ADInterstitial_GAD        = 2,
    ADInterstitial_IAD_GAD    = 3,
};

@interface ADInterstitialManager : NSObject <ADInterstitialAdDelegate, GADInterstitialDelegate>
{
    UIViewController*   _rootViewController;
    
    GADInterstitial*    _GADView;
    NSString*           _GAD_ID;
    
    ADInterstitialAd *  _IADView;
    NSString*           _IAD_ID;
    
    
    ADInterstitial      _mode;
}

DECLARE_SINGLETON_FOR_CLASS(ADInterstitialManager)



@property (nonatomic, retain)UIViewController* rootViewController;

@property (nonatomic, retain)GADInterstitial *GADView;
@property (nonatomic, copy)NSString* GAD_ID;


@property (nonatomic, retain)ADInterstitialAd *IADView;
@property (nonatomic, copy)NSString* IAD_ID;

@property (nonatomic, assign)ADInterstitial mode;

@property (nonatomic, assign)NSRange intervalRange;
@property (nonatomic, assign)int showInterval;
@property (nonatomic, assign)int requestTimes;

-(void)GADShow;
-(void)IADShow;
-(BOOL)willShow;
-(void)show;
-(void)load;
@end
