//
//  FriendCloudViewController.m
//  WeLiiKe
//
//  Created by techvalens on 28/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FriendCloudViewController.h"
#import "OtherUserProfile.h"

@implementation FriendCloudViewController

@synthesize tableForFollowing,strForCategoryId,strForCategoryName,lblForCate,strForClass,arrayForSelectedCategory,btnForNext,strForMasterId;

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
    lblForCate.text=strForCategoryName;
    if ([strForClass isEqualToString:@"AddCate"]) {
        btnForNext.hidden=NO;
    }
    //[self performSelector:@selector(callWebService) withObject:nil afterDelay:0.5];
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)actionOnNext:(id)sender{

    if ([strForClass isEqualToString:@"AddCate"]) {
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    
        EnityUserController *obj=[[EnityUserController alloc] init];
        //NSLog(@"value of %@",[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_category_id"]);
        obj.strForCateID=strForCategoryId;
        obj.strForCateName=strForCategoryName;
        obj.strForMastCateID=strForMasterId;
        [self.navigationController pushViewController:obj animated:YES];
    }
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
}

-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetFollowingUserHandler:)];
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];    
    [service GetFollowingUser:strID user_category_id:strForCategoryId master_category_id:strForMasterId];
    
}


-(void)GetFollowingUserHandler:(id)sender{
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
                NSLog(@"value of %d",[strForResponce count]);
                arrayForServerData=[[NSMutableArray alloc] init];
                arrayForSuggestedUser=[[NSMutableArray alloc] init];
                
                for (int i=0; i<[strForResponce count]; i++) {
                    NSString *strForCateIDMast=[[strForResponce objectAtIndex:i] valueForKey:@"status"];
                    if ([strForCateIDMast isEqualToString:@"YES"]) {
                        [arrayForServerData addObject:[strForResponce objectAtIndex:i]];
                    }else{
                        NSArray *array = [arrayForServerData valueForKey:@"user_id"];
                        if (![array containsObject:[[strForResponce objectAtIndex:i] valueForKey:@"user_id"]]) {
                            
                            NSArray *array1 = [arrayForSuggestedUser valueForKey:@"user_id"];
                            if (![array1 containsObject:[[strForResponce objectAtIndex:i] valueForKey:@"user_id"]]) {
                                [arrayForSuggestedUser addObject:[strForResponce objectAtIndex:i]];
                            }
                        }
                    }
                }
                
                
                //NSLog(@"value of aara %@",arrayForServerData);
                arrayForServerDataForSugested=[[NSMutableArray alloc] initWithArray:(NSArray*)arrayForSuggestedUser];
                arrayForSearchResult=[arrayForServerData mutableCopy];
                [tableForFollowing reloadData];
                
            }else{
                //[arrayForServerData removeAllObjects];
                //[tableForFollowing reloadData];
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


-(void)actionOnUserProfile:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<[arrayForSearchResult count]) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForSearchResult objectAtIndex:btn.tag] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
}

-(void)actionOnUserProfileSug:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<[arrayForSearchResult count]) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForSuggestedUser objectAtIndex:btn.tag] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text length]>0 && [textField.text length]>1) {
        //resultObjectsArray = [NSMutableArray array];
        [arrayForSearchResult removeAllObjects];
        for(NSDictionary *wine in arrayForServerData)
        {
            NSString *wineName = [wine objectForKey:@"user_name"];
            NSRange range = [wineName rangeOfString:textField.text options:NSCaseInsensitiveSearch];
            if(range.location != NSNotFound)
                [arrayForSearchResult addObject:wine];
        }
        [tableForFollowing reloadData];
    }else if ([textField.text length]==1 && [string isEqualToString:@""]){
        [arrayForSearchResult removeAllObjects];
        arrayForSearchResult=[arrayForServerData mutableCopy];
        [tableForFollowing reloadData];
    }

    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[arrayForSearchResult removeAllObjects];
    //arrayForSearchResult=[arrayForServerData mutableCopy];
    [textField resignFirstResponder];
    //[tableForFollowing reloadData];
    return YES;
}

-(IBAction)actionOnAtoZ:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (btn.tag==0) {
        btn.tag=1;
        [btn setImage:[UIImage imageNamed:@"a-z_btnBlue.png"] forState:UIControlStateNormal];
        
        NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                    initWithKey:@"user_name"
                                    ascending:YES
                                    selector:@selector(localizedCaseInsensitiveCompare:)] ;
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
        NSArray *sortedArray = [arrayForSearchResult sortedArrayUsingDescriptors:sortDescriptors];
        arrayForSearchResult=[[NSMutableArray alloc] initWithArray:sortedArray];
        
        NSArray *sortedArray1 = [arrayForSuggestedUser sortedArrayUsingDescriptors:sortDescriptors];
        arrayForSuggestedUser=[[NSMutableArray alloc] initWithArray:sortedArray1];
        
        [tableForFollowing reloadData];
        
    }else{
        btn.tag=0;
        [btn setImage:[UIImage imageNamed:@"a-z_btn.png"] forState:UIControlStateNormal];
        arrayForSuggestedUser=[arrayForServerDataForSugested mutableCopy];
        arrayForSearchResult=[arrayForServerData mutableCopy];
        [tableForFollowing reloadData];
        
    }
    
}
-(IBAction)actionOnList:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (btn.tag==0) {
        //btnForList.tag=1;
        //[self performSelector:@selector(callWebServiceForCategory)];
    }else{
        // btnForList.tag=0;
        // [tableForFriends reloadData];
    }
    
}


