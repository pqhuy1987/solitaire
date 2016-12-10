//
//  GameScene.m
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-7.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import "GameScene.h"
#import "Card.h"
#import "CardStack.h"
#import "StaticStack.h"
#import "DeliverStack.h"
#import "FloatStack.h"
#import "FinishStack.h"
#import "PopStack.h"
#import "CCMenuItemSprite+Helper.h"
#import "PuzzleRecord.h"
#import "HistoryManager.h"

#import "ResultLayer.h"
#import "AbandonLayer.h"
#import "TitleScene.h"
#import "CCFlipXLeftOver.h"
#import "CCFlipXRightOver.h"

#import "AudioManager.h"
#import "PauseLayer.h"

#import "SettingLayer.h"
@implementation GameScene

static GameScene* instanceOfGameScene;

+(GameScene *)sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

@synthesize cardBatch   = _cardBatch;
@synthesize stacks      = _stacks;
@synthesize currentStep = _currentStep;
@synthesize steps       = _steps;
@synthesize record      = _record;
@synthesize tipManager  = _tipManager;
@synthesize pickHint    = _pickHint;
@synthesize dropHint    = _dropHint;

@synthesize scoreLabel  = _scoreLabel;
@synthesize score  = _score;
@synthesize timeLabel   = _timeLabel;
@synthesize time  = _time;
@synthesize move = _move;
@synthesize state   = _state;
@synthesize mode = _mode;
@synthesize factor = _factor;
@synthesize factorLabel = _factorLabel;

+(CCScene *) sceneWithMode:(GameModes)mode
{
    CCScene *scene = [CCScene node];
	GameScene *layer = [[[self alloc] initWithMode:mode] autorelease];
	[scene addChild: layer];
	return scene;
}

-(id)initWithMode:(GameModes)mode
{
    if (self = [super init])
    {
        instanceOfGameScene = self;
        
        CGPoint PosBG;
        
        CGPoint PosTopBG;
        CGPoint PosUIBG;
        CGPoint PosFactor;
        CGPoint PosScore;
        CGPoint PosTime;
        CGPoint PosMove;
    
        CGPoint PosUndo;
        CGPoint PosHint;
        CGPoint PosSet;
        
        CGPoint PosAuto;
        
        float fontSize1;
        float fontSize2;
        float fontSize3;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            PosBG           = CGPointMake(384,  512);
            PosTopBG        = CGPointMake(384,  994);
            PosFactor       = CGPointMake(13,   998);
            PosScore        = CGPointMake(199,  998);
            PosTime         = CGPointMake(400,  998);
            PosMove         = CGPointMake(588,  998);
            
            PosUIBG         = CGPointMake(384,  50);
            PosUndo         = CGPointMake(172,  50);
            PosHint         = CGPointMake(384,  50);
            PosSet          = CGPointMake(596,  50);
            
            PosAuto         = CGPointMake(384,  136);
            
            fontSize1       = 22;
            fontSize2       = 36;
            fontSize3       = 24;
        }
        else
        {
            PosBG           = CGPointMake(160,  240);
            PosTopBG        = CGPointMake(160,  466);
            PosFactor       = CGPointMake(6,    468);
            PosScore        = CGPointMake(83,   468);
            PosTime         = CGPointMake(166,  468);
            PosMove         = CGPointMake(246,  468);
            
            PosUIBG         = CGPointMake(160,  20);
            PosUndo         = CGPointMake(60,   20);
            PosHint         = CGPointMake(160,  20);
            PosSet          = CGPointMake(260,  20);
            
            PosAuto         = CGPointMake(160,  60);
            
            CGSize screen = [CCDirector sharedDirector].winSize;
            if(screen.height == 568)
            {
                
                PosTopBG        = CGPointMake(160,  510);
                PosFactor       = CGPointMake(6,    512);
                PosScore        = CGPointMake(83,   512);
                PosTime         = CGPointMake(166,  512);
                PosMove         = CGPointMake(246,  512);
                
                
                PosUIBG         = CGPointMake(160,  -24);
                PosUndo         = CGPointMake(60,   -24);
                PosHint         = CGPointMake(160,  -24);
                PosSet          = CGPointMake(260,  -24);
                
                PosAuto         = CGPointMake(160,  16);
            }
            
            fontSize1       = 11;
            fontSize2       = 18;
            fontSize3       = 12;
        }
        

        CGPoint PosDeliverStart;
        CGPoint PosFinishStatr;

        CGSize  SizeDeliver;
        CGSize  SizeFinish;
  
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {

            PosDeliverStart = CGPointMake(669,896);
            PosFinishStatr  = CGPointMake(384,896);
    
            SizeDeliver = CGSizeMake(30,     0);
            SizeFinish  = CGSizeMake(-95,    0);
        }
        else
        {
            PosDeliverStart = CGPointMake(295, 420);
            PosFinishStatr  = CGPointMake(160, 420);
            
            CGSize screen = [[CCDirector sharedDirector] winSize];
            if(screen.height == 568)
            {
                PosDeliverStart = CGPointMake(295, 464);
                PosFinishStatr  = CGPointMake(160, 464);
            }
            SizeDeliver = CGSizeMake(15,     0);
            SizeFinish  = CGSizeMake(-45,    0);
        }
        
        
        
        _mode = mode;
        
        [[CCTextureCache sharedTextureCache] addImage:@"bg_game_0.png"];
        [[CCTextureCache sharedTextureCache] addImage:@"bg_game_1.png"];
        [[CCTextureCache sharedTextureCache] addImage:@"bg_game_2.png"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"cards.plist"];
        
        _bg = [CCSprite spriteWithFile:@"bg_game_0.png"];
        _bg.position = PosBG;
        [self addChild:_bg];
        
        CCSprite* topBg = [CCSprite spriteWithFile:@"lb_bottom.png"];
        topBg.position = PosTopBG;
        [self addChild:topBg];
        
        for (int i = 0; i < MAX_FINISH_STACK; i++)
        {
            CCSprite* finish = [CCSprite spriteWithFile:@"lb_a.png"];
            finish.position = ccp(PosFinishStatr.x + SizeFinish.width * i, PosFinishStatr.y + SizeFinish.height * i);
            [self addChild:finish];
        }
        
        CCSprite* delver = [CCSprite spriteWithFile:@"lb_undo.png"];
        delver.position = ccp(PosDeliverStart.x, PosDeliverStart.y);
        [self addChild:delver];
       
        self.currentStep = [StepInfo info];
        self.stacks = [CCArray arrayWithCapacity:10];
        self.cardBatch = [CCNode node];
        [self addChild:self.cardBatch];
        
        CCSprite* UIBG = [CCSprite spriteWithFile:@"lb_black.png"];
        UIBG.position = PosUIBG;
        [self addChild:UIBG];
        
        _ready = NO;
        _arranged = NO;
        _noOperation = YES;
        [self scheduleUpdate];
        [self creatCard];
        
        self.steps = [NSMutableArray array];
        self.pickHint = [CCSprite spriteWithSpriteFrameName:@"hint2.png"];
        [self.cardBatch addChild:self.pickHint];
        self.pickHint.visible = NO;
        self.dropHint = [CCSprite spriteWithSpriteFrameName:@"hint1.png"];
        [self.cardBatch addChild:self.dropHint];
        self.dropHint.visible = NO;
        
        self.factorLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Bouns x00",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        self.factorLabel.position = PosFactor;
        self.factorLabel.anchorPoint = ccp(0.0, 0.5);
        self.factorLabel.color = ccWHITE;
        [self addChild:self.factorLabel];
        
        self.scoreLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Score:0000",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        self.scoreLabel.position = PosScore;
        self.scoreLabel.color = ccWHITE;
        self.scoreLabel.anchorPoint = ccp(0.0, 0.5);
        [self addChild:self.scoreLabel];

        self.timeLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Time:00:00",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        self.timeLabel.position = PosTime;
        self.timeLabel.color = ccWHITE;
        self.timeLabel.anchorPoint = ccp(0.0, 0.5);
        [self addChild:self.timeLabel];
        
        
        self.moveLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Move 0",nil) fontName:SYSTEM_FONT fontSize:fontSize1];
        self.moveLabel.position = PosMove;
        self.moveLabel.color = ccWHITE;
        self.moveLabel.anchorPoint = ccp(0.0, 0.5);
        [self addChild:self.moveLabel];
       
        
        CCLabelTTF* rules = [CCLabelTTF labelWithString:NSLocalizedString(@"Auto Finish",nil) fontName:SYSTEM_FONT fontSize:fontSize3];
        _autoFinish = [CCMenuItemSpriteWithLabel itemFromOneFile:@"bt_bg_1.png" Label:rules Postion:PosAuto target:self selector:@selector(onAutoFinish:)];
        _autoFinish.visible = NO;
        
        
        CCMenuItemSprite* btUndo = [CCMenuItemSprite itemFromOneFile:@"bt_undo.png" Postion:PosUndo target:self selector:@selector(onUndo:)];
        CCMenuItemSprite* btHint = [CCMenuItemSprite itemFromOneFile:@"bt_hint.png" Postion:PosHint target:self selector:@selector(onTip:)];
        
        _btSetting = [CCMenuItemSprite itemFromOneFile:@"bt_set.png" Postion:PosSet target:self selector:@selector(onSetting:)];
        

        CCMenu* menu = [CCMenu menuWithItems:btUndo, btHint, _btSetting, _autoFinish, nil];
        menu.position = CGPointZero;
        [self addChild: menu];
        self.tipManager = [TipManager tipManager];
        
        self.state = GameState_Pause;
        
        
        if(_mode == GameMode_Continue)
        {
            self.score = [PuzzleRecord sharedPuzzleRecord].score;
            self.time = [PuzzleRecord sharedPuzzleRecord].time;
            self.factor = [PuzzleRecord sharedPuzzleRecord].factor;
            self.move = [PuzzleRecord sharedPuzzleRecord].move;
        }
        else
        {
            if(_mode == GameMode_One)
                self.factor = 100;
            else if(_mode == GameMode_Three)
                self.factor = 200;
            self.score = 0;
            self.time = 0;
            self.move = 0;
        }
        
        self.backgroundID = [LevelManager sharedLevelManager].BackgroundID;
        self.cardID = [LevelManager sharedLevelManager].CardID;
        
        
    }
    return self;
}

