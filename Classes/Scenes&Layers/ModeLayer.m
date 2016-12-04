//
//  ModeScene.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-6.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "ModeLayer.h"
#import "TitleScene.h"
#import "GameScene.h"
#import "CCMenuItemSpriteWithLabel.h"
#import "CCMenuItemSprite+Helper.h"
#import "CCMenuItemToggle+Helper.h"
#import "AudioManager.h"
#import "PuzzleRecord.h"
#import "AbandonLayer.h"
@implementation ModeLayer


-(id) init
{
	if( (self = [super init]) )
    {
        CGPoint PosTitle;
        CGPoint PosTerminate;
        CGPoint PosOneLabel;
        CGPoint PosThreeLabel;
        CGPoint PosOne;
        CGPoint PosThree;
        CGPoint PosMusicLabel;
        CGPoint PosSoundLabel;
        CGPoint PosMusic;
        CGPoint PosSound;
        CGPoint PosBG;
        
        float   FontSize1;
        float   FontSize2;
        float   FontSize3;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosTitle        = CGPointMake(0,    244);
            PosTerminate    = CGPointMake(220,  318);
            PosOneLabel     = CGPointMake(-200, 122);
            PosThreeLabel   = CGPointMake(-200, 2);
            PosOne          = CGPointMake(64,   122);
            PosThree        = CGPointMake(64,   2);
            PosMusicLabel   = CGPointMake(-164,  -148);
            PosSoundLabel   = CGPointMake(-164,  -232);
            PosMusic        = CGPointMake(144,   -148);
            PosSound        = CGPointMake(144,   -232);
            PosBG           = CGPointMake(0,    0);
            
            FontSize1       = 40;
            FontSize2       = 60;
            FontSize3       = 36;
        }
        else
        {
            PosTitle        = CGPointMake(0,    122);
            PosTerminate    = CGPointMake(110,  159);
            PosOneLabel     = CGPointMake(-100, 61);
            PosThreeLabel   = CGPointMake(-100, 1);
            PosOne          = CGPointMake(32,   61);
            PosThree        = CGPointMake(32,   1);
            PosMusicLabel   = CGPointMake(-82,  -74);
            PosSoundLabel   = CGPointMake(-82,  -116);
            PosMusic        = CGPointMake(72,   -74);
            PosSound        = CGPointMake(72,   -116);
            PosBG           = CGPointMake(0,    0);
            
            FontSize1       = 20;
            FontSize2       = 30;
            FontSize3       = 18;
        }
        
		CCSprite* bg = [CCSprite spriteWithFile:@"bg_over.png"];
        bg.position = PosBG;
        [self.diag addChild:bg];
        
        
        CCLabelTTF* title = [CCLabelTTF labelWithString:NSLocalizedString(@"Options",nil) fontName:@"STHeitiK-Light" fontSize:FontSize2];
        title.position = PosTitle;
        [self.diag addChild:title];
        
        CCSprite* one = [CCSprite spriteWithFile:@"lb_draw_1.png"];
        one.position = PosOneLabel;
        [self.diag addChild:one];
        
        CCSprite* three = [CCSprite spriteWithFile:@"lb_draw_3.png"];
        three.position = PosThreeLabel;
        [self.diag addChild:three];
        
        
        CCLabelTTF* music = [CCLabelTTF labelWithString:NSLocalizedString(@"Music",nil) fontName:@"STHeitiK-Light" fontSize:FontSize1];
        music.position = PosMusicLabel;
        [self.diag addChild:music];
        
        CCLabelTTF* sound = [CCLabelTTF labelWithString:NSLocalizedString(@"Sound",nil) fontName:@"STHeitiK-Light" fontSize:FontSize1];
        sound.position = PosSoundLabel;
        [self.diag addChild:sound];
        
        
        CCLabelTTF* card1 = [CCLabelTTF labelWithString:NSLocalizedString(@"Draw One",nil) fontName:@"STHeitiK-Light" fontSize:FontSize1];
        card1.color = ccc3(18, 70, 121);
        CCMenuItemSpriteWithLabel* btOne = [CCMenuItemSpriteWithLabel itemWithDefault:@"bt_off_1.png" Selected:@"bt_on_1.png" Label:card1 Postion:PosOne target:self selector:@selector(OnOne:)];
        btOne.defaultColor = ccc3(18, 70, 121);
        btOne.selectedColor = ccWHITE;
        
        CCLabelTTF* card3 = [CCLabelTTF labelWithString:NSLocalizedString(@"Draw Three",nil) fontName:@"STHeitiK-Light" fontSize:FontSize1];
        card3.color = ccc3(18, 70, 121);
        CCMenuItemSpriteWithLabel* btThree = [CCMenuItemSpriteWithLabel itemWithDefault:@"bt_off_1.png" Selected:@"bt_on_1.png" Label:card3 Postion:PosThree target:self selector:@selector(OnThree:)];
        btThree.defaultColor = ccc3(18, 70, 121);
        btThree.selectedColor = ccWHITE;
        
        
        
        
        CCLabelTTF* musicOffLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"NO",nil) fontName:@"STHeitiK-Light" fontSize:FontSize3];
        musicOffLabel.color = ccc3(18, 70, 121);
        CCMenuItemSpriteWithLabel* btMusicOff = [CCMenuItemSpriteWithLabel itemWithDefault:@"bt_off_2.png" Selected:@"bt_on_2.png" Label:musicOffLabel Postion:PosMusic target:nil selector:nil];
        btMusicOff.defaultColor = ccc3(18, 70, 121);
        btMusicOff.selectedColor = ccWHITE;
        
        CCLabelTTF* musicOnLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"YES",nil) fontName:@"STHeitiK-Light" fontSize:FontSize3];
        musicOnLabel.color = ccc3(18, 70, 121);
        CCMenuItemSpriteWithLabel* btMusicOn = [CCMenuItemSpriteWithLabel itemWithDefault:@"bt_off_2.png" Selected:@"bt_on_2.png" Label:musicOnLabel Postion:PosMusic target:nil selector:nil];
        btMusicOn.defaultColor = ccc3(18, 70, 121);
        btMusicOn.selectedColor = ccWHITE;
        
        CCMenuItemToggle* btMusic = [CCMenuItemToggle itemWithTarget:self selector:@selector(OnMusic:) items:btMusicOff,btMusicOn,nil];
        btMusic.position = PosMusic;
        if([AudioManager sharedAudioManager].music != 0)
            btMusic.selectedIndex = 1;
        else
            btMusic.selectedIndex = 0;
        
        
        
        
        CCLabelTTF* soundOffLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"NO",nil) fontName:@"STHeitiK-Light" fontSize:FontSize3];
        soundOffLabel.color = ccc3(18, 70, 121);
        CCMenuItemSpriteWithLabel* btSoundOff = [CCMenuItemSpriteWithLabel itemWithDefault:@"bt_off_2.png" Selected:@"bt_on_2.png" Label:soundOffLabel Postion:PosMusic target:nil selector:nil];
        btSoundOff.defaultColor = ccc3(18, 70, 121);
        btSoundOff.selectedColor = ccWHITE;
        
        CCLabelTTF* soundOnLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"YES",nil) fontName:@"STHeitiK-Light" fontSize:FontSize3];
        soundOnLabel.color = ccc3(18, 70, 121);
        CCMenuItemSpriteWithLabel* btSoundOn = [CCMenuItemSpriteWithLabel itemWithDefault:@"bt_off_2.png" Selected:@"bt_on_2.png" Label:soundOnLabel Postion:PosMusic target:nil selector:nil];
        btSoundOn.defaultColor = ccc3(18, 70, 121);
        btSoundOn.selectedColor = ccWHITE;
        
        CCMenuItemToggle* btSound = [CCMenuItemToggle itemWithTarget:self selector:@selector(OnSound:) items:btSoundOff,btSoundOn,nil];
        btSound.position = PosSound;
        if([AudioManager sharedAudioManager].sound != 0)
            btSound.selectedIndex = 1;
        else
            btSound.selectedIndex = 0;
        
        CCMenuItemSprite* btTerminate    = [CCMenuItemSprite itemFromOneFile:@"bt_out.png"  Postion:PosTerminate   target:self selector:@selector(OnTerminate:)];
        
        _menu = [CCMenu menuWithItems: btTerminate, btOne, btThree, btMusic, btSound, nil];
        _menu.position = CGPointZero;
        [self.diag addChild: _menu];
        
	}
	return self;
}


