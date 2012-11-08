/*  
 *  FullscreenControls.h
 *  MPlayerOSX Extended
 *  
 *  Created on 03.11.2008
 *  
 *  Description:
 *	Window used for the fullscreen controls.
 *  
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import <Cocoa/Cocoa.h>
//#import "PlayerController.h"

//#import "MPlayerInterface.h"
#import "PlayerFullscreenWindow.h"
#import "ProgressSlider.h"
#import "VolumeSlider.h"
#import "Protocols.h"


@class TimestampTextField;


@interface FullscreenControls : NSWindow <MusicPlayerProtocol, ProgressSliderProtocol, VolumeSliderProtocol> {
	
	PlayerFullscreenWindow *fcWindow;
	//IBOutlet NSButton *fcPlayButton;
    //IBOutlet id fcVolumeSlider;
	//IBOutlet id fcScrubbingBar;
	//IBOutlet TimestampTextField *fcTimeTextField;
	//IBOutlet id fcAudioCycleButton;
	//IBOutlet id fcSubtitleCycleButton;
	//IBOutlet id fcFullscreenButton;
	
	NSImage *pauseButtonImage;
	NSImage *playButtonImage;
    NSButton *playButton;
    NSButton *pauseButton;
    NSButton *fastforwardButton;
    NSButton *rewindButton;
    NSButton *fullscreenButton;
    VolumeSlider *volumeSlider;
    ProgressSlider *progressSlider;
    
	NSPoint dragStartPoint;
	
	NSViewAnimation *animation;
	//BOOL isOpen;
	//BOOL beingDragged;
    
    NSBundle* resourceBundle;
	
    JMPlayer* jm_player;
	//IBOutlet PlayerController *playerController;
}

@property (nonatomic, retain) id<MusicPlayerClientProtocol> delegate;
@property (readonly,getter=window) PlayerFullscreenWindow *fcWindow;
@property (readonly) BOOL beingDragged;

+(NSBundle*)findResourceBundleWithAppPath:(NSString*) appPath;

-(id) initWithJMPlayer: (JMPlayer*) jmPlayer fullscreenWindow: (PlayerFullscreenWindow*) playerFSWindow;

- (void)fadeWith:(NSString*)effect;
- (void)cycleTimeDisplayMode:(id)sender;

- (void)show;
- (void)hide;

- (void)dealloc;


// MusicPlayerProtocol implementations
-(void)setVolume:(CGFloat)volume;
-(void)setState:(int)state;
-(void)setMaxTime:(CGFloat)seconds;
-(void)setCurrentTime:(CGFloat)seconds;

@end
