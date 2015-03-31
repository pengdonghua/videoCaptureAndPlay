

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

//@class MyImageView;
typedef void (^Playblock)(BOOL isPlaying);
@interface MyMovieViewController : UIViewController 
{
@private
    MPMoviePlayerController *moviePlayerController;

	IBOutlet UIImageView *movieBackgroundImageView;
	IBOutlet UIView *backgroundView;
}


@property (nonatomic, strong) IBOutlet UIImageView *movieBackgroundImageView;
@property (nonatomic, strong) IBOutlet UIView *backgroundView;
@property (nonatomic, copy) Playblock playblock;

@property (strong) MPMoviePlayerController *moviePlayerController;

- (void)viewWillEnterForeground;
- (void)playMovieFile:(NSURL *)movieFileURL;
- (void)playMovieStream:(NSURL *)movieFileURL;
- (void)stopMovie;
@end