- (void) dealloc
{
    self.currentStep = nil;
    self.cardBatch = nil;
    self.stacks = nil;
    self.steps = nil;
    self.tipManager = nil;
    
    self.record = nil;
    self.pickHint = nil;
    self.dropHint = nil;
    
    self.scoreLabel = nil;
    self.timeLabel = nil;
    self.factorLabel = nil;
	[super dealloc];
}

-(void)setBackgroundID:(int)backgroundID
{
    switch (backgroundID)
    {
        case 0:
        {
            _backgroundID = backgroundID;
            CCSprite* temp = [CCSprite spriteWithFile:[NSString stringWithFormat:@"bg_game_%d.png",_backgroundID]];
            _bg.texture = temp.texture;
            _bg.textureRect = temp.textureRect;
        }
            break;
        case 1:
        {
            _backgroundID = backgroundID;
            CCSprite* temp = [CCSprite spriteWithFile:[NSString stringWithFormat:@"bg_game_%d.png",_backgroundID]];
            _bg.texture = temp.texture;
            _bg.textureRect = temp.textureRect;
        }
            break;
        case 2:
        {
            _backgroundID = backgroundID;
            CCSprite* temp = [CCSprite spriteWithFile:[NSString stringWithFormat:@"bg_game_%d.png",_backgroundID]];
            _bg.texture = temp.texture;
            _bg.textureRect = temp.textureRect;
        }
            break;
        case 3:
        {
            _backgroundID = backgroundID;
            CCSprite* temp = [CCSprite spriteWithFile:@"bg_title.png"];
            _bg.texture = temp.texture;
            _bg.textureRect = temp.textureRect;
        }
            
        default:
            break;
    }
    
   
    
    [LevelManager sharedLevelManager].BackgroundID = _backgroundID;
}


-(void)setCardID:(int)cardID
{
    switch (cardID)
    {
        case 0:
        {
            _cardID = cardID;
        }
            break;
        case 1:
        {
            _cardID = cardID;
        }
        case 2:
        {
            _cardID = cardID;
        }
            break;
        case 3:
        {
            _cardID = cardID;
        }
            break;
        case 4:
        {
            _cardID = cardID;
        }
            break;
        case 5:
        {
            _cardID = cardID;
        }
            break;
        default:
            break;
    }
    
    for (int i = 0; i <= MAX_CARDS; i++)
    {
        Card* card = [self getCardByTag:i];
        if(card)
            card.cardID = _cardID;
    }
    
    [LevelManager sharedLevelManager].CardID = _cardID;
}


-(void)onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
    [super onEnter];
    
    if(_mode == GameMode_Continue)
    {
        [self createGame];
        self.isResumed = YES;
    }
    else
    {
        self.isResumed = NO;
    }
}
- (void)onExit
{
    
	[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
	[super onExit];
}

-(void)setScore:(float)score
{
    if(score < 0)
        score = 0;
    _score = score;
    self.scoreLabel.string = [NSString stringWithFormat:NSLocalizedString(@"Score  %d",nil),(int)_score];
}

-(void)setFactor:(int)factor
{
    if(factor < 1)
        factor = 1;
    _factor = factor;
    self.factorLabel.string = [NSString stringWithFormat:NSLocalizedString(@"Bonus  x%d",nil),(int)_factor];
}

-(void)setTime:(float)time
{
    _time = time;
    
    NSTimeInterval temp = time;
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSString* text = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:temp]];
    self.timeLabel.string = [NSString stringWithFormat: NSLocalizedString(@"Time  %@",nil),text];
}

-(void)setMove:(float)move
{
    _move = move;
    self.moveLabel.string = [NSString stringWithFormat:NSLocalizedString(@"Move  %d",nil),(int)_move];
}


-(void)update:(ccTime)delta
{
    if(self.state == GameState_Run)
    {
        self.time = self.time += delta;
        
        _factorTimer += delta;
        if(_factorTimer > 10)
        {
            _factorTimer = _factorTimer - 10;
            self.factor = self.factor - 1;
        }
    }
   
    if(_ready == NO)
    {
        for (Card* card in self.cardBatch.children)
        {
            if([card numberOfRunningActions])
            {
                _ready = NO;
                return;
            }
        }
        _ready = YES;
    
        if(_ready)
        {
            for (int i = 0; i < MAX_STATIC_STACK; i++)
            {
                StaticStack* stack = [self getStaticStackByIndex:i];
                [stack updateCardsAnimate:YES DelayTime:0];
            }
            
            if(!_noOperation)
            {
                [self hideTip];
                _hasSearched = NO;
                if(self.steps.count > 0)
                {
                    CCLOG(@"Step:%d Score:%.0f",self.currentStep.stepID,_tempScore);
                    
                    for (StepInfo* step in self.steps)
                    {
                        step.score = _tempScore;
                        [[HistoryManager sharedHistoryManager].history addObject:step];
                        //CCLOG(@"%@",step);
                    }
                    [self.steps removeAllObjects];
                    _currentStep.stepID = _currentStep.stepID + 1;
                    self.move = _currentStep.stepID;
                }
                [self save];
            }
            
            
        }
    }
    else
    {
        if(_arranged == NO)
        {
            for (Card* card in self.cardBatch.children)
            {
                if([card numberOfRunningActions])
                {
                    _arranged = NO;
                    return;
                }
            }
            _arranged = YES;
            
            self.score = self.score + _tempScore;
            [PuzzleRecord sharedPuzzleRecord].score = _score;
            if(_tempScore != 0)
            {
                CGPoint PosFloatScore;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    PosFloatScore   = CGPointMake(384, 256);
                }
                else
                {
                    PosFloatScore   = CGPointMake(160,  122);
                    CGSize screen = [[CCDirector sharedDirector] winSize];
                    if(screen.height == 568)
                    {
                        PosFloatScore = CGPointMake(160,  78);
                    }
                }
                
                if(_tempScore < 0)
                {
                    CCLabelTTF* label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"-%d",(int)(0-_tempScore)] fontName:SYSTEM_FONT fontSize:self.factorLabel.fontSize * 2];
                    label.color = self.factorLabel.color;
                    label.position = PosFloatScore;
                    
                    CCSequence* sequence = [CCSequence actions:
                                            [CCScaleTo actionWithDuration:1.0 scale:1.5],
                                            [CCCallFuncND actionWithTarget:label selector:@selector(removeFromParentAndCleanup:) data:(void*)YES],
                                            nil];
                    CCFadeOut* fade = [CCFadeOut actionWithDuration:1.0];
                    [label runAction:sequence];
                    [label runAction:fade];
                    [self addChild:label];
                }
                else
                {
                    CCLabelTTF* label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d",(int)_tempScore] fontName:SYSTEM_FONT fontSize:self.factorLabel.fontSize * 2];
                    label.color = self.factorLabel.color;
                    label.position = PosFloatScore;
                    
                    CCSequence* sequence = [CCSequence actions:
                                            [CCScaleTo actionWithDuration:1.0 scale:1.5],
                                            [CCCallFuncND actionWithTarget:label selector:@selector(removeFromParentAndCleanup:) data:(void*)YES],
                                            nil];
                    CCFadeOut* fade = [CCFadeOut actionWithDuration:1.0];
                    CCEaseOut* up = [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1.0 position:CGPointMake(0, self.factorLabel.fontSize)] rate:1.5];
                    [label runAction:sequence];
                    [label runAction:fade];
                    [label runAction:up];
                    [self addChild:label];
                }
            }
            
            _tempScore = 0;
            if ([self canAutoFinish] && _auto == NO)
            {
                _autoFinish.visible = YES;
            }
            else
            {
                _autoFinish.visible = NO;
            }
            
            if([self checkComplete] && _complete == NO)
            {
                _complete = YES;
                [self complete];
            }
            
            if(_auto && _complete == NO)
            {
                [self nextAutoFinish];
            }
            
            
        }
        
    }
}

