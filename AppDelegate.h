//
//  AppDelegate.h
//  VideoCaptureAndPlay
//
//  Created by donghua.peng on 14/12/11.
//  Copyright (c) 2014年 donghua.peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCamViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet AVCamViewController *rViewController;

@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@end

