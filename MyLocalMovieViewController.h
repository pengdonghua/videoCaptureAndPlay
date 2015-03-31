
#import <UIKit/UIKit.h>
#import "MyMovieViewController.h"


@interface MyLocalMovieViewController : MyMovieViewController 
{
}
@property (nonatomic, strong) NSMutableArray *groupArrays;
-(IBAction)playMovieButtonPressed:(id)sender;

@end