-(void)creatCard
{
    CGPoint PosStaticStart;
    CGPoint PosDeliverStart;
    CGPoint PosPopStart;
    CGPoint PosFinishStatr;
    CGPoint PosStart;
    CGSize  SizeStatic;
    CGSize  SizeDeliver;
    CGSize  SizeFinish;
    CardKind Starkind;
    int      kinds;
    int      drawn;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        PosStart = ccp(669,896);
        PosStaticStart  = CGPointMake(99,739);
        PosDeliverStart = CGPointMake(669,896);
        PosPopStart = CGPointMake(495,896);
        PosFinishStatr  = CGPointMake(384,896);
        
        SizeStatic  = CGSizeMake(95,    0);
        SizeDeliver = CGSizeMake(30,     0);
        SizeFinish  = CGSizeMake(-95,    0);
    }
    else
    {
        PosStart = ccp(295, 420);
        PosStaticStart  = CGPointMake(25, 350);
        PosDeliverStart = CGPointMake(295, 420);
        PosPopStart = CGPointMake(213, 420);
        PosFinishStatr  = CGPointMake(160, 420);
        
        CGSize screen = [[CCDirector sharedDirector] winSize];
        if(screen.height == 568)
        {
            PosStart = ccp(295, 464);
            PosStaticStart  = CGPointMake(25, 394);
            PosDeliverStart = CGPointMake(295, 464);
            PosPopStart = CGPointMake(213, 464);
            PosFinishStatr  = CGPointMake(160, 464);
        }
    
        SizeStatic  = CGSizeMake(45,    0);
        SizeDeliver = CGSizeMake(15,     0);
        SizeFinish  = CGSizeMake(-45,    0);
    }
    
    
    
    switch (_mode)
    {
        case GameMode_One:
            kinds = 4;
            Starkind = CardKind_Diamond;
            drawn = 1;
            break;
        case GameMode_Three:
            kinds = 4;
            Starkind = CardKind_Diamond;
            drawn = 3;
            break;
        case GameMode_Continue:
            if([PuzzleRecord sharedPuzzleRecord].mode == GameMode_One)
            {
                kinds = 4;
                Starkind = CardKind_Diamond;
                drawn = 1;
            }
            else if ([PuzzleRecord sharedPuzzleRecord].mode == GameMode_Three)
            {
                kinds = 4;
                Starkind = CardKind_Diamond;
                drawn = 3;
            }
            break;
        default:
            break;
    }
    
    for (int i = 0; i < MAX_START_DECK; i++)
    {
        for (int j = CardPoint_A; j <= CardPoint_K; j++)
        {
            Card* card = [Card cardWithKind:i % kinds + Starkind Point:j isCovered:YES];
            card.tag = i * CardPoint_K + j + GameNodeTag_Card;
            card.position = PosStart;
            [self.cardBatch addChild:card z:0 tag:i * CardPoint_K + j + GameNodeTag_Card];
        }
    }
    
    for (int i = 0; i < MAX_STATIC_STACK; i++)
    {
        CardStack* stack = [StaticStack cardStack];
        stack.index = i;
        stack.position = ccp(PosStaticStart.x + SizeStatic.width * i, PosStaticStart.y + SizeStatic.height * i);
        stack.zOrder = GameNodeZOrder_StaticStack + MAX_CAPACITY * i;
        stack.tag = GameNodeTag_StaticStack + i;
        [self.stacks addObject:stack];
        [self addChild:stack];
    }
    
    for (int i = 0; i < MAX_FINISH_STACK; i++)
    {
        FinishStack* stack = [FinishStack cardStack];
        stack.index = MAX_STATIC_STACK + i;
        stack.position = ccp(PosFinishStatr.x + i * SizeFinish.width, PosFinishStatr.y + i * SizeFinish.height);
        stack.zOrder = GameNodeZOrder_FinishStack + MAX_CAPACITY * i;
        stack.tag = GameNodeTag_FinishStack + i;
        [self.stacks addObject:stack];
        [self addChild:stack];
    }
    
    DeliverStack* deliver = [DeliverStack cardStack];
    deliver.drawn = drawn;
    deliver.index = MAX_STATIC_STACK + MAX_FINISH_STACK ;
    deliver.position = ccp(PosDeliverStart.x, PosDeliverStart.y);
    deliver.zOrder = GameNodeZOrder_DeliverStack;
    deliver.tag = GameNodeTag_DeliverStack;
    [self.stacks addObject:deliver];
    [self addChild:deliver];
    
    PopStack* pop = [PopStack cardStack];
    pop.drawn = drawn;
    pop.index = MAX_STATIC_STACK + MAX_FINISH_STACK + MAX_DELIVER_STACK ;
    pop.position = ccp(PosPopStart.x, PosPopStart.y);
    pop.zOrder = GameNodeZOrder_DeliverStack;
    pop.tag = GameNodeTag_DeliverStack;
    [self.stacks addObject:pop];
    [self addChild:pop];
    
    CardStack* stack = [FloatStack cardStack];
    stack.position = ccp(160, 140);
    stack.index = MAX_STATIC_STACK + MAX_FINISH_STACK + MAX_DELIVER_STACK + MAX_POP_STACK ;
    stack.zOrder = GameNodeZOrder_FloatStack;
    stack.tag = GameNodeTag_FloatStack;
    [self.stacks addObject:stack];
}

-(void)createGame
{
    _ready = NO;
    _arranged = NO;
    _noOperation = YES;
    self.state = GameState_Run;
    if(_mode == GameMode_Continue)
    {
        StepInfo* last = [[HistoryManager sharedHistoryManager].history lastObject];
        if(last)
        {
            self.currentStep.stepID = last.stepID + 1;
        }
        _mode = [PuzzleRecord sharedPuzzleRecord].mode;
        [self setTime:[PuzzleRecord sharedPuzzleRecord].time];
        [self setScore:[PuzzleRecord sharedPuzzleRecord].score];
        
        for (int i = 0; i < 7; i++)
        {
            StackRecord* record = [[PuzzleRecord sharedPuzzleRecord].statics objectAtIndex:i];
            StaticStack* stack = [self getStaticStackByIndex:i];
            
            for (int j = 0; j < 52; j++)
            {
                int tag = [record cardAtIndex:j];
                if(tag != -1)
                {
                    Card* card = [self getCardByTag:tag];
                    [card setIsCovered:[record coveredAtIndex:j]];
                    [stack addCard:card Animated:NO DelayTime:0 Duration:SHIFT_DURATION];
                }
                else
                    break;
            }
        }
        
        for (int i = 0; i < 2; i++)
        {
            
            StackRecord* record = [[PuzzleRecord sharedPuzzleRecord].delivers objectAtIndex:i];
            if(i == 0)
            {
                DeliverStack* stack = [self getDeliverStackByIndex:i];
                
                for (int j = 0; j < 52; j++)
                {
                    int tag = [record cardAtIndex:j];
                    if(tag != -1)
                    {
                        Card* card = [self getCardByTag:tag];
                        [card setIsCovered:[record coveredAtIndex:j]];
                        [stack addCard:card Animated:NO DelayTime:0 Duration:SHIFT_DURATION];
                    }
                    else
                        break;
                }
            }
            else
            {
                PopStack* stack = [self getPopStackByIndex:0];
                
                for (int j = 0; j < 52; j++)
                {
                    int tag = [record cardAtIndex:j];
                    if(tag != -1)
                    {
                        Card* card = [self getCardByTag:tag];
                        [card setIsCovered:[record coveredAtIndex:j]];
                        [stack addCard:card Animated:NO DelayTime:0 Duration:SHIFT_DURATION];
                    }
                    else
                        break;
                }
            }
            
        }
        
        for (int i = 0; i < 4; i++)
        {
            StackRecord* record = [[PuzzleRecord sharedPuzzleRecord].finishes objectAtIndex:i];
            FinishStack* stack = [self getFinishStackByIndex:i];
            
            for (int j = 0; j < 52; j++)
            {
                int tag = [record cardAtIndex:j];
                if(tag != -1)
                {
                    Card* card = [self getCardByTag:tag];
                    [card setIsCovered:[record coveredAtIndex:j]];
                    [stack addCard:card Animated:NO DelayTime:0 Duration:SHIFT_DURATION];
                }
                else
                    break;
            }
        }
        
        PopStack* stack = [self getPopStackByIndex:0];
        [stack updateCardsAnimate:YES DelayTime:0];
    }
    else
    {
        [[LevelManager sharedLevelManager] setRounds:[[LevelManager sharedLevelManager] roundsForMode:_mode] + 1 forMode:_mode];
        [self setTime:0];
        [self setScore:0];
        
        _auto = NO;
        _complete = NO;
        int order[MAX_CARDS];
        for (int i = 1; i <= MAX_CARDS; i++)
        {
            order[i - 1] = i;
        }
        for (int i = 0;  i < MAX_CARDS; i++)
        {
            int a = arc4random() % MAX_CARDS;
            int b = arc4random() % MAX_CARDS;
            
            if(a != b)
            {
                int temp = order[a];
                order[a] = order[b];
                order[b] = temp;
            }
        }
        
        int index = 0;
        int target = 7;
        int count = 0;
        for (int i = 0; i < 28; i++)
        {
            int stack_index = index;
            
            Card* card = [self getCardByTag:order[i]];
            if(i == 0 || i == 7 || i == 13 || i == 18 || i == 22 || i == 25 || i == 27)
                [card setIsCovered:NO Animated:YES DelayTime:(i) * 0.05 Duration:FLIP_DURATION];
            
            
            [self.cardBatch reorderChild:card z:GameNodeZOrder_Top - i];
            StaticStack* stack = [self getStaticStackByIndex:stack_index];
            [stack addCard:card Animated:YES DelayTime:(i) * 0.05 Duration:DELIVER_DURATION];
            
            count++;
            index++;
            if(count >= target)
            {
                target--;
                index = MAX_STATIC_STACK - target;
                count = 0;
            }
        }
        
        
        DeliverStack* stack = [self getDeliverStackByIndex:0];
        for (int j = 0; j < 24; j++)
        {
            Card* card = [self getCardByTag:order[28 + j]];
            [stack addCard:card Animated:YES DelayTime: 0.05 Duration:DELIVER_DURATION];
        }
        
        
        [self save];
        [[HistoryManager sharedHistoryManager].history removeAllObjects];
        self.currentStep.stepID = 0;
    }
    
}

