
#import <UIKit/UIKit.h>

@interface AnimView : UIView{
    id target;
    SEL openedSEL;
    SEL closedSEL;
    
    NSString * m_openSound;
    NSString * m_closeSound;
    NSString * m_openedSound;
    NSString * m_closedSound;
}

@property (assign) id target;
@property (assign) SEL openedSEL;
@property (assign) SEL closedSEL;
@property(nonatomic,retain)NSString * m_openSound;
@property(nonatomic,retain)NSString * m_closeSound;
@property(nonatomic,retain)NSString * m_openedSound;
@property(nonatomic,retain)NSString * m_closedSound;

-(void)autoOpen;
-(void)prepare;
-(void)openViewDelay:(CGFloat)delay;
-(void)openView;
-(void)closeView;

@end
