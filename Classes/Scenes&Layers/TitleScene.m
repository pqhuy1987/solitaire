//
//  TitleScene.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-3.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "TitleScene.h"
#import "AudioManager.h"
#import "CCMenuItemSprite+Helper.h"
#import "CCMenuItemToggle+Helper.h"
#import "CCMenuItemSpriteWithLabel.h"
#import "CCMenuItemSpriteWithBG.h"

#import "HelpScene.h"
#import "GameScene.h"
#import "MyGameCenterManager.h"
#import "LevelManager.h"
#import "IdentifieManager.h"
#import "AudioManager.h"
#import "PuzzleRecord.h"
#import "AbandonLayer.h"
#import "AdBannerRespond.h"
#import "StatisticsScene.h"
@implementation TitleScene

@synthesize title = _title;
@synthesize option = _option;
@synthesize state = _state;
@synthesize ready = _ready;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	TitleScene *layer = [TitleScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self = [super init]) )
    {
        CGPoint PosTitle;
        CGPoint PosPlayBG;
        CGPoint PosPlay;
        CGPoint PosLeader;
        CGPoint PosHelp;
        CGPoint PosMusic;
        CGPoint PosSound;
        CGPoint PosStatics;
        
        CGPoint PosDrawOne;
        CGPoint PosDrawThree;
        CGPoint PosResume;
        CGPoint PosBack;
        
        CGPoint PosBG;
        
        float fontSize1;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosTitle    = CGPointMake(384,	880);
            PosPlayBG   = CGPointMake(384,	574);
            PosPlay     = CGPointMake(405,	574);
            
            PosLeader   = CGPointMake(135,	100);
            PosHelp     = CGPointMake(633,	100);
            PosMusic    = CGPointMake(305,	78);
            PosSound    = CGPointMake(464,	78);
            PosStatics  = CGPointMake(384,	224);
            
            PosDrawOne  = CGPointMake(384,	490);
            PosDrawThree= CGPointMake(384,	330);
            PosResume   = CGPointMake(384,	650);
            PosBack     = CGPointMake(132,	80);
            
            PosBG       = CGPointMake(384, 512);
            
            fontSize1   = 32;
        }
        else
        {
            PosTitle    = CGPointMake(160,	412);
            PosPlayBG   = CGPointMake(160,	265);
            PosPlay     = CGPointMake(170,	265);
            
            PosLeader   = CGPointMake(50,	45);
            PosHelp     = CGPointMake(270,	45);
            PosMusic    = CGPointMake(125,	35);
            PosSound    = CGPointMake(195,	35);
            PosStatics  = CGPointMake(160,	100);
            
            PosDrawOne  = CGPointMake(160,	235);
            PosDrawThree= CGPointMake(160,	165);
            PosResume   = CGPointMake(160,	305);
            PosBack     = CGPointMake(35,	34);
            
            PosBG       = CGPointMake(160, 240);
            
            CGSize screen = [CCDirector sharedDirector].winSize;
            if(screen.height == 568)
            {
                PosTitle    = CGPointMake(160,	434);
                
                PosLeader   = CGPointMake(50,	23);
                PosHelp     = CGPointMake(270,	23);
                PosMusic    = CGPointMake(125,	13);
                PosSound    = CGPointMake(195,	13);
                PosStatics  = CGPointMake(160,	78);
                
                PosBack     = CGPointMake(35,	12);
            }
            
            fontSize1   = 16;
        }
        
		CCSprite* bg = [CCSprite spriteWithFile:@"bg_title.png"];
        bg.position = PosBG;
        [self addChild:bg];
        
        CCSprite* title = [CCSprite spriteWithFile:@"lb_title.png"];
        title.position = PosTitle;
        [self addChild:title];
        
        
        self.title = [CCNode node];
        [self addChild:self.title];
        
        CCSprite* playBG = [CCSprite spriteWithFile:@"lb_border.png"];
        playBG.position = PosPlayBG;
        [self.title addChild:playBG];
        
        CCMenuItemSprite* btPlay    = [CCMenuItemSprite itemFromOneFile:@"bt_play.png"      Postion:PosPlay   target:self selector:@selector(OnPlay:)];
        
        
        CCLabelTTF* lb_static = [CCLabelTTF labelWithString:NSLocalizedString(@"Statistics",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        CCMenuItemSpriteWithLabel* btStatics = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_0.png" Label:lb_static Postion:PosStatics target:self selector:@selector(OnStatistics:)];
        [self addADRespondtoNode:btStatics];
        

        CCMenuItemSprite* btHelp    = [CCMenuItemSprite itemFromOneFile:@"bt_help.png"  Postion:PosHelp   target:self selector:@selector(OnRules:)];
        [self addADRespondtoNode:btHelp];
        
        CCMenuItemSprite* btLeader = [CCMenuItemSprite itemFromOneFile:@"bt_gamecenter.png" Postion:PosLeader target:self selector:@selector(OnLeader:)];
        [self addADRespondtoNode:btLeader];
        
        CCMenuItemToggle* btMusic = [CCMenuItemToggle switchWithOffFile:@"bt_music_off.png" OnFile:@"bt_music_on.png" Position:PosMusic Target:self selector:@selector(OnMusic:)];
        [self addADRespondtoNode:btMusic];
        if([AudioManager sharedAudioManager].music != 0)
            btMusic.selectedIndex = 1;
        else
            btMusic.selectedIndex = 0;
        
        CCMenuItemToggle* btSound = [CCMenuItemToggle switchWithOffFile:@"bt_sound_off.png" OnFile:@"bt_sound_on.png" Position:PosSound Target:self selector:@selector(OnSound:)];
        [self addADRespondtoNode:btSound];
        if([AudioManager sharedAudioManager].sound != 0)
            btSound.selectedIndex = 1;
        else
            btSound.selectedIndex = 0;
        
        CCMenu* menuTitle = [CCMenu menuWithItems:btStatics, btPlay, btHelp, btSound, btMusic, btLeader, nil];
        menuTitle.position = CGPointZero;
        [self.title addChild: menuTitle];
        
        self.option = [CCNode node];
        [self addChild:self.option];
        
        
        CCLabelTTF* lb_draw1 = [CCLabelTTF labelWithString:NSLocalizedString(@"Draw One",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        CCMenuItemSpriteWithLabel* btDraw1 = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_0.png" Label:lb_draw1 Postion:PosDrawOne target:self selector:@selector(OnDraw1:)];
        
        CCLabelTTF* lb_draw3 = [CCLabelTTF labelWithString:NSLocalizedString(@"Draw Three",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        CCMenuItemSpriteWithLabel* btDraw3 = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_0.png" Label:lb_draw3 Postion:PosDrawThree target:self selector:@selector(OnDraw3:)];
        
        CCLabelTTF* lb_resume = [CCLabelTTF labelWithString:NSLocalizedString(@"Resume",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        CCMenuItemSpriteWithLabel* btResume = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_0.png" Label:lb_resume Postion:PosResume target:self selector:@selector(OnResume:)];
        
        if([PuzzleRecord sharedPuzzleRecord].hasRecord)
        {
            btResume.isEnabled = YES;
        }
        else
        {
            btResume.isEnabled = NO;
        }
        
        CCMenuItemSprite* btBack = [CCMenuItemSprite itemFromOneFile:@"bt_return_0.png" Postion:PosBack target:self selector:@selector(OnBack:)];
        [self addADRespondtoNode:btBack];
        
        CCMenu* menuOption = [CCMenu menuWithItems:btDraw1, btDraw3, btResume, btBack, nil];
        menuOption.position = CGPointZero;
        [self.option addChild: menuOption];
        
        [self setState:TitleSceneState_Title Animated:NO];
        self.ready = YES;
        
        [[AudioManager sharedAudioManager] playBackgroundMusic:@"bgm.mp3" loop:YES];

	}
	return self;
}
-(void)dealloc
{
    self.title = nil;
    self.option = nil;
    [super dealloc];
}

-(void)addADRespondtoNode:(CCNode*)node
{
    AdBannerRespond* temp =  [AdBannerRespond node];
    [node addChild:temp];
    [temp load];
}

-(void)showTitleAnimated:(BOOL)isAnimated
{
    CGPoint PosTitle;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        PosTitle = ccp(0, 0);
    }
    else
    {
        PosTitle = ccp(0, 0);
    }
    
    if(isAnimated)
    {
        CCEaseIn* move = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:PosTitle]rate:1.5];
        CCCallBlock* block = [CCCallBlock actionWithBlock:^{self.ready = YES;}];
        CCSequence* sequence = [CCSequence actions:move, block, nil];
        [self.title runAction:sequence];
    }
    else
    {
        self.ready = YES;
        self.title.position = PosTitle;
    }
}

-(void)hideTitleAnimated:(BOOL)isAnimated
{
    CGPoint PosTitle;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        PosTitle = ccp(0, -768);
    }
    else
    {
        PosTitle = ccp(0, -568);
    }
    
    if(isAnimated)
    {
        CCEaseIn* move = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:PosTitle]rate:1.5];
        [self.title runAction:move];
    }
    else
    {
        self.title.position = PosTitle;
    }
}

