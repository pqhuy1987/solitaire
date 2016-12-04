

#import <Foundation/Foundation.h>


@interface BZNewsManager : NSObject <UIWebViewDelegate> {
    UIViewController *rootViewController_;
    NSString *appID_;
    BOOL loaded_;
    BOOL visible_;
}
@property (nonatomic,readwrite,retain) UIViewController *rootViewController;
@property (nonatomic,readwrite,copy) NSString *appID;
@property (nonatomic,readonly,getter=isLoaded) BOOL loaded;
@property (nonatomic,readonly,getter=isVisible) BOOL visible;

+ (BZNewsManager *) shared;

- (void)loadNews;
- (void)showNews;
@end
