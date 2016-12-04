//
//  AudioManager.m
//  CommonTest
//
//  Created by 张朴军 on 13-6-3.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "AudioManager.h"
#import "UserDefault.h"
#import "SimpleAudioEngine.h"
@implementation AudioManager
@synthesize sound = _sound;
@synthesize music = _music;
@synthesize enabled = _enabled;
@synthesize currentFile = _currentFile;
SYNTHESIZE_SINGLETON_FOR_CLASS(AudioManager)

-(id)init
{
    if(self = [super init])
    {
        bool level_data = [[UserDefault sharedUserDefault] boolForKey:@"AudioManagerData"];
        if(level_data==false)
        {
            [[UserDefault sharedUserDefault] setBool:true forKey:@"AudioManagerData"];
            [[UserDefault sharedUserDefault] setFloat:1.0 forKey:@"Audio_Sound"];
            [[UserDefault sharedUserDefault] setFloat:1.0 forKey:@"Audio_Music"];
            [[UserDefault sharedUserDefault] setBool:YES forKey:@"Audio_Enabled"];
        }
        self.currentFile = nil;
    }
    return self;
}

-(void)dealloc
{
    self.currentFile = nil;
    [super dealloc];
}

-(void)setSound:(float)sound
{
    _sound = sound;
    [SimpleAudioEngine sharedEngine].effectsVolume=_sound;
}

-(void)setMusic:(float)music
{
    _music = music;
    [SimpleAudioEngine sharedEngine].backgroundMusicVolume=_music * BGM_FACTOR;
}

-(void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    [SimpleAudioEngine sharedEngine].enabled = _enabled;
}

-(void) preloadBackgroundMusic:(NSString*) filePath
{
    [[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:filePath];
}

-(void) playBackgroundMusic:(NSString*) filePath
{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:filePath];
}

-(void) playBackgroundMusic:(NSString*) filePath loop:(BOOL) loop
{
    if([self.currentFile isEqualToString:filePath])
        return;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:filePath loop:loop];
    self.currentFile = filePath;
}

-(void) stopBackgroundMusic
{
    self.currentFile = nil;
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

-(void) pauseBackgroundMusic
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

-(void) resumeBackgroundMusic
{
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

-(void) rewindBackgroundMusic
{
    [[SimpleAudioEngine sharedEngine] rewindBackgroundMusic];
}

-(BOOL) isBackgroundMusicPlaying
{
    return [[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying];
}

-(ALuint) playEffect:(NSString*) filePath
{
    return [[SimpleAudioEngine sharedEngine] playEffect:filePath];
}

-(void) stopEffect:(ALuint) soundId
{
    [[SimpleAudioEngine sharedEngine] stopEffect:soundId];
}

-(ALuint) playEffect:(NSString*) filePath pitch:(Float32) pitch pan:(Float32) pan gain:(Float32) gain
{
    return [[SimpleAudioEngine sharedEngine] playEffect:filePath pitch:pitch pan:pan gain:gain];
}

-(void) preloadEffect:(NSString*) filePath
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:filePath];
}

-(void) unloadEffect:(NSString*) filePath
{
    [[SimpleAudioEngine sharedEngine] unloadEffect:filePath];
}

-(CDSoundSource *) soundSourceForFile:(NSString*) filePath
{
    return [[SimpleAudioEngine sharedEngine] soundSourceForFile:filePath];
}

-(void)loadResource
{
    
}

-(void)load
{
    [self loadResource];
    self.sound = [[UserDefault sharedUserDefault] floatForKey:@"Audio_Sound"];
    self.music = [[UserDefault sharedUserDefault] floatForKey:@"Audio_Music"];
    self.enabled = [[UserDefault sharedUserDefault] boolForKey:@"Audio_Enabled"];
}

-(void)save
{
    [[UserDefault sharedUserDefault] setFloat:self.sound forKey:@"Audio_Sound"];
    [[UserDefault sharedUserDefault] setFloat:self.music forKey:@"Audio_Music"];
    [[UserDefault sharedUserDefault] setBool:self.enabled forKey:@"Audio_Enabled"];
}

@end
