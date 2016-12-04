//
//  AlertLayer.m
//  MoveTheJewel
//
//  Created by 张朴军 on 13-3-5.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import "AlertLayer.h"


@implementation AlertLayer

@synthesize bg = bg_;
@synthesize diag = diag_;

+(id)layer;
{
    return [[[self alloc] init] autorelease];
}


-(id)init
{
    if(self = [super init])
    {
        self.color = ccBLACK;
        self.opacity = 128;
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.anchorPoint = ccp(0.5, 0.5);
            self.position = CGPointMake(0, 0);
        }
        else
        {
            self.ignoreAnchorPointForPosition = NO;
            self.anchorPoint = ccp(0.5, 0.5);
            
            self.position = CGPointMake(160, 240);
            CCLOG(@"%@ %@ %@",NSStringFromCGPoint(self.anchorPoint), NSStringFromCGSize(self.contentSize),NSStringFromCGRect(self.boundingBox));
        }
        diag_ = [CCNode node];
        diag_.position = ccp(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        [self addChild:diag_];
        
    }
    return self;
}

-(void)onEnter
{
    //  优先判断触摸
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kCCMenuHandlerPriority - 1 swallowsTouches:YES];
    [super onEnter];
}
- (void)onExit
{
    
	[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
@end
