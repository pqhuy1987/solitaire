//
//  CCMenuItemSpriteWithLabel.h
//  unblock
//
//  Created by 张朴军 on 12-12-19.
//  Copyright 2012年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCMenuItemSpriteWithLabel : CCMenuItemSprite
{
    CCNode<CCLabelProtocol, CCRGBAProtocol> *label_;
	ccColor3B	defaultColor_;
    ccColor3B	selectedColor_;
	ccColor3B	disabledColor_;
}

@property (nonatomic, retain)CCNode<CCLabelProtocol, CCRGBAProtocol>* label;

@property (nonatomic, assign)ccColor3B defaultColor;
@property (nonatomic, assign)ccColor3B selectedColor;
@property (nonatomic, assign)ccColor3B disabledColor;

+(CCMenuItemSpriteWithLabel*)itemFromOneFile:(NSString*)file Label:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label Postion:(CGPoint)position target:(id)target selector:(SEL)selector;

+(CCMenuItemSpriteWithLabel*)itemWithDefault:(NSString*)Default Selected:(NSString*)Selected Label:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label Postion:(CGPoint)position target:(id)target selector:(SEL)selector;

-(void) setString:(NSString *)string;
-(void) setLabelPosition:(CGPoint)Position;

@end
