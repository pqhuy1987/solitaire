//
//  StatisticsScene.m
//  SpiderSolitaire
//
//  Created by 张朴军 on 13-8-3.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "StatisticsScene.h"
#import "CCMenuItemSprite+Helper.h"
#import "CCMenuItemToggle+Helper.h"
#import "LevelManager.h"
#import "TitleScene.h"
#import "CCMenuItemColorLabel.h"
#import "MyGameCenterManager.h"
#import "IdentifieManager.h"
#import "AudioManager.h"
#import "ResetLayer.h"
@implementation StatisticsScene

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	StatisticsScene *layer = [StatisticsScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self = [super init]) )
    {
        CGPoint PosTitle;
        CGPoint PosWindow;
        CGPoint PosBack;
        CGPoint PosReset;
        CGPoint PosOne;
        CGPoint PosThree;

        CGPoint PosBG;
        
        CGPoint PosBestScore;
        CGPoint PosBestScoreL;
        CGPoint PosMove;
        CGPoint PosMoveL;
        CGPoint PosGames;
        CGPoint PosGamesL;
        CGPoint PosWons;
        CGPoint PosWonsL;
        CGPoint PosPer;
        CGPoint PosPerL;
        
        float   fontSize;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosTitle        = CGPointMake(384, 927);
            PosWindow       = CGPointMake(419, 536);
            PosBack         = CGPointMake(100, 190);
            PosReset        = CGPointMake(419, 322);
            PosOne          = CGPointMake(118, 769);
            PosThree        = CGPointMake(118, 682);
            
            PosBG           = CGPointMake(384, 512);
            
            PosBestScore    = CGPointMake(444, 774);
            PosBestScoreL   = CGPointMake(549, 774);
            PosMove         = CGPointMake(444, 690);
            PosMoveL        = CGPointMake(549, 690);
            PosGames        = CGPointMake(444, 606);
            PosGamesL       = CGPointMake(549, 606);
            PosWons         = CGPointMake(444, 522);
            PosWonsL        = CGPointMake(549, 522);
            PosPer          = CGPointMake(444, 438);
            PosPerL         = CGPointMake(549, 438);
            
            fontSize        = 32;
        }
        else
        {
            PosTitle        = CGPointMake(160, 446);
            PosWindow       = CGPointMake(187, 265);
            PosBack         = CGPointMake(35,  83);
            PosReset        = CGPointMake(187, 155);
            PosOne          = CGPointMake(37,  380);
            PosThree        = CGPointMake(37,  335);
            
            PosBG           = CGPointMake(160, 240);
            
            PosBestScore    = CGPointMake(203, 380);
            PosBestScoreL   = CGPointMake(253, 380);
            PosMove         = CGPointMake(203, 338);
            PosMoveL        = CGPointMake(253, 338);
            PosGames        = CGPointMake(203, 296);
            PosGamesL       = CGPointMake(253, 296);
            PosWons         = CGPointMake(203, 254);
            PosWonsL        = CGPointMake(253, 254);
            PosPer          = CGPointMake(203, 214);
            PosPerL         = CGPointMake(253, 214);
            
            CGSize screen = [CCDirector sharedDirector].winSize;
            if(screen.height == 568)
            {
                PosTitle    = CGPointMake(160, 468);
                PosBack     = CGPointMake(38,   61);
            }

            fontSize        = 16;
        }
        
		CCSprite* bg = [CCSprite spriteWithFile:@"bg_title.png"];
        bg.position = PosBG;
        [self addChild:bg];
        
        CCSprite* title = [CCSprite spriteWithFile:@"lb_statistics.png"];
        title.position = PosTitle;
        [self addChild:title];
        
        
        _one = [CCMenuItemToggle switchWithOffFile:@"bt_drawOne_off.png" OnFile:@"bt_drawOne_on.png" Position:PosOne Target:self selector:@selector(OnOne:)];
        _one.position = PosOne;
        _one.selectedIndex = 1;
        _one.isEnabled = NO;
        
        _three = [CCMenuItemToggle switchWithOffFile:@"bt_drawThree_off.png" OnFile:@"bt_drawThree_on.png" Position:PosOne Target:self selector:@selector(OnThree:)];
        _three.position = PosThree;
        _three.selectedIndex = 0;
        _three.isEnabled = YES;
        
        CCMenuItemSprite* btBack = [CCMenuItemSprite itemFromOneFile:@"bt_return_1.png" Postion:PosBack target:self selector:@selector(OnBack:)];
        
        CCMenu* menu2 = [CCMenu menuWithItems: _one, _three, btBack, nil];
        menu2.position = CGPointZero;
        [self addChild: menu2];
        
        
        
        _window = [CCSprite spriteWithFile:@"bg_statistics.png"];
        _window.position = PosWindow;
        [self addChild:_window];
        
        CCLabelTTF* bestScore = [CCLabelTTF labelWithString:NSLocalizedString(@"Best score:",nil) fontName:SYSTEM_FONT fontSize:fontSize];
        bestScore.anchorPoint = ccp(1, 0.5);
        bestScore.position = PosBestScore;
        [self addChild:bestScore];
        
        CCLabelTTF* bestMove = [CCLabelTTF labelWithString:NSLocalizedString(@"Least moves:",nil) fontName:SYSTEM_FONT fontSize:fontSize];
        bestMove.position = PosMove;
        bestMove.anchorPoint = ccp(1, 0.5);
        [self addChild:bestMove];
        
    
        CCLabelTTF* games = [CCLabelTTF labelWithString:NSLocalizedString(@"Games played:",nil) fontName:SYSTEM_FONT fontSize:fontSize];
        games.position = PosGames;
        games.anchorPoint = ccp(1, 0.5);
        [self addChild:games];

        CCLabelTTF* won = [CCLabelTTF labelWithString:NSLocalizedString(@"Games won:",nil) fontName:SYSTEM_FONT fontSize:fontSize];
        won.position = PosWons;
        won.anchorPoint = ccp(1, 0.5);
        [self addChild:won];
        
        
        CCLabelTTF* percentage = [CCLabelTTF labelWithString:NSLocalizedString(@"Win percentage:",nil) fontName:SYSTEM_FONT fontSize:fontSize];
        percentage.position = PosPer;
        percentage.anchorPoint = ccp(1, 0.5);
        [self addChild:percentage];
        
        
        
        _bestScore   = [CCLabelTTF labelWithString:@"" fontName:SYSTEM_FONT fontSize:fontSize];
        _bestScore.position = PosBestScoreL;
        _bestScore.anchorPoint = ccp(0.5, 0.5);
        [self addChild:_bestScore];
        
        _bestMoves    = [CCLabelTTF labelWithString:@"" fontName:SYSTEM_FONT fontSize:fontSize];
        _bestMoves.position = PosMoveL;
        _bestMoves.anchorPoint = ccp(0.5, 0.5);
        [self addChild:_bestMoves];
        
        
        _gamesPlayed = [CCLabelTTF labelWithString:@"" fontName:SYSTEM_FONT fontSize:fontSize];
        _gamesPlayed.position = PosGamesL;
        _gamesPlayed.anchorPoint = ccp(0.5, 0.5);
        [self addChild:_gamesPlayed];
        
        _won         = [CCLabelTTF labelWithString:@"" fontName:SYSTEM_FONT fontSize:fontSize];
        _won.position = PosWonsL;
        _won.anchorPoint = ccp(0.5, 0.5);
        [self addChild:_won];
        
        
        _percentage  = [CCLabelTTF labelWithString:@"" fontName:SYSTEM_FONT fontSize:fontSize];
        _percentage.position = PosPerL;
        _percentage.anchorPoint = ccp(0.5, 0.5);
        [self addChild:_percentage];
        
        
        
        
        
     
        
        
        
        
        CCLabelTTF* lb_reset = [CCLabelTTF labelWithString:NSLocalizedString(@"Reset",nil) fontName:SYSTEM_FONT fontSize:fontSize];
        CCMenuItemSpriteWithLabel* btReset = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_0.png" Label:lb_reset Postion:PosReset target:self selector:@selector(OnReset:)];
        CCMenu* menu = [CCMenu menuWithItems:btReset, nil];
        menu.position = CGPointZero;
        [self addChild: menu];
        
        [self loadDataForMode:GameMode_One];
	}
	return self;
}

