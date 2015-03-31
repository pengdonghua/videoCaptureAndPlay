/*

    File: MyLocalMovieViewController.m
Abstract: 
Subclass of MyMovieViewController. Gives a URL to a local movie stored in the app bundle. Implements a 'Play Movie' button for playback of a local movie. 
Also plays the local movie on touches to the UIImageView. 

 Version: 1.5

Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
Inc. ("Apple") in consideration of your agreement to the following
terms, and your use, installation, modification or redistribution of
this Apple software constitutes acceptance of these terms.  If you do
not agree with these terms, please do not use, install, modify or
redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and
subject to these terms, Apple grants you a personal, non-exclusive
license, under Apple's copyrights in this original Apple software (the
"Apple Software"), to use, reproduce, modify and redistribute the Apple
Software, with or without modifications, in source and/or binary forms;
provided that if you redistribute the Apple Software in its entirety and
without modifications, you must retain this notice and the following
text and disclaimers in all such redistributions of the Apple Software.
Neither the name, trademarks, service marks or logos of Apple Inc. may
be used to endorse or promote products derived from the Apple Software
without specific prior written permission from Apple.  Except as
expressly stated in this notice, no other rights or licenses, express or
implied, are granted by Apple herein, including but not limited to any
patent rights that may be infringed by your derivative works or by other
works in which the Apple Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

Copyright (C) 2014 Apple Inc. All Rights Reserved.


*/

#import "MyLocalMovieViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define KVideoUrlPath \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VideoURL"]

@interface MyLocalMovieViewController (LocalMovieURL)
-(NSURL *)localMovieURL;
@end

#pragma mark -
@implementation MyLocalMovieViewController (LocalMovieURL)

/* Returns a URL to a local movie in the app bundle. */
-(NSURL *)localMovieURL
{
	NSURL *theMovieURL = nil;
	NSBundle *bundle = [NSBundle mainBundle];
	if (bundle) 
	{
		NSString *moviePath = [bundle pathForResource:@"Movie" ofType:@"m4v"];
		if (moviePath)
		{
			theMovieURL = [NSURL fileURLWithPath:moviePath];
		}
	}
    return theMovieURL;
}

@end

#pragma mark -

@implementation MyLocalMovieViewController

/* Button presses for the 'Play Movie' button. */
-(IBAction)playMovieButtonPressed:(id)sender
{
	/* Play the movie at the specified URL. */
//    [self playMovieFile:[self localMovieURL]];
    [self getLocalVideoAndPlay];
}

- (void)getLocalVideoAndPlay{
    if (self.groupArrays == nil) {
        self.groupArrays = [NSMutableArray array];
    }
//    BOOL isVideo = NO;
    __block BOOL isPlaying = NO;
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
            if (group != nil) {
                [weakSelf.groupArrays addObject:group];
            } else {
                [weakSelf.groupArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    [obj enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                        
                        if ([result thumbnail] != nil) {
                            
                            // 视频
                            
                            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo] ){
                               
                                // 和图片方法类似
//                                NSDate *date= [result valueForProperty:ALAssetPropertyDate];
//
//                                UIImage *image = [UIImage imageWithCGImage:[result thumbnail]];
                                
//                                NSString *fileName = [[result defaultRepresentation] filename];
                                
                                NSURL *url = [[result defaultRepresentation] url];
                                
//                                int64_t fileSize = [[result defaultRepresentation] size];
                                
                                if (stop) {
                                    if (!isPlaying) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [weakSelf playMovieFile:url];
                                        });
                                        isPlaying = YES;
                                    }
                                    
                                    return ;
                                }
                                
//                                NSLog(@"date = %@",date);
//                                
//                                NSLog(@"fileName = %@",fileName);
//                                
//                                NSLog(@"url = %@",url);
//                                
//                                NSLog(@"fileSize = %lld",fileSize);
                            }
                            
                        }
                        
                    }];
                    
                }];
     
            }
            
        };
      
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error)
        {
            NSString *errorMessage = nil;

            switch ([error code]) {
                    
                case ALAssetsLibraryAccessUserDeniedError:
                    
                case ALAssetsLibraryAccessGloballyDeniedError:
                    
                    errorMessage = @"用户拒绝访问相册,请在<隐私>中开启";
                    
                    break;
                    
                    
                    
                default:
                    
                    errorMessage = @"Reason unknown.";
                   
                    break;
                    
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误,无法访问!"
                                          
                                                                   message:errorMessage
                                          
                                                                  delegate:self
                                         
                                                         cancelButtonTitle:@"确定"
                                          
                                                         otherButtonTitles:nil, nil];
                
                [alertView show];
                
            });
            
        };

        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]  init];
        
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
         
                                     usingBlock:listGroupBlock failureBlock:failureBlock];
       
    });
}
@end
