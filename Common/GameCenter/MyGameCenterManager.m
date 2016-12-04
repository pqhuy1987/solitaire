//
//  MyGameCenterManager.m
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-25.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "MyGameCenterManager.h"

@implementation MyGameCenterManager

@synthesize rootViewController = _rootViewController;
@synthesize gameCenterManager = _gameCenterManager;
@synthesize currentLeaderBoard = _currentLeaderBoard;

SYNTHESIZE_SINGLETON_FOR_CLASS(MyGameCenterManager)

- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
	UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate: NULL
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: NULL] autorelease];
	[alert show];
}

-(id)init
{
    if(self = [super init])
    {
        _isGameCenterAvailable = [GameCenterManager isGameCenterAvailable];
        if(_isGameCenterAvailable)
        {
            self.gameCenterManager= [[[GameCenterManager alloc] init] autorelease];
            [self.gameCenterManager setDelegate: self];
        }
        else
        {
            [self showAlertWithTitle: @"Game Center Support Required!"
                             message: @"The current device does not support Game Center, which this sample requires."];
        }
    }
    return self;
}

-(void)dealloc
{
    self.gameCenterManager = nil;
    self.rootViewController = nil;
    self.currentLeaderBoard = nil;
    [super dealloc];
}

#pragma mark AuthenticateLocalUser

// 验证结束警告框回调
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // 如果不是取消，怎重试验证
    if(buttonIndex != [alertView cancelButtonIndex])
    {
        [self.gameCenterManager authenticateLocalUser];
    }
}

// GameCenter验证回调
- (void) processGameCenterAuth: (NSError*) error
{
    // 验证成功
	if(error == NULL)
	{
        NSLog(@"GameCenter AuthenticateLocalUser Succeed！");
		//[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
	}
    // 验证失败
	else
	{
        NSLog(@"GameCenter AuthenticateLocalUser Failed！");
        
        // 用户取消或者GameCenter禁用
        if([[error domain] isEqualToString:GKErrorDomain] && [error code] == GKErrorCancelled)
        {
            NSLog(@"Reason: GameCenter is Disabled or User Canceled ！");
            [self showAlertWithTitle: @"Game Center Account Required!"
                             message:[NSString stringWithFormat: @"Please sign in."]];
           
        }
        // 其他原因
        else
        {
            NSLog(@"Reason: %@", [error localizedDescription]);
            
            UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: @"Game Center Account Required"
                                                            message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]
                                                           delegate: self
                                                  cancelButtonTitle: @"Cancel"
                                                  otherButtonTitles: @"Try again", NULL] autorelease];
            [alert show];
        }
	}
}

// 验证用户
-(void)authenticateLocalUser;
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Authenticating");
    [self.gameCenterManager authenticateLocalUser];
}


#pragma mark LeaderBorder

// 上传分数
-(void)submitScore: (int64_t) score forCategory: (NSString*) category
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Report %lld Score for Category %@", score, category);
    // 记录上传的ID
    self.currentLeaderBoard = category;
    [self.gameCenterManager reportScore: score forCategory: self.currentLeaderBoard];
}

