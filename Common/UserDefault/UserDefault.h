//
//  UserDefault.h
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-10.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#define APP_PUBLIC_PASSWORD     @"BacteriaDash"
@interface UserDefault : NSObject
{
    NSString* _filePath;
    NSMutableDictionary* _dictionary;
}
@property (nonatomic, copy)NSString* filePath;
@property (nonatomic, retain)NSMutableDictionary* dictionary;

- (id)objectForKey:(NSString *)defaultName;
- (void)setObject:(id)value forKey:(NSString *)defaultName;
- (void)removeObjectForKey:(NSString *)defaultName;

- (NSString *)stringForKey:(NSString *)defaultName;
- (NSArray *)arrayForKey:(NSString *)defaultName;
- (NSDictionary *)dictionaryForKey:(NSString *)defaultName;
- (NSData *)dataForKey:(NSString *)defaultName;

- (NSInteger)integerForKey:(NSString *)defaultName;
- (float)floatForKey:(NSString *)defaultName;
- (double)doubleForKey:(NSString *)defaultName;
- (BOOL)boolForKey:(NSString *)defaultName;


- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setFloat:(float)value forKey:(NSString *)defaultName;
- (void)setDouble:(double)value forKey:(NSString *)defaultName;
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

- (BOOL)synchronize;
- (void)load;



DECLARE_SINGLETON_FOR_CLASS(UserDefault)

@end
