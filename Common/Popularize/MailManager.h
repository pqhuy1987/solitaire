//
//  MailManager.h
//  unblock
//
//  Created by 张朴军 on 12-12-26.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "CommonDefine.h"
@interface MailManager : NSObject<MFMailComposeViewControllerDelegate>
{
    NSString * subject_iPhone_;
    NSString * body_iPhone_;
    NSString * subject_iPad_;
    NSString * body_iPad_;
    UIViewController * rootViewController;
}
DECLARE_SINGLETON_FOR_CLASS(MailManager)

-(void)show;

-(void)load;

@end