-(void)onEnter
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    CGPoint target = ccp(screen.width * 0.5, screen.height * 0.5);
    diag_.position = ccp(screen.width * 0.5, -screen.height * 0.5);
    CCMoveTo* move = [CCMoveTo actionWithDuration:0.3 position:target];
    CCEaseIn* Bounce = [CCEaseIn actionWithAction:move rate:1.5];
    CCSequence* Sequence = [CCSequence actions:
                            Bounce,
                            nil];
    [diag_ runAction:Sequence];
    
    [super onEnter];
}

-(void)onEnterTransitionDidFinish
{
    [_menu setHandlerPriority:AlertLayerMenuHandlerPriority];
}

-(void) OnOne:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:@"button.mp3"];
    CCScene* s2 = [GameScene sceneWithMode:GameMode_One];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

-(void) OnThree:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:@"button.mp3"];
    CCScene* s2 = [GameScene sceneWithMode:GameMode_Three];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

-(void) OnMusic:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:@"button.mp3"];
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
    [[AudioManager sharedAudioManager] playEffect:@"button.mp3"];
    CCMenuItemToggle* soundSwitch= (CCMenuItemToggle*)sender;
    if(soundSwitch.selectedIndex == 0)
    {
        [AudioManager sharedAudioManager].sound = 0;
    }
    else
    {
        [AudioManager sharedAudioManager].sound = 1.0;
    }
}

-(void) OnTerminate:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:@"button.mp3"];
    CGSize screen = [CCDirector sharedDirector].winSize;
    CCMoveTo* move = [CCMoveTo actionWithDuration:0.3 position:ccp(screen.width * 0.5, -screen.height * 0.5)];
    CCEaseIn* Bounce = [CCEaseIn actionWithAction:move rate:1.5];
    CCCallFuncND* Call1 = [CCCallFuncND actionWithTarget:self selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
    CCSequence* Sequence = [CCSequence actions:Bounce, Call1,nil];
    [diag_ runAction:Sequence];
}

@end
