//
//  SplashViewController.m
//  WeLiiKe
//
//  Created by techvalens on 12/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SplashViewController.h"
#import "AfterContinueViewController.h"

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [imageView1 setImage:[UIImage imageNamed:@"Splash1.png"]];
    [self.view addSubview:imageView1];
    
    imageView2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [imageView2 setImage:[UIImage imageNamed:@"Splash2.png"]];
    imageView2.hidden=YES;
    [self.view addSubview:imageView2];
    
    imageView3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [imageView3 setImage:[UIImage imageNamed:@"Splash3.png"]];
    imageView3.hidden=YES;
    [self.view addSubview:imageView3];
    
    UIButton *btnForConti=[[UIButton alloc] initWithFrame:CGRectMake(200, 415, 100, 30)];
    [btnForConti setTitle:@"Continue" forState:UIControlStateNormal];
    [btnForConti.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [btnForConti setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnForConti setBackgroundColor:[UIColor grayColor]];
    btnForConti.layer.cornerRadius=5;
    btnForConti.layer.masksToBounds=YES;
    UIColor *color = btnForConti.currentTitleColor;
    btnForConti.titleLabel.layer.shadowColor = [color CGColor];
    btnForConti.titleLabel.layer.shadowRadius = 4.0f;
    btnForConti.titleLabel.layer.shadowOpacity = .9;
    btnForConti.titleLabel.layer.shadowOffset = CGSizeZero;
    btnForConti.titleLabel.layer.masksToBounds = NO;
    
    UIColor *color1 = [UIColor blackColor];
    btnForConti.layer.shadowColor = [color1 CGColor];
    btnForConti.layer.shadowRadius = 4.0f;
    btnForConti.layer.shadowOpacity = .9;
    btnForConti.layer.shadowOffset = CGSizeZero;
    btnForConti.layer.masksToBounds = NO;

    [btnForConti addTarget:self action:@selector(actionOnConti:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnForConti];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(targetMethod)
                                   userInfo:nil
                                    repeats:YES];
    // Do any additional setup after loading the view from its nib.
}
-(void)actionOnConti:(id)sender{
 
    AfterContinueViewController *obj=[[AfterContinueViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(void)targetMethod{
    if (!imageView1.hidden && imageView2.hidden && imageView3.hidden) {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        transition.delegate = self;
        [self.view.layer addAnimation:transition forKey:nil];
        imageView1.hidden = YES;
        imageView2.hidden = NO;
    }else if (!imageView2.hidden && imageView3.hidden && imageView1.hidden){
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        transition.delegate = self;
        [self.view.layer addAnimation:transition forKey:nil];
        imageView2.hidden = YES;
        imageView3.hidden = NO;
    }else if (!imageView3.hidden && imageView1.hidden && imageView2.hidden){
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        transition.delegate = self;
        [self.view.layer addAnimation:transition forKey:nil];
        imageView3.hidden = YES;
        imageView1.hidden = NO;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
