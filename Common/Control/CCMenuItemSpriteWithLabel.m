//
//  CCMenuItemSpriteWithLabel.m
//  unblock
//
//  Created by 张朴军 on 12-12-19.
//  Copyright 2012年 张朴军. All rights reserved.
//

#import "CCMenuItemSpriteWithLabel.h"


@implementation CCMenuItemSpriteWithLabel

@synthesize label = label_;
@synthesize defaultColor = defaultColor_;
@synthesize selectedColor = selectedColor_;
@synthesize disabledColor = disabledColor_;

+(CCMenuItemSpriteWithLabel*)itemFromOneFile:(NSString*)file Label:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label Postion:(CGPoint)position target:(id)target selector:(SEL)selector
{
    CCMenuItemSpriteWithLabel* item = nil;
    item = [[[self alloc] initFromOneFile:file Label:label target:target selector:selector] autorelease];
    item.position = position;
    return item;
}

+(CCMenuItemSpriteWithLabel*)itemWithDefault:(NSString*)Default Selected:(NSString*)Selected Label:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label Postion:(CGPoint)position target:(id)target selector:(SEL)selector
{
    CCMenuItemSpriteWithLabel* item = nil;
    item = [[[self alloc] initWithDefault:Default Selected:Selected Label:label Postion:position target:target selector:selector] autorelease];
    item.position = position;
    return item;
}

-(id)initWithDefault:(NSString*)Default Selected:(NSString*)Selected Label:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label Postion:(CGPoint)position target:(id)target selector:(SEL)selector
{
    CCSprite *item_D = [CCSprite spriteWithFile:Default];
    CCSprite *item_H = [CCSprite spriteWithFile:Selected];
  
    CCSprite *item_Dis = [CCSprite spriteWithFile:Default];
    item_Dis.color = ccc3(128, 128, 128);
    
    if(self = [super initWithNormalSprite:item_D selectedSprite:item_H disabledSprite:item_Dis target:target selector:selector])
    {
        self.label = label;
        self.label.position = CGPointMake(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        defaultColor_ = self.label.color;
        selectedColor_ = ccc3(64 * 0.5 + defaultColor_.r * 0.5, 64 * 0.5 + defaultColor_.g * 0.5, 64 * 0.5 + defaultColor_.b * 0.5);
        disabledColor_ = ccc3(128 * 0.5 + defaultColor_.r * 0.5, 128 * 0.5 + defaultColor_.g * 0.5, 128 * 0.5 + defaultColor_.b * 0.5);
        [self addChild:self.label];
    }
    return self;
}

-(id)initFromOneFile:(NSString*)file Label:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label target:(id)target selector:(SEL)selector
{
    CCSprite *item_D = [CCSprite spriteWithFile:file];
    CCSprite *item_H = [CCSprite spriteWithFile:file];
    item_H.color = ccc3(192, 192, 192);
    
    CCSprite *item_Dis = [CCSprite spriteWithFile:file];
    item_Dis.color = ccc3(128, 128, 128);
    
    if(self = [super initWithNormalSprite:item_D selectedSprite:item_H disabledSprite:item_Dis target:target selector:selector])
    {
        self.label = label;
        self.label.position = CGPointMake(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        defaultColor_ = self.label.color;
        selectedColor_ = ccc3(64 * 0.5 + defaultColor_.r * 0.5, 64 * 0.5 + defaultColor_.g * 0.5, 64 * 0.5 + defaultColor_.b * 0.5);
        disabledColor_ = ccc3(128 * 0.5 + defaultColor_.r * 0.5, 128 * 0.5 + defaultColor_.g * 0.5, 128 * 0.5 + defaultColor_.b * 0.5);
        [self addChild:self.label];
    }
    return self;
}
-(void)dealloc
{
    self.label = nil;
    [super dealloc];
}

-(void) selected
{
	[super selected];
    self.label.color = selectedColor_;
}

-(void) unselected
{
	[super unselected];
	self.label.color = defaultColor_;
}

-(void)setIsEnabled:(BOOL)enabled
{
    if(enabled)
    {
        self.label.color = defaultColor_;
    }
    else
    {
        self.label.color = disabledColor_;
    }
    [super setIsEnabled:enabled];
}

-(void) setString:(NSString *)string
{
	[label_ setString:string];
}

-(void) setLabelPosition:(CGPoint)Position
{
    [label_ setPosition:Position];
}


@end
