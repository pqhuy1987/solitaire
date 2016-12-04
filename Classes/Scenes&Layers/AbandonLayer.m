//
//  AbandonLayer.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-7-10.
//  Copyright (c) 2013年 穆暮. All rights reserved.
//

#import "AbandonLayer.h"
#import "CCMenuItemSpriteWithLabel.h"
#import "GameScene.h"
#import "CCFlipXLeftOver.h"
#import "CCFlipXRightOver.h"
#import "CCMenuItemSprite+Helper.h"
#import "TitleScene.h"
@implementation AbandonLayer

+(id)layerWithMode:(GameModes)mode Type:(AbandonType)type;
{
    return [[[self alloc] initWithMode:mode Type:type] autorelease];
}

-(id)initWithMode:(GameModes)mode Type:(AbandonType)type;
{
    if(self = [super init])
    {
        CGPoint PosBG;
        CGPoint PosTitle;
       
        CGPoint PosConfirm;
        CGPoint PosCancel;
       
        CGSize  SizeDetail;
        float   SizeFont1;
        float   SizeFont2;
        float   SizeFont3;
        _mode = mode;
        _type = type;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosBG           = CGPointMake(0,0);
            PosTitle        = CGPointMake(0,70);
            
            PosConfirm      = CGPointMake(130, -74);
            PosCancel       = CGPointMake(-130, -74);
            
            SizeDetail      = CGSizeMake(450, 196);
            SizeFont1       = 40;
            SizeFont2       = 32;
            SizeFont3       = 36;
            self.diag.position = ccp(384, 608);
        }
        else
        {
            PosBG           = CGPointMake(0,0);
            PosTitle        = CGPointMake(0,35);
            
            PosConfirm      = CGPointMake(65, -37);
            PosCancel       = CGPointMake(-65, -37);
            
            SizeDetail      = CGSizeMake(225, 98);
            SizeFont1       = 20;
            SizeFont2       = 16;
            SizeFont3       = 18;
            self.diag.position = ccp(160, 285);
            
            CGSize screen = [CCDirector sharedDirector].winSize;
            if(screen.height == 568)
            {
                self.diag.position = ccp(160, 329);
            }
        }
        
        CCSprite* bg = [CCSprite spriteWithFile:@"bg_alert.png"];
        bg.position = PosBG;
        [self.diag addChild:bg];
        
        CCLabelTTF* label = [CCLabelTTF labelWithString:NSLocalizedString(@"Are you sure you want to abandon the saved game?",nil) fontName:SYSTEM_FONT fontSize:SizeFont3 dimensions:SizeDetail hAlignment:kCCTextAlignmentCenter vAlignment:kCCVerticalTextAlignmentCenter];
        label.position = PosTitle;
        [self.diag addChild:label];
        
        
        CCLabelTTF* confirm = [CCLabelTTF labelWithString:NSLocalizedString(@"Yes",nil) fontName:SYSTEM_FONT fontSize:SizeFont2];
        CCMenuItemSpriteWithLabel* btConfirm = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_2.png" Label:confirm Postion:PosConfirm target:self selector:@selector(OnConfirm:)];
        
        
        
        CCLabelTTF* cancel = [CCLabelTTF labelWithString:NSLocalizedString(@"No",nil) fontName:SYSTEM_FONT fontSize:SizeFont2];
        CCMenuItemSpriteWithLabel* btCancel = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_2.png" Label:cancel Postion:PosCancel target:self selector:@selector(OnCancel:)];
        
        
        _menu = [CCMenu menuWithItems:btConfirm, btCancel, nil];
        _menu.position = CGPointZero;
        [self.diag addChild:_menu];
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
                            nil];
    [diag_ runAction:Sequence];
    
    [super onEnter];
}

-(void)onEnterTransitionDidFinish
{
    [[[CCDirector sharedDirector] touchDispatcher] setPriority:AlertLayerMenuHandlerPriority - 1 forDelegate:self];
    [_menu setHandlerPriority:AlertLayerMenuHandlerPriority - 1];
}

-(void) OnConfirm:(id) sender
{
    CCScene* s2 = nil;
    switch (_type)
    {
        case AbandonType_HOME:
            s2 = [TitleScene scene];
            break;
        case AbandonType_REPLAY:
            s2 = [GameScene sceneWithMode:_mode];
            break;
        default:
            break;
    }
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:s2]];
}

-(void) OnCancel:(id) sender
{
    CCScaleTo* ScaleDown = [CCScaleTo actionWithDuration:0.3 scale: 0.01];
    CCEaseIn* Bounce = [CCEaseIn actionWithAction:ScaleDown rate:1.5];
    CCCallFuncND* Call1 = [CCCallFuncND actionWithTarget:self selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
    CCSequence* Sequence = [CCSequence actions:Bounce, Call1,nil];
    [diag_ runAction:Sequence];
    
    if(self.delegate)
    {
        if([self.delegate respondsToSelector:@selector(setState:)])
        {
            [self.delegate performSelector:@selector(setState:) withObject:(void*)GameState_Run];
//            GameScene* scene =[GameScene sharedGameScene];
//            scene.state = GameState_Run;
        }
        
    }
    
}

@end
