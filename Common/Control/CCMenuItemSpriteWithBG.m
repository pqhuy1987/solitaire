//
//  CCMenuItemSpriteWithBG.m
//  ColorFlow
//
//  Created by 张朴军 on 13-3-6.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import "CCMenuItemSpriteWithBG.h"


@implementation CCMenuItemSpriteWithBG

@synthesize frontD = frontD_;
@synthesize frontH = frontH_;
@synthesize frontDis = frontDis_;

+(CCMenuItemSpriteWithBG*)itemFromBGFile:(NSString*)bg_file File:(NSString*)file Postion:(CGPoint)position target:(id)target selector:(SEL)selector
{
    CCMenuItemSpriteWithBG* item = nil;
    item = [[[self alloc] initFromBGFile:bg_file File:file Postion:position target:target selector:selector] autorelease];
    item.position = position;
    return item;
}

-(id)initFromBGFile:(NSString*)bg_file File:(NSString*)file Postion:(CGPoint)position target:(id)target selector:(SEL)selector
{
    CCSprite *item_D = [CCSprite spriteWithFile:bg_file];
    CCSprite *item_H = [CCSprite spriteWithFile:bg_file];
    item_H.color = ccc3(192, 192, 192);
    
    CCSprite *item_Dis = [CCSprite spriteWithFile:bg_file];
    item_Dis.color = ccc3(128, 128, 128);
    
    if(self = [super initWithNormalSprite:item_D selectedSprite:item_H disabledSprite:item_Dis target:target selector:selector])
    {
        self.frontD = [CCSprite spriteWithFile:file];
        self.frontH = [CCSprite spriteWithFile:file];
        self.frontH.color = ccc3(192, 192, 192);
        self.frontDis = [CCSprite spriteWithFile:file];
        self.frontDis.color = ccc3(128, 128, 128);
        
        frontD_.position = CGPointMake(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        frontH_.position = CGPointMake(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        frontDis_.position = CGPointMake(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        
        [self addChild:frontD_];
        [self addChild:frontH_];
        [self addChild:frontDis_];
        
        [self unselected];
    }
    return self;
}
-(void)dealloc
{
    self.frontD = nil;
    self.frontH = nil;
    self.frontDis = nil;
    [super dealloc];
}

-(void) selected
{
    self.frontH.visible = true;
    self.frontD.visible = false;
    self.frontDis.visible = false;
	[super selected];
    
	
}

-(void) unselected
{
    self.frontH.visible = false;
    self.frontD.visible = true;
    self.frontDis.visible = false;
	[super unselected];
	
}

-(void)setIsEnabled:(BOOL)enabled
{
    if(enabled)
    {
        self.frontH.visible = false;
        self.frontD.visible = true;
        self.frontDis.visible = false;
    }
    else
    {
        self.frontH.visible = false;
        self.frontD.visible = false;
        self.frontDis.visible = true;
    }
    [super setIsEnabled:enabled];
}

@end
