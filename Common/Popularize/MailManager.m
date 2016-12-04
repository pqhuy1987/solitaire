//
//  MailManager.m
//  unblock
//
//  Created by 张朴军 on 12-12-26.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import "MailManager.h"
#import "cocos2d.h"
@implementation MailManager

SYNTHESIZE_SINGLETON_FOR_CLASS(MailManager)

-(id)init
{
    if(self = [super init])
    {
        subject_iPhone_ = @"Check out this game!";
        body_iPhone_    = @"<p>I just got this FREE game \" Solitaire\". It's awesome! I play it all day!<br>I bet you will love it too! If you don't have it, you can <a href='https://itunes.apple.com/us/app/solitaire-d/id691006211?ls=1&mt=8' style='font-weight:bold;font-size:1.25em;'>download</a> it for FREE from the app store!<br><a href='https://itunes.apple.com/us/app/solitaire-d/id691006211?ls=1&mt=8' style='font-weight:bold;font-size:1.25em;'>View in iTunes</a></p>";
        
        subject_iPad_   = @"Check out this game!";
        body_iPad_      = @"<p>I just got this FREE game \" Solitaire\". It's awesome! I play it all day!<br>I bet you will love it too! If you don't have it, you can <a href='https://itunes.apple.com/us/app/solitaire-d/id691006211?ls=1&mt=8' style='font-weight:bold;font-size:1.25em;'>download</a> it for FREE from the app store!<br><a href='https://itunes.apple.com/us/app/solitaire-d/id691006211?ls=1&mt=8' style='font-weight:bold;font-size:1.25em;'>View in iTunes</a></p>";
        
        rootViewController = [CCDirector sharedDirector].navigationController;
    }
    return self;
}

-(void)show
{
    if(!rootViewController)
    {
        NSLog(@"[Mail] warning: Not Root View Controller For Create Send Mail!");
        return;
    }
    
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"No Mail Accounts",nil)
                              message:NSLocalizedString(@"Please set up a Mail account in order to send email.",nil)
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK",nil)
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [picker setSubject:NSLocalizedString(subject_iPad_,nil)];
    }
    else
    {
        [picker setSubject:NSLocalizedString(subject_iPhone_,nil)];
    }
    
    // Attach an image to the email
    NSString *path = [[NSBundle mainBundle] pathForResource:@"img4mail" ofType:@"jpg"];
    NSData *myData = [NSData dataWithContentsOfFile:path];
    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"img4mail"];
    
    // Fill out the email body text
    NSString *emailBody = nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        emailBody = NSLocalizedString(body_iPad_,nil);
    }
    else
    {
        emailBody = NSLocalizedString(body_iPhone_,nil);
    }
    
    [picker setMessageBody:emailBody isHTML:YES];
    
    [rootViewController presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [rootViewController dismissModalViewControllerAnimated:YES];
}

-(void)load
{
    
}

@end
