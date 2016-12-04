//
//  CCMenuItemColorLabel.m
//  Solitaire
//
//  Created by 张朴军 on 13-8-14.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "CCMenuItemColorLabel.h"


@implementation CCMenuItemColorLabel

@synthesize disabledColor = _disabledColor;

+(id) itemWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label
{
	return [[[self alloc] initWithLabel:label block:nil] autorelease];
}

+(id) itemWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label target:(id)target selector:(SEL)selector
{
	return [[[self alloc] initWithLabel:label target:target selector:selector] autorelease];
}

+(id) itemWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label block:(void(^)(id sender))block {
	return [[[self alloc] initWithLabel:label block:block] autorelease];
}


-(id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol>*)label target:(id)target selector:(SEL)selector
{
	// avoid retain cycle
	__block id t = target;
    
	self = [self initWithLabel:label block: ^(id sender) {
		[t performSelector:selector withObject:sender];
	}
			];
	return self;
}

//
// Designated initializer
//
-(id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol> *)label block:(void (^)(id))block
{
	if( (self=[self initWithBlock:block]) ) {
		self.defaultColor = label.color;
        self.selectedColor = ccc3(64 * 0.5 + self.defaultColor.r * 0.5, 64 * 0.5 + self.defaultColor.g * 0.5, 64 * 0.5 + self.defaultColor.b * 0.5);
		self.disabledColor = ccc3(128 * 0.5 + self.defaultColor.r * 0.5, 128 * 0.5 + self.defaultColor.g * 0.5, 128 * 0.5 + self.defaultColor.b * 0.5);
		self.label = label;
		
		self.cascadeColorEnabled = YES;
		self.cascadeOpacityEnabled = YES;
	}
    
	return self;
}

-(CCNode<CCLabelProtocol, CCRGBAProtocol>*) label
{
	return _label;
}
-(void) setLabel:(CCNode<CCLabelProtocol, CCRGBAProtocol>*) label
{
	if( label != _label ) {
		[self removeChild:_label cleanup:YES];
		[self addChild:label];
        
		_label = label;
		_label.anchorPoint = ccp(0,0);
        
		[self setContentSize:[_label contentSize]];
	}
}

-(void) setString:(NSString *)string
{
	[_label setString:string];
	[self setContentSize: [_label contentSize]];
}

-(void) activate {
	if(_isEnabled) {
		[self stopAllActions];
        
		[super activate];
	}
}

-(void) selected
{
	// subclass to change the default action
	if(_isEnabled) {
		[super selected];
		_label.color = self.selectedColor;
	}
}

-(void) unselected
{
	// subclass to change the default action
	if(_isEnabled) {
		[super unselected];
		_label.color = self.defaultColor;
	}
}

-(void) setIsEnabled: (BOOL)enabled
{
	if( _isEnabled != enabled ) {
		if(enabled == NO) {
			[_label setColor: _disabledColor];
		}
		else
			[_label setColor:self.defaultColor];
	}
    
	[super setIsEnabled:enabled];
}

@end
