

#import "BZNewsManager.h"
#import "cocos2d.h"
@interface BZNewsManager () {
    UIView *bgView_;
    UIWebView *newsView_;
    NSString *newsID_;
    CGSize newsSize_;
    BOOL loadCompleted_;
}
- (void)unloadNews;
- (CGRect)newsFrameWithSize:(CGSize)aSize;
- (BOOL)isNewsAPIAvailable;
- (void)createNewsView;
- (void)layoutNews;
- (NSString *)deviceType;
- (NSString *)currentLanguage;
- (NSString *)newsResponse;
- (void)clickNews;
@end

@implementation BZNewsManager
@synthesize rootViewController=rootViewController_;
@synthesize appID=appID_;
@synthesize loaded=loaded_;
@synthesize visible=visible_;

static BZNewsManager *sharedInstance = nil;

+ (BZNewsManager *) shared
{
    if (sharedInstance == nil)
        sharedInstance = [[BZNewsManager alloc] init] ;
    return sharedInstance;
    
}

- (id)init
{
    if((self = [super init])) {
        Class AppDelegate = NSClassFromString(@"AppDelegate");
        Class AppController = NSClassFromString(@"AppController");
        if ((AppDelegate != nil) && [AppDelegate instancesRespondToSelector:NSSelectorFromString(@"viewController")]) {
            self.rootViewController = [[[UIApplication sharedApplication] delegate] performSelector:NSSelectorFromString(@"viewController")];//UIKit
        } else if ((AppController != nil) && [AppController instancesRespondToSelector:NSSelectorFromString(@"navController")]) {
            self.rootViewController = [[[UIApplication sharedApplication] delegate] performSelector:NSSelectorFromString(@"navController")];//Cocos2d
        }
        if ((AppController != nil) && [AppController instancesRespondToSelector:NSSelectorFromString(@"appID")]) {
            self.appID = [[[UIApplication sharedApplication] delegate] performSelector:NSSelectorFromString(@"appID")];
        }
        
        loaded_ = NO;
        visible_ = NO;
        loadCompleted_ = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutNews) name:@"willAnimateRotationToInterfaceOrientation" object:nil];//旋转时调用layoutNews
    }
    return self;
}

- (void)dealloc
{
    [sharedInstance release];
    sharedInstance = nil;
    
    [rootViewController_ release];
    [appID_ release];
    [super dealloc];
}

- (void)loadNews
{
    NSAssert(rootViewController_ != nil, @"Invalid RootViewController for News");
    if ([self isNewsAPIAvailable]) {
        [self createNewsView];
    } else {
        loaded_ = YES;
        [self unloadNews];
    }
}

- (void)showNews
{
    if (loaded_ && !visible_ && loadCompleted_) {
        CCLOG(@"[BZNewsManager] show News View");
        visible_ = YES;
        [self layoutNews];
    }
}

- (void)unloadNews
{
    if (newsView_ != nil) {
        CCLOG(@"[BZNewsManager] remove News View");
        [newsView_ removeFromSuperview];
        newsView_.delegate = nil;
        [newsView_ release];
        newsView_ = nil;
    }
    if (newsID_ != nil) {
        [newsID_ release];
        newsID_ = nil;
    }
    if (bgView_ != nil) {
        [bgView_ removeFromSuperview];
        [bgView_ release];
        bgView_ = nil;
    }
    visible_ = NO;
}

- (CGRect)newsFrameWithSize:(CGSize)aSize
{
    NSAssert(rootViewController_ != nil, @"Invalid RootViewController for News");
    CGRect rootViewFrame = rootViewController_.view.bounds;
    CGRect frame = CGRectZero;
    frame.size = aSize;
    frame.origin.x = (rootViewFrame.size.width - frame.size.width) * 0.5f;
    frame.origin.y = (rootViewFrame.size.height - frame.size.height) * 0.5f;
    
    return frame;
}

- (BOOL)isNewsAPIAvailable
{
    // Check for presence of UIWebView class.
    BOOL localPlayerClassAvailable = (NSClassFromString(@"UIWebView")) != nil;
    
    // The device must be running iOS 2.0 or later.
    NSString *reqSysVer = @"2.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    if (localPlayerClassAvailable && osVersionSupported) {
        CCLOG(@"[BZNewsManager] News API is available");
    } else {
        CCLOG(@"[BZNewsManager] News API is unavailable");
    }
    
    return (localPlayerClassAvailable && osVersionSupported);
}

