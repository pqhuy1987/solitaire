//
//  HelpScene.h
//  SpiderSolitaire
//
//  Created by 张 朴军 on 13-5-6.
//  Copyright 2013年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NibLayer.h"
@interface HelpScene : NibLayer <UIScrollViewDelegate>
{
    
    IBOutlet UIButton*      m_button;
}

+(CCScene *) scene;

@end
