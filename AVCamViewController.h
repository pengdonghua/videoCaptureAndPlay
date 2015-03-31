//
//  AVCamViewController.h
//  VideoCaptureAndPlay
//
//  Created by donghua.peng on 14/12/11.
//  Copyright (c) 2014年 donghua.peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCamPreviewView.h"
#import "AVCamManager.h"
@interface AVCamViewController : UIViewController<UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIBarButtonItem *recordButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *cameralToggleButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *playButton;

@property (nonatomic) BOOL lockInterfaceRotation;

@property (nonatomic, weak) IBOutlet AVCamPreviewView *previewView;
@property (nonatomic, strong) AVCamManager *avCamManager;
//- (void)viewWillEnterForeground;
- (void)didBecomeActive;
@end
