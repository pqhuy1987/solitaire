//
//  MoreGame.m
//  unblock
//
//  Created by 张朴军 on 12-12-27.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import "MoreGame.h"
#import "cocos2d.h"
#import "IdentifieManager.h"
@implementation MoreGame

SYNTHESIZE_SINGLETON_FOR_CLASS(MoreGame)

-(void) OnMoreGame:(id) sender
{
//    NSString *requestString = nil;
//    
//    requestString = [NSString stringWithFormat:@"http://www.fino-soft.com/moregames/index.php?appleid=%@&devicetype=%@&language=%@",
//                     [IdentifieManager sharedIdentifieManager].App_ID,
//                     [self deviceType],
//                     [self currentLanguage]];
//    
//    
//    NSURL *requestURL = [NSURL URLWithString:requestString];
//    // 更多游戏请求的返回值
//    NSString *responseString = [NSString stringWithContentsOfURL:requestURL encoding:NSUTF8StringEncoding error:nil];
//    CCLOG(@"[MoreGamesButton] moregames request URL: [%@], return: \"%@\"", requestString, responseString);
//    // 根据返回值确定跳转的策略
//    NSString *openURLString = (responseString != nil)?[responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]:@"0";//如果收到的返回值为空, 则跳转的连接为0, 否则跳转的连接为去掉空白的返回值
//    // 如果跳转的连接为0或空白, 则使用默认连接, 否则使用收到的返回值作为跳转连接
//    if ([openURLString isEqualToString:@"0"] || [openURLString isEqualToString:@""]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.com/apps/finosoftinc"]];
//    } else {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openURLString]];
//    }
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://longyun.webs.com"]];
}

- (NSString *)deviceType
{
    NSString *type = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)?@"iPhone":@"iPad";
    CCLOG(@"[MoreGamesButton] deviceType: %@", type);
    return type;
}

- (NSString *)currentLanguage
{
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    CCLOG(@"[MoreGamesButton] currentLanguage: %@", [languages objectAtIndex:0]);
    return [languages objectAtIndex:0];
}

@end
