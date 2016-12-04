//
//  AdBannerRespond.m
//  Solitaire
//
//  Created by 张朴军 on 13-8-22.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "AdBannerRespond.h"
#import "ADBannerManager.h"

@implementation AdBannerRespond

-(id)init
{
    if(self =[super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respond) name:kADBannerManagerDidLoadAd object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respond) name:kADBannerManagerDidFailToReceiveAd object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

-(void)setHadADBanner:(BOOL)hadADBanner Animated:(BOOL)isAnimated
{
    if(_hadADBanner == hadADBanner)
        return;
    _hadADBanner = hadADBanner;
    
    CGPoint delta;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(hadADBanner)
            delta = ccp(0, 90);
        else
            delta = ccp(0, -90);
    }
    else
    {
        if(hadADBanner)
            delta = ccp(0, 50);
        else
            delta = ccp(0, -50);
    }
    
    if (hadADBanner)
    {
        if(self.parent)
        {
            if(isAnimated)
            {
                CCEaseOut* moveUp = [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:0.25 position:delta] rate:1.5];
                [self.parent runAction:moveUp];
            }
            else
            {
                self.parent.position = ccpAdd(self.parent.position, delta);
            }
        }
    }
    else
    {
        if(self.parent)
        {
            if(isAnimated)
            {
                CCEaseOut* moveUp = [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:0.25 position:delta] rate:1.5];
                [self.parent runAction:moveUp];
            }
            else
            {
                self.parent.position = ccpAdd(self.parent.position, delta);
            }
        }
    }
}

-(void)respond
{
    [self setHadADBanner:[ADBannerManager sharedADBannerManager].hadADShowing Animated:YES];
}
-(void)load
{
    [self setHadADBanner:[ADBannerManager sharedADBannerManager].hadADShowing Animated:NO];
}
@end
