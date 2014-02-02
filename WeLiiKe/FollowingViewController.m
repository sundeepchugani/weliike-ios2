//
//  FollowingViewController.m
//  WeLiiKe
//
//  Created by techvalens on 27/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FollowingViewController.h"
#import "OtherUserProfile.h"

@implementation FollowingViewController
@synthesize tableForFollowing,strForCategoryId,strForMasterID;

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
     dicForSelectedUser=[[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
}

-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetFollowingUserHandler:)];

    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetFollowingUser:strID user_category_id:strForCategoryId master_category_id:strForMasterID];
}

-(void)GetFollowingUserHandler:(id)sender{
    [self killHUD];
    NSLog(@"GetFollowingUserHandler = %@",sender);
    
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
                arrayForServerData=[[NSMutableArray alloc] init];
                arrayForSuggestedUser=[[NSMutableArray alloc] init];
                NSMutableDictionary *dicTemp=[[NSMutableDictionary alloc] init];
                
                for (int i=0; i<[strForResponce count]; i++) {
                    if ([dicTemp valueForKey:[[strForResponce objectAtIndex:i] valueForKey:@"user_id"]]==nil) {
                        [dicTemp setValue:[strForResponce objectAtIndex:i] forKey:[[strForResponce objectAtIndex:i] valueForKey:@"user_id"]];
                    }
                }
                
                for(NSString *key in dicTemp) {
                    NSDictionary *dic=[dicTemp valueForKey:key];
                    NSString *strForCateIDMast=[dic valueForKey:@"status"];
                    if ([strForCateIDMast isEqualToString:@"YES"]) {
                        [arrayForServerData addObject:dic];
                    }else{
                        [arrayForSuggestedUser addObject:dic];
                    }
                }
                arrayForServerDataForSugested=[[NSMutableArray alloc] initWithArray:(NSArray*)arrayForSuggestedUser];
                arrayForSearchResult=[arrayForServerData mutableCopy];
                [tableForFollowing reloadData];
                
                //code for sorting by entity count
                NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                            initWithKey:@"entity_count"
                                            ascending:YES
                                            selector:@selector(compare:)] ;
                
                NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
                NSArray *sortedArray = [arrayForSearchResult sortedArrayUsingDescriptors:sortDescriptors];
                arrayForSearchResult=[[NSMutableArray alloc] initWithArray:sortedArray copyItems:YES];
                
                NSArray *sortedArray1 = [arrayForSuggestedUser sortedArrayUsingDescriptors:sortDescriptors];
                arrayForSuggestedUser=[[NSMutableArray alloc] initWithArray:sortedArray1 copyItems:YES];
                
                arrayForSearchResult=[arrayForSearchResult mutableCopy];
                arrayForSuggestedUser=[arrayForSuggestedUser mutableCopy];
                [tableForFollowing reloadData];
                // end of sorting code
                
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
        return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![textField.text isEqualToString:@""]||![textField.text isEqualToString:nil]) {
        
        NSString *searchText = textField.text;
        if ([searchText length]>0) {
            userFromServer=1;
            [self showHUD];
            [textField resignFirstResponder];
            [self performSelector:@selector(search_friend_on_people:) withObject:searchText afterDelay:0.2];
            return YES;
           }
        userFromServer=0;
        [self.tableForFollowing reloadData];
        [textField resignFirstResponder];
        return YES;
        }
    else{
        
    }
    userFromServer=0;
    [self.tableForFollowing reloadData];
    [textField resignFirstResponder];
    //[tableForFollowing reloadData];
    return YES;
}
-(void)search_friend_on_people:(NSString*)name{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(searchHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service search_friend_on_people:strID user_name:name];
    
}