-(void)showOptionAnimated:(BOOL)isAnimated
{
    CGPoint PosOption;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        PosOption = ccp(0, 0);
    }
    else
    {
        PosOption = ccp(0, 0);
    }
    
    if(isAnimated)
    {
        
        CCEaseIn* move = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:PosOption]rate:1.5];
        CCCallBlock* block = [CCCallBlock actionWithBlock:^{self.ready = YES;}];
        CCSequence* sequence = [CCSequence actions:move, block, nil];
        [self.option runAction:sequence];
    }
    else
    {
        self.option.position = PosOption;
        self.ready = YES;
    }
}

-(void)hideOptionAnimated:(BOOL)isAnimated
{
    CGPoint PosOption;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        PosOption = ccp(0, -768);
    }
    else
    {
        PosOption = ccp(0, -568);
    }
    
    if(isAnimated)
    {
        CCEaseIn* move = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:PosOption]rate:1.5];
        [self.option runAction:move];
    }
    else
    {
        self.option.position = PosOption;
    }
}

-(void)setState:(TitleSceneState)state Animated:(BOOL)isAnimated
{
    switch (state)
    {
        case TitleSceneState_Title:
            _state = state;
            self.ready = NO;
            [self showTitleAnimated:isAnimated];
            [self hideOptionAnimated:isAnimated];
            break;
        case TitleSceneState_Option:
            self.ready = NO;
            _state = state;
            [self hideTitleAnimated:isAnimated];
            [self showOptionAnimated:isAnimated];
            break;
        default:
            break;
    }
}

