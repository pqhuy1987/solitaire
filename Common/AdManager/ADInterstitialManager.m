//
//  ADInterstitialManager.m
//  IconTest
//
//  Created by 张朴军 on 13-10-10.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "ADInterstitialManager.h"
#import "AppDelegate.h"
#import "IdentifieManager.h"
#import "UserDefault.h"
@implementation ADInterstitialManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ADInterstitialManager)

@synthesize rootViewController = _rootViewController;

@synthesize GADView = _GADView;
@synthesize GAD_ID = _GAD_ID;


@synthesize IADView = _IADView;
@synthesize IAD_ID = _IAD_ID;

@synthesize mode = _mode;
-(id)init
{
    if(self = [super init])
    {
        bool level_data = [[UserDefault sharedUserDefault] boolForKey:@"ADInterstitialManagerData"];
        if(level_data == false)
        {
            [[UserDefault sharedUserDefault] setBool:YES forKey:@"ADInterstitialManagerData"];
            [[UserDefault sharedUserDefault] setInteger:0 forKey:@"ADInterstitialManager_ResquestTimes"];
        }
        self.intervalRange = NSMakeRange(1,1);
        self.showInterval = arc4random() % self.intervalRange.length + self.intervalRange.location;
        self.requestTimes = 0;
    }
    return self;
}

-(void)dealloc
{
    self.GADView.delegate = nil;
    self.GADView = nil;
    self.GAD_ID = nil;
    
    self.IADView.delegate = nil;
    self.IADView = nil;
    self.IAD_ID = nil;
    
    [super dealloc];
}

- (BOOL)canDisplayIAD
{
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    
    NSMutableSet* countries = [NSMutableSet setWithObjects:
                               @"AI",//Anguilla
                               @"AG",//Antigua & Barbuda
                               @"AR",//Argentina
                               @"AM",//Armenia
                               @"AU",//Australia
                               @"AT",//Austria
                               @"BS",//Bahamas
                               @"BB",//Barbados
                               @"BY",//Belarus
                               @"BE",//Belgium
                               @"BZ",//Belize
                               @"BM",//Bermuda
                               @"BO",//Bolivia
                               @"BW",//Botswana
                               @"BR",//Brazil
                               @"VG",//British Virgin Islands
                               @"BN",//Brunei Darussalam
                               @"BG",//Bulgaria
                               @"BF",//Burkina-Faso
                               @"KH",//Cambodia
                               @"CA",//Canada
                               @"CV",//Cape Verde
                               @"KY",//Cayman Islands
                               @"CL",//Chile
                               @"CO",//Colombia
                               @"CR",//Costa Rica
                               @"CY",//Cyprus
                               @"CZ",//Czech Republic
                               @"DK",//Denmark
                               @"DM",//Dominica
                               @"DO",//Dominican Republic
                               @"EC",//Ecuador
                               @"SV",//El Salvador
                               @"EE",//Estonia
                               @"FJ",//Fiji
                               @"FI",//Finland
                               @"FR",//France
                               @"GM",//Gambia
                               @"DE",//Germany
                               @"GH",//Ghana
                               @"GD",//Grenada
                               @"GR",//Greece
                               @"GT",//Guatemala
                               @"GW",//Guinea-Bissau
                               @"HN",//Honduras
                               @"HK",//Hong Kong
                               @"IN",//India
                               @"IE",//Ireland
                               @"IT",//Italy
                               @"JP",//Japan
                               @"KZ",//Kazakhstan
                               @"KE",//Kenya
                               @"KG",//Kyrgyzstan
                               @"LA",//Laos
                               @"LV",//Latvia
                               @"LT",//Lithuania
                               @"LU",//Luxembourg
                               @"MO",//Macau
                               @"MY",//Malaysia
                               @"MT",//Malta
                               @"MU",//Mauritius
                               @"MX",//Mexico
                               @"FM",//Micronesia
                               @"MN",//Mongolia
                               @"MZ",//Mozambique
                               @"NA",//Namibia
                               @"NP",//Nepal
                               @"NL",//Netherlands
                               @"NZ",//New Zealand
                               @"NI",//Nicaragua
                               @"NE",//Niger
                               @"NG",//Nigeria
                               @"NO",//Norway
                               @"PA",//Panama
                               @"PG",//Papua New Guinea
                               @"PY",//Paraguay
                               @"PE",//Peru
                               @"PL",//Poland
                               @"PT",//Portugal
                               @"RO",//Romania
                               @"RU",//Russia
                               @"SK",//Slovakia
                               @"SI",//Slovenia
                               @"ZA",//South Africa
                               @"ES",//Spain
                               @"LK",//Sri Lanka
                               @"VC",//St Kitts & Nevis
                               @"SZ",//Swaziland
                               @"SE",//Sweden
                               @"CH",//Switzerland
                               @"TW",//Taiwan
                               @"TJ",//Tajikistan
                               @"TH",//Thailand
                               @"TT",//Trinidad and Tobago
                               @"TR",//Turkey
                               @"TM",//Turkmenistan
                               @"UG",//Uganda
                               @"UA",//Ukraine
                               @"GB",//United Kingdom
                               @"US",//United States
                               @"VE",//Venezuela
                               @"ZW",//Zimbabwe
                               nil];
    if ([countries containsObject:countryCode])
    {
        return YES;
    }
    return NO;
}


