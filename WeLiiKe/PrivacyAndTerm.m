//
//  PrivacyAndTerm.m
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PrivacyAndTerm.h"

@implementation PrivacyAndTerm
@synthesize btnForVersion,scrollViewForPrivacy;

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
    //[scrollViewForPrivacy setFrame:CGRectMake(0, 93, 320, 368)];
    [scrollViewForPrivacy setContentSize:CGSizeMake(320, 400)];

    //lblForTitle.text=strForTitle;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)actionOnAboutWeLiike:(id)sender{

}

-(IBAction)actionOnSupport:(id)sender{


}


-(IBAction)actionOnTermsOfservice:(id)sender{

}

-(IBAction)actionOnPrivatePolicy:(id)sender{

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