-(void)loadDataForMode:(GameModes)mode
{
    if([[LevelManager sharedLevelManager] roundsForMode:mode] > 0)
    {
        if([[LevelManager sharedLevelManager] wonsForMode:mode] > 0)
        {
            _bestScore.string = [NSString stringWithFormat:@"%.0f",[[LevelManager sharedLevelManager] bestScoreForMode:mode]];
            _bestMoves.string = [NSString stringWithFormat:@"%.0f",[[LevelManager sharedLevelManager] movesForMode:mode]];
            _gamesPlayed.string = [NSString stringWithFormat:@"%.0f",[[LevelManager sharedLevelManager] roundsForMode:mode]];
            _won.string = [NSString stringWithFormat:@"%.0f",[[LevelManager sharedLevelManager] wonsForMode:mode]];
            _percentage.string = [NSString stringWithFormat:@"%.0f%%",[[LevelManager sharedLevelManager] wonsForMode:mode] * 100 / [[LevelManager sharedLevelManager] roundsForMode:mode]];
        }
        else
        {
            _bestScore.string = @"--";
            _bestMoves.string = @"--";
            _gamesPlayed.string = [NSString stringWithFormat:@"%.0f",[[LevelManager sharedLevelManager] roundsForMode:mode]];
            _won.string = [NSString stringWithFormat:@"%.0f",[[LevelManager sharedLevelManager] wonsForMode:mode]];
            _percentage.string = [NSString stringWithFormat:@"%.0f%%",[[LevelManager sharedLevelManager] wonsForMode:mode] * 100 / [[LevelManager sharedLevelManager] roundsForMode:mode]];
        }
    }
    else
    {
        
        _bestScore.string = @"--";
        _bestMoves.string = @"--";
        _gamesPlayed.string = @"--";
        _won.string = @"--";
        _percentage.string =@"--";
    }
    
}

-(void) OnOne:(id) sender
{
    //[[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCMenuItemToggle* musicSwitch= (CCMenuItemToggle*)sender;
    if(musicSwitch.selectedIndex == 0)
    {
        
    }
    else
    {
        [self loadDataForMode:GameMode_One];
        _one.isEnabled = NO;
        
        _three.selectedIndex = 0;
        _three.isEnabled = YES;
        _mode = GameMode_One;
       
    }
}

-(void) OnThree:(id) sender
{
   //[[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCMenuItemToggle* musicSwitch= (CCMenuItemToggle*)sender;
    if(musicSwitch.selectedIndex == 0)
    {
        
    }
    else
    {
        [self loadDataForMode:GameMode_Three];
        _three.isEnabled = NO;
        _one.selectedIndex = 0;
        _one.isEnabled = YES;
        _mode = GameMode_Three;
    }
}

-(void) OnLeader:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    [[MyGameCenterManager sharedMyGameCenterManager] showLeaderboardForCategory:[[IdentifieManager sharedIdentifieManager] GameCenter_IDByCategory:_mode]];
}

-(void) OnReset:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    ResetLayer* layer = [ResetLayer layerWithMode:_mode];
    [self addChild:layer];
}

-(void) OnBack:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCScene* s2 = [TitleScene scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}



@end
