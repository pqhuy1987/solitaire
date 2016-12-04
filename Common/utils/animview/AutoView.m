

#import "AutoView.h"
#import "cocos2d.h"

@implementation AutoView


-(void)autoOpen{
    /*[self prepare];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView prepare];
    }*/
    [self openView];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView openView];
    }
}/*

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    [self prepare];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView prepare];
    }
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self openView];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView openView];
    }
}*/
/*
-(void)willMoveToWindow:(UIWindow *)newWindow{
    [self prepare];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView prepare];
    }
}

-(void)didMoveToWindow{
    [self openView];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView openView];
    }
}*/

-(void)prepare{
    [super prepare];
    
    //self.alpha=0;
}

-(void)openView{
    [super openView];
/*
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha=1;
	[UIView commitAnimations];*/
}

-(void)closeView{
    [super closeView];
    /*
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha=0;
	[UIView commitAnimations];
    
    for (AnimView * animView in self.subviews) {
        if([animView isKindOfClass:[AnimView class]])[animView closeView];
    }*/
}

@end
