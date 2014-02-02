//
//  FollowerViewController.m
//  WeLiiKe
//
//  Created by techvalens on 27/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FollowerViewController.h"
#import "OtherUserProfile.h"

@implementation FollowerViewController
@synthesize tableForFollowing,strForCategoryId,strForMasterCategoryId;

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
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
}
-(void)callWebService{
    
   WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetFollowerUserHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetFollowerUser:strID user_category_id:strForCategoryId master_category_id:strForMasterCategoryId];
    }


-(void)GetFollowerUserHandler:(id)sender{
    [self killHUD];
    
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
            
            [self killHUD];
            NSLog(@"value of aara %@",strForResponce);
            
            if ([strForResponce count]>0) {
                
                if([strForResponce isKindOfClass:[NSDictionary class]]) {
                    
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [strForResponce valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    return;
                }
                NSLog(@"value of %d",[strForResponce count]);
                arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                NSLog(@"value of aara %@",arrayForServerData);
                //arrayForSearchResult=[arrayForServerData mutableCopy];
                [tableForFollowing reloadData];
                
            }else{
                [arrayForServerData removeAllObjects];
                [tableForFollowing reloadData];
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


-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  [arrayForServerData count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    FollowAndFollowingCell *cell= (FollowAndFollowingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[FollowAndFollowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row<[arrayForServerData count]) {
        
        NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
        
        [cell.imgProfile loadImage:strProfile];
        [cell.lblName setText:[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"user_name"]];//user_name
       // [cell.lblForCountEntity setText:[[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"entity_count"] stringValue]];
        //NSLog(@"value of %@",[[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] class] description]);
        cell.lblForCountEntity.hidden=YES;
        cell.imgForAddSing.hidden=NO;
        if ([[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
            //cell.imgBg.hidden=NO;
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
        }else{
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
            //cell.imgBg.hidden=YES;
        }
        
    }
    
	return cell;
}

-(void)actionOnUserProfile:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<[arrayForServerData count]) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FollowAndFollowingCell *cell=(FollowAndFollowingCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"NO"]) {
        [cell.lblForCountEntity setTextColor:[UIColor whiteColor]];
        [cell.lblForCountEntity setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        cell.imgBg.hidden=NO;
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForServerData objectAtIndex:indexPath.row]];
        [dic setValue:@"YES" forKey:@"status"];
        [arrayForServerData replaceObjectAtIndex:indexPath.row withObject:dic];
        
        //[[arrayForServerData objectAtIndex:indexPath.row] setValue:@"YES" forKey:@"status"];
        [self showHUD];
        [self callWebserviceFor:indexPath.row];

    }else{
        //[cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"]];
        //cell.imgBg.hidden=YES;
    }
}

-(void)callWebserviceFor:(int)index{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(addFriendByCategoryHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strFriendID=[[arrayForServerData objectAtIndex:index] valueForKey:@"user_id"];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    
    [[arrayForServerData objectAtIndex:index] setValue:@"added" forKey:@"checked"];
    [tableForFollowing reloadData];
    [service addFriendByCategory:strID friend_user_id:strFriendID user_category_id:strForCategoryId];
        
}


-(void)addFriendByCategoryHandler:(id)sender{
    [self killHUD];
    
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
            [self killHUD];
            if ([strForResponce count]>0) {
                
                
            }else{
                //[arrayForServerData removeAllObjects];
                [tableForFollowing reloadData];
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"No data found."
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
