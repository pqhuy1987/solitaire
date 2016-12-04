//
//  CCMenuItemSprite+Helper.h
//  MineSweeper
//
//  Created by 张朴军 on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCMenuItem.h"

@interface CCMenuItemSprite (Helper)

+(CCMenuItemSprite*)itemFromOneFile:(NSString*)file Postion:(CGPoint)position target:(id)target selector:(SEL)selector;

+(CCMenuItemSprite*)itemDefault:(NSString*)file_D Selected:(NSString*)file_S Postion:(CGPoint)position target:(id)target selector:(SEL)selector;

@end
