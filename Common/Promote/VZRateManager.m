//
//  AutoRate.m
//  unblock
//
//  Created by 张朴军 on 13-1-16.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "VZRateManager.h"
#import "VZIdentifyManager.h"
#import "VZUserDefault.h"
#import "VZArchiveManager.h"

NSString *VZTemplateReviewURL = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";
NSString *VZTemplateReviewURLiOS7 = @"itms-apps://itunes.apple.com/app/idAPP_ID";

@implementation VZRateManager

VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZRateManager)

-(id)init
{
    if (self = [super init])
    {
        if(![[VZUserDefault sharedVZUserDefault] objectForKey:@"RateData"])
        {
            NSMutableDictionary* InitialDictionary = [NSMutableDictionary dictionary];
            
            NSNumber* hadRated  = [NSNumber numberWithBool:NO];
            NSNumber* showTimes = [NSNumber numberWithInt:0];
            
            [InitialDictionary setObject:hadRated forKey:@"RateEnable"];
            [InitialDictionary setObject:showTimes forKey:@"RateShowTimes"];
            
            [[VZUserDefault sharedVZUserDefault] setObject:InitialDictionary forKey:@"RateData"];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
        [self load];
	}
	return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)save
{
    NSNumber* hadRated  = [NSNumber numberWithBool:_hadVote];
    NSNumber* showTimes = [NSNumber numberWithInt:_showTimes];
    
    [self.dictionary setObject:hadRated forKey:@"RateEnable"];
    [self.dictionary setObject:showTimes forKey:@"RateShowTimes"];
    
    [[VZUserDefault sharedVZUserDefault] setObject:self.dictionary forKey:@"RateData"];
    [[VZUserDefault sharedVZUserDefault] synchronize];
}

-(void)load
{
    self.dictionary = [[VZUserDefault sharedVZUserDefault] objectForKey:@"RateData"];
    
    NSNumber* hadRated = [self.dictionary objectForKey:@"RateEnable"];
    _hadVote = [hadRated boolValue];
    
    NSNumber* showTimes = [self.dictionary objectForKey:@"RateShowTimes"];
    _showTimes = [showTimes intValue];
    
    _maxShowTimes   = 3;
    _showDelay      = 2;
    _requestTimes   = 0;
}

-(BOOL)wiiRemind
{
    if(!_hadVote)
    {
        if(_requestTimes + 1 >= _showDelay)
            return YES;
    }
    return NO;
}


-(void)remind
{
    if(_hadVote)
        return;
    if(_showTimes >= _maxShowTimes)
        return;
    
    _requestTimes ++ ;
    if(_requestTimes >= _showDelay)
    {
        _requestTimes = 0;
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Like The Game?",nil)
                                                    message:NSLocalizedString(@"Please support us by rating it in the App Store!",nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Remind me later",nil)
                                          otherButtonTitles:NSLocalizedString(@"Yes",nil), NSLocalizedString(@"No,Thanks",nil),nil];
        [alert show];
        _showTimes++;
    }
    [self save];
}

-(void)rate
{
    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Like The Game?",nil)
                                                message:NSLocalizedString(@"Please support us by rating it in the App Store!",nil)
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"Remind me later",nil)
                                      otherButtonTitles:NSLocalizedString(@"Yes",nil), NSLocalizedString(@"No,Thanks",nil),nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        _hadVote = true;
        NSString* appID = [[VZIdentifyManager sharedVZIdentifyManager] objectForIdentifyInfoDictionaryKey:kVZIdentifyAppID];
        
        NSString *reviewURL = [VZTemplateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", appID]];
        

		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
			reviewURL = [VZTemplateReviewURLiOS7 stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", appID]];
		}
        
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
        

        if(self.delegate && [self.delegate respondsToSelector:self.ratedCallBackFunc])
        {
            VZSuppressPerformSelectorLeakWarning([self.delegate performSelector:self.ratedCallBackFunc withObject:self]);
        }
        
    }
    else if (buttonIndex == 2)
    {
        _hadVote = true;
    }
    else
    {
        
    }
}

@end
