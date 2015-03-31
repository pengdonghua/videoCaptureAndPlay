//
//  AVCamManager.h
//  VideoCaptureAndPlay
//
//  Created by donghua.peng on 14/12/12.
//  Copyright (c) 2014年 donghua.peng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AVCamPreviewView.h"

@protocol AVCamManagerDelegate;
typedef void (^ChangeCamerBlock)(void);

@interface AVCamManager : NSObject
// Session management.
@property (nonatomic) dispatch_queue_t sessionQueue; // Communicate with the session and other session objects on this queue.
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic) AVCaptureDeviceInput *audioDeviceInput;
@property (nonatomic) AVCaptureMovieFileOutput *movieFileOutput;

@property (nonatomic, strong) AVAssetWriterInput *assetWriterInput;
@property (nonatomic, strong) AVAssetWriterInputPixelBufferAdaptor *pixelBufferAdaptor;
@property (nonatomic, strong) AVAssetWriter *assetWriter;

@property (nonatomic, strong) AVCamPreviewView *previewView;

// Utilities.
@property (nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic, getter = isDeviceAuthorized) BOOL deviceAuthorized;
@property (nonatomic, readonly, getter = isSessionRunningAndDeviceAuthorized) BOOL sessionRunningAndDeviceAuthorized;

@property (nonatomic) id runtimeErrorHandlingObserver;

@property (nonatomic, weak) id<AVCamManagerDelegate> delegate;
@property (nonatomic, copy) ChangeCamerBlock block;
- (void)initSession;
- (void)addObservers;
- (void)removeObservers;
- (void)record;
- (void)changeCamera;

@end

@protocol AVCamManagerDelegate <NSObject>

@optional
- (UIInterfaceOrientation )getDeviceOrientation;
- (void)changeRecordStatus:(BOOL)isRecording;
- (void)lockInterfaction:(BOOL)isLock;
- (void)changeRunningStatus:(BOOL)isRunning;
@end
