//
//  IdentifieManager.m
//  minesweeper
//
//  Created by 张朴军 on 12-12-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "IdentifieManager.h"

#import "cocos2d.h"
@implementation IdentifieManager

@synthesize BundleName_iPhone   = BundleName_iPhone_;
@synthesize AppName_iPhone      = AppName_iPhone_;
@synthesize App_ID_iPhone       = App_ID_iPhone_;
@synthesize AdmobBanner_ID_iPhone     = AdmobBanner_ID_iPhone_;
@synthesize AdmobInterstitial_ID_iPhone = AdmobInterstitial_ID_iPhone_;
@synthesize GameCenter_Categories_iPhone = GameCenter_Categories_iPhone_;

@synthesize BundleName_iPad     = BundleName_iPad_;
@synthesize AppName_iPad        = AppName_iPad_;
@synthesize App_ID_iPad         = App_ID_iPad_;
@synthesize AdmobBanner_ID_iPad       = AdmobBanner_ID_iPad_;
@synthesize AdmobInterstitial_ID_iPad = AdmobInterstitial_ID_iPad_;
@synthesize GameCenter_Categories_iPad  = GameCenter_Categories_iPad_;

SYNTHESIZE_SINGLETON_FOR_CLASS(IdentifieManager)

-(id)init
{
    if(self = [super init])
    {
        AppName_iPhone_     = @"Solitaire";
        BundleName_iPhone_  = @"solitaire6";
        App_ID_iPhone_      = @"1108258984";
        AdmobBanner_ID_iPhone_    = @"ca-app-pub-3464821182263759/9968043626";
        AdmobInterstitial_ID_iPhone_ = @"ca-app-pub-3464821182263759/2444776827";
        GameCenter_Categories_iPhone_ = [[NSArray alloc] initWithObjects:@"dsolitaire6.draw_one", @"dsolitaire6.draw_three", nil];;
        Products_iPhone_    = [[NSArray alloc] initWithObjects: nil];
        
        AppName_iPad_     = @"Solitaire";
        BundleName_iPad_  = @"solitaire6";
        App_ID_iPad_      = @"1108258984";
        AdmobBanner_ID_iPad_    = @"ca-app-pub-3464821182263759/9968043626";
        AdmobInterstitial_ID_iPad_ = @"ca-app-pub-3464821182263759/2444776827";
        GameCenter_Categories_iPad_ = [[NSArray alloc] initWithObjects:@"dsolitaire6.draw_one", @"dsolitaire6.draw_three", nil];;
        Products_iPad_    = [[NSArray alloc] initWithObjects: nil];
        
    }
    return self;
}

-(NSString *)AppName
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return AppName_iPad_;
    }
    else
    {
        return AppName_iPhone_;
    }
}

-(NSString*)App_ID
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return App_ID_iPad_;
    }
    else
    {
        return App_ID_iPhone_;
    }
}
-(NSString*)AdmobBanner_ID
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return AdmobBanner_ID_iPad_;
    }
    else
    {
        return AdmobBanner_ID_iPhone_;
    }
}
-(NSString *)AdmobInterstitial_ID
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return AdmobInterstitial_ID_iPad_;
    }
    else
    {
        return AdmobInterstitial_ID_iPhone_;
    }
}
-(NSString*)GameCenter_IDByCategory:(GameCenterCategories) Category
{
    NSString* Identifie = nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(Category >= [GameCenter_Categories_iPhone_ count])
            return nil;
        NSString* CategoryName = (NSString*)[GameCenter_Categories_iPad_ objectAtIndex:Category];
        Identifie = CategoryName;
    }
    else
    {
        if(Category >= [GameCenter_Categories_iPhone_ count])
            return nil;
        NSString* CategoryName = (NSString*)[GameCenter_Categories_iPhone_ objectAtIndex:Category];
        Identifie = CategoryName;
    }
    return Identifie;
}

-(NSString*)GameCenter_ID
{
    NSString* Identifie = nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Identifie = @"";
    }
    else
    {
        Identifie = @"";
    }
    return Identifie;
}

-(NSArray*)Products
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSMutableArray* products = [NSMutableArray arrayWithCapacity:Products_iPad_.count];
        for (Commodity* commodity in Products_iPad_)
        {
            [products addObject:commodity.productID];
        }
        return products;
    }
    else
    {
        NSMutableArray* products = [NSMutableArray arrayWithCapacity:Products_iPhone_.count];
        for (Commodity* commodity in Products_iPhone_)
        {
            [products addObject:commodity.productID];
        }
        return products;
    }
}

-(NSString *)IdentiferOfProduct:(Products)index
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Commodity* commodity = [Products_iPad_ objectAtIndex:index];
        return commodity.productID;
    }
    else
    {
        Commodity* commodity = [Products_iPhone_ objectAtIndex:index];
        return commodity.productID;
    }
}
-(int)AmountOfProduct:(Products)index
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Commodity* commodity = [Products_iPad_ objectAtIndex:index];
        return commodity.amount;
    }
    else
    {
        Commodity* commodity = [Products_iPhone_ objectAtIndex:index];
        return commodity.amount;
    }
}
-(float)PriceOfProduct:(Products)index
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Commodity* commodity = [Products_iPad_ objectAtIndex:index];
        return commodity.price;
    }
    else
    {
        Commodity* commodity = [Products_iPhone_ objectAtIndex:index];
        return commodity.price;
    }
}

-(void)test
{
    CCLOG(@"%@",[self App_ID]);
    CCLOG(@"%@",[self AdmobBanner_ID]);
}

@end
