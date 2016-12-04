//
//  CCMenuItemToggle+Helper.h
//  MineSweeper
//
//  Created by 张朴军 on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCMenuItem.h"

@interface CCMenuItemToggle (Helper)

+(CCMenuItemToggle*) switchWithOneFile:(NSString*)file Position:(CGPoint) position Target: (id)t selector: (SEL)sel;

+(CCMenuItemToggle *)switchWithOffFile:(NSString *)offFile OnFile:(NSString *)onFile Position:(CGPoint)position Target:(id)t selector:(SEL)sel;

+(CCMenuItemToggle *)switchWithOnDefault:(NSString *)onDefault OnSelected:(NSString *)onSelected OffDefault:(NSString *)offDefault  OffSelected:(NSString *)offSelected Position:(CGPoint)position Target:(id)t selector:(SEL)sel;



@end