-(void)save
{
    [PuzzleRecord sharedPuzzleRecord].hasRecord = YES;
    [PuzzleRecord sharedPuzzleRecord].mode = _mode;
    [PuzzleRecord sharedPuzzleRecord].score = _score;
    [PuzzleRecord sharedPuzzleRecord].time = _time;
    [PuzzleRecord sharedPuzzleRecord].factor = _factor;

    [[PuzzleRecord sharedPuzzleRecord] clear];
    for (int i = 0; i < 7; i++)
    {
        StackRecord* record = [[PuzzleRecord sharedPuzzleRecord].statics objectAtIndex:i];
        StaticStack* stack = [self getStaticStackByIndex:i];
        int j = 0;
        for (Card* card in stack.cards)
        {
            [record setCard:card.tag AtIndex:j];
            
            if(card == stack.cards.lastObject)
                [record setCovered:NO AtIndex:j];
            else
                [record setCovered:card.isCovered AtIndex:j];
            
            j++;
        }
    }
    
    for (int i = 0; i < 2; i++)
    {
        if(i == 0)
        {
            StackRecord* record = [[PuzzleRecord sharedPuzzleRecord].delivers objectAtIndex:i];
            DeliverStack* stack = [self getDeliverStackByIndex:i];
            int j = 0;
            for (Card* card in stack.cards)
            {
                [record setCard:card.tag AtIndex:j];
                [record setCovered:card.isCovered AtIndex:j];
                j++;
            }
        }
        else
        {
            StackRecord* record = [[PuzzleRecord sharedPuzzleRecord].delivers objectAtIndex:i];
            PopStack* stack = [self getPopStackByIndex:0];
            int j = 0;
            for (Card* card in stack.cards)
            {
                [record setCard:card.tag AtIndex:j];
                [record setCovered:card.isCovered AtIndex:j];
                j++;
            }
        }
        
    }
    
    for (int i = 0; i < 4; i++)
    {
        StackRecord* record = [[PuzzleRecord sharedPuzzleRecord].finishes objectAtIndex:i];
        FinishStack* stack = [self getFinishStackByIndex:i];
        int j = 0;
        for (Card* card in stack.cards)
        {
            [record setCard:card.tag AtIndex:j];
            [record setCovered:card.isCovered AtIndex:j];
            j++;
        }
    }
    [[PuzzleRecord sharedPuzzleRecord] save];
    [[PuzzleRecord sharedPuzzleRecord] PrintOut];
}

-(void)onEnterTransitionDidFinish
{
    if(self.isResumed == NO)
    {
        [self createGame];
    }
}

-(Card*)getCardByTag:(NSInteger)tag
{
    if(tag > GameNodeTag_Card + MAX_CARDS)
        CCLOG(@"WRING: Tag is Out of Range");
    Card* card = (Card*)[self.cardBatch getChildByTag:tag];
    return card;
}

-(StaticStack*)getStaticStackByIndex:(int)index
{
    StaticStack* stack = [self.stacks objectAtIndex:index];
    return stack;
}

-(DeliverStack*)getDeliverStackByIndex:(int)index
{
    DeliverStack* stack = [self.stacks objectAtIndex:index + MAX_STATIC_STACK + MAX_FINISH_STACK];
    return stack;
}

-(PopStack*)getPopStackByIndex:(int)index
{
    PopStack* stack = [self.stacks objectAtIndex:index + MAX_STATIC_STACK + MAX_FINISH_STACK + MAX_DELIVER_STACK];
    return stack;
}

-(FloatStack*)getFloatStack
{
    FloatStack* stack = [self.stacks objectAtIndex:MAX_STATIC_STACK + MAX_FINISH_STACK + MAX_DELIVER_STACK + MAX_POP_STACK];
    return stack;
}

-(FinishStack*)getFinishStackByIndex:(int)index
{
    FinishStack* stack = [self.stacks objectAtIndex:MAX_STATIC_STACK + index];
    return stack;
}

