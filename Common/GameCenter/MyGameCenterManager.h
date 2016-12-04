//
//  MyGameCenterManager.h
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-25.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "CommonDefine.h"
#import "GameCenterManager.h"

@class GameCenterManager;

@interface MyGameCenterManager : NSObject <UIActionSheetDelegate,GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate>
{
    GameCenterManager* _gameCenterManager;
    UIViewController*  _rootViewController;
    BOOL               _isGameCenterAvailable;
    NSString*          _currentLeaderBoard;
}

DECLARE_SINGLETON_FOR_CLASS(MyGameCenterManager)
@property (nonatomic, retain)UIViewController* rootViewController;
@property (nonatomic, retain) GameCenterManager* gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;

-(void)authenticateLocalUser;

-(void)submitScore: (int64_t) score forCategory: (NSString*) category;
-(void)showLeaderboardForCategory:(NSString*)catrgory;


- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete;
- (void) resetAchievements;
-(void)showAchievements;

@end
