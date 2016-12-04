

#import "NibLayer.h"

@implementation NibLayer

@synthesize m_animView;

+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	[scene addChild: [[[self alloc] initWithNib] autorelease]];
	return scene;
}

-(id)initWithNib{
    return nil;
}

-(id)initWithNibNamed:(NSString*)name{
	if( (self=[super init]))
    {
        NSString* xibFile = nil;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            xibFile = [name stringByAppendingString:@"_iPad"];
            [[NSBundle mainBundle] pathForResource:xibFile ofType:@"nib"];
        }
        else
        {
            xibFile = [name stringByAppendingString:@""];
            [[NSBundle mainBundle] pathForResource:xibFile ofType:@"nib"];
        }
        
        
        [[NSBundle mainBundle]loadNibNamed:xibFile owner:self options:NULL];
        [[[CCDirector sharedDirector] view] insertSubview:m_animView atIndex:0];
        [m_animView prepare];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
        }
        else
        {
            CGSize screen = [[CCDirector sharedDirector] winSize];
            self.position = CGPointMake(0, (screen.height - 480) * 0.5);
            m_animView.frame = CGRectMake(
                                       self.m_animView.frame.origin.x,
                                       self.m_animView.frame.origin.y + (screen.height - 480) * 0.5,
                                       self.m_animView.frame.size.width,
                                       self.m_animView.frame.size.height
                                       );
        }
	}
	return self;
}

-(void)dealloc{
    [m_animView release];
    [m_animView removeFromSuperview];
    [super dealloc];
}

-(void)onEnter{
    [m_animView openView];
    m_animView.userInteractionEnabled=false;
    [super onEnter];
}

-(void)onEnterTransitionDidFinish{
    m_animView.userInteractionEnabled=true;
    [super onEnterTransitionDidFinish];
}

-(void)onExit{
    [super onExit];
}

@end
