//
//  MoviePlayViewController.m
//  VideoCaptureAndPlay
//
//  Created by donghua.peng on 14/12/14.
//  Copyright (c) 2014年 donghua.peng. All rights reserved.
//

#import "MoviePlayViewController.h"

#define mainSize [UIScreen mainScreen].bounds.size

@interface MoviePlayViewController ()

@end

@implementation MoviePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"视频播放";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];
    [self addBackLeftBarButtonItem];
    
    [self addChildViewController:self.streamingMovieViewController];
    [self addChildViewController:self.localMovieViewController];
    self.viewContent.frame = CGRectMake(0,64,mainSize.width,mainSize.height - 45 -64);
    self.viewButton.frame = CGRectMake(0, mainSize.height - 45, mainSize.width, 45);
    
    [self.viewContent addSubview:self.streamingMovieViewController.view];
    [self.viewContent addSubview:self.localMovieViewController.view];
    
    self.streamingMovieViewController.view.frame = self.viewContent.bounds;
    self.localMovieViewController.view.frame = self.viewContent.bounds;
    
    void (^playblock)(BOOL isPlaying) = ^(BOOL isPlaying){
        if (isPlaying) {
            self.navigationController.navigationBarHidden = YES;
            self.viewContent.frame = CGRectMake(0, 0, mainSize.width, mainSize.height - 45);
        }
        else{
            self.navigationController.navigationBarHidden = NO;
            self.viewContent.frame = CGRectMake(0,64,mainSize.width,mainSize.height - 45 -64);

        }
    };
    self.streamingMovieViewController.playblock = playblock;
    self.localMovieViewController.playblock = playblock;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.streamingMovieViewController.view.hidden = YES;
    self.localMovieViewController.view.hidden = NO;
        
    
    
}
- (IBAction)stream:(id)sender{
    [self.localMovieViewController stopMovie];
    self.streamingMovieViewController.view.hidden = NO;
    self.localMovieViewController.view.hidden = YES;
}

- (IBAction)local:(id)sender{
    [self.streamingMovieViewController stopMovie];
    self.streamingMovieViewController.view.hidden = YES;
    self.localMovieViewController.view.hidden = NO;
}

- (void)addBackLeftBarButtonItem {
    UIImage *backImg = [UIImage imageNamed:@"nav_back_normal"];
    UIImage *backImgSel = [UIImage imageNamed:@"nav_back_select"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect tempFrame;
    tempFrame.origin = CGPointMake(0, 0);
    tempFrame.size = backImg.size;
    [backBtn setFrame:tempFrame];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    [backBtn setImage:backImgSel forState:UIControlStateHighlighted];

    [backBtn addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:backBtn]];
    }
    else
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
