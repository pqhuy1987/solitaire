//
//  ResultLayer.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-7-9.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "ResultLayer.h"
#import "CCMenuItemSpriteWithLabel.h"
#import "CCMenuItemSprite+Helper.h"
#import "GameScene.h"
#import "TitleScene.h"
#import "CCFlipXLeftOver.h"
#import "CCFlipXRightOver.h"
#import "MyGameCenterManager.h"
#import "IdentifieManager.h"
#import "MailManager.h"
#import "AudioManager.h"
#import "AutoRate.h"
#import "VZShareManager.h"
#import "Appirater.h"
@implementation ResultLayer

+(id)layerWithMode:(GameModes)mode
{
    return [[[self alloc] initWithMode:mode] autorelease];
}

-(id)initWithMode:(GameModes)mode
{
    if(self = [super init])
    {
        _mode = mode;
        CGPoint PosBG;
        CGPoint PosTitle;
        CGPoint PosScore;
        CGPoint PosBest;
        CGPoint PosReplay;
        CGPoint PosHome;
        CGPoint PosShare;
        CGPoint PosGameCenter;

        float   SizeFont1;

        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosBG           = CGPointMake(0,    36);
            PosTitle        = CGPointMake(0,    290);
            PosScore        = CGPointMake(0,    186);
            PosBest         = CGPointMake(0,    92);
            PosReplay       = CGPointMake(-74,  -6);
            PosHome         = CGPointMake(-74,  -96);
            PosShare        = CGPointMake(-74,  -186);
            PosGameCenter   = CGPointMake(146,  -96);
            SizeFont1       = 32;
        }
        else
        {
            PosBG           = CGPointMake(0,    18);
            PosTitle        = CGPointMake(0,    145);
            PosScore        = CGPointMake(0, 93);
            PosBest         = CGPointMake(0, 46);
            PosReplay       = CGPointMake(-37,  -3);
            PosHome         = CGPointMake(-37,  -48);
            PosShare        = CGPointMake(-37,  -93);
            PosGameCenter   = CGPointMake(73,   -48);
            SizeFont1       = 16;
        }
        GameScene* scene = [GameScene sharedGameScene];
    
        [[MyGameCenterManager sharedMyGameCenterManager] submitScore:scene.score forCategory:[[IdentifieManager sharedIdentifieManager] GameCenter_IDByCategory:scene.mode]];

        _needStamp = NO;
        if(scene.score  > [[LevelManager sharedLevelManager] bestScoreForMode:scene.mode])
        {
            [[LevelManager sharedLevelManager] setBestScore:scene.score forMode:scene.mode];
            _needStamp = YES;
        }
        
        if(scene.move  < [[LevelManager sharedLevelManager] movesForMode:scene.mode] || [[LevelManager sharedLevelManager] movesForMode:scene.mode] == 0)
        {
            [[LevelManager sharedLevelManager] setMoves:scene.move forMode:scene.mode];
        }
        
        if(scene.time  < [[LevelManager sharedLevelManager] bestTimeForMode:scene.mode] || [[LevelManager sharedLevelManager] bestTimeForMode:scene.mode] == 0)
        {
            [[LevelManager sharedLevelManager] setBestTime:scene.time forMode:scene.mode];
        }
        
        [[LevelManager sharedLevelManager] setWons:[[LevelManager sharedLevelManager] wonsForMode:scene.mode] + 1 forMode:scene.mode];


        CCSprite* bg = [CCSprite spriteWithFile:@"bg_result.png"];
        bg.position = PosBG;
        [self.diag addChild:bg];
        
        CCSprite* title = [CCSprite spriteWithFile:@"lb_win.png"];
        title.position = PosTitle;
        [self.diag addChild:title];
        
        
        CCLabelTTF* score = [CCLabelTTF labelWithString:[NSString stringWithFormat:NSLocalizedString(@"Score: %d",nil), (int)scene.score] fontName:SYSTEM_FONT fontSize:SizeFont1];
        score.position = PosScore;
        [self.diag addChild:score];
        
        float bestScore = [[LevelManager sharedLevelManager] bestScoreForMode:scene.mode];
        
        CCLabelTTF* best = [CCLabelTTF labelWithString:[NSString stringWithFormat:NSLocalizedString(@"Best: %d",nil), (int)bestScore] fontName:SYSTEM_FONT fontSize:SizeFont1];
        best.position = PosBest;
        [self.diag addChild:best];
        
        
        
        

        CCLabelTTF* replay =  [CCLabelTTF labelWithString:NSLocalizedString(@"New Game",nil) fontName:SYSTEM_FONT fontSize:SizeFont1];
        CCMenuItemSpriteWithLabel* btReplay = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_1.png" Label:replay Postion:PosReplay target:self selector:@selector(OnReplay:)];
        
        CCLabelTTF* menu =  [CCLabelTTF labelWithString:NSLocalizedString(@"Menu",nil) fontName:SYSTEM_FONT fontSize:SizeFont1];
        CCMenuItemSpriteWithLabel* btHome = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_1.png" Label:menu Postion:PosHome target:self selector:@selector(OnHome:)];
        
        
        CCLabelTTF* share =  [CCLabelTTF labelWithString:NSLocalizedString(@"Share",nil) fontName:SYSTEM_FONT fontSize:SizeFont1];
        CCMenuItemSpriteWithLabel* btShare = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_1.png" Label:share Postion:PosShare target:self selector:@selector(OnShare:)];
        
        CCMenuItemSprite* btGameCenter = [CCMenuItemSprite itemFromOneFile:@"bt_gamecenter.png" Postion:PosGameCenter target:self selector:@selector(OnGameCenter:)];
       
        _menu = [CCMenu menuWithItems:btReplay, btHome, btShare, btGameCenter, nil];
        _menu.position = CGPointZero;
        [self.diag addChild:_menu];
    }
    return self;
}