-(FinishStack*)emptyFinishStack
{
    for (int i = 0; i < 8; i++)
    {
        FinishStack* stack = [self getFinishStackByIndex:i];
        if(stack.cards.count == 0)
            return stack;
    }
    return nil;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(_ready == NO || _arranged == NO)
    {
        return YES;
    }
    CGPoint p = [self convertTouchToNodeSpace:touch];
    _draged = NO;
    _posTap = p;
    _noOperation = YES;
    _tempScore = 0;
    [self.steps removeAllObjects];
    
    
    
    
    FloatStack* floatStack = [self getFloatStack];
    [floatStack.cards removeAllObjects];
    
    for (int i = 0; i < MAX_STATIC_STACK; i++)
    {
        StaticStack* stack = [self getStaticStackByIndex:i];
        if(stack.cards.count > 0)
        {
            if(CGRectContainsPoint([stack availableArea], p))
            {
                FloatStack* floatStack = [self getFloatStack];
                floatStack.position = p;
                if ([stack pickWithTouch:touch ToStack:floatStack])
                {
                    self.currentStep.pickIndex = stack.index;
                    break;
                }
            }
        }
    }
    
    for (int i = 0; i < MAX_FINISH_STACK; i++)
    {
        FinishStack* stack = [self getFinishStackByIndex:i];
        if(stack.cards.count > 0)
        {
            if(CGRectContainsPoint([stack availableArea], p))
            {
                FloatStack* floatStack = [self getFloatStack];
                floatStack.position = p;
                
                Card* card = [stack.cards lastObject];
                [floatStack.cards addObject:card];
                [card.parent reorderChild:card z:floatStack.zOrder];
                [stack.cards removeObject:card];
                self.currentStep.pickIndex = stack.index;
                break;
            }
        }
        
    }
    
    
    
    PopStack* stack = [self getPopStackByIndex:0];
    if(stack.cards.count > 0)
    {
        if(CGRectContainsPoint([stack availableArea], p))
        {
            FloatStack* floatStack = [self getFloatStack];
            floatStack.position = p;
            
            Card* card = [stack.cards lastObject];
            [floatStack.cards addObject:card];
            [card.parent reorderChild:card z:floatStack.zOrder];
            [stack.cards removeObject:card];
            
            self.currentStep.pickIndex = stack.index;
        }
    }
    
    
    DeliverStack* deliver = [self getDeliverStackByIndex:0];
    if(CGRectContainsPoint([deliver availableArea], p))
    {
        if(deliver.cards.count)
        {
            _ready = NO;
            _noOperation = NO;
            _arranged = NO;
            
            PopStack* pop = [self getPopStackByIndex:0];
            for (int i = 0; i < deliver.drawn; i++)
            {
                Card* card = [deliver.cards lastObject];
                
                
                if(card)
                {
                    [card.parent reorderChild:card z:GameNodeZOrder_Top];
                    [card setIsCovered:NO Animated:YES DelayTime:0.0 Duration:FLIP_DURATION];
                    [pop.cards addObject:card];
                    [deliver.cards removeObject:card];
                    
                    StepInfo* step = [StepInfo info];
                    step.pickIndex = deliver.index;
                    step.dropIndex = pop.index;
                    step.cardTag = card.tag;
                    step.stepID = self.currentStep.stepID;
                    step.type = StepType_Deliver;
                    [self.steps addObject:step];
                }
                
            }
            [pop updateCardsAnimate:YES DelayTime:0];
        }
        else
        {
            PopStack* pop = [self getPopStackByIndex:0];
            if(pop.cards.count > 0)
            {
                _ready = NO;
                _noOperation = NO;
                _arranged = NO;
                
                
                DeliverStack* deliver = [self getDeliverStackByIndex:0];
                for (int i = pop.cards.count - 1; i >= 0; i--)
                {
                    Card* card = [pop.cards objectAtIndex:i];
                    
                    [deliver addCard:card Animated:YES DelayTime:0 Duration:DELIVER_DURATION];
                    [card setIsCovered:YES Animated:NO DelayTime:0 Duration:FLIP_DURATION];
                    
                    StepInfo* step = [StepInfo info];
                    step.pickIndex = pop.index;
                    step.dropIndex = deliver.index;
                    step.cardTag = card.tag;
                    step.stepID = self.currentStep.stepID;
                    step.type = StepType_Pop;
                    [self.steps addObject:step];
                }
                [pop.cards removeAllObjects];
                
                if(_mode == GameMode_One)
                {
                    _tempScore += SCORE_LOOP_ONE * self.factor;
                }
                else
                {
                    _tempScore += SCORE_LOOP_Three * self.factor;
                }
            }
        }
    }
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(_ready == NO || _arranged == NO)
        return ;
    CGPoint p = [self convertTouchToNodeSpace:touch];
    CGPoint delta = ccpSub(_posTap, p);
    if(ccpLength(delta) > 10)
    {
        _draged = YES;
    }
    
    FloatStack* floatStack = [self getFloatStack];
    floatStack.position = p;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(_ready == NO || _arranged == NO)
        return ;
    _ready = NO;
    _arranged = NO;
    CGPoint p = [self convertTouchToNodeSpace:touch];
    FloatStack* floatStack = [self getFloatStack];
    floatStack.position = p;
    
    if(floatStack.cards.count == 0)
        return;
    

    
    if(_draged)
    {
        BOOL Found = NO;
        Card* card = [floatStack.cards objectAtIndex:0];
        CGRect rect = CGRectMake(p.x - card.contentSize.width * 0.5, p.y - card.contentSize.height * 0.5, card.contentSize.width, card.contentSize.height);
        
        if(!Found)
        {
            if(floatStack.cards.count == 1)
            {
                for (int i = 0; i < MAX_FINISH_STACK; i++)
                {
                    FinishStack* stack = [self getFinishStackByIndex:i];
                    
                    if(stack.index == _currentStep.pickIndex)
                        continue;
                    if(CGRectIntersectsRect([stack availableArea], rect))
                    {
                        if([stack canConnectWithStack:floatStack])
                        {
                            self.currentStep.dropIndex = i;
                            
                            _noOperation = NO;
                            [stack addStack:floatStack Duration:SHIFT_DURATION];
                            
                            for (Card* card in floatStack.cards)
                            {
                                StepInfo* step = [StepInfo info];
                                step.pickIndex = self.currentStep.pickIndex;
                                step.dropIndex = stack.index;
                                step.cardTag = card.tag;
                                step.stepID = self.currentStep.stepID;
                                step.type = StepType_Transfer;
                                [self.steps addObject:step];
                                
                                
                            }
                            
                            _tempScore += [self computeScoreByPickIndex:self.currentStep.pickIndex DropIndex2:stack.index];
                            
                            
                            if(self.currentStep.pickIndex < MAX_STATIC_STACK)
                            {
                                StaticStack* pickStack = [self getStaticStackByIndex:self.currentStep.pickIndex];
                                if([pickStack checkOpenNewCard])
                                {
                                    Card* card = [pickStack.cards lastObject];
                                    StepInfo* step = [StepInfo info];
                                    step.pickIndex = pickStack.index;
                                    step.dropIndex = pickStack.index;
                                    step.cardTag = card.tag;
                                    step.stepID = self.currentStep.stepID;
                                    step.type = StepType_Flip;
                                    [self.steps addObject:step];
                                    
                                    _tempScore += [self computeScoreByPickIndex:pickStack.index DropIndex2:pickStack.index];
                                }
                            }
                            Found = YES;
                            break;
                        }
                    }
                }
            }
        }
        
        
        if(!Found)
        {
            for (int i = 0; i < MAX_STATIC_STACK; i++)
            {
                
                StaticStack* stack = [self getStaticStackByIndex:i];
                
                if(stack.index == _currentStep.pickIndex)
                    continue;
                
                if(CGRectIntersectsRect([stack availableArea], rect))
                {
                    if([stack canConnectWithStack:floatStack])
                    {
                        self.currentStep.dropIndex = i;
                        
                        _noOperation = NO;
                        [stack addStack:floatStack Duration:SHIFT_DURATION];
                        
                        for (Card* card in floatStack.cards)
                        {
                            StepInfo* step = [StepInfo info];
                            step.pickIndex = self.currentStep.pickIndex;
                            step.dropIndex = stack.index;
                            step.cardTag = card.tag;
                            step.stepID = self.currentStep.stepID;
                            step.type = StepType_Transfer;
                            [self.steps addObject:step];
                        }
                        
                        _tempScore += [self computeScoreByPickIndex:self.currentStep.pickIndex DropIndex2:stack.index];
                        
                        if(self.currentStep.pickIndex < MAX_STATIC_STACK)
                        {
                            StaticStack* pickStack = [self getStaticStackByIndex:self.currentStep.pickIndex];
                            if([pickStack checkOpenNewCard])
                            {
                                Card* card = [pickStack.cards lastObject];
                                StepInfo* step = [StepInfo info];
                                step.pickIndex = pickStack.index;
                                step.dropIndex = pickStack.index;
                                step.cardTag = card.tag;
                                step.stepID = self.currentStep.stepID;
                                step.type = StepType_Flip;
                                [self.steps addObject:step];
                                
                                _tempScore += [self computeScoreByPickIndex:pickStack.index DropIndex2:pickStack.index];
                            }
                        }
                        break;
                    }
                }
            }
        }
        
        if(_noOperation)
        {
            PopStack* pop = [self getPopStackByIndex:0];
            
            if(self.currentStep.pickIndex == pop.index)
            {
                CardStack* floatStack = [self getFloatStack];
                for (Card* card in floatStack.cards)
                {
                    [pop.cards addObject:card];
                }
                [pop updateCardsAnimate:YES DelayTime:0];
            }
            else
            {
                CardStack* stack = [self.stacks objectAtIndex:self.currentStep.pickIndex];
                [stack addStack:[self getFloatStack] Duration:SHIFT_DURATION];
            }
        }
        else
        {
            PopStack* pop = [self getPopStackByIndex:0];
            if(self.currentStep.pickIndex == pop.index)
            {
                [pop updateCardsAnimate:YES DelayTime:0];
            }
        }
        
        [floatStack.cards removeAllObjects];
    }
    else
    {
        int i = 0;
        BOOL Found = NO;
        
        if(!Found)
        {
            if(floatStack.cards.count == 1)
            {
                for (int i = 0; i < MAX_FINISH_STACK; i++)
                {
                    FinishStack* stack = [self getFinishStackByIndex:i];
                    
                    if(stack.index == _currentStep.pickIndex)
                        continue;
                    
                    if([stack canConnectWithStack:floatStack])
                    {
                        self.currentStep.dropIndex = i;
                       
                        _noOperation = NO;
                        [stack addStack:floatStack Duration:SHIFT_DURATION];
                        
                        for (Card* card in floatStack.cards)
                        {
                            StepInfo* step = [StepInfo info];
                            step.pickIndex = self.currentStep.pickIndex;
                            step.dropIndex = stack.index;
                            step.cardTag = card.tag;
                            step.stepID = self.currentStep.stepID;
                            step.type = StepType_Transfer;
                            [self.steps addObject:step];
                        }
                        _tempScore += [self computeScoreByPickIndex:self.currentStep.pickIndex DropIndex2:stack.index];
                        
                        if(self.currentStep.pickIndex < MAX_STATIC_STACK)
                        {
                            StaticStack* pickStack = [self getStaticStackByIndex:self.currentStep.pickIndex];
                            if([pickStack checkOpenNewCard])
                            {
                                Card* card = [pickStack.cards lastObject];
                                StepInfo* step = [StepInfo info];
                                step.pickIndex = pickStack.index;
                                step.dropIndex = pickStack.index;
                                step.cardTag = card.tag;
                                step.stepID = self.currentStep.stepID;
                                step.type = StepType_Flip;
                                [self.steps addObject:step];
                                _tempScore += [self computeScoreByPickIndex:pickStack.index DropIndex2:pickStack.index];

                            }
                        }
                        Found = YES;
                        break;
                    }
                }
            }
        }
        
        if(!Found)
        {
            for (i = 0; i < MAX_STATIC_STACK; i++)
            {
                StaticStack* stack = [self getStaticStackByIndex:i ];
                
                if(stack.index == _currentStep.pickIndex)
                    continue;
                if([stack canConnectWithStack:floatStack])
                {
                    self.currentStep.dropIndex = i ;
                    _noOperation = NO;
                    [stack addStack:floatStack Duration:SHIFT_DURATION];
                    
                    for (Card* card in floatStack.cards)
                    {
                        StepInfo* step = [StepInfo info];
                        step.pickIndex = self.currentStep.pickIndex;
                        step.dropIndex = stack.index;
                        step.cardTag = card.tag;
                        step.stepID = self.currentStep.stepID;
                        step.type = StepType_Transfer;
                        [self.steps addObject:step];
                    }
                    
                    _tempScore += [self computeScoreByPickIndex:self.currentStep.pickIndex DropIndex2:stack.index];
                    
                    if(self.currentStep.pickIndex < MAX_STATIC_STACK)
                    {
                        StaticStack* pickStack = [self getStaticStackByIndex:self.currentStep.pickIndex];
                        if([pickStack checkOpenNewCard])
                        {
                            Card* card = [pickStack.cards lastObject];
                            StepInfo* step = [StepInfo info];
                            step.pickIndex = pickStack.index;
                            step.dropIndex = pickStack.index;
                            step.cardTag = card.tag;
                            step.stepID = self.currentStep.stepID;
                            step.type = StepType_Flip;
                            [self.steps addObject:step];
                            _tempScore += [self computeScoreByPickIndex:pickStack.index DropIndex2:pickStack.index];
                        }
                    }
                    break;
                }
            }
        }
        
        
        if(_noOperation)
        {
            PopStack* pop = [self getPopStackByIndex:0];
            
            if(self.currentStep.pickIndex == pop.index)
            {
                CardStack* floatStack = [self getFloatStack];
                for (Card* card in floatStack.cards)
                {
                    [pop.cards addObject:card];
                }
                [pop updateCardsAnimate:YES DelayTime:0];
            }
            else
            {
                CardStack* stack = [self.stacks objectAtIndex:self.currentStep.pickIndex];
                [stack addStack:[self getFloatStack] Duration:SHIFT_DURATION];
            }
        }
        else
        {
            PopStack* pop = [self getPopStackByIndex:0];
            if(self.currentStep.pickIndex == pop.index)
            {
                [pop updateCardsAnimate:YES DelayTime:0];
            }
        }
        
        [floatStack.cards removeAllObjects];
    }
    
}

