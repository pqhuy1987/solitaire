//
//  SocialManager.h
//  ZooLinkLink
//
//  Created by 穆暮 on 14-4-24.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "cocos2d.h"
@interface VZShareManager : NSObject
{
    
}

DECLARE_SINGLETON_FOR_CLASS(VZShareManager)

-(void) shareWithFile:(NSString*)filename;
-(void) shareWithScreenShot;
@end
