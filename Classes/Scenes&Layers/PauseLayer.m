//
//  PauseLayer.m
//  Solitaire
//
//  Created by 张朴军 on 13-8-14.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "PauseLayer.h"
#import "CCMenuItemSprite+Helper.h"
#import "GameScene.h"
#import "TitleScene.h"
#import "AudioManager.h"
#import "MailManager.h"
#import "MyGameCenterManager.h"
#import "IdentifieManager.h"
#import "AbandonLayer.h"
#import "CCMenuItemToggle+Helper.h"
@implementation PauseLayer


+(id)layer
{
    return [[[self alloc] init] autorelease];
}

-(id)init
{
    if(self = [super init])
    {
        CGPoint PosPause;
        CGPoint PosWord;
        
        float   SizeFont1;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosPause        = CGPointMake(0,100);
            PosWord         = CGPointMake(0, -40);
            
            
            
            SizeFont1       = 40;
        }
        else
        {
            PosPause        = CGPointMake(0,50);
            PosWord         = CGPointMake(0, -20);
            
            
            
            SizeFont1       = 20;
        }
        
        
        CCMenuItemSprite* btResume = [CCMenuItemSprite itemFromOneFile:@"lb_click.png" Postion:PosPause target:self selector:@selector(OnResume:)];
        
        CCLabelTTF* lbWord = [CCLabelTTF labelWithString:NSLocalizedString(@"Click to resume",nil) fontName:SYSTEM_FONT fontSize:SizeFont1];
        lbWord.position = PosWord;
        [self.diag addChild:lbWord];

        _menu = [CCMenu menuWithItems:btResume, nil];
        _menu.position = CGPointZero;
        [self.diag addChild: _menu];
        
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
