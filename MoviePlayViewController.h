//
//  MoviePlayViewController.h
//  VideoCaptureAndPlay
//
//  Created by donghua.peng on 14/12/14.
//  Copyright (c) 2014年 donghua.peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MyLocalMovieViewController.h"
#import "MyStreamingMovieViewController.h"

@interface MoviePlayViewController : UIViewController
{
    
}
@property (nonatomic, weak) IBOutlet UIButton *streamButton;
@property (nonatomic, weak) IBOutlet UIButton *localButton;
@property (nonatomic, weak) IBOutlet UIView *viewContent;
@property (nonatomic, weak) IBOutlet UIView *viewButton;

@property (nonatomic, weak) IBOutlet MyStreamingMovieViewController *streamingMovieViewController;
@property (nonatomic, weak) IBOutlet MyLocalMovieViewController *localMovieViewController;
@end
