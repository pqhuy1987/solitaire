//
//  SoundBar.m
//  Fruit Connections Cut
//
//  Created by 张朴军 on 13-4-7.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "SoundBar.h"
#import "AudioManager.h"

@implementation SoundBar

-(void)onEnter
{
    
    [super onEnter];
}

- (void)onExit
{
	[super onExit];
}


-(void)setValue:(float)value
{
    [super setValue:value];
    [[AudioManager sharedAudioManager] setSound:value / _max];
}



@end
