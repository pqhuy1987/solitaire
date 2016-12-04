//
//  ThemeLayer.m
//  Solitaire
//
//  Created by 穆暮 on 14-5-19.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "ThemeLayer.h"
#import "CCMenuItemSpriteWithLabel.h"
#import "CCMenuItemToggle+Helper.h"
#import "GameScene.h"
#import "AudioManager.h"
@implementation ThemeLayer

+(id)layer
{
    return [[[self alloc] init] autorelease];
}

-(id)init
{
    if(self = [super init])
    {
        CGPoint PosBG;
        CGPoint PosBGL;
        CGPoint PosCardL;
        CGPoint PosBG0;
        CGPoint PosBG1;
        CGPoint PosBG2;
        CGPoint PosBG3;
        
        CGPoint PosCard0;
        CGPoint PosCard1;
        CGPoint PosCard2;
        CGPoint PosCard3;
        CGPoint PosCard4;
        CGPoint PosCard5;
        
        CGPoint PosOK;
        
        
        float   SizeFont1;
        float   SizeFont2;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosBG       = ccp(0,    50);
            PosBGL      = ccp(0, 	296);
            PosCardL    = ccp(0,    76);
            PosBG0      = ccp(-150,  184);
            PosBG1      = ccp(-50,  184);
            PosBG2      = ccp(50,   184);
            PosBG3      = ccp(150,   184);
            
            PosCard0    = ccp(-200, -36);
            PosCard1    = ccp(-120,  -36);
            PosCard2    = ccp(-40,  -36);
            PosCard3    = ccp(40,   -36);
            PosCard4    = ccp(120,   -36);
            PosCard5    = ccp(200,  -36);
            
            PosOK       = ccp(0,    -168);
            SizeFont1       = 40;
            SizeFont2   = 32;
        }
        else
        {
            PosBG       = ccp(0,    25);
            PosBGL      = ccp(0, 	148);
            PosCardL    = ccp(0,    38);
            PosBG0      = ccp(-75,  92);
            PosBG1      = ccp(-25,  92);
            PosBG2      = ccp(25,   92);
            PosBG3      = ccp(75,   92);
            
            PosCard0    = ccp(-100, -18);
            PosCard1    = ccp(-60,  -18);
            PosCard2    = ccp(-20,  -18);
            PosCard3    = ccp(20,   -18);
            PosCard4    = ccp(60,   -18);
            PosCard5    = ccp(100,  -18);
            
            PosOK       = ccp(0,    -84);
            SizeFont1       = 20;
            SizeFont2   = 16;
            
            
        }
        
        
        self.opacity = 0;
        
        CCSprite* bg = [CCSprite spriteWithFile:@"bg_themes.png"];
        bg.position = PosBG;
        [self.diag addChild:bg];
        
        
        CCLabelTTF* background = [CCLabelTTF labelWithString:NSLocalizedString(@"Background", nil) fontName:SYSTEM_FONT fontSize:SizeFont2];
        background.position = PosBGL;
        [self.diag addChild:background];
        
        
        _btBG0 = [CCMenuItemToggle switchWithOffFile:@"bt_bg_0_off.png" OnFile:@"bt_bg_0_on.png" Position:PosBG0 Target:self selector:@selector(OnSwitchBG:)];
        _btBG0.position = PosBG0;
        _btBG0.tag = 0;
        
        _btBG1 = [CCMenuItemToggle switchWithOffFile:@"bt_bg_1_off.png" OnFile:@"bt_bg_1_on.png" Position:PosBG1 Target:self selector:@selector(OnSwitchBG:)];
        _btBG1.position = PosBG1;
        _btBG1.tag = 1;
        
        _btBG2 = [CCMenuItemToggle switchWithOffFile:@"bt_bg_2_off.png" OnFile:@"bt_bg_2_on.png" Position:PosBG2 Target:self selector:@selector(OnSwitchBG:)];
        _btBG2.position = PosBG2;
        _btBG2.tag = 2;
        
        _btBG3 = [CCMenuItemToggle switchWithOffFile:@"bt_bg_3_off.png" OnFile:@"bt_bg_3_on.png" Position:PosBG3 Target:self selector:@selector(OnSwitchBG:)];
        _btBG3.position = PosBG3;
        _btBG3.tag = 3;
        

        
        
        
        CCLabelTTF* card = [CCLabelTTF labelWithString:NSLocalizedString(@"Card", nil)  fontName:SYSTEM_FONT fontSize:SizeFont2];
        card.position = PosCardL;
        [self.diag addChild:card];
        
        _btCard0 = [CCMenuItemToggle switchWithOffFile:@"bt_card_0_off.png" OnFile:@"bt_card_0_on.png" Position:PosCard0 Target:self selector:@selector(OnSwitchCard:)];
        _btCard0.position = PosCard0;
        _btCard0.tag = 0;
        
        _btCard1 = [CCMenuItemToggle switchWithOffFile:@"bt_card_1_off.png" OnFile:@"bt_card_1_on.png" Position:PosCard1 Target:self selector:@selector(OnSwitchCard:)];
        _btCard1.position = PosCard1;
        _btCard1.tag = 1;
        
        _btCard2 = [CCMenuItemToggle switchWithOffFile:@"bt_card_2_off.png" OnFile:@"bt_card_2_on.png" Position:PosCard2 Target:self selector:@selector(OnSwitchCard:)];
        _btCard2.position = PosCard2;
        _btCard2.tag = 2;
        
        _btCard3 = [CCMenuItemToggle switchWithOffFile:@"bt_card_3_off.png" OnFile:@"bt_card_3_on.png" Position:PosCard3 Target:self selector:@selector(OnSwitchCard:)];
        _btCard3.position = PosCard3;
        _btCard3.tag = 3;
        
        _btCard4 = [CCMenuItemToggle switchWithOffFile:@"bt_card_4_off.png" OnFile:@"bt_card_4_on.png" Position:PosCard4 Target:self selector:@selector(OnSwitchCard:)];
        _btCard4.position = PosCard4;
        _btCard4.tag = 4;
        
        _btCard5 = [CCMenuItemToggle switchWithOffFile:@"bt_card_5_off.png" OnFile:@"bt_card_5_on.png" Position:PosCard5 Target:self selector:@selector(OnSwitchCard:)];
        _btCard5.position = PosCard5;
        _btCard5.tag = 5;
        
        
        CCLabelTTF* lbOk = [CCLabelTTF labelWithString:NSLocalizedString(@"OK",nil) fontName:SYSTEM_FONT fontSize:SizeFont1];
        CCMenuItemSpriteWithLabel* btOk = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_2.png" Label:lbOk Postion:PosOK target:self selector:@selector(OnResume:)];
        
        
        
        
        _menu = [CCMenu menuWithItems:btOk, _btBG0, _btBG1, _btBG2, _btBG3, _btCard0, _btCard1, _btCard2, _btCard3, _btCard4, _btCard5, nil];
        _menu.position = CGPointZero;
        [self.diag addChild: _menu];
        
        
        self.backgroundID = [LevelManager sharedLevelManager].BackgroundID;
        self.cardID = [LevelManager sharedLevelManager].CardID;
        
    }
    return self;
}