-(BOOL)isGADAvailable
{
    
	Class gcClass = (NSClassFromString(@"GADInterstitial"));
	NSString *reqSysVer = @"4.3";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	return (gcClass && osVersionSupported);
}

-(BOOL)isIADAvailable
{
    
    if([self canDisplayIAD])
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            Class gcClass = (NSClassFromString(@"ADInterstitialAd"));
            NSString *reqSysVer = @"4.3";
            NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
            BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
            return (gcClass && osVersionSupported);
            
        }
        else
        {
            Class gcClass = (NSClassFromString(@"ADInterstitialAd"));
            NSString *reqSysVer = @"7.0";
            NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
            BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
            return (gcClass && osVersionSupported);
        }
    }
    return NO;
}

-(void)setMode:(ADInterstitial)mode
{
    
    BOOL isGADAvailable = [self isGADAvailable];
    BOOL isIADAvailable = [self isIADAvailable];
    
    switch (mode)
    {
        case ADInterstitial_None:
            _mode = mode;
            break;
        case ADInterstitial_IAD:
            if(isIADAvailable)
                _mode = mode;
            else if(isGADAvailable)
                _mode = ADInterstitial_GAD;
            else
                _mode = ADInterstitial_None;
            
            break;
        case ADInterstitial_GAD:
            if(isGADAvailable)
                _mode = mode;
            else if(isIADAvailable)
                _mode = ADInterstitial_IAD;
            else
                _mode = ADInterstitial_None;
            break;
        case ADInterstitial_IAD_GAD:
            
            if(isIADAvailable)
            {
                if(isGADAvailable)
                {
                     _mode = mode;
                }
                else
                {
                    _mode = ADInterstitial_IAD;
                }
            }
            else
            {
                if(isGADAvailable)
                {
                    _mode = ADInterstitial_GAD;
                }
                else
                {
                    _mode = ADInterstitial_None;
                }
            }
            break;
            
        default:
            break;
    }
}

-(BOOL)willShow
{
    if(self.requestTimes + 1 >= self.showInterval)
        return YES;
    return NO;
}

-(void)show
{
    self.requestTimes++;
    if(self.requestTimes >= self.showInterval)
    {
        self.requestTimes = 0;
        self.showInterval = arc4random() % self.intervalRange.length + self.intervalRange.location;
        switch (_mode)
        {
            case ADInterstitial_None:
                
                break;
            case ADInterstitial_IAD:
                [self IADShow];
                break;
            case ADInterstitial_GAD:
                [self GADShow];
                break;
            case ADInterstitial_IAD_GAD:
                if([self canDisplayIAD])
                {
                    if(self.IADView.loaded)
                    {
                        [self IADShow];
                    }
                    else if (self.GADView.isReady)
                    {
                        [self GADShow];
                    }
                    else
                    {
                        [self IADCycleInterstitial];
                        [self GADCycleInterstitial];
                    }
                }
                else
                {
                    if (self.GADView.isReady)
                    {
                        [self GADShow];
                    }
                    else
                    {
                        [self GADCycleInterstitial];
                    }
                }
                break;
                
            default:
                break;
        }
    }
}