-(void)searchHandler:(id)sender{
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
            
            NSLog(@"value of string %@",strForResponce);
           
            if ([strForResponce count]>0) {
                arrayForServerDataSearch=[[NSMutableArray alloc] initWithArray:(NSArray*)strForResponce copyItems:YES];
                [self.tableForFollowing reloadData];
            }else{
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"No friend found."
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

-(IBAction)actionOnAtoZ:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (btn.tag==0) {
        btn.tag=1;
        [btn setImage:[UIImage imageNamed:@"a-z_btnBlue.png"] forState:UIControlStateNormal];
        
        //NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"user_name" ascending:YES];
        
        NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                    initWithKey:@"user_name"
                                    ascending:YES
                                    selector:@selector(localizedCaseInsensitiveCompare:)] ;
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
        NSArray *sortedArray = [arrayForSearchResult sortedArrayUsingDescriptors:sortDescriptors];
        arrayForSearchResult=[[NSMutableArray alloc] initWithArray:sortedArray copyItems:YES];
        
        NSArray *sortedArray1 = [arrayForSuggestedUser sortedArrayUsingDescriptors:sortDescriptors];
        arrayForSuggestedUser=[[NSMutableArray alloc] initWithArray:sortedArray1 copyItems:YES];
        
        [tableForFollowing reloadData];
        
    }else{
        btn.tag=0;
        [btn setImage:[UIImage imageNamed:@"a-z_btn.png"] forState:UIControlStateNormal];
       
        NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                    initWithKey:@"entity_count"
                                    ascending:YES
                                    selector:@selector(compare:)] ;
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
        NSArray *sortedArray = [arrayForSearchResult sortedArrayUsingDescriptors:sortDescriptors];
        arrayForSearchResult=[[NSMutableArray alloc] initWithArray:sortedArray copyItems:YES];
        
        NSArray *sortedArray1 = [arrayForSuggestedUser sortedArrayUsingDescriptors:sortDescriptors];
        arrayForSuggestedUser=[[NSMutableArray alloc] initWithArray:sortedArray1 copyItems:YES];
        
        arrayForSearchResult=[arrayForSearchResult mutableCopy];
        arrayForSuggestedUser=[arrayForSuggestedUser mutableCopy];
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
    [self callWebService];
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (userFromServer==1) {
        return 1;
    }else{
       return 2;
    }
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (userFromServer==1) {
        return [arrayForServerDataSearch count];
    }else{
        if (section==0) {
            return [arrayForSearchResult count];
        }else if (section==1){
            return [arrayForSuggestedUser count];
        }
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
    if (userFromServer==1) {
        
        if ([[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"profile_picture"] length]>0) {
            [cell.imgProfile loadImage:[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
        }
        
        [cell.imgProfile setTitle:[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"friend_user_id"] forState:UIControlStateNormal];
        [cell.imgProfile setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [cell.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
        
   
        cell.lblName.text=[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"user_name"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        cell.lblForCountEntity.hidden=YES;
        cell.imgForAddSing.hidden=NO;
        cell.imgForAddSing.frame=CGRectMake(240, 10, 40, 25);
        cell.imgForAddSing.tag=indexPath.row;
        if ([[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
            //cell.imgBg.hidden=NO;
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
//            [cell.imgForAddSing addTarget:self action:@selector(callUnfollow:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
//            [cell.imgForAddSing addTarget:self action:@selector(callfollow:) forControlEvents:UIControlEventTouchUpInside];
        }

        
    }else{
       
        
        if (indexPath.section==0) {
            if (indexPath.row<[arrayForSearchResult count]) {
                
                NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
                
                [cell.imgProfile loadImage:strProfile];
                cell.imgProfile.tag=indexPath.row;
                [cell.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                [cell.lblName setText:[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"user_name"]];//user_name
                [cell.lblForCountEntity setTextColor:[UIColor whiteColor]];
                //[cell.lblForCountEntity setBackgroundColor:[UIColor lightGrayColor]];
                [cell.lblForCountEntity setText:[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"entity_count"] stringValue]];
                
                
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
                    //              [arrayForSearchResult addObject:[arrayForSuggestedUser objectAtIndex:indexPath.row]];
                    //                [arrayForSuggestedUser removeObjectAtIndex:indexPath.row];
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

    
    
    }
       
        
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (userFromServer==1) {
        
        if ([[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForServerDataSearch objectAtIndex:indexPath.row]];
            [dic setValue:@"NO" forKey:@"status"];
            [arrayForServerDataSearch replaceObjectAtIndex:indexPath.row withObject:dic];
            [tableForFollowing reloadData];
            [self showHUD];
            NSLog(@"array for server data = = = = %@", arrayForServerData);
            [self performSelector:@selector(callUnfollow:) withObject:[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"friend_user_id"] afterDelay:0.2];
        }else if ([[[arrayForServerDataSearch objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"NO"]) {
            
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForServerDataSearch objectAtIndex:indexPath.row]];
            [dic setValue:@"YES" forKey:@"status"];
            [arrayForServerDataSearch replaceObjectAtIndex:indexPath.row withObject:dic];
            [tableForFollowing reloadData];
            [self showHUD];
            [self callWebserviceFor:indexPath.row];
        }
    }else{
        
        if (indexPath.section==0) {
            
            if ([[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
                
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForSearchResult objectAtIndex:indexPath.row]];
                [dic setValue:@"NO" forKey:@"status"];
                [arrayForSearchResult replaceObjectAtIndex:indexPath.row withObject:dic];
                [arrayForServerData replaceObjectAtIndex:indexPath.row withObject:dic];
                [self showHUD];
                [self performSelector:@selector(callUnfollow:) withObject:[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"user_id"] afterDelay:0.2];
                [tableForFollowing reloadData];
 
            }else{
                
            }
            
        }else if (indexPath.section==1){
            
            if ([dicForSelectedUser valueForKey:[[arrayForSuggestedUser objectAtIndex:indexPath.row] valueForKey:@"user_id"]]==nil) {
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForSuggestedUser objectAtIndex:indexPath.row]];
                [dic setValue:@"YES" forKey:@"status"];
                
                [dicForSelectedUser setValue:dic forKey:[dic valueForKey:@"user_id"]];
                
                [arrayForSuggestedUser replaceObjectAtIndex:indexPath.row withObject:dic];
                [arrayForServerDataForSugested replaceObjectAtIndex:indexPath.row withObject:dic];
                
            }else{
                
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForSuggestedUser objectAtIndex:indexPath.row]];
                [dic setValue:@"NO" forKey:@"status"];
                
                [dicForSelectedUser setValue:nil forKey:[dic valueForKey:@"user_id"]];
                
                [arrayForSuggestedUser replaceObjectAtIndex:indexPath.row withObject:dic];
                [arrayForServerDataForSugested replaceObjectAtIndex:indexPath.row withObject:dic];
                
            }
            
            //        [self callWebserviceFor:indexPath.row];
            
        }

    
    }
    
        [tableView reloadData];
    
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
    if (btn.tag<[arrayForSuggestedUser count]) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForSuggestedUser objectAtIndex:btn.tag] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
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
    NSString *strFriendID=@"";
    
    if (userFromServer==1) {
        strFriendID=[[arrayForServerDataSearch objectAtIndex:index] valueForKey:@"friend_user_id"];
    }else{
        strFriendID=[[arrayForSuggestedUser objectAtIndex:index] valueForKey:@"user_id"];
    }
    
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
                
                dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
                });
                
                
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

- (IBAction)actionOnDone:(id)sender {

    [self.view endEditing:YES];
    if (userFromServer==1) {
        userFromServer=0;
        [self.tableForFollowing reloadData];
    }else{
        if ([dicForSelectedUser count]>0) {
            [self showHUD];
            [self callWebserviceAddFriends];
        }else{
            
            
        }
    }
    

}


-(void)callWebserviceAddFriends{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(callWebserviceAddFriendsHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    NSMutableArray *arrayForUserID=[NSMutableArray array];
    
    for (NSString *key in dicForSelectedUser) {
        [arrayForUserID addObject:key];
    }
    NSString *strForFriendsKey=[arrayForUserID componentsJoinedByString:@","];
    [dicForSelectedUser removeAllObjects];
    //NSString *strFriendID=[[arrayForSuggestedUser objectAtIndex:index] valueForKey:@"user_id"];
    //[[arrayForSuggestedUser objectAtIndex:index] setValue:@"added" forKey:@"checked"];
    //    [tableForFollowing reloadData];
    [service addFriendByCategory:strID friend_user_id:strForFriendsKey user_category_id:strForCategoryId];
}

-(void)callWebserviceAddFriendsHandler:(id)sender{
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
                
                
                //                obj.strForCategoryId=[[arrayForCateSelected objectAtIndex:0] valueForKey:@"user_category_id"];
                //                obj.strForCategoryName=[[arrayForCateSelected objectAtIndex:0] valueForKey:@"user_category_name"];
                //                obj.strForMasterId=[[arrayForCateSelected objectAtIndex:0] valueForKey:@"master_category_id"];
                                
                [self.navigationController popViewControllerAnimated:YES];
                //[self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
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
                [self.navigationController popViewControllerAnimated:YES];
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


@end
