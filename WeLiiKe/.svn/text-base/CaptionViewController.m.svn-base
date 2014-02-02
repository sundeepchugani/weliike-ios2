//
//  CaptionViewController.m
//  WeLiiKe
//
//  Created by techvalens on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CaptionViewController.h"

@implementation CaptionViewController
@synthesize txtViewForCatpion;

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)actionOnShare:(id)sender{
    
    ShareSettingViewController *obj=[[ShareSettingViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(IBAction)actionOnDone:(id)sender{

    [[NSUserDefaults standardUserDefaults] setValue:txtViewForCatpion.text forKey:@"captionText"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [txtViewForCatpion becomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
