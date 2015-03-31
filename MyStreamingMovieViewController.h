

#import <UIKit/UIKit.h>

#import "MyMovieViewController.h"

@interface MyStreamingMovieViewController : MyMovieViewController <UITextFieldDelegate> 
{
@private
	IBOutlet UITextField *movieURLTextField;
}

@property (nonatomic,strong) IBOutlet UITextField *movieURLTextField;

-(IBAction)playStreamingMovieButtonPressed:(id)sender;

@end
