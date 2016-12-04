//
//  InAppPurchaseManager.h
//  unblock
//
//  Created by 张朴军 on 13-1-18.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "CommonDefine.h"
#import "IdentifieManager.h"
#import "MBProgressHUD.h"
#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionCancelNotification @"kInAppPurchaseManagerTransactionCancelNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"
#define kInAppPurchaseManagerTransactionRestoreCompleteNotification @"kInAppPurchaseManagerTransactionRestoreCompleteNotification"
@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}

DECLARE_SINGLETON_FOR_CLASS(InAppPurchaseManager)

- (void)requestProUpgradeProductData;
- (void)loadStore;
- (BOOL)canMakePurchases;

- (void)purchaseProduct:(Products)product;

-(void)restorePurchases;

@end