-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self ccTouchEnded:touch withEvent:event];
}


-(void)onUndo:(id)sender
{
    if(_ready == NO || _arranged == NO)
        return;
    if([HistoryManager sharedHistoryManager].history.count == 0)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    _ready = NO;
    _arranged = NO;
    _noOperation = NO;
    [self.steps removeAllObjects];
    _currentStep.stepID = _currentStep.stepID - 1;
    self.move = _currentStep.stepID;
    
    self.score = self.score + SCORE_UNDO;
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = [HistoryManager sharedHistoryManager].history.count - 1; i >= 0; i--)
    {
        StepInfo* info = [[HistoryManager sharedHistoryManager].history objectAtIndex:i];
        
        if(info.stepID == _currentStep.stepID)
        {
            [array addObject:info];
        }
        else
            break;
    }
    
    StepInfo* first = [array objectAtIndex:0];
    StepKind kind;
    if(first.type == StepType_Pop)
    {
        kind = StepKind_Pop;
    }
    else if(first.type == StepType_Deliver)
    {
        kind = StepKind_Deliver;
    }
    else if (first.type == StepType_Flip)
    {
        kind = StepKind_Transfer_Flip;
    }
    else if (first.type == StepType_Transfer)
    {
        kind = StepKind_Transfer;
    }
    else if(first.type == StepType_Swap)
    {
        kind = StepKind_Swap;
    }
    else
    {
        kind = 0;
    }
    
    int i = 0;
    DeliverStack* deliver = [self getDeliverStackByIndex:0];
    PopStack*     pop = [self getPopStackByIndex:0];
    switch (kind)
    {
        case StepKind_Pop:
            i = 0;
            for (StepInfo* info in array)
            {
                Card* card = [self getCardByTag:info.cardTag];
                [card.parent reorderChild:card z:GameNodeZOrder_Top + i];
                [deliver.cards removeObject:card];
                [card setIsCovered:NO Animated:NO DelayTime:0 Duration:FLIP_DURATION];
                [pop.cards addObject:card];
                
                i++;

            }
            
            [pop updateCardsAnimate:YES DelayTime:0];
            break;
        case StepKind_Deliver:
            i = 0;
            for (StepInfo* info in array)
            {
                Card* card = [self getCardByTag:info.cardTag];
                [card.parent reorderChild:card z:GameNodeZOrder_Top];
                [deliver addCard:card Animated:YES DelayTime:0 Duration:DELIVER_DURATION];
                [card setIsCovered:YES Animated:YES DelayTime:0 Duration:FLIP_DURATION];
                [pop.cards removeObject:card];
                i++;
            }
            [pop updateCardsAnimate:YES DelayTime:0];
            break;
        case StepKind_Transfer_Flip:
            {
                StepInfo* info = [array objectAtIndex:0];
                Card* card = [self getCardByTag:info.cardTag];
                [card setIsCovered:YES Animated:YES DelayTime:0 Duration:FLIP_DURATION];
            }
            
            for (int j = array.count - 1; j >= 1; j--)
            {
                StepInfo* info = [array objectAtIndex:j];
                Card* card = [self getCardByTag:info.cardTag];
                [card.parent reorderChild:card z:GameNodeZOrder_Top + i];
                
                if(info.pickIndex == [self getPopStackByIndex:0].index)
                {
                    PopStack* pick = [self getPopStackByIndex:0];
                    CardStack* drop = [self.stacks objectAtIndex:info.dropIndex];
                    [drop.cards removeObject:card];
                    [pick.cards addObject:card];
                    [pick updateCardsAnimate:YES DelayTime:0.1];
                }
                else
                {
                    CardStack* pick = [self.stacks objectAtIndex:info.pickIndex];
                    CardStack* drop = [self.stacks objectAtIndex:info.dropIndex];
                    [drop.cards removeObject:card];
                    [pick addCard:card Animated:YES DelayTime:0.1 Duration:DELIVER_DURATION];
                }
            }
            
            break;
        case StepKind_Transfer:
            
            for (int j = array.count - 1; j >= 0; j--)
            {
                StepInfo* info = [array objectAtIndex:j];
                Card* card = [self getCardByTag:info.cardTag];
                [card.parent reorderChild:card z:GameNodeZOrder_Top + i];
                
                if(info.pickIndex == [self getPopStackByIndex:0].index)
                {
                    PopStack* pick = [self getPopStackByIndex:0];
                    CardStack* drop = [self.stacks objectAtIndex:info.dropIndex];
                    [drop.cards removeObject:card];
                    [pick.cards addObject:card];
                    [pick updateCardsAnimate:YES DelayTime:0];
                }
                else
                {
                    CardStack* pick = [self.stacks objectAtIndex:info.pickIndex];
                    CardStack* drop = [self.stacks objectAtIndex:info.dropIndex];
                    [drop.cards removeObject:card];
                    [pick addCard:card Animated:YES DelayTime:0 Duration:DELIVER_DURATION];
                }
            }
            
            break;
        case StepKind_Swap:
            _ready = NO;
            _arranged = NO;
            _noOperation = NO;
            
            Card* card1 = [pop.cards objectAtIndex:pop.cards.count - 1];
            Card* card2 = [pop.cards objectAtIndex:pop.cards.count - 2];
            Card* card3 = [pop.cards objectAtIndex:pop.cards.count - 3];
            
            [pop.cards removeObject:card1];
            [pop.cards removeObject:card2];
            [pop.cards removeObject:card3];
            
            [pop.cards addObject:card1];
            [pop.cards addObject:card2];
            [pop.cards addObject:card3];
            
            [pop updateCardsAnimate:YES DelayTime:0];
            
            break;
        default:
            break;
    }
   
    
    StepInfo* info = [array objectAtIndex:0];
    _tempScore = -info.score;
    CCLOG(@"Step:%d Score:%.0f",self.currentStep.stepID,info.score);
    
    for (StepInfo* info in array)
    {
        [[HistoryManager sharedHistoryManager].history removeObject:info];
    }
}

