

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AnimView.h"

@interface NibLayer : CCLayer {
    AnimView * m_animView;
}

@property (retain,nonatomic)IBOutlet AnimView * m_animView;

+(CCScene *) scene;

-(id)initWithNib;

-(id)initWithNibNamed:(NSString*)name;

@end
