//
//  CCMenuItemColorLabel.h
//  Solitaire
//
//  Created by 张朴军 on 13-8-14.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCMenuItemColorLabel : CCMenuItem  <CCRGBAProtocol>
{
    CCNode<CCLabelProtocol, CCRGBAProtocol> *_label;
	ccColor3B	_defaultColor;
    ccColor3B   _selectedColor;
	ccColor3B	_disabledColor;
}

/** the color that will be used to disable the item */
@property (nonatomic,readwrite) ccColor3B defaultColor;
@property (nonatomic,readwrite) ccColor3B selectedColor;
@property (nonatomic,readwrite) ccColor3B disabledColor;

/** Label that is rendered. It can be any CCNode that implements the CCLabelProtocol */
@property (nonatomic,readwrite,assign) CCNode<CCLabelProtocol, CCRGBAProtocol>* label;

/** creates a CCMenuItemLabel with a Label. */
+(id) itemWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label;

/** creates a CCMenuItemLabel with a Label, target and selector.
 The "target" won't be retained.
 */
+(id) itemWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label target:(id)target selector:(SEL)selector;

/** creates a CCMenuItemLabel with a Label and a block to execute.
 The block will be "copied".
 */
+(id) itemWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label block:(void(^)(id sender))block;

/** initializes a CCMenuItemLabel with a Label, target and selector.
 Internally it will create a block that executes the target/selector.
 The "target" won't be retained.
 */
-(id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label target:(id)target selector:(SEL)selector;

/** initializes a CCMenuItemLabel with a Label and a block to execute.
 The block will be "copied".
 This is the designated initializer.
 */
-(id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label block:(void(^)(id sender))block;

/** sets a new string to the inner label */
-(void) setString:(NSString*)label;

/** Enable or disabled the CCMenuItemFont
 @warning setIsEnabled changes the RGB color of the font
 */
-(void) setIsEnabled: (BOOL)enabled;

@end
