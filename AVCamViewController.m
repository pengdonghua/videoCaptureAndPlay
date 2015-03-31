//
//  AVCamViewController.m
//  VideoCaptureAndPlay
//
//  Created by donghua.peng on 14/12/11.
//  Copyright (c) 2014年 donghua.peng. All rights reserved.
//

#import "AVCamViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


#import "MoviePlayViewController.h"

@interface AVCamViewController ()<AVCamManagerDelegate>


@end

@implementation AVCamViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)vidDidLoad{
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.recordButton setTitle:NSLocalizedString(@"Record", @"Toggle recording button record title")];
    [self.cameralToggleButton setTitle:NSLocalizedString(@"Camera", @"Toggle camera button title")];
    [self.playButton setTitle:NSLocalizedString(@"Play", @"Toggle Play button title")];
    [self.view sendSubviewToBack:[self previewView]];
    
    if (self.avCamManager == nil) {
        _avCamManager = [[AVCamManager alloc] init];
        _avCamManager.delegate = self;
        _avCamManager.previewView = self.previewView;
    }
    [self.avCamManager initSession];
    [self.avCamManager addObservers];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.avCamManager removeObservers];
    self.navigationController.navigationBarHidden = NO;

}

- (void)didBecomeActive{
    

}


- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (BOOL)shouldAutorotate
{
    // Disable autorotation of the interface when recording is in progress.
//    return ![self lockInterfaceRotation];
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)toInterfaceOrientation];
}



#pragma mark - action
- (IBAction)record:(id)sender{
    [[self recordButton] setEnabled:NO];
    [self.avCamManager record];
    
}

- (IBAction)changeCameral:(id)sender{
    [self.cameralToggleButton setEnabled:NO];
    [self.recordButton setEnabled:NO];
    [self.playButton setEnabled:NO];
//    [[self stillButton] setEnabled:NO];
    
    void (^block)(void) = ^(void){
        [self.cameralToggleButton setEnabled:YES];
        [self.recordButton setEnabled:YES];
        [self.playButton setEnabled:YES];
    };
    [self.avCamManager setBlock:block];
    [self.avCamManager changeCamera];
   
}

- (IBAction)play:(id)sender{
    self.navigationController.navigationBarHidden = NO;
    MoviePlayViewController *movieController = [[MoviePlayViewController alloc] init];
    [self.navigationController pushViewController:movieController animated:YES];
//    [self.navigationController presentViewController:movieController animated:YES completion:nil];
}


#pragma mark - AVCamManagerDelegate
- (UIInterfaceOrientation )getDeviceOrientation{
    return [self interfaceOrientation];
}
- (void)changeRecordStatus:(BOOL)isRecording{
    if (isRecording) {
        [self.recordButton setTitle:NSLocalizedString(@"Stop", @"Recording button stop title")];
        [self.cameralToggleButton setEnabled:NO];
        [self.playButton setEnabled:NO];
    }
    else{
        [self.recordButton setTitle:NSLocalizedString(@"Record", @"Toggle recording button record title")];
        
        [self.cameralToggleButton setEnabled:YES];
        [self.playButton setEnabled:YES];
    }
    [self.recordButton setEnabled:YES];
}
- (void)changeRunningStatus:(BOOL)isRunning{
    if (isRunning) {
        [self.cameralToggleButton setEnabled:YES];
        [self.playButton setEnabled:YES];
        [self.recordButton setEnabled:YES];
    }
    else{
        [self.cameralToggleButton setEnabled:NO];
        [self.playButton setEnabled:NO];
        [self.recordButton setEnabled:NO];
    }
}
- (void)lockInterfaction:(BOOL)isLock{
    self.lockInterfaceRotation = isLock;
}
@end
