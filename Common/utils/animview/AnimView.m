
#import "AnimView.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@implementation AnimView

@synthesize target;
@synthesize openedSEL;
@synthesize closedSEL;
@synthesize m_openSound,m_closeSound;
@synthesize m_openedSound,m_closedSound;

-(void)dealloc{
    [m_openSound release];
    [m_closeSound release];
    [m_openedSound release];
    [m_closedSound release];
    [super dealloc];
}

-(void)autoOpen{
    
}

-(void)prepare{
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView prepare];
    }
}

-(void)openViewDelay:(CGFloat)delay{
    [self performSelector:@selector(openView) withObject:nil afterDelay:delay];
}

-(void)openView{
    if(m_openSound){
        [[SimpleAudioEngine sharedEngine] playEffect:m_openSound];
    }
    [self performSelector:@selector(onOpened) withObject:nil afterDelay:0.3];
}

-(void)onOpened{
    if(m_openedSound){
        [[SimpleAudioEngine sharedEngine] playEffect:m_openedSound];
    }
    if(target&&openedSEL)[target performSelector:openedSEL];
}

-(void)closeView{
    if(m_closeSound){
        [[SimpleAudioEngine sharedEngine] playEffect:m_closeSound];
    }
    
    [self performSelector:@selector(onClosed) withObject:nil afterDelay:0.3];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView closeView];
    }
}

-(void)onClosed{
    if(m_closedSound){
        [[SimpleAudioEngine sharedEngine] playEffect:m_closedSound];
    }
    if(target&&closedSEL)[target performSelector:closedSEL];
}

-(CGFloat)getScreenWidth{
    return [CCDirector sharedDirector].winSize.width;
}

-(CGFloat)getScreenHeight{
    return [CCDirector sharedDirector].winSize.height;
}

@end