-(void)onEnter
{
    [super onEnter];
}

-(void)onEnterTransitionDidFinish
{
    [_menu setHandlerPriority:AlertLayerMenuHandlerPriority];
}

-(void)setBackgroundID:(int)backgroundID
{
    switch (backgroundID)
    {
        case 0:
        {
            _backgroundID = backgroundID;
            
            _btBG0.selectedIndex = 1;
            _btBG1.selectedIndex = 0;
            _btBG2.selectedIndex = 0;
            _btBG3.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.backgroundID = _backgroundID;
        }
            break;
            
        case 1:
        {
            _backgroundID = backgroundID;
            _btBG0.selectedIndex = 0;
            _btBG1.selectedIndex = 1;
            _btBG2.selectedIndex = 0;
            _btBG3.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.backgroundID = _backgroundID;
        }
            break;
        
        case 2:
        {
            _backgroundID = backgroundID;
            
            _btBG0.selectedIndex = 0;
            _btBG1.selectedIndex = 0;
            _btBG2.selectedIndex = 1;
            _btBG3.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.backgroundID = _backgroundID;
        }
            break;
            
        case 3:
        {
            _backgroundID = backgroundID;
            
            _btBG0.selectedIndex = 0;
            _btBG1.selectedIndex = 0;
            _btBG2.selectedIndex = 0;
            _btBG3.selectedIndex = 1;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.backgroundID = _backgroundID;
        }
            
            break;
            
        default:
            break;
    }
}