-(void)searchTips
{
    [self.tipManager.tips removeAllObjects];
    self.tipManager.tipIndex = 0;
    
    for (int i = 0; i< MAX_STATIC_STACK; i++)
    {
        StaticStack* dropStack = [self getStaticStackByIndex:i];
        Card* bottomCard =  dropStack.cards.lastObject;
        if(bottomCard)
        {
            for (int j = 0; j < MAX_STATIC_STACK; j++)
            {
                if(j == i)
                {
                    continue;
                }
                else
                {
                    StaticStack* pickStack = [self getStaticStackByIndex:j];
                    for (int k = pickStack.cards.count - 1; k >= 0; k--)
                    {
                        
                        Card* card = [pickStack.cards objectAtIndex:k];
                        if(card.isCovered == NO)
                        {
                            if([pickStack canPickAtIndex:k] && [dropStack canConnectWithCard:card])
                            {
                                int Priority = 5;
                                
                                if(k > 0)
                                {
                                    Card* tail = [pickStack.cards objectAtIndex:k - 1];
                                    // 可以翻牌 优先级 + 1
                                    if (tail.isCovered)
                                    {
                                        Priority += 13;
                                    }
                                    
                                }
                                else
                                {
                                    // 出现空牌堆
                                    Priority += 26;
                                }
                        
                                Tip* tip = [Tip tip];
                                tip.pickStack = pickStack.index;
                                tip.pickIndex = k;
                                tip.dropStack = dropStack.index;
                                
                                tip.priority = Priority;
                                
                                [self.tipManager.tips addObject:tip];
                            }
                            else
                            {
                                
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
            }
            
            PopStack* pop = [self getPopStackByIndex:0];
            Card* tail = [pop.cards lastObject];
            if(tail)
            {
                
                if([dropStack canConnectWithCard:tail])
                {
                    int Priority = 6;
                    Tip* tip = [Tip tip];
                    tip.pickStack = pop.index;
                    tip.pickIndex = pop.cards.count - 1;
                    tip.dropStack = dropStack.index;
                    tip.priority = Priority;
                    [self.tipManager.tips addObject:tip];
                }
                else
                {
                    
                }
            }
            
//            for (int j = 0; j < MAX_FINISH_STACK; j++)
//            {
//                FinishStack* pickStack = [self getFinishStackByIndex:j];
//                
//                Card* tail = [pickStack.cards lastObject];
//                if(tail)
//                {
//                    if([dropStack canConnectWithCard:tail])
//                    {
//                        int Priority = 1;
//                        Tip* tip = [Tip tip];
//                        tip.pickStack = pickStack.index;
//                        tip.pickIndex = pickStack.cards.count - 1;
//                        tip.dropStack = dropStack.index;
//                        tip.priority = Priority;
//                        [self.tipManager.tips addObject:tip];
//                    }
//                    else
//                    {
//                        
//                    }
//                }
//            }
    
        }
        else
        {
            for (int j = 0; j < MAX_STATIC_STACK; j++)
            {
                if(j == i)
                    continue;
                
                StaticStack* pickStack = [self getStaticStackByIndex:j];
                
                for (int k = pickStack.cards.count - 1; k >= 0; k--)
                {
                    Card* card = [pickStack.cards objectAtIndex:k];
                    if(card.isCovered == NO)
                    {
                        if([pickStack canPickAtIndex:k] && [dropStack canConnectWithCard:card])
                        {
                            int Priority = 0;
                            
                            if(k > 0)
                            {
                                Card* tail = [pickStack.cards objectAtIndex:k - 1];
                                // 可以翻牌 优先级 + 1
                                if (tail.isCovered)
                                {
                                    Priority += 13;
                                }
                                
                            }
                           
                            Tip* tip = [Tip tip];
                            tip.pickStack = j;
                            tip.pickIndex = k;
                            tip.dropStack = i;
                            
                            tip.priority = Priority;
                            
                            [self.tipManager.tips addObject:tip];
                        }
                    }
                    else
                        break;
                }
            }
            
            PopStack* pop = [self getPopStackByIndex:0];
            Card* tail = [pop.cards lastObject];
            if(tail)
            {
                
                if([dropStack canConnectWithCard:tail])
                {
                    int Priority = 5;
                    Tip* tip = [Tip tip];
                    tip.pickStack = pop.index;
                    tip.pickIndex = pop.cards.count - 1;
                    tip.dropStack = dropStack.index;
                    tip.priority = Priority;
                    [self.tipManager.tips addObject:tip];
                }
                else
                {
                    
                }
            }
        }
    }
    
    for (int i = 0; i < MAX_FINISH_STACK; i++)
    {
        FinishStack* dropStack = [self getFinishStackByIndex:i];
        Card* bottom = [dropStack.cards lastObject];
        if(bottom)
        {
            for (int j = 0; j < MAX_STATIC_STACK; j++)
            {
                StaticStack* pickStack = [self getStaticStackByIndex:j];
                Card* tail = [pickStack.cards lastObject];
                if(tail)
                {
                    if([dropStack canConnectWithCard:tail])
                    {
                        
                        int Priority = 8;
                        
                        if(pickStack.cards.count == 1)
                        {
                            Priority += 26;
                        }
                        else
                        {
                            Card* card = [pickStack.cards objectAtIndex:pickStack.cards.count - 2];
                            if(card.isCovered == YES)
                                Priority += 13;
                        }
                        
                        Tip* tip = [Tip tip];
                        tip.pickStack = pickStack.index;
                        tip.pickIndex = pickStack.cards.count - 1;
                        tip.dropStack = dropStack.index;
                        
                        tip.priority = Priority;
                        
                        [self.tipManager.tips addObject:tip];
                    }
                }
            }
            
            
            PopStack* pop = [self getPopStackByIndex:0];
            Card* tail = [pop.cards lastObject];
            if(tail)
            {
                
                if([dropStack canConnectWithCard:tail])
                {
                    int Priority = 8;
                    Tip* tip = [Tip tip];
                    tip.pickStack = pop.index;
                    tip.pickIndex = pop.cards.count - 1;
                    tip.dropStack = dropStack.index;
                    tip.priority = Priority;
                    [self.tipManager.tips addObject:tip];
                }
                else
                {
                    
                }
            }
        }
        else
        {
            for (int j = 0; j < MAX_STATIC_STACK; j++)
            {
                StaticStack* pickStack = [self getStaticStackByIndex:j];
                Card* tail = [pickStack.cards lastObject];
                if(tail)
                {
                    if([dropStack canConnectWithCard:tail])
                    {
                        int Priority = 8;
                        
                        if(pickStack.cards.count == 1)
                        {
                            Priority += 26;
                        }
                        else
                        {
                            Card* card = [pickStack.cards objectAtIndex:pickStack.cards.count - 2];
                            if(card.isCovered == YES)
                                Priority += 13;
                        }
                        
                        Tip* tip = [Tip tip];
                        tip.pickStack = pickStack.index;
                        tip.pickIndex = pickStack.cards.count - 1;
                        tip.dropStack = dropStack.index;
                        
                        tip.priority = Priority;
                        
                        [self.tipManager.tips addObject:tip];
                    }
                }
            }
            
            
            PopStack* pop = [self getPopStackByIndex:0];
            Card* tail = [pop.cards lastObject];
            if(tail)
            {
                
                if([dropStack canConnectWithCard:tail])
                {
                    int Priority = 8;
                    Tip* tip = [Tip tip];
                    tip.pickStack = pop.index;
                    tip.pickIndex = pop.cards.count - 1;
                    tip.dropStack = dropStack.index;
                    tip.priority = Priority;
                    [self.tipManager.tips addObject:tip];
                }
                else
                {
                    
                }
            }
        }
    }

    [self.tipManager sort];
}

-(void)hideTip
{
    self.pickHint.visible = NO;
    self.dropHint.visible = NO;
    
    for (int i = 0; i <= MAX_CARDS; i++)
    {
        Card* card = [self getCardByTag:i];
        if(card)
            card.light = CardLightKind_None;
    }
}

-(void)showTip:(Tip*)tip
{
    [self hideTip];
    if(tip == nil)
    {
        float SizeFont;
        CGPoint PosHint;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            SizeFont = 36;
            PosHint = CGPointMake(348,  260);
        }
        else
        {
            SizeFont = 18;
            PosHint = CGPointMake(160,  140);
        }
        CCLabelTTF* label = [CCLabelTTF labelWithString:NSLocalizedString(@"There is no card can be moved",nil) fontName:SYSTEM_FONT fontSize:SizeFont];
        label.position = PosHint;
        [self addChild:label];
        
        CCSequence* sequence = [CCSequence actions:
                                [CCFadeIn actionWithDuration:0.3],
                                [CCDelayTime actionWithDuration:0.2],
                                [CCFadeOut actionWithDuration:0.2],
                                [CCCallFuncND actionWithTarget:label selector:@selector(removeFromParentAndCleanup:) data:(void*)YES],
                                nil];
        [label runAction:sequence];
    }
    else
    {
        CGPoint target;
        CardStack* dropStack = [self.stacks objectAtIndex:tip.dropStack];
        Card* dropCard = [dropStack.cards lastObject];
        dropCard.light = CardLightKind_Blue;
        
        if(dropStack.cards.count == 0)
        {
            self.dropHint.visible = YES;
            self.dropHint.position = dropStack.position;
            target = dropStack.position;
            target = ccp(target.x - dropStack.gap.width, target.y - dropStack.gap.height);
        }
        else
        {
            target = dropCard.position;
        }
        
        if(tip.dropStack >= MAX_STATIC_STACK && dropStack.cards.count > 0)
        {
            target = ccp(target.x - dropStack.gap.width, target.y - dropStack.gap.height);
        }
        else
        {
            //target = ccp(target.x + dropStack.gap.width, target.y + dropStack.gap.height);
        }
        
        
        CardStack* pickStack = [self.stacks objectAtIndex:tip.pickStack];
        for (int i = tip.pickIndex; i < pickStack.cards.count; i++)
        {
            Card* card = [pickStack.cards objectAtIndex:i];
            card.light = CardLightKind_Yellow;
            int zOrder = card.zOrder;
            
            CGPoint temp = ccp(target.x + dropStack.gap.width * (i + 1 - tip.pickIndex), target.y + dropStack.gap.height * (i + 1 - tip.pickIndex));
            
            [card.parent reorderChild:card z:GameNodeZOrder_Top + i];
            CCSequence* sequence = [CCSequence actions:
                                    [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:HINT_DURATION position:temp] rate:1.5],
                                    [CCDelayTime actionWithDuration:HINT_DURATION * 0.5],
                                    [CCEaseOut actionWithAction:[CCMoveTo actionWithDuration:HINT_DURATION position:card.position] rate:1.5],
                                    [CCCallBlock actionWithBlock:^{[card.parent reorderChild:card z:zOrder];}],
                                    nil];
            [card runAction:sequence];
        }
        
        
    }
}

-(void)onTip:(id)sender
{
    if(_ready == NO || _arranged == NO)
        return;
    _ready = NO;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    
    _noOperation = YES;
    if(_hasSearched == NO)
    {
        [self searchTips];
        _hasSearched = YES;
        
        if(self.tipManager.tips.count > 0)
        {
            Tip* tip = [self.tipManager.tips objectAtIndex:0];
            [self showTip:tip];
        }
        else
        {
            [self showTip:nil];
        }
    }
    else
    {
        if(self.tipManager.tips.count > 0)
        {
            Tip* tip = [self.tipManager nextTip];
            [self showTip:tip];
        }
        else
        {
            [self showTip:nil];
        }
    }
}

-(void)onSetting:(id)sender
{
    if(_ready == NO || _arranged == NO)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    [self save];
    self.state = GameState_Pause;
    SettingLayer* layer = [SettingLayer layerWithPosition:_btSetting.position];
    [self addChild:layer];
    
}

-(void)onReplay:(id)sender
{
    if(_ready == NO || _arranged == NO)
        return;
    [[AudioManager sharedAudioManager] playEffect:BUTTON_SOUND];
    AbandonLayer* layer = [AbandonLayer layerWithMode:_mode Type:AbandonType_REPLAY];
    [self addChild:layer];
}

-(void)onAutoFinish:(id)sender
{
    if(_ready == NO || _arranged == NO)
        return;
    _auto =YES;
    [self nextAutoFinish];
    _autoFinish.visible = NO;
}

-(BOOL)checkComplete
{
    BOOL isComplete = YES;
    for (int i = 0; i < MAX_FINISH_STACK; i++)
    {
        FinishStack* stack = [self getFinishStackByIndex:i];
        if(stack.cards.count != 13)
        {
            isComplete = NO;
            break;
        }
    }
    return isComplete;
}

-(void)swapPop
{
    PopStack* pop = [self getPopStackByIndex:0];
    int count = pop.cards.count;
    if(count < 3)
        return;
    else
    {
        self.score = self.score + SCORE_SWAP;
        _ready = NO;
        _arranged = NO;
        _noOperation = NO;
        
        Card* card1 = [pop.cards objectAtIndex:count - 1];
        Card* card2 = [pop.cards objectAtIndex:count - 2];
        Card* card3 = [pop.cards objectAtIndex:count - 3];
        
        [pop.cards removeObject:card1];
        [pop.cards removeObject:card2];
        [pop.cards removeObject:card3];
        
        [pop.cards addObject:card1];
        [pop.cards addObject:card2];
        [pop.cards addObject:card3];
        
        [pop updateCardsAnimate:YES DelayTime:0];
        
        StepInfo* step = [StepInfo info];
        step.pickIndex = pop.index;
        step.dropIndex = pop.index;
        step.cardTag = 0;
        step.stepID = self.currentStep.stepID;
        step.type = StepType_Swap;
        [self.steps addObject:step];
    }
}

-(void)nextAutoFinish
{
    BOOL unfinish = NO;
    for (int i = 0; i < MAX_STATIC_STACK; i++)
    {
        StaticStack* temp = [self getStaticStackByIndex:i];
        if(temp.cards.count > 0)
        {
            unfinish = YES;
            break;
        }
    }
    
    if(unfinish == NO)
    {
        PopStack* temp = [self getPopStackByIndex:0];
        if(temp.cards.count > 0)
        {
            unfinish = YES;
        }
    }
    
    if(unfinish)
    {
        _ready = NO;
        _arranged = NO;
        for (int i = 0; i < MAX_STATIC_STACK; i++)
        {
            StaticStack* stack = [self getStaticStackByIndex:i];
            Card* tail = [stack.cards lastObject];
            if(tail)
            {
                for (int j = 0; j < MAX_FINISH_STACK; j++)
                {
                    FinishStack* finish = [self getFinishStackByIndex:j];
                    if([finish canConnectWithCard:tail])
                    {
                        _noOperation = NO;
                        [self.cardBatch reorderChild:tail z:GameNodeZOrder_Top];
                        [finish addCard:tail Animated:YES DelayTime:0 Duration:DELIVER_DURATION];
                        [stack.cards removeObject:tail];
                        
                        StepInfo* step = [StepInfo info];
                        step.pickIndex = stack.index;
                        step.dropIndex = finish.index;
                        step.cardTag = tail.tag;
                        step.stepID = self.currentStep.stepID;
                        step.type = StepType_Transfer;
                        [self.steps addObject:step];
                        
                        _tempScore += [self computeScoreByPickIndex:stack.index DropIndex2:finish.index];
                        
                        if(self.currentStep.pickIndex < MAX_STATIC_STACK)
                        {
                            StaticStack* pickStack = [self getStaticStackByIndex:self.currentStep.pickIndex];
                            if([pickStack checkOpenNewCard])
                            {
                                Card* card = [pickStack.cards lastObject];
                                StepInfo* step = [StepInfo info];
                                step.pickIndex = pickStack.index;
                                step.dropIndex = pickStack.index;
                                step.cardTag = card.tag;
                                step.stepID = self.currentStep.stepID;
                                step.type = StepType_Flip;
                                [self.steps addObject:step];
                                
                                _tempScore += [self computeScoreByPickIndex:pickStack.index DropIndex2:pickStack.index];
                            }
                        }
                        return;
                    }
                }
                
                
            }
        }
        
        
        
        PopStack* stack = [self getPopStackByIndex:0];
        Card* tail = [stack.cards lastObject];
        if(tail)
        {
            for (int j = 0; j < MAX_FINISH_STACK; j++)
            {
                FinishStack* finish = [self getFinishStackByIndex:j];
                if([finish canConnectWithCard:tail])
                {
                    _noOperation = NO;
                    [self.cardBatch reorderChild:tail z:GameNodeZOrder_Top];
                    [finish addCard:tail Animated:YES DelayTime:0 Duration:DELIVER_DURATION];
                    [stack.cards removeObject:tail];
                    
                    StepInfo* step = [StepInfo info];
                    step.pickIndex = stack.index;
                    step.dropIndex = finish.index;
                    step.cardTag = tail.tag;
                    step.stepID = self.currentStep.stepID;
                    step.type = StepType_Transfer;
                    [self.steps addObject:step];
                    
                    _tempScore += [self computeScoreByPickIndex:stack.index DropIndex2:finish.index];
                    
                    if(self.currentStep.pickIndex < MAX_STATIC_STACK)
                    {
                        StaticStack* pickStack = [self getStaticStackByIndex:self.currentStep.pickIndex];
                        if([pickStack checkOpenNewCard])
                        {
                            Card* card = [pickStack.cards lastObject];
                            StepInfo* step = [StepInfo info];
                            step.pickIndex = pickStack.index;
                            step.dropIndex = pickStack.index;
                            step.cardTag = card.tag;
                            step.stepID = self.currentStep.stepID;
                            step.type = StepType_Flip;
                            [self.steps addObject:step];
                            
                            _tempScore += [self computeScoreByPickIndex:pickStack.index DropIndex2:pickStack.index];
                        }
                    }
                    return;
                }
            }
        }
        
    }
    else
    {
        return;
    }
   
}

-(BOOL)canAutoFinish
{
    PopStack* pop = [self getPopStackByIndex:0];
    if(pop.cards.count > 1)
    {
        return NO;
    }
    DeliverStack* deliver = [self getDeliverStackByIndex:0];
    if(deliver.cards.count > 0)
    {
        return NO;
    }
    
    for (int i = 0; i < MAX_CARDS; i++)
    {
        Card* card = [self getCardByTag:i];
        if(card.isCovered)
        {
            return NO;
        }
        
    }
    return YES;
}

-(void)complete
{
    self.state = GameState_Pause;
    [[HistoryManager sharedHistoryManager].history removeAllObjects];
    [[HistoryManager sharedHistoryManager] save];
    [PuzzleRecord sharedPuzzleRecord].hasRecord = NO;
    [[PuzzleRecord sharedPuzzleRecord] save];
   
    [[AudioManager sharedAudioManager] playEffect:@"complete.m4v"];
    ResultLayer* layer = [ResultLayer layerWithMode:_mode];
    [self addChild:layer];
}

-(float)computeScoreByPickIndex:(int)pickIndex DropIndex2:(int)dropIndex
{
    if(pickIndex >= STATIC_START && pickIndex <= STATIC_END)
    {
        if(dropIndex == pickIndex)
            return SCORE_FLIP * self.factor;
        else if (dropIndex >= FINISH_START && dropIndex <= FINISH_END)
            return SCORE_FROM_STATIC_TO_FINISH * self.factor;
    }
    else if(pickIndex >= FINISH_START && pickIndex <= FINISH_END)
    {
        if(dropIndex >= STATIC_START && dropIndex <= STATIC_END)
            return SCORE_FROM_FINISH_TO_STATIC * self.factor;
        else if (dropIndex >= FINISH_START && dropIndex <= FINISH_END)
            return 0;
    }
    else if(pickIndex == DELIVER_INDEX)
    {
        
    }
    else if(pickIndex == POP_INDEX)
    {
        if(dropIndex >= STATIC_START && dropIndex <= STATIC_END)
            return SCORE_FROM_POP_TO_STATIC * self.factor;
        else if (dropIndex >= FINISH_START && dropIndex <= FINISH_END)
            return SCORE_FROM_POP_TO_FINISH * self.factor;
    }
    
    return 0;
}

@end
