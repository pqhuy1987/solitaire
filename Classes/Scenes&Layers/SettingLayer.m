//
//  SettingLayer.m
//  Solitaire
//
//  Created by 穆暮 on 14-5-19.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "SettingLayer.h"
#import "CCMenuItemSprite+Helper.h"
#import "GameScene.h"
#import "PauseLayer.h"
#import "ThemeLayer.h"
#import "AbandonLayer.h"
#import "TitleScene.h"
#import "ResultLayer.h"
@implementation SettingLayer

+(id)layerWithPosition:(CGPoint)point
{
    return [[[self alloc] initWithPosition:point] autorelease];
}

-(id)initWithPosition:(CGPoint)point
{
    if(self = [super init])
    {
        CGPoint PosBG;
        CGPoint PosMenu;
        CGPoint PosNew;
        CGPoint PosThemes;
        CGPoint PosPause;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosBG       = ccp(0, 0);
            PosMenu     = ccp(-98, 118);
            PosNew      = ccp(-98, 226);
            PosThemes   = ccp(-98, 172);
            PosPause    = ccp(-98, 64);
            
            self.diag.position  = point;
        }
        else
        {
     
            PosBG       = ccp(0, 0);
            PosMenu      = ccp(-49, 59);
            PosNew      = ccp(-49, 113);
            PosThemes   = ccp(-49, 86);
            PosPause    = ccp(-49, 32);
            
            
            CGSize screen = [CCDirector sharedDirector].winSize;
            if(screen.height == 568)
            {
                self.diag.position = ccpAdd(point, ccp(0, 44));
            }
            else
            {
                self.diag.position  = point;
            }
        }
        
        self.opacity = 0;
        
        CCSprite* bg = [CCSprite spriteWithFile:@"bg_set.png"];
        bg.position = PosBG;
        bg.anchorPoint = ccp(0.5, 0);
        [self.diag addChild:bg];
        
        
        CCMenuItemSprite* btNew = [CCMenuItemSprite itemFromOneFile:@"bt_menu.png" Postion:PosMenu target:self selector:@selector(OnHome:)];
        btNew.anchorPoint = ccp(0, 0.5);
        CCMenuItemSprite* btRestart = [CCMenuItemSprite itemFromOneFile:@"bt_new.png" Postion:PosNew target:self selector:@selector(OnReplay:)];
        btRestart.anchorPoint = ccp(0, 0.5);
        CCMenuItemSprite* btThemes = [CCMenuItemSprite itemFromOneFile:@"bt_themes.png" Postion:PosThemes target:self selector:@selector(OnThemes:)];
        btThemes.anchorPoint = ccp(0, 0.5);
        CCMenuItemSprite* btPause = [CCMenuItemSprite itemFromOneFile:@"bt_pause.png" Postion:PosPause target:self selector:@selector(OnPause:)];
        btPause.anchorPoint = ccp(0, 0.5);
        
        _menu = [CCMenu menuWithItems:btNew, btRestart, btThemes, btPause, nil];
        _menu.position = CGPointZero;
        [self.diag addChild: _menu];
        _isReady = NO;
        
    }
    return self;
}

-(void)onEnter
{
    diag_.scale = 0.01;
    CCScaleTo* ScaleUp = [CCScaleTo actionWithDuration:0.3 scale: 1.0];
    CCEaseIn* Bounce = [CCEaseIn actionWithAction:ScaleUp rate:1.5];
    CCSequence* Sequence = [CCSequence actions:
                            Bounce,
                            [CCCallBlock actionWithBlock:^{_isReady = YES;}],
                            nil];
    [diag_ runAction:Sequence];
    
    [super onEnter];
}

-(void)onEnterTransitionDidFinish
{
    [_menu setHandlerPriority:AlertLayerMenuHandlerPriority];
}

-(void) OnReplay:(id) sender
{
    if (!_isReady)
        return;
    
    CCCallFuncND* Call1 = [CCCallFuncND actionWithTarget:self selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
    CCSequence* Sequence = [CCSequence actions:Call1,nil];
    [diag_ runAction:Sequence];
    
    GameScene* scene =[GameScene sharedGameScene];
    AbandonLayer* layer = [AbandonLayer layerWithMode:scene.mode Type:AbandonType_REPLAY];
    layer.delegate = scene;
    [scene addChild:layer];
}

-(void) OnHome:(id) sender
{
    if (!_isReady)
        return;
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[TitleScene scene]]];
}

-(void) OnThemes:(id) sender
{
    if (!_isReady)
        return;
    
    CCCallFuncND* Call1 = [CCCallFuncND actionWithTarget:self selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
    CCSequence* Sequence = [CCSequence actions:Call1,nil];
    [diag_ runAction:Sequence];
    
    GameScene* scene =[GameScene sharedGameScene];
    [scene addChild:[ThemeLayer layer]];
}

-(void) OnPause:(id) sender
{
    if (!_isReady)
        return;
    CCCallFuncND* Call1 = [CCCallFuncND actionWithTarget:self selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
    CCSequence* Sequence = [CCSequence actions:Call1,nil];
    [diag_ runAction:Sequence];
    
    GameScene* scene =[GameScene sharedGameScene];
    [scene addChild:[PauseLayer layer]];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!_isReady)
        return YES;
    CCScaleTo* ScaleDown = [CCScaleTo actionWithDuration:0.3 scale: 0.01];
    CCEaseIn* Bounce = [CCEaseIn actionWithAction:ScaleDown rate:1.5];
    CCCallFuncND* Call1 = [CCCallFuncND actionWithTarget:self selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
    CCSequence* Sequence = [CCSequence actions:Bounce, Call1,nil];
    [diag_ runAction:Sequence];

    GameScene* scene =[GameScene sharedGameScene];
    scene.state = GameState_Run;
    return YES;
}

@end
