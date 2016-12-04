//
//  SocialManager.m
//  ZooLinkLink
//
//  Created by 穆暮 on 14-4-24.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "VZShareManager.h"
#import "cocos2d.h"
#import "VZShareViewController.h"
@implementation VZShareManager

SYNTHESIZE_SINGLETON_FOR_CLASS(VZShareManager)

-(void) shareWithFile:(NSString*)filename
{
    
    UIViewController* view = [CCDirector sharedDirector];
    
    if([self isSocialAvailable])
    {
        UIImage* viewImage = [UIImage imageNamed:filename];
        
        NSString* shareContent = NSLocalizedString(@"Solitaire Time! It was a very addictive game. Join us!", nil);
        NSString* downloadLink = @"https://itunes.apple.com/app/id1059716144";
        
        NSURL* url = [NSURL URLWithString:downloadLink];
        
        NSArray *activityItems = [NSArray arrayWithObjects:NSLocalizedString(shareContent, nil), viewImage, url, nil];
        
       
        
        VZShareViewController *activityController =
        
        [[VZShareViewController alloc] initWithActivityItems:activityItems  applicationActivities:nil];
        
        [view presentViewController:activityController  animated:YES completion:nil];
        

    }
}

-(void) shareWithScreenShot;
{
    UIViewController* view = [CCDirector sharedDirector];
        
    if([self isSocialAvailable])
    {
        [CCDirector sharedDirector].nextDeltaTimeZero = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCRenderTexture* renTxture =[CCRenderTexture renderTextureWithWidth:winSize.width height:winSize.height];
        [renTxture begin];
        [[CCDirector sharedDirector].runningScene visit];
        [renTxture end];
        UIImage* viewImage = [UIImage imageWithData:UIImageJPEGRepresentation([renTxture getUIImage], 1.0)];
        
       
        
        NSString* shareContent = NSLocalizedString(@"Solitaire Time! It was a very addictive game. Join us!", nil);
        NSString* downloadLink = @"https://itunes.apple.com/app/id1059716144";
        
        NSURL* url = [NSURL URLWithString:downloadLink];
        
        NSArray *activityItems = [NSArray arrayWithObjects:NSLocalizedString(shareContent, nil), viewImage, url, nil];
        
        
        
        VZShareViewController *activityController =
        
        [[VZShareViewController alloc] initWithActivityItems:activityItems  applicationActivities:nil];
        
        UIActivityViewControllerCompletionHandler myBlock = ^(NSString *activityType,BOOL completed)
        {
            NSLog(@"%@\\", activityType);
            if(completed)
            {
                NSLog(@"completed\\");
                
            }
            else
            {
                NSLog(@"cancled\\");
            }
            [activityController dismissViewControllerAnimated:YES completion:Nil];
            [[CCDirector sharedDirector] resume];
            [[CCDirector sharedDirector] startAnimation];
        };
        
        activityController.completionHandler = myBlock;
    
        
        
        
        
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            activityController.popoverPresentationController.sourceView = view.view;
            CGRect old = view.view.frame;
            activityController.popoverPresentationController.sourceRect = CGRectMake(old.size.width * 0.5, old.size.height * 0.78, 0, 0);
            activityController.popoverPresentationController.barButtonItem = nil;
        }
        
        [view presentViewController:activityController  animated:YES completion:
         ^{
             [[CCDirector sharedDirector] pause];
             [[CCDirector sharedDirector] stopAnimation];
         }];
    }
    
}


- (BOOL)isSocialAvailable
{
    // Check for presence of ADBannerView class.
    BOOL classAvailable = (NSClassFromString(@"UIActivityViewController")) != nil;
    
    // The device must be running iOS 6.0 or later.
    NSString *reqSysVer = @"6.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (classAvailable && osVersionSupported);
}



@end
