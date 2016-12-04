//
//  HelpScene.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-6.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "HelpScene.h"
#import "CCMenuItemSprite+Helper.h"
#import "TitleScene.h"
#import "AudioManager.h"
@implementation HelpScene

+(CCScene *)scene
{
    CCScene* scene = [CCScene node];
    HelpScene* layer = [HelpScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
	if( (self = [super initWithNibNamed:@"HelpScene"]) )
    {
        CGPoint PosTitle;
        CGPoint PosBox;
        CGPoint PosRules;
        CGPoint PosBack;
        CGPoint PosBG;
        float   FontSize;
        
         self.m_animView.alpha = 0;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosTitle    = CGPointMake(384,  940);
            PosBG       = CGPointMake(384,  512);
            
            
            
            
        }
        else
        {
            
            PosTitle    = CGPointMake(160,  440);
            PosBox      = CGPointMake(160,  260);
            PosRules    = CGPointMake(160,  270);
            PosBack     = CGPointMake(38,   84);
            PosBG       = CGPointMake(160,  240);
            FontSize    = 15;
            
            CGSize screen = [CCDirector sharedDirector].winSize;
            if(screen.height == 568)
            {
                PosTitle    = CGPointMake(160,  462);
                PosBack     = CGPointMake(38,   62);
            }
        }
        
        CCSprite* bg = [CCSprite spriteWithFile:@"bg_title.png"];
        bg.position = PosBG;
        [self addChild:bg];
        
        CCSprite* title = [CCSprite spriteWithFile:@"lb_rules.png"];
        title.position = PosTitle;
        [self addChild:title];
        
    
        self.m_animView.alpha = 0;
        
        [[AudioManager sharedAudioManager] playBackgroundMusic:@"bgm.mp3" loop:YES];
	}
	return self;
}

-(void)onEnter
{
    CCSequence* actions =[CCSequence actions:
                          [CCDelayTime actionWithDuration:0.5],
                          [CCCallFunc actionWithTarget:self selector:@selector(show)]
                          , nil];
    [self runAction:actions];
    CCDirector* director = [CCDirector sharedDirector];
    director.animationInterval = director.animationInterval * 2.0f;
    [super onEnter];
}

-(void)onExit
{
    CCDirector* director = [CCDirector sharedDirector];
    director.animationInterval = director.animationInterval * 0.5f;
    [super onExit];
}

-(void)hide
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.m_animView.alpha = 0;
	[UIView commitAnimations];
}

-(void)show
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.m_animView.alpha = 1;
	[UIView commitAnimations];
}

-(IBAction) OnBack:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    [self hide];
    CCScene* s2 = [TitleScene scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

@end
