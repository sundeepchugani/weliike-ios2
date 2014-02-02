//
//  WelcomeSearchScreen.m
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "WelcomeSearchScreen.h"

extern BOOL checkForLogInAndSignUp;
extern BOOL checkForLogIn;
BOOL checkForSignUp;
@implementation WelcomeSearchScreen
@synthesize lblForUserName,searchBarExplore,tableForSearch;

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
    arrayForAllData=[[NSMutableArray alloc] initWithObjects:@"News Feed",@"My profile",@"Trens",@"Friends", nil];
    arrayForAfterSearch =[[NSMutableArray alloc] initWithArray:arrayForAllData copyItems:YES];
    [self performSelector:@selector(callArrangeTop)];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (checkForLogInAndSignUp==YES) {
        checkForLogInAndSignUp=NO;
        checkForSignUp=YES;
        [self performSelector:@selector(nextClass) withObject:nil afterDelay:0.8];
      
    } else if (checkForLogIn==YES) {
        //checkForLogInAndSignUp=NO;
        //checkForSignUp=YES;
        [self performSelector:@selector(nextClass) withObject:nil afterDelay:0.8];
        
    }
}
-(void)nextClass{

    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.tabBarController.selectedIndex=1;
    delegate.tabBarController.delegate=self;
    [self.navigationController pushViewController:delegate.tabBarController animated:NO];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    NSLog(@"value of index %d",self.tabBarController.selectedIndex);
    if (self.tabBarController.selectedIndex!=2) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}


-(void)callArrangeTop{
    
    profileImage=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 0, 80, 120)];
    [profileImage setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:profileImage];    
    
}
#pragma mark - search bar delegates
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBarExplore setShowsCancelButton:YES animated:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    //[self.searchBarExplore setFrame:CGRectMake(0, searchBarExplore.frame.origin.y-44, 320, 44)];  
    //manoj added
    [UIView commitAnimations];
    [self.view bringSubviewToFront:self.searchBarExplore];
    [tableForSearch setUserInteractionEnabled:NO];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    //searchString=searchText;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //NSLog(@"searchBarSearchButtonClicked");
    [searchBar setShowsCancelButton:YES];
    [searchBar resignFirstResponder];
    
    //NSLog(@"value of search Bar %@",searchBar.text);
    
    if (![searchBar.text isEqualToString:@""]||![searchBar.text isEqualToString:nil]) {
        
        NSString *searchText = searchBar.text;
       // NSMutableArray *searchArray = [[NSMutableArray alloc] init];
        
//        for (NSDictionary *dictionary in myArray)
//        {
//            NSString *value = [dictionary objectForKey:@"name"];
//            [searchArray addObject:value];
//        }
        if ([arrayForAfterSearch count]>0) {
            [arrayForAfterSearch removeAllObjects];
        }
        for (NSString *sTemp in arrayForAllData)
        {
            NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (titleResultsRange.length > 0)
                [arrayForAfterSearch addObject:sTemp];
        }
        [tableForSearch setUserInteractionEnabled:YES];
        [tableForSearch reloadData];
    } 
    else{
    
    }
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    //NSLog(@"searchBarCancelButtonClicked");
    [searchBar resignFirstResponder];
    [self.searchBarExplore setShowsCancelButton:NO animated:YES];
    [tableForSearch setUserInteractionEnabled:NO];
    arrayForAfterSearch =[[NSMutableArray alloc] initWithArray:arrayForAllData copyItems:YES];
    [tableForSearch reloadData];
    [tableForSearch setUserInteractionEnabled:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  [arrayForAfterSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text=[arrayForAfterSearch objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<[arrayForAfterSearch count]) {
//        if ([[arrayForAfterSearch objectAtIndex:indexPath.row] isEqualToString:@"News Feed"]) {
//            
//            AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
//            [self.navigationController pushViewController:delegate.tabBarController animated:YES];
//            
//        }
    }
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