-(void)setCardID:(int)cardID
{
    switch (cardID)
    {
        case 0:
        {
            _cardID = cardID;
            
            _btCard0.selectedIndex = 1;
            _btCard1.selectedIndex = 0;
            _btCard2.selectedIndex = 0;
            _btCard3.selectedIndex = 0;
            _btCard4.selectedIndex = 0;
            _btCard5.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.cardID = _cardID;
        }
            break;
            
        case 1:
        {
            _cardID = cardID;
            
            _btCard0.selectedIndex = 0;
            _btCard1.selectedIndex = 1;
            _btCard2.selectedIndex = 0;
            _btCard3.selectedIndex = 0;
            _btCard4.selectedIndex = 0;
            _btCard5.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.cardID = _cardID;
        }
            break;
        case 2:
        {
            _cardID = cardID;
            
            _btCard0.selectedIndex = 0;
            _btCard1.selectedIndex = 0;
            _btCard2.selectedIndex = 1;
            _btCard3.selectedIndex = 0;
            _btCard4.selectedIndex = 0;
            _btCard5.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.cardID = _cardID;
        }
            break;
        case 3:
        {
            _cardID = cardID;
            
            _btCard0.selectedIndex = 0;
            _btCard1.selectedIndex = 0;
            _btCard2.selectedIndex = 0;
            _btCard3.selectedIndex = 1;
            _btCard4.selectedIndex = 0;
            _btCard5.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.cardID = _cardID;
        }
            break;
        case 4:
        {
            _cardID = cardID;
            
            _btCard0.selectedIndex = 0;
            _btCard1.selectedIndex = 0;
            _btCard2.selectedIndex = 0;
            _btCard3.selectedIndex = 0;
            _btCard4.selectedIndex = 1;
            _btCard5.selectedIndex = 0;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.cardID = _cardID;
        }
            break;
        case 5:
        {
            _cardID = cardID;
            
            _btCard0.selectedIndex = 0;
            _btCard1.selectedIndex = 0;
            _btCard2.selectedIndex = 0;
            _btCard3.selectedIndex = 0;
            _btCard4.selectedIndex = 0;
            _btCard5.selectedIndex = 1;
            
            GameScene* scene =[GameScene sharedGameScene];
            scene.cardID = _cardID;
        }
            break;

        
        default:
            break;
    }
}


-(void)OnSwitchBG:(id)sender
{
    CCMenuItemToggle* item = (CCMenuItemToggle*)sender;
    self.backgroundID = item.tag;
}

-(void)OnSwitchCard:(id)sender
{
    CCMenuItemToggle* item = (CCMenuItemToggle*)sender;
    self.cardID = item.tag;
}


-(void) OnResume:(id) sender
{
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    CCCallFuncND* Call1 = [CCCallFuncND actionWithTarget:self selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
    CCSequence* Sequence = [CCSequence actions:Call1,nil];
    [diag_ runAction:Sequence];
    
    GameScene* scene =[GameScene sharedGameScene];
    scene.state = GameState_Run;
}

@end