-(void)onEnter
{
    CGPoint PosDiag;
    
    CGSize screen = [CCDirector sharedDirector].winSize;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        PosDiag = CGPointMake(384, 512);
    }
    else
    {
        PosDiag = CGPointMake(160, screen.height * 0.5);
    }

    CGPoint target = PosDiag;
    diag_.position = ccp(screen.width * 0.5, -screen.height * 0.5);
    CCMoveTo* move = [CCMoveTo actionWithDuration:0.3 position:target];
    CCEaseIn* Bounce = [CCEaseIn actionWithAction:move rate:1.5];
    CCSequence* Sequence = [CCSequence actions:
                            Bounce,
                            [CCCallBlock actionWithBlock:^{[self showRateOrAD];}],
                            nil];
    [diag_ runAction:Sequence];
    
    [super onEnter];
}

-(void)onEnterTransitionDidFinish
{
    
    CGPoint PosStamp;
        
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        PosStamp = CGPointMake(140, 108);
    }
    else
    {
        PosStamp = CGPointMake(70, 54);
    }

    
    
    [_menu setHandlerPriority:AlertLayerMenuHandlerPriority];
    
    if(_needStamp)
    {
        CCSprite* stamp = [CCSprite spriteWithFile:@"lb_stamp.png"];
        stamp.position = PosStamp;
        [self.diag addChild:stamp];
        stamp.scale = 2.0;
        CCSequence* sequence = [CCSequence actions:
                                [CCEaseIn actionWithAction:[CCScaleTo actionWithDuration:0.5 scale:1.0] rate:1.5],
                                nil];
        [stamp runAction:sequence];
    }
    
    [Appirater userDidSignificantEvent:YES];
    
}


-(void) OnReplay:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCScene* s2 = [GameScene sceneWithMode:_mode];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

-(void) OnHome:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCScene* s2 = [TitleScene scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

- (BOOL)isSocialAvailable
{
    // Check for presence of ADBannerView class.
    BOOL classAvailable = (NSClassFromString(@"UIActivityViewController")) != nil;
    
    // The device must be running iOS 6.0 or later.
    NSString *reqSysVer = @"6.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (classAvailable && osVersionSupported);
}

-(void) OnShare:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    if([self isSocialAvailable])
    {
        [[VZShareManager sharedVZShareManager] shareWithScreenShot];
    }
}

-(void) OnGameCenter:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    GameScene* scene = (GameScene*)self.parent;
    GameModes mode = scene.mode;
    [[MyGameCenterManager sharedMyGameCenterManager] showLeaderboardForCategory:[[IdentifieManager sharedIdentifieManager] GameCenter_IDByCategory:mode]];
    
}

@end