// 上传分数回调
- (void) scoreReported: (NSError*) error;
{
    // 上传成功
	if(error == NULL)
	{
        NSLog(@"GameCenter Report Score Succeed！");
        
//		[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
//		[self showAlertWithTitle: @"High Score Reported!"
//						 message: [NSString stringWithFormat: @"%@", [error localizedDescription]]];
	}
	else
	{
        NSLog(@"GameCenter Report Score Failed！");
        NSLog(@"Reason: %@", [error localizedDescription]);
        
//		[self showAlertWithTitle: @"Score Report Failed!"
//						 message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

// 下载最高分数的回调
- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error;
{
    // 下载成功
	if(error == NULL)
	{
//		int64_t personalBest= leaderBoard.localPlayerScore.value;
//		self.personalBestScoreDescription= @"Your Best:";
//		self.personalBestScoreString= [NSString stringWithFormat: @"%ld", personalBest];
//		if([leaderBoard.scores count] >0)
//		{
//			self.leaderboardHighScoreDescription=  @"-";
//			self.leaderboardHighScoreString=  @"";
//			GKScore* allTime= [leaderBoard.scores objectAtIndex: 0];
//			self.cachedHighestScore= allTime.formattedValue;
//			[gameCenterManager mapPlayerIDtoPlayer: allTime.playerID];
//		}
	}
	else
	{
//		self.personalBestScoreDescription= @"GameCenter Scores Unavailable";
//		self.personalBestScoreString=  @"-";
//		self.leaderboardHighScoreDescription= @"GameCenter Scores Unavailable";
//		self.leaderboardHighScoreDescription=  @"-";
//		[self showAlertWithTitle: @"Score Reload Failed!"
//						 message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

- (void) mappedPlayerIDToPlayer: (GKPlayer*) player error: (NSError*) error
{
	if((error == NULL) && (player != NULL))
	{
//      self.leaderboardHighScoreDescription= [NSString stringWithFormat: @"%@ got:", player.alias];
//		
//		if(self.cachedHighestScore != NULL)
//		{
//			self.leaderboardHighScoreString= self.cachedHighestScore;
//		}
//		else
//		{
//			self.leaderboardHighScoreString= @"-";
//		}
	}
	else
	{
//      self.leaderboardHighScoreDescription= @"GameCenter Scores Unavailable";
//		self.leaderboardHighScoreDescription=  @"-";
	}
}

// 展示Leaderboard
-(void)showLeaderboardForCategory:(NSString*)category
{
    if(_isGameCenterAvailable == NO)
        return;
    
    if([GKLocalPlayer localPlayer].authenticated == NO)
    {
        [self.gameCenterManager authenticateLocalUser];
    }
    else
    {
        NSLog(@"GameCenter Show Leaderboard for Category %@", category);
        
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        if (leaderboardController != NULL)
        {
            leaderboardController.category = category;
            leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
            leaderboardController.leaderboardDelegate = self;
            [self.rootViewController presentModalViewController: leaderboardController animated: YES];
        }
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self.rootViewController dismissModalViewControllerAnimated: YES];
	[viewController release];
}

#pragma mark Achievement

- (void) checkAchievements
{
    //	NSString* identifier= NULL;
    //	double percentComplete= 0;
    //	switch(self.currentScore)
    //	{
    //		case 1:
    //		{
    //			identifier= kAchievementGotOneTap;
    //			percentComplete= 100.0;
    //			break;
    //		}
    //		case 10:
    //		{
    //			identifier= kAchievementHidden20Taps;
    //			percentComplete= 50.0;
    //			break;
    //		}
    //		case 20:
    //		{
    //			identifier= kAchievementHidden20Taps;
    //			percentComplete= 100.0;
    //			break;
    //		}
    //		case 50:
    //		{
    //			identifier= kAchievementBigOneHundred;
    //			percentComplete= 50.0;
    //			break;
    //		}
    //		case 75:
    //		{
    //			identifier= kAchievementBigOneHundred;
    //			percentComplete= 75.0;
    //			break;
    //		}
    //		case 100:
    //		{
    //			identifier= kAchievementBigOneHundred;
    //			percentComplete= 100.0;
    //			break;
    //		}
    //			
    //	}
    //	if(identifier!= NULL)
    //	{
    //		[self.gameCenterManager submitAchievement: identifier percentComplete: percentComplete];
    //	}
}

// 上传成就
- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Submit Achievement %@ for Percent %f", identifier, percentComplete);
    [self.gameCenterManager submitAchievement:identifier percentComplete:percentComplete];
}

- (void) resetAchievements
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Reset Achievement");
	[self.gameCenterManager resetAchievements];
}

- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error;
{
	if((error == NULL) && (ach != NULL))
	{
        NSLog(@"GameCenter Submit Achievement Succeed！");
		if(ach.percentComplete == 100.0)
		{
            NSLog(@"GameCenter Achievement %@ Earned",NSLocalizedString(ach.identifier, NULL));
//			[self showAlertWithTitle: @"Achievement Earned!"
//                             message: [NSString stringWithFormat: @"Great job!  You earned an achievement: \"%@\"", NSLocalizedString(ach.identifier, NULL)]];
		}
		else
		{
			if(ach.percentComplete > 0)
			{
                NSLog(@"GameCenter Achievement %@ got %.0f\%%", NSLocalizedString(ach.identifier, NULL), ach.percentComplete);
//				[self showAlertWithTitle: @"Achievement Progress!"
//                                 message: [NSString stringWithFormat: @"Great job!  You're %.0f\%% of the way to: \"%@\"",ach.percentComplete, NSLocalizedString(ach.identifier, NULL)]];
			}
		}
	}
	else
	{
        NSLog(@"GameCenter Submit Achievement Failed！");
        NSLog(@"Reason: %@", [error localizedDescription]);
        
//		[self showAlertWithTitle: @"Achievement Submission Failed!"
//                         message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

- (void) achievementResetResult: (NSError*) error;
{
    NSLog(@"GameCenter Reset Achievement Succeed！");
	if(error != NULL)
	{
        NSLog(@"GameCenter Reset Achievement Failed！");
		[self showAlertWithTitle: @"Achievement Reset Failed!"
                         message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

- (void) showAchievements
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Show Achievement!");
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	if (achievements != NULL)
	{
		achievements.achievementDelegate = self;
		[self.rootViewController presentModalViewController: achievements animated: YES];
	}
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    [self.rootViewController dismissModalViewControllerAnimated: YES];
	[viewController release];
}

@end
