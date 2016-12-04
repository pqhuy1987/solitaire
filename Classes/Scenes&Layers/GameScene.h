//
//  GameScene.h
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-7.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LevelManager.h"
#import "Card.h"
#import "StepInfo.h"
#import "FinishStack.h"
#import "PuzzleRecord.h"
#import "TipManager.h"
#import "AdjustLayer.h"
#import "CCMenuItemSpriteWithLabel.h"
typedef enum
{
    GameNodeTag_Card = 0,
    GameNodeTag_StaticStack = 200,
    GameNodeTag_DeliverStack = 300,
    GameNodeTag_FloatStack = 400,
    GameNodeTag_FinishStack = 500,
}GameNodeTag;

typedef enum
{
    StepKind_Transfer = 0,
    StepKind_Transfer_Flip,
    StepKind_Deliver,
    StepKind_Pop,
    StepKind_Swap,
}StepKind;

typedef enum
{
    GameNodeZOrder_Card = 0,
    GameNodeZOrder_StaticStack = 100,
    GameNodeZOrder_DeliverStack = 1000,
    GameNodeZOrder_FloatStack = 2000,
    GameNodeZOrder_FinishStack = 1200,
    GameNodeZOrder_Top = 3000,
}GameNodeZOrder;

typedef enum
{
    GameState_Pause = 0,
    GameState_Run,
}GameStates;
#define MAX_CARDS   52
#define MAX_START_DECK  4

#define MAX_STATIC_STACK 7
#define MAX_CAPACITY 52
#define MAX_DELIVER_STACK  1
#define MAX_POP_STACK   1
#define MAX_FINISH_STACK  4

#define STATIC_START 0
#define STATIC_END 6
#define FINISH_START 7
#define FINISH_END 10

#define POP_INDEX 12
#define DELIVER_INDEX 11

#define SCORE_FROM_STATIC_TO_FINISH 15
#define SCORE_FROM_POP_TO_FINISH 10
#define SCORE_FROM_POP_TO_STATIC 5
#define SCORE_FLIP 5
#define SCORE_FROM_FINISH_TO_STATIC -15
#define SCORE_LOOP_ONE -100
#define SCORE_LOOP_Three -20
#define SCORE_UNDO 0
#define SCORE_SWAP -5

#define HINT_DURATION   0.3f

@interface GameScene : AdjustLayer <CCTouchOneByOneDelegate>
{
    CCNode*  _cardBatch;
    CCArray*            _stacks;
    GameModes           _mode;
    StepInfo*           _currentStep;
    NSMutableArray*     _steps;
    BOOL                _ready;
    BOOL                _arranged;
    BOOL                _noOperation;
    PuzzleRecord*       _record;
    BOOL                _draged;
    
    TipManager*         _tipManager;
    BOOL                _hasSearched;
    
    CCSprite*           _pickHint;
    CCSprite*           _dropHint;
    
    CCLabelTTF*         _scoreLabel;
    float               _score;
    CCLabelTTF*         _timeLabel;
    float               _time;
    float               _move;
   
    GameStates          _state;
    
    CCMenuItemSprite*   _btSetting;
    CCMenuItemSpriteWithLabel*   _autoFinish;
    BOOL                         _auto;
    BOOL                         _complete;
    
    float               _tempScore;
    
    CCLabelTTF*                 _factorLabel;
    int                         _factor;
    float                       _factorTimer;
    
    CCSprite*           _bg;
    CGPoint             _posTap;
}

@property (nonatomic, retain)CCNode* cardBatch;
@property (nonatomic, retain)CCArray*           stacks;
@property (nonatomic, retain)StepInfo*          currentStep;
@property (nonatomic, retain)NSMutableArray*    steps;
@property (nonatomic, retain)PuzzleRecord*      record;
@property (nonatomic, retain)TipManager*        tipManager;
@property (nonatomic, retain)CCSprite*          pickHint;
@property (nonatomic, retain)CCSprite*          dropHint;

@property (nonatomic, retain)CCLabelTTF*        factorLabel;
@property (nonatomic, assign)int                factor;
@property (nonatomic, retain)CCLabelTTF*      scoreLabel;
@property (nonatomic, assign)float              score;
@property (nonatomic, retain)CCLabelTTF*      timeLabel;
@property (nonatomic, assign)float              time;
@property (nonatomic, retain)CCLabelTTF*        moveLabel;
@property (nonatomic, assign)float              move;


@property (nonatomic, assign)GameStates         state;
@property (nonatomic, assign)GameModes          mode;

@property (nonatomic, assign)int                backgroundID;
@property (nonatomic, assign)int                cardID;
@property (nonatomic, assign)BOOL               isResumed;


+(CCScene *) sceneWithMode:(GameModes)mode;
+(GameScene *)sharedGameScene;

-(FinishStack*)emptyFinishStack;
-(Card*)getCardByTag:(NSInteger)tag;

@end
