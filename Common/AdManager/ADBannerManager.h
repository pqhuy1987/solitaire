//
//  ADBannerManager.h
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-22.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <iAd/iAd.h>
#import <iAd/ADBannerView.h>

#define kADBannerManagerDidLoadAd  @"kInADBannerManagerDidLoadAd"
#define kADBannerManagerDidFailToReceiveAd  @"kInADBannerManagerDidFailToReceiveAd"

@class GADBannerView, GADRequest;

typedef NS_ENUM(NSUInteger, ADBannerMode)
{
    ADBanner_None       = 0,
    ADBanner_IAD        = 1,
    ADBanner_GAD        = 2,
    ADBanner_IAD_GAD    = 3,
};

@interface ADBannerManager : NSObject <ADBannerViewDelegate,GADBannerViewDelegate>
{
    UIViewController*  _rootViewController;
    
    GADBannerView*      _GADView;
    ADBannerView*       _IADView;
    BOOL                _isAdPositionAtTop;
    ADBannerMode        _mode;
    
    NSString*           _GAD_ID;
    NSString*           _IAD_ID;
    
    BOOL                _isIADEnable;
    BOOL                _isGADEnable;
    
    BOOL                _GADHasLoaded;
    BOOL                _hadAdShowing;
}

DECLARE_SINGLETON_FOR_CLASS(ADBannerManager)

@property (nonatomic, assign)BOOL isAdPositionAtTop;
@property (nonatomic, assign)ADBannerMode mode;
@property (nonatomic, retain)UIViewController* rootViewController;

@property (nonatomic, retain) GADBannerView* GADView;
@property (nonatomic, copy)NSString* GAD_ID;

@property (nonatomic, retain) ADBannerView* IADView;
@property (nonatomic, copy)NSString* IAD_ID;


-(void)setIADEnable:(BOOL)isEnable Animated:(BOOL)animated;
-(void)setGADEnable:(BOOL)isEnable Animated:(BOOL)animated;

-(void)remove;
-(void)load;

-(BOOL)hadADShowing;

@end