-(void)load
{
    self.requestTimes = [[UserDefault sharedUserDefault] integerForKey:@"ADInterstitialManager_ResquestTimes"];
    switch (_mode)
    {
        case ADInterstitial_None:
            break;
        case ADInterstitial_IAD:
            [self IADCycleInterstitial];
            break;
        case ADInterstitial_GAD:
            [self GADCycleInterstitial];
            break;
        case ADInterstitial_IAD_GAD:
            [self GADCycleInterstitial];
            [self IADCycleInterstitial];
            break;
            
        default:
            break;
    }
}

#pragma mark IADInterstitial Creat

// 加载广告
-(void)IADCycleInterstitial
{
    self.IADView.delegate = nil;
    self.IADView = nil;
    
    self.IADView = [[[ADInterstitialAd alloc] init] autorelease];
    self.IADView.delegate = self;
    
    CCLOG(@"Request IAD");
}

// 显示广告
-(void)IADShow
{
    if(self.IADView.loaded)
    {
        if(self.rootViewController)
        {
            [self.IADView presentFromViewController:self.rootViewController];
        }
        else
        {
            CCLOG(@"[iAdInterstitial]: RootViewController is Null");
        }
    }
    else
    {
        [self IADCycleInterstitial];
        CCLOG(@"[iAdInterstitial]: No Content to show");
    }
}

#pragma mark IADInterstitialDelegate

// 加载广告失败
- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    [self performSelector:@selector(IADCycleInterstitial) withObject:self afterDelay:10];
    CCLOG(@"[iAdInterstitial]: Faild to load: %@", error);
}

// 广告加载完毕
- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{
    CCLOG(@"[iAdInterstitial]: IAD has loaded.");
}

// 广告消失
- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
 
}

//即将加载广告
- (void)interstitialAdWillLoad:(ADInterstitialAd *)interstitialAd
{
    
}

// 是否允许展示广告
- (BOOL)interstitialAdActionShouldBegin:(ADInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

/*!
 * @method interstitialAdActionDidFinish:
 * This message is sent when the action has completed and control is returned to
 * the application. Games, media playback, and other activities that were paused
 * in response to the beginning of the action should resume at this point.
 */
- (void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    [self IADCycleInterstitial];
    //[[CCDirector sharedDirector] resume];
}


#pragma mark GADInterstitial Creat

-(GADRequest *)createRequest
{
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as
    // well as any devices you want to receive test ads.
    request.testDevices =
    [NSArray arrayWithObjects:
     // TODO: Add your device/simulator test identifiers here. They are
     // printed to the console when the app is launched.
     nil];
    return request;
}

-(void)GADCycleInterstitial
{
//    if(self.GADView == nil)
//    {
//        self.GADView = [[[GADInterstitial alloc] init] autorelease];
//        self.GADView.delegate = self;
//        self.GADView.adUnitID = self.GAD_ID;
//    }
    
    self.GADView.delegate = nil;
    self.GADView = nil;

    self.GADView = [[[GADInterstitial alloc] init] autorelease];
    self.GADView.delegate = self;
    self.GADView.adUnitID = self.GAD_ID;
    [self.GADView loadRequest: [self createRequest]];
    
    CCLOG(@"Request GAD");
}

-(void)GADShow
{
    if(self.GADView.isReady)
    {
        if(self.rootViewController)
        {
            [self.GADView presentFromRootViewController:self.rootViewController];
            //[[CCDirector sharedDirector] pause];
        }
        else
        {
            CCLOG(@"[GAdInterstitial]: RootViewController is Null");
        }
    }
    else
    {
        [self GADCycleInterstitial];
        CCLOG(@"[GAdInterstitial]: No Content to show");
    }
}
#pragma mark GADInterstitialDelegate

// 加载失败
- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error
{
    //[self GADCycleInterstitial];
    
    [self performSelector:@selector(GADCycleInterstitial) withObject:self afterDelay:10];
    CCLOG(@"[GAdInterstitial]: Faild to load: %@", error);
}

// 加载成功
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
    CCLOG(@"[GAdInterstitial]: GAD has loaded.");
}

// 广告消失
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    [self GADCycleInterstitial];
    //[[CCDirector sharedDirector] resume];
}

// 即将展示
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad
{
    
}

// 即将消失
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
    
}

// 即将离开应用
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad
{
    
}

@end
