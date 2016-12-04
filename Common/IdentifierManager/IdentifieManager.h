//
//  IdentifieManager.h
//  minesweeper
//
//  Created by 张朴军 on 12-12-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "Commodity.h"

typedef enum
{
    GameCenterCategory_One = 0,
    GameCenterCategory_Three,
    GameCenterCategory_Total,
}GameCenterCategories;

typedef enum
{
    Product_Hint_50 = 0,
    Product_Hint_100,
}Products;

@interface IdentifieManager : NSObject
{
    NSString*   AppName_iPhone_;
    NSString*   BundleName_iPhone_;
    NSString*   App_ID_iPhone_;
    NSString*   AdmobBanner_ID_iPhone_;
    NSString*   AdmobInterstitial_ID_iPhone_;
    NSArray*    GameCenter_Categories_iPhone_;
    NSArray*    Products_iPhone_;
    
    NSString*   AppName_iPad_;
    NSString*   BundleName_iPad_;
    NSString*   App_ID_iPad_;
    NSString*   AdmobBanner_ID_iPad_;
    NSString*   AdmobInterstitial_ID_iPad_;
    NSArray*    GameCenter_Categories_iPad_;
    NSArray*    Products_iPad_;
}
@property (nonatomic, readonly)NSString* BundleName_iPhone;
@property (nonatomic, readonly)NSString* AppName_iPhone;
@property (nonatomic, readonly)NSString* App_ID_iPhone;
@property (nonatomic, readonly)NSString* AdmobBanner_ID_iPhone;
@property (nonatomic, readonly)NSString* AdmobInterstitial_ID_iPhone;
@property (nonatomic, readonly)NSArray* GameCenter_Categories_iPhone;

@property (nonatomic, readonly)NSString* BundleName_iPad;
@property (nonatomic, readonly)NSString* AppName_iPad;
@property (nonatomic, readonly)NSString* App_ID_iPad;
@property (nonatomic, readonly)NSString* AdmobBanner_ID_iPad;
@property (nonatomic, readonly)NSString* AdmobInterstitial_ID_iPad;
@property (nonatomic, readonly)NSArray* GameCenter_Categories_iPad;



-(NSString*)AppName;
-(NSString*)App_ID;
-(NSString*)AdmobBanner_ID;
-(NSString*)AdmobInterstitial_ID;
-(NSString*)GameCenter_IDByCategory:(GameCenterCategories) Category;
-(NSString*)GameCenter_ID;
DECLARE_SINGLETON_FOR_CLASS(IdentifieManager)

-(void)test;

-(NSArray*)Products;
-(NSString*)IdentiferOfProduct:(Products)index;
-(int)AmountOfProduct:(Products)index;
-(float)PriceOfProduct:(Products)index;

@end
