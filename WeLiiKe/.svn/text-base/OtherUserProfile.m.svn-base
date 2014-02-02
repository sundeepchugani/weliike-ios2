//
//  OtherUserProfile.m
//  WeLiiKe
//
//  Created by techvalens on 02/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "OtherUserProfile.h"
#import "MediadetailViewController.h"
#import "WeLiikeWebService.h"
#import "AddCategoryInUser.h"
#import "EnityUserController.h"
#import "AddGroupViewController.h"

@implementation OtherUserProfile

@synthesize tableViewForCategoty,lblForTitle,strForUserID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    dicForServerData=[[NSDictionary alloc] init];
}

-(IBAction)actionOnBack:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}
- (void)swipeRightAction:(id)ignored
{
    NSLog(@"Swipe Right");
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navControllerApp popViewControllerAnimated:YES];
    //add Function
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (checkForFriend==NO) {
        return 0;
    }
    int coutForArray=[arrayForGroup count];
    if (coutForArray==0) {
        return 1;
    }
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([arrayForServerData count]==0) {
        return 0;
    }
    if (section==0) {
        
        int coutForArray=[arrayForServerData count];
        if (coutForArray<=3) {
            return 1;
        }else {
            int countForRow=coutForArray/3;
            if (coutForArray%3 !=0) {
                return countForRow+1;
            }else{
                return countForRow;
            }
        }
    }
    
    if (section==1) {
        int coutForArray=[arrayForGroup count];
        if (coutForArray<=3) {
            return 1;
        }else {
            int countForRow=coutForArray/3;
            if (coutForArray%3 !=0) {
                return countForRow+1;
            }else{
                return countForRow;
            }
        }
    }
    
    return  6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    CellForWelcomeCategory *cell= (CellForWelcomeCategory*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[CellForWelcomeCategory alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    //***************************
    if (indexPath.section==0) {
        
        int countForRow=[arrayForServerData count]/3;
        if ([arrayForServerData count]%3 !=0) {
            countForRow= countForRow+1;
        }
        int coutForLoop=3;
        if (indexPath.row==countForRow-1 && [arrayForServerData count]>3 && [arrayForServerData count]%3 !=0) {
            coutForLoop=[arrayForServerData count]%3;
        }else if ([arrayForServerData count]<=3){
            coutForLoop=[arrayForServerData count];
        }
        for (int i=0; i<coutForLoop; i++) {
            
            
            if ((indexPath.row *3)+i <[arrayForServerData count]) {
                
                               
                NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_image"]];
                if (i==0 && [str hasPrefix:@"http"]) {
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.image1.tag=(indexPath.row *3)+i;
                    cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image1.layer.borderWidth=1.5;
                    [cell.image1 loadImage:str];
                    cell.imgViewForGra1.hidden=NO;
                    [cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl1 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];//category_name
                    cell.lbl1.tag=0;
                    
                }
                
                if (i==1 && [str hasPrefix:@"http"]) {
                    cell.image2.tag=(indexPath.row *3)+i;
                    [cell.image2 loadImage:str];
                    cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image2.layer.borderWidth=1.5;
                    cell.imgViewForGra2.hidden=NO;
                    [cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl2 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];
                    cell.lbl2.tag=0;
                    
                }
                
                if (i==2 && [str hasPrefix:@"http"]) {
                    
                    cell.image3.tag=(indexPath.row *3)+i;
                    [cell.image3 loadImage:str];
                    cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image3.layer.borderWidth=1.5;
                    cell.imgViewForGra3.hidden=NO;
                    [cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl3 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];
                    cell.lbl3.tag=0;
                }
            }
        }
    }
    //***************************
    
    if (indexPath.section==1) {
        
        int countForRow=[arrayForGroup count]/3;
        if ([arrayForGroup count]%3 !=0) {
            countForRow= countForRow+1;
        }
        int coutForLoop=3;
        if (indexPath.row==countForRow-1 && [arrayForGroup count]>3 && [arrayForGroup count]%3 !=0) {
            coutForLoop=[arrayForGroup count]%3;
        }else if ([arrayForGroup count]<=3){
            coutForLoop=[arrayForGroup count];
        }
        for (int i=0; i<coutForLoop; i++) {
            
            
            if ((indexPath.row *3)+i <[arrayForGroup count]) {
                
                NSString *str=[NSString stringWithFormat:@"%@",[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_image_url"]];
                if (i==0 && [str hasPrefix:@"http"]) {
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.image1.tag=(indexPath.row *3)+i;
                    cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image1.layer.borderWidth=1.5;
                    [cell.image1 loadImage:str];
                    cell.imgViewForGra1.hidden=NO;
                    [cell.image1 addTarget:self action:@selector(actionOnGroupEdit:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl1 setText:[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_name"]];//category_name
                    cell.lbl1.tag=0;
                    
                }
                
                if (i==1 && [str hasPrefix:@"http"]) {
                    cell.image2.tag=(indexPath.row *3)+i;
                    [cell.image2 loadImage:str];
                    cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image2.layer.borderWidth=1.5;
                    cell.imgViewForGra2.hidden=NO;
                    [cell.image2 addTarget:self action:@selector(actionOnGroupEdit:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl2 setText:[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_name"]];
                    cell.lbl2.tag=0;
                    
                }
                
                if (i==2 && [str hasPrefix:@"http"]) {
                    
                    cell.image3.tag=(indexPath.row *3)+i;
                    [cell.image3 loadImage:str];
                    cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image3.layer.borderWidth=1.5;
                    cell.imgViewForGra3.hidden=NO;
                    [cell.image3 addTarget:self action:@selector(actionOnGroupEdit:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl3 setText:[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_name"]];
                    cell.lbl3.tag=0;
                }
            }
        }
    }
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 30;
    }
    return  0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        
        UIView *viewForHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UIImageView *imgViewForBg=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 30)];
        [imgViewForBg setImage:[UIImage imageNamed:@"nav_bottom_bar.png"]];
        [viewForHeader addSubview:imgViewForBg];
        //search_bar
        UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
        [lblForAddress setText:@"Group"];
        [lblForAddress setFont:[UIFont boldSystemFontOfSize:14]];
        [lblForAddress setTextAlignment:UITextAlignmentLeft];
        [lblForAddress setBackgroundColor:[UIColor clearColor]];
        [lblForAddress setTextColor:[UIColor darkGrayColor]];
        [viewForHeader addSubview:lblForAddress];
        
        return viewForHeader;
    }
    return nil;
    
}



- (void)checkButtonTapped:(UIButton*)sender
{
       
    UIButton *btn=(UIButton*)sender;
    
    EnityUserController *obj=[[EnityUserController alloc] init];
    obj.strForCateID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_category_id"];
    obj.strForCateName=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"category_name"];
    obj.strForMastCateID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"master_category_id"];
    obj.strUserID=strForUserID;
    obj.strForClass=@"Other";
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

-(void)callArrangeTop{
    
    NSDictionary *dicForUser=[[dicForServerData valueForKey:@"users"] objectAtIndex:0];
    id sender=[dicForUser valueForKey:@"user_name"];
    NSLog(@"sender %@",sender);
    if ([sender isKindOfClass:[NSString class]]) {
        lblForTitle.text=sender;
    }
    //coverImg=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 320, 90)];
    [coverImg setBackgroundColor:[UIColor grayColor]];
    if ([[dicForUser valueForKey:@"cover_photo"] hasPrefix:@"http://"]) {
        
        NSLog(@"value of cover image %@",[dicForUser valueForKey:@"cover_photo"]);
        [coverImg loadImage:[dicForUser valueForKey:@"cover_photo"]];
    }
   
    [coverImg addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:coverImg];
    
    NSString *strForProfile =[dicForUser valueForKey:@"profile_picture"];
    NSLog(@"value of profile image %@",strForProfile);
    profileImage=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 80, 120)];
    [profileImage loadImage:strForProfile];
    [profileImage addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
    [profileImage setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:profileImage];
    
    if (checkForFriend==NO) {
        
        UIButton *btnForAddFriend=[[UIButton alloc] initWithFrame:CGRectMake(240, 95, 70, 35)];
        //[btnForUserName setTitle:[[arrayForData objectAtIndex:i] valueForKey:@"UserName"] forState:UIControlStateNormal];
        [btnForAddFriend.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        //[btnForAddFriend setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnForAddFriend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnForAddFriend setBackgroundColor:[UIColor clearColor]];
        [btnForAddFriend setBackgroundImage:[UIImage imageNamed:@"blank_btn.png"] forState:UIControlStateNormal];
        [btnForAddFriend setTitle:@"Follow" forState:UIControlStateNormal];
        [btnForAddFriend addTarget:self action:@selector(actionOnFollow:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnForAddFriend];
    }
    
}

-(void)actionOnFollow:(UIButton*)btn{
    [btn removeFromSuperview];
    [self showHUD];
    [self performSelector:@selector(callWebserviceForAddFriend) withObject:nil afterDelay:0.2];
    
}


-(void)callWebserviceForAddFriend{
    
    //NSLog(@"value of Friend ID ***************** %@",strFriend);
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(addFriendByCategoryHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service addFriendByCategory:strID friend_user_id:strForUserID user_category_id:@""];
    
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
            
            
            NSLog(@"value of responce %@",strForResponce);
            if ([strForResponce count]>0) {
                
                //[self.navigationController popViewControllerAnimated:YES];
                checkForFriend=YES;
                [self.tableViewForCategoty reloadData];
                
            }else{
                //[arrayForServerData removeAllObjects];
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


-(void)actionOnZoom:(UIButton*)sender{
    
    UIImage *img=[sender.imageView image];
    if (img!=nil) {
    zoomViewController *obj=[[zoomViewController alloc] init];
    obj.imgOnZoom=img;
    obj.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:obj animated:YES];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.navControllerApp.navigationBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    [self showHUD];
    [self performSelector:@selector(callServiceForOtherUser) withObject:nil afterDelay:0.2];
}

-(void)actionOnFriend:(id)sender{
    
    [self showHUD];
    [self performSelector:@selector(callWebserviceForAddFriend:) withObject:@"all" afterDelay:0.2];
    
}



-(void)callServiceForOtherUser{
   
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(other_userHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service other_user:strID other_user_id:strForUserID];
}


-(void)other_userHandler:(id)sender{
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
            //[self killHUD];
            if ([strForResponce count]>0) {
                arrayForServerData=[[NSMutableArray alloc] init];
                arrayForGroup=[[NSMutableArray alloc] init];
                dicForServerData=(NSDictionary*)strForResponce;
                arrayForServerData=[dicForServerData valueForKey:@"category"];
                arrayForGroup=[dicForServerData valueForKey:@"group"];
                
                NSDictionary *dicForUser=[[dicForServerData valueForKey:@"users"] objectAtIndex:0];
                if ([[dicForUser valueForKey:@"is_friend"] isEqualToString:@"YES"]) {
                    checkForFriend=YES;
                }else{
                    checkForFriend=NO;
                }
                [self performSelector:@selector(callArrangeTop)];
                

                
                [tableViewForCategoty reloadData];
                [self performSelector:@selector(killHUD) withObject:nil afterDelay:0];
            }else{
                [self killHUD];
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


-(void)actionOnGroupEdit:(id)sender{
    UIButton *btn=(UIButton*)sender;
    AddGroupViewController *obj=[[AddGroupViewController alloc] init];
    obj.strForCheckEdit=@"edit";
    if (btn.tag<[arrayForGroup count]) {
        obj.dicForGroupInfo=[arrayForGroup objectAtIndex:btn.tag];
        obj.strForUserID=strForUserID;
    }
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(IBAction)actionOnFeed:(id)sender{
    
    UserProfileFeedViewController *obj=[[UserProfileFeedViewController alloc] init];
    obj.strForUserId=strForUserID;
    [self.navigationController pushViewController:obj animated:YES];
    
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