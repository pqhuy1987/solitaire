//
//  CCAnimation+Helper.m
//  SpriteBatchNode
//
//  Created by finosoft on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCAnimation+Helper.h"

@implementation CCAnimation (Helper)

+(CCAnimation *)animationWithFile:(NSString *)name frameCount:(int)frameCount delay:(float)delay
{
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    
    for (int i = 0; i < frameCount; ++i) 
    {
        NSString* file = [NSString stringWithFormat:@"%@%i.png", name, i];
        CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
        
        CGSize texSize = texture.contentSize;
        CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
        CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
        
        [frames addObject:frame];
    }
    CCAnimation* animation = [CCAnimation animationWithSpriteFrames:frames delay:delay];
    return animation;
}

+(CCAnimation *)animationWithFrame:(NSString *)frame frameCount:(int)frameCount delay:(float)delay
{
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    
    for (int i = 0; i < frameCount; ++i) 
    {
        NSString* file = [NSString stringWithFormat:@"%@%i.png", frame, i];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
    CCAnimation* animation = [CCAnimation animationWithSpriteFrames:frames delay:delay];
    return animation;
}

@end
