//
//  CaptionPopViewController.m
//  WeLiiKe
//
//  Created by anoop gupta on 23/05/13.
//
//

#import "CaptionPopViewController.h"

@interface CaptionPopViewController ()

@end

@implementation CaptionPopViewController
@synthesize strForCaption,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:self.view.bounds];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:strForCaption];
    [lbl setNumberOfLines:0];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [scrollView addSubview:lbl];
    
    CGSize labelSize = [lbl.text sizeWithFont:lbl.font
                                constrainedToSize:lbl.frame.size
                                    lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat labelHeight = labelSize.height;
    if (self.view.bounds.size.height>labelHeight) {
        [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+10)];
    }else{
        [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, labelHeight+10)];
    }
    [lbl setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, labelHeight)];
    
    [self.view addSubview:scrollView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
