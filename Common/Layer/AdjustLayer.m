//
//  AdjustLayer.m
//  bubbleshooter
//
//  Created by 张朴军 on 12-11-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdjustLayer.h"


@implementation AdjustLayer

-(id)init
{
    if(self = [super init])
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
        }
        else
        {
            CGSize screen = [[CCDirector sharedDirector] winSize];
            self.position = CGPointMake(0, (screen.height - 480) * 0.5);
        }
    }
    return self;
}

@end