-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 2;
}     

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [arrayForSearchResult count];    
    }else if (section==1){
        return [arrayForSuggestedUser count];
    }
	return  0;
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
    if (indexPath.section==0) {
        if (indexPath.row<[arrayForSearchResult count]) {
            
            NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
            
            [cell.imgProfile loadImage:strProfile];
            [cell.lblName setText:[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"user_name"]];//user_name
            cell.imgProfile.tag=indexPath.row;
            [cell.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.lblForCountEntity setTextColor:[UIColor whiteColor]];
            //[cell.lblForCountEntity setBackgroundColor:[UIColor lightGrayColor]];
            [cell.lblForCountEntity setText:[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"entity_count"] stringValue]];
            //NSLog(@"value of %@",[[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] class] description]);
            if ([[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
                cell.imgBg.hidden=NO;
            }else{
                cell.imgBg.hidden=YES;
            }
            
        }
        
    }
    
    if (indexPath.section==1) {
        
        if (indexPath.row<[arrayForSuggestedUser count]) {
            
            NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForSuggestedUser objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
            
            [cell.imgProfile loadImage:strProfile];
            cell.imgProfile.tag=indexPath.row;
            [cell.imgProfile addTarget:self action:@selector(actionOnUserProfileSug:) forControlEvents:UIControlEventTouchUpInside];
            [cell.lblName setText:[[arrayForSuggestedUser objectAtIndex:indexPath.row] valueForKey:@"user_name"]];//user_name
            [cell.lblForCountEntity setText:[[[arrayForSuggestedUser objectAtIndex:indexPath.row] valueForKey:@"entity_count"] stringValue]];
            //NSLog(@"value of %@",[[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] class] description]);
            if ([[[arrayForSuggestedUser objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
                [cell.lblForCountEntity setTextColor:[UIColor whiteColor]];
                [cell.lblForCountEntity setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
                cell.imgBg.hidden=NO;
            }else{
                [cell.lblForCountEntity setTextColor:[UIColor darkGrayColor]];
                [cell.lblForCountEntity setBackgroundColor:[UIColor lightGrayColor]];
                cell.imgBg.hidden=YES;
            }
            
        }
        
    }
    
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        NSLog(@"%@",[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"]);
        if ([[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
            
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForSearchResult objectAtIndex:indexPath.row]];
            [dic setValue:@"NO" forKey:@"status"];
            [arrayForSearchResult replaceObjectAtIndex:indexPath.row withObject:dic];
            [arrayForServerData replaceObjectAtIndex:indexPath.row withObject:dic];
            [tableForFollowing reloadData];
            [self showHUD];
            [self performSelector:@selector(callUnfollow:) withObject:[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"user_id"] afterDelay:0.2];
            
        }else{
            
        }
        
    }else if (indexPath.section==1){
        
        FollowAndFollowingCell *cell=(FollowAndFollowingCell*)[tableView cellForRowAtIndexPath:indexPath];
        [cell.lblForCountEntity setTextColor:[UIColor whiteColor]];
        [cell.lblForCountEntity setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        cell.imgBg.hidden=NO;
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForSuggestedUser objectAtIndex:indexPath.row]];
        [dic setValue:@"YES" forKey:@"status"];
        [arrayForSuggestedUser replaceObjectAtIndex:indexPath.row withObject:dic];
        [arrayForServerDataForSugested replaceObjectAtIndex:indexPath.row withObject:dic];
        [self callWebserviceFor:indexPath.row];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 30;
    }
    return  0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        
        UIView *viewForHeader=[[UIView alloc] initWithFrame:CGRectMake(0, -5, 320, 45)];
        UIImageView *imgViewForBg=[[UIImageView alloc] initWithFrame:CGRectMake(0,-5, 320, 35)];
        [imgViewForBg setImage:[UIImage imageNamed:@"nav_bottom_bar.png"]];
        [viewForHeader addSubview:imgViewForBg];
        //search_bar
        UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
        [lblForAddress setText:@"SUGGESTED"];
        [lblForAddress setFont:[UIFont boldSystemFontOfSize:14]];
        [lblForAddress setTextAlignment:UITextAlignmentLeft];
        [lblForAddress setBackgroundColor:[UIColor clearColor]];
        [lblForAddress setTextColor:[UIColor darkGrayColor]];
        [viewForHeader addSubview:lblForAddress];
        
        return viewForHeader;
    }
    return nil;
    
}

-(void)callUnfollow:(NSString*)str{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(unfollowHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    //NSString *strFriendID=[[arrayForServerData objectAtIndex:[str integerValue]] valueForKey:@"user_id"];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    
    //[[arrayForSearchResult objectAtIndex:index] setValue:@"added" forKey:@"checked"];
    [tableForFollowing reloadData];
    [service unfollow:strID friend_user_id:str];
    
    
}

-(void)unfollowHandler:(id)sender{
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
                [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
            }else{
                //[arrayForServerData removeAllObjects];
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



-(void)callWebserviceFor:(int)index{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(addFriendByCategoryHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strFriendID=[[arrayForSuggestedUser objectAtIndex:index] valueForKey:@"user_id"];
    
        [[arrayForSuggestedUser objectAtIndex:index] setValue:@"added" forKey:@"checked"];
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
            NSLog(@"value of str for %@",strForResponce);
            if ([strForResponce count]>0) {
                [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
            }else{
                //[arrayForServerData removeAllObjects];
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
