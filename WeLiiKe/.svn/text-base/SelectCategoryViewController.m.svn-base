//
//  SelectCategoryViewController.m
//  WeLiiKe
//
//  Created by techvalens on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SelectCategoryViewController.h"

extern NSDictionary *dicForCategorySelected;
@implementation SelectCategoryViewController
@synthesize tableViewForCategory;

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

- (void) killHUD
{
	if(aHUD != nil ){
		[aHUD.loadingView removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        aHUD = nil;
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

//Initialize and display the progress view
- (void) showHUD
{
	if(aHUD == nil)
	{
		aHUD = [[HudView alloc]init];
        [aHUD loadingViewInView:self.view text:@"Please Wait..."];
		[aHUD setUserInteractionEnabledForSuperview:self.view.superview];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showHUD];
    [self performSelector:@selector(callWebServiceForCategory) withObject:nil afterDelay:0.2];
}

-(void)callWebServiceForCategory{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetAllCategoryByUserIDHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetAllCategoryByUserID:strID];
        
}


-(void)GetAllCategoryByUserIDHandler:(id)sender{
    
    [self performSelector:@selector(killHUD) withObject:nil afterDelay:0.2];
    if([sender isKindOfClass:[NSError class]]) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Error"
                                   message: @"Error from server please try again later."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        
    }else{
        NSError *error=nil;
        NSString *str=[sender stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        //NSLog(@"value of data %@",str);
        id strForResponce = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (error==nil) {
            NSLog(@"value of string %@",strForResponce);
            if ([strForResponce count]>0) {
                
                arrayForCategory=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                
                NSLog(@"array for %@",arrayForCategory);
                [tableViewForCategory reloadData];
                
                //arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                //[tableViewForCategoty reloadData];
            }else{
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Error"
                                           message: @"Error from server please try again later."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                
            }

            
            
        }else{
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Error"
                                       message: @"Error from server please try again later."
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
            
        }
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if ([arrayForCategory count]>9 && checkSeeMore==NO) {
        return 9;
    }
    return  [arrayForCategory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    
    int index=indexPath.row;
    
    if (checkSeeMore==NO && index==8) {
        
    UITableViewCell *cellSeeMore= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cellSeeMore == nil) {
        cellSeeMore = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UIButton *btnForSeeMore=[[UIButton alloc] initWithFrame:CGRectMake(110, 2, 100, 40)];
    [btnForSeeMore setImage:[UIImage imageNamed:@"see_more.png"] forState:UIControlStateNormal];
    [btnForSeeMore addTarget:self action:@selector(actionOnSeeMore:) forControlEvents:UIControlEventTouchUpInside];
    [cellSeeMore.contentView addSubview:btnForSeeMore];
        return cellSeeMore;
    
    }
    
    
    CategoryAddCell *cell= (CategoryAddCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[CategoryAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    if ([arrayForCategory count]>index) {
        
    if ([[[arrayForCategory objectAtIndex:index] valueForKey:@"status"] isEqualToString:@"YES"]) {
        cell.lblName.textColor=[UIColor redColor];
        cell.imgAdd.hidden=YES;
        //cell.imgAdd.image=[UIImage imageNamed:@"ri8.png"];
        [cell.lblName setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        cell.lblName.text=[[arrayForCategory objectAtIndex:index] valueForKey:@"master_category_name"];
    }else{
        cell.imgAdd.hidden=YES;
        
        //[cell.lblName setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [cell.lblName setTextColor:[UIColor blackColor]];
        cell.lblName.text=[[arrayForCategory objectAtIndex:index] valueForKey:@"master_category_name"];
    }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[cell.imgProfile setImage:[UIImage imageNamed:[[arrayAllServerData objectAtIndex:index] valueForKey:@"userProfile"]] forState:UIControlStateNormal];
    //cell.lblName.text=[arrayForAfterSearch objectAtIndex:index];
    
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<[arrayForCategory count]) {
        dicForCategorySelected=[arrayForCategory objectAtIndex:indexPath.row];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (checkSeeMore==NO && indexPath.row==8) {
        return 80;
    }
    return 50;
    
}
-(void)actionOnSeeMore:(id)sender{
    
    checkSeeMore=YES;
    [tableViewForCategory reloadData];
}
-(IBAction)actionOnCancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
