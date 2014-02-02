//
//  Splash1.m
//  WellLike
//
//  Created by Amit soni on 18/12/12.
//  Copyright (c) 2012 Techvalens Software Systems Pvt Ltd. All rights reserved.
//

#import "Splash1.h"
#import "AfterContinueViewController.h"
#import "WelcomeSearchScreen.h"

extern BOOL checkForLogIn;

int screen = 1;
extern BOOL logoutCheck;
@implementation Splash1
@synthesize splashImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] length] >0) {
        checkForLogIn=YES;
        WelcomeSearchScreen *obj=[[WelcomeSearchScreen alloc] init];
        [self.navigationController pushViewController:obj animated:YES];
        return;
    }
    
    if (logoutCheck==YES) {
        logoutCheck=NO;
        AfterContinueViewController *obj=[[AfterContinueViewController alloc] init];
        [self.navigationController pushViewController:obj animated:YES];
        return;
    }
    
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
    
    [splashImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"welike_screen%d.png",++imageNumber]]];
    //[self performSelector:@selector(changeScreen) withObject:nil afterDelay:2.0];
}

-(void)changeScreen
{
    if (screen<7)
    {
        screen++;

        if (screen%2)
        {
            UIImage * toImage = [UIImage imageNamed:[NSString stringWithFormat:@"welike_screen%d.png",++imageNumber]];
            [UIView transitionWithView:self.view
                              duration:2.0f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                //[self.splashImageView setAlpha:1.0];
                                self.splashImageView.image = toImage;
                                [self performSelector:@selector(changeScreen) withObject:nil afterDelay:5.0];
                            }
                            completion:NULL];
        }
        else
        {
            UIImage * toImage = [UIImage imageNamed:@"welike_screen_blank.png"];
            [UIView transitionWithView:self.view
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                //[self.splashImageView setAlpha:0.5];
                                self.splashImageView.image = toImage;
                                [self performSelector:@selector(changeScreen) withObject:nil afterDelay:1.0];
                            }
                            completion:NULL];
        }
        
//        Splash1 *anotherSplash = [[Splash1 alloc] init];
//        [self.navigationController pushViewController:anotherSplash animated:YES];
    }else{
    
        [UIView transitionWithView:self.view
                          duration:0.7f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
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
                        }
                        completion:NULL];
        
        
        
    }
}
-(void)actionOnConti:(id)sender{
    
    AfterContinueViewController *obj=[[AfterContinueViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}


- (void)viewDidUnload
{
    [self setSplashImageView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
