//
//  UserDefault.m
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-10.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "UserDefault.h"
#import "cocos2d.h"
#import "NSData+AES.h"


@implementation UserDefault
SYNTHESIZE_SINGLETON_FOR_CLASS(UserDefault)
@synthesize filePath = _filePath;
@synthesize dictionary = _dictionary;
-(id)init
{
    if(self = [super init])
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSLog(@"documentsDirectory%@",documentsDirectory);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"UserData"];
        
        BOOL isDir = FALSE;
        BOOL isExist = [fileManager fileExistsAtPath:testDirectory isDirectory:&isDir];
        if(!(isExist && isDir))
        {
            BOOL bCreatDir = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            if(!bCreatDir)
            {
                NSLog(@"Creat Directory Failed!");
            }
            NSLog(@"%@",testDirectory);
        }
       
        isExist = FALSE;
        self.filePath = [testDirectory stringByAppendingPathComponent:@"userdata.dat"];
        isExist = [fileManager fileExistsAtPath:self.filePath];
        if(!isExist)
        {
            BOOL bCreatFile = [fileManager createFileAtPath:self.filePath contents:nil attributes:nil];
            if(!bCreatFile)
            {
                NSLog(@"Creat File Failed!");
            }
            
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            NSData* fileData = [NSKeyedArchiver archivedDataWithRootObject:dic];
            NSData* encodeData = [fileData AES256EncryptWithKey:APP_PUBLIC_PASSWORD];
            [encodeData writeToFile:self.filePath atomically:YES];
            
            NSLog(@"%@",self.filePath);
        }
        
        NSData* fileData = [NSData dataWithContentsOfFile:self.filePath];
        NSData* decodeData = [fileData AES256DecryptWithKey:APP_PUBLIC_PASSWORD];
        self.dictionary = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:decodeData]];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(synchronize) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(synchronize) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(synchronize) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}
-(void)dealloc
{
    [self synchronize];
    self.filePath = nil;
    self.dictionary = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)objectForKey:(NSString *)defaultName
{
    return [self.dictionary objectForKey:defaultName];
}
- (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [self.dictionary setObject:value forKey:defaultName];
}
- (void)removeObjectForKey:(NSString *)defaultName
{
    [self removeObjectForKey:defaultName];
}

- (NSString *)stringForKey:(NSString *)defaultName
{
    NSString* string = [self.dictionary valueForKey:defaultName];
    return string;
}
- (NSArray *)arrayForKey:(NSString *)defaultName
{
    NSArray* array = [self.dictionary valueForKey:defaultName];
    return array;
}
- (NSDictionary *)dictionaryForKey:(NSString *)defaultName
{
    NSDictionary* dictionary = [self.dictionary valueForKey:defaultName];
    return dictionary;
}
- (NSData *)dataForKey:(NSString *)defaultName
{
    NSData* data = [self.dictionary valueForKey:defaultName];
    return data;
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
    NSNumber* value = [self.dictionary valueForKey:defaultName];
    return [value integerValue];
}
- (float)floatForKey:(NSString *)defaultName
{
    NSNumber* value = [self.dictionary valueForKey:defaultName];
    return [value floatValue];
}
- (double)doubleForKey:(NSString *)defaultName
{
    NSNumber* value = [self.dictionary valueForKey:defaultName];
    return [value doubleValue];
}
- (BOOL)boolForKey:(NSString *)defaultName
{
    NSNumber* value = [self.dictionary valueForKey:defaultName];
    return [value boolValue];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    NSNumber* number = [NSNumber numberWithInteger:value];
    [self.dictionary setObject:number forKey:defaultName];
}
- (void)setFloat:(float)value forKey:(NSString *)defaultName
{
    NSNumber* number = [NSNumber numberWithFloat:value];
    [self.dictionary setObject:number forKey:defaultName];
}
- (void)setDouble:(double)value forKey:(NSString *)defaultName
{
    NSNumber* number = [NSNumber numberWithDouble:value];
    [self.dictionary setObject:number forKey:defaultName];
}
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    NSNumber* number = [NSNumber numberWithBool:value];
    [self.dictionary setObject:number forKey:defaultName];
}

- (BOOL)synchronize
{
    NSData* fileData = [NSKeyedArchiver archivedDataWithRootObject:self.dictionary];
    NSData* encodeData = [fileData AES256EncryptWithKey:APP_PUBLIC_PASSWORD];
    return  [encodeData writeToFile:self.filePath atomically:YES];
}

-(void)applicationDidEnterBackground
{
    [self synchronize];
}
- (void)load
{
    
}

@end