- (void)createNewsView
{
    NSString *returnString = [self newsResponse];
    if ([returnString isEqualToString:@"0"]) {
        CCLOG(@"[BZNewsManager] no pull url");
        loaded_ = YES;
        [self unloadNews];
    } else {
        CCLOG(@"[BZNewsManager] create News View");
        NSAssert(rootViewController_ != nil, @"Invalid RootViewController for News");
        //弹窗广告背景的黑幕
        bgView_ = [[UIView alloc] initWithFrame:rootViewController_.view.bounds];
        bgView_.hidden = !visible_;
        bgView_.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];
        [rootViewController_.view addSubview:bgView_];
        
        //分割弹窗广告请求收到的字符串
        NSArray *returnStringArray = [returnString componentsSeparatedByString:@"^"];
        newsID_ = [[returnStringArray objectAtIndex:0] copy];//弹窗广告推荐的APPID
        NSURL *loadRequestURL = [NSURL URLWithString:[returnStringArray objectAtIndex:1]];//弹窗广告加载的图片地址
        newsSize_ = CGSizeMake([((NSString *)[returnStringArray objectAtIndex:2]) floatValue], [((NSString *)[returnStringArray objectAtIndex:3]) floatValue]);//弹窗广告的窗口大小
        
        newsView_ = [[UIWebView alloc] initWithFrame:[self newsFrameWithSize:newsSize_]];
        newsView_.delegate = self;
        newsView_.hidden = !visible_;
        //设置背景透明
        newsView_.backgroundColor = [UIColor clearColor];
        newsView_.opaque = NO;
        
        [bgView_ addSubview:newsView_];
        
        [newsView_ loadRequest:[NSURLRequest requestWithURL:loadRequestURL]];
    }
}

- (void)layoutNews
{
    if (newsView_ != nil) {
        [bgView_.superview bringSubviewToFront:bgView_];
        
        [UIView animateWithDuration:0.25f animations:^{
            newsView_.frame = [self newsFrameWithSize:newsSize_];
            newsView_.hidden = !visible_;
            bgView_.frame = rootViewController_.view.bounds;
            bgView_.hidden = !visible_;
        }];
    }
}

- (NSString *)deviceType
{
    NSString *type = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)?@"iPhone":@"iPad";
    CCLOG(@"[BZNewsManager] deviceType: %@", type);
    return type;
}

- (NSString *)currentLanguage
{
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    CCLOG(@"[BZNewsManager] currentLanguage: %@", [languages objectAtIndex:0]);
    return [languages objectAtIndex:0];
}

- (NSString *)newsResponse
{
    // 弹窗广告的连接请求
    NSAssert(appID_ != nil, @"Invalid Apple ID for News");
    NSString *requestString = [NSString stringWithFormat:@"http://games.fino-soft.com/news/test.php?appleid=%@&devicetype=%@&language=%@", appID_, [self deviceType], [self currentLanguage]];
    NSURL *requestURL = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:2.f];//忽略缓存, 超时2秒则请求失败
    // 弹窗广告请求的返回值
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    CCLOG(@"[BZNewsManager] News request URL: [%@], timeoutInterval: %fs, return: \"%@\"", requestString, [request timeoutInterval], responseString);
    // 根据返回值确定弹窗策略
    NSString *returnString = (responseString != nil)?[responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]:@"0";//如果收到的返回值为空, 则返回字符串"0", 否则返回去掉空白的返回值
    // 如果返回字符串为空白, 则返回字符串"0"
    if ([returnString isEqualToString:@""]) returnString = @"0";
    
    return returnString;
}

- (void)clickNews
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8",newsID_]]];
}

#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    CCLOG(@"[BZNewsManager] didFailLoadWithError:%@", [error localizedDescription]);
    loaded_ = YES;
    [self unloadNews];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    CCLOG(@"[BZNewsManager] create link button");
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    linkButton.frame = newsView_.bounds;
    [linkButton addTarget:self action:@selector(clickNews) forControlEvents:UIControlEventTouchUpInside];
    [newsView_ addSubview:linkButton];
    
    CCLOG(@"[BZNewsManager] create close button");
    CGRect newsViewFrame = newsView_.bounds;
    CGRect frame = CGRectZero;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        frame.size = CGSizeMake(32.f, 32.f);
    } else {
        frame.size = CGSizeMake(64.f, 64.f);
    }
    frame.origin.x = newsViewFrame.size.width - frame.size.width;
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = frame;
    [closeButton addTarget:self action:@selector(unloadNews) forControlEvents:UIControlEventTouchUpInside];
    [newsView_ addSubview:closeButton];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CCLOG(@"[BZNewsManager] News load completed");
    loaded_ = YES;
    loadCompleted_ = YES;
}
@end
