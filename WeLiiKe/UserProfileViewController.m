//
//  UserProfileViewController.m
//  WeLiiKe
//
//  Created by techvalens on 30/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileFeedViewController.h"

@implementation UserProfileViewController
@synthesize tableViewForCategoty;

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
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.delegate = self;
    [self.view addGestureRecognizer:swipeRight];
    [self performSelector:@selector(callArrangeTop)];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)swipeRightAction:(id)ignored
{
    NSLog(@"Swipe Right");
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navControllerApp popViewControllerAnimated:YES];
    //add Function
}

-(IBAction)actionOnUserProfileFeed:(id)sender{
    
    UserProfileFeedViewController *obj=[[UserProfileFeedViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    CellForWelcomeCategory *cell= (CellForWelcomeCategory*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[CellForWelcomeCategory alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	[cell.image1 setImage:[UIImage imageNamed:@"Splash1.png"] forState:UIControlStateNormal];
    //[cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.image1.tag=indexPath.row;
    
    
    [cell.image2 setImage:[UIImage imageNamed:@"Splash2.png"] forState:UIControlStateNormal];
    cell.image2.tag=indexPath.row;
    //[cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    [cell.image3 setImage:[UIImage imageNamed:@"Splash3.png"] forState:UIControlStateNormal];
    cell.image3.tag=indexPath.row;
    //[cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.lbl1 setText:@"Cayegory 1"];
   // [cell.lbl1 setFrame:CGRectMake(0, 0, 100, 20)];
    //[cell.lbl2 setFrame:CGRectMake(0, 0, 100, 20)];
    //[cell.lbl3 setFrame:CGRectMake(0, 0, 100, 20)];
    cell.lbl1.tag=0;
    [cell.lbl2 setText:@"Cayegory 2"];
    cell.lbl2.tag=0;
    [cell.lbl3 setText:@"Cayegory 3"];
    cell.lbl3.tag=0;
    
	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

-(void)callArrangeTop{
    
    profileImage=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 80, 120)];
    [profileImage setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:profileImage];    
    
}

-(void)viewWillAppear:(BOOL)animated{
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
