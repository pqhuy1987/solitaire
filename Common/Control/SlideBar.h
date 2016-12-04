//
//  SlideBar.h
//  Fruit Connections Cut
//
//  Created by 张朴军 on 13-4-7.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "ProgressBar.h"

@interface SlideBar : ProgressBar <CCTouchOneByOneDelegate>
{
    
}

-(void)setHandlerPriority:(NSInteger)newPriority;

@end
