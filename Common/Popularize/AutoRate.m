//
//  AutoRate.m
//  unblock
//
//  Created by 张朴军 on 13-1-16.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "AutoRate.h"
#import "IdentifieManager.h"
#import "UserDefault.h"
@implementation AutoRate

SYNTHESIZE_SINGLETON_FOR_CLASS(AutoRate)

-(id)init
{
    if (self = [super init])
    {
        bool autoRate = [[UserDefault sharedUserDefault] boolForKey:@"AutoRateData"];
        if(autoRate == false)
        {
            [[UserDefault sharedUserDefault] setBool:true forKey:@"AutoRateData"];
            [[UserDefault sharedUserDefault] setBool:NO   forKey:@"AutoRate_HadRated"];
            [[UserDefault sharedUserDefault] setInteger:0 forKey:@"AutoRate_ShowTimes"];
        }
	}
	return self;
}

-(void)dealloc
{
    [super dealloc];
}

-(void)save
{
    [[UserDefault sharedUserDefault] setBool:hadVote_         forKey:@"AutoRate_HadRated"];
    [[UserDefault sharedUserDefault] setInteger:showTimes_    forKey:@"AutoRate_ShowTimes"];
}

-(void)load
{
    hadVote_        = [[UserDefault sharedUserDefault] boolForKey:@"AutoRate_HadRated"];
    showTimes_      = [[UserDefault sharedUserDefault] integerForKey:@"AutoRate_ShowTimes"];
    maxShowTimes_   = 3;
    showDelay_      = 2;
    requestTimes_   = 0;
}

-(BOOL)wiiRate
{
    if(!hadVote_)
    {
        if(requestTimes_ + 1 >= showDelay_)
            return YES;
    }
    return NO;
}


-(void)rate
{
    if(hadVote_)
        return;
    if(showTimes_ >= maxShowTimes_)
        return;
    
    requestTimes_ ++ ;
    if(requestTimes_ >= showDelay_)
    {
        requestTimes_ = 0;
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Like The Game?",nil)
                                                    message:NSLocalizedString(@"Please support us by rating it in the App Store!",nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Remind me later",nil)
                                          otherButtonTitles:NSLocalizedString(@"Yes",nil), NSLocalizedString(@"No,Thanks",nil),nil];
        [alert show];
        [alert release];
        
        showTimes_++;
    }
    [self save];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    NSLog(@"%d",buttonIndex);
    if(buttonIndex == 1)
    {
        hadVote_=true;
        NSString *email = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=";
        email = [email stringByAppendingString:[IdentifieManager sharedIdentifieManager].App_ID];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:email]];
    }
    else if (buttonIndex == 2)
    {
        hadVote_=true;
    }
    else
    {
        
    }
}

@end