-(void)setReady:(BOOL)ready
{
    _ready = ready;
}

-(void) OnPlay:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    [self setState:TitleSceneState_Option Animated:YES];
}

-(void) OnStatistics:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCScene* s2 = [StatisticsScene scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

-(void) OnRules:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCScene* s2 = [HelpScene scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}


-(void) OnMusic:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCMenuItemToggle* musicSwitch= (CCMenuItemToggle*)sender;
    if(musicSwitch.selectedIndex == 0)
    {
        [AudioManager sharedAudioManager].music = 0;
    }
    else
    {
        [AudioManager sharedAudioManager].music = 1.0;
    }
}

-(void) OnSound:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    CCMenuItemToggle* musicSwitch= (CCMenuItemToggle*)sender;
    if(musicSwitch.selectedIndex == 0)
    {
        [AudioManager sharedAudioManager].sound = 0;
    }
    else
    {
        [AudioManager sharedAudioManager].sound = 1.0;
    }
}


-(void) OnDraw1:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    if([PuzzleRecord sharedPuzzleRecord].hasRecord)
    {
        AbandonLayer* layer = [AbandonLayer layerWithMode:GameMode_One Type:AbandonType_REPLAY];
        [self addChild:layer];
    }
    else
    {
        CCScene* s2 = [GameScene sceneWithMode:GameMode_One];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
    }
}

-(void) OnDraw3:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    if([PuzzleRecord sharedPuzzleRecord].hasRecord)
    {
        AbandonLayer* layer = [AbandonLayer layerWithMode:GameMode_Three Type:AbandonType_REPLAY];
        [self addChild:layer];
    }
    else
    {
        CCScene* s2 = [GameScene sceneWithMode:GameMode_Three];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
    }
    
}

-(void) OnResume:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    CCScene* s2 = [GameScene sceneWithMode:GameMode_Continue];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

-(void) OnLeader:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    [[MyGameCenterManager sharedMyGameCenterManager] showLeaderboardForCategory:[[IdentifieManager sharedIdentifieManager] GameCenter_IDByCategory:GameCenterCategory_One]];
}

-(void) OnBack:(id) sender
{
    if(!self.ready)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    [self setState:TitleSceneState_Title Animated:YES];
}


@end
