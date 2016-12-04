//
//  AudioManager.h
//  CommonTest
//
//  Created by 张朴军 on 13-6-3.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "SimpleAudioEngine.h"

#define BUTTON_SOUND @"button.aif"
#define BGM_FACTOR 0.1f
@interface AudioManager : NSObject
{
    float _sound;
    float _music;
    BOOL  _enabled;
    
    NSString*   _currentFile;
}

DECLARE_SINGLETON_FOR_CLASS(AudioManager)

@property (nonatomic, assign)float sound;
@property (nonatomic, assign)float music;
@property (nonatomic, assign)BOOL enabled;
@property (nonatomic, copy)NSString* currentFile;

-(void) preloadBackgroundMusic:(NSString*) filePath;
/** plays background music in a loop*/
-(void) playBackgroundMusic:(NSString*) filePath;
/** plays background music, if loop is true the music will repeat otherwise it will be played once */
-(void) playBackgroundMusic:(NSString*) filePath loop:(BOOL) loop;
/** stops playing background music */
-(void) stopBackgroundMusic;
/** pauses the background music */
-(void) pauseBackgroundMusic;
/** resume background music that has been paused */
-(void) resumeBackgroundMusic;
/** rewind the background music */
-(void) rewindBackgroundMusic;
/** returns whether or not the background music is playing */
-(BOOL) isBackgroundMusicPlaying;

/** plays an audio effect with a file path*/
-(ALuint) playEffect:(NSString*) filePath;
/** stop a sound that is playing, note you must pass in the soundId that is returned when you started playing the sound with playEffect */
-(void) stopEffect:(ALuint) soundId;
/** plays an audio effect with a file path, pitch, pan and gain */
-(ALuint) playEffect:(NSString*) filePath pitch:(Float32) pitch pan:(Float32) pan gain:(Float32) gain;
/** preloads an audio effect */
-(void) preloadEffect:(NSString*) filePath;
/** unloads an audio effect from memory */
-(void) unloadEffect:(NSString*) filePath;
/** Gets a CDSoundSource object set up to play the specified file. */
-(CDSoundSource *) soundSourceForFile:(NSString*) filePath;


-(void)load;
-(void)save;

@end
