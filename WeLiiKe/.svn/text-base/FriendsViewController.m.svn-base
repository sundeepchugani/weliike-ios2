//
//  FriendsViewController.m
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"
#import "UITabBarController+hidable.h"
#import "CustomCellLikeList.h"
#import "WeLiikeWebService.h"
#import "OtherUserProfile.h"
#import "FriendEmailFbViewController.h"
#import "zoomViewController.h"

extern int checkForFB;
@implementation FriendsViewController
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
    arrayAllServerData=[[NSMutableArray alloc] init];
    
    
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleChange:)
                                                 name:@"FBGetPeople"
                                               object:nil];
}

- (void)handleChange:(NSNotification*)note {
        
        
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        //[self showLoggedOut];
    } else {
        [self showHUD];
        [self performSelector:@selector(getAllfriends) withObject:nil afterDelay:0.2];
    }

}


-(void)getAllfriends{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    

    
    //NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"SELECT uid, first_name, last_name, name, pic,pic_small, pic_big, birthday_date, sex, current_location,profile_url, email, is_app_user FROM user WHERE uid=me()", @"query",nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, first_name, last_name, name, pic,pic_small, pic_big, birthday_date, sex, current_location,profile_url, email, is_app_user FROM user WHERE uid=me()", @"query",
                                   nil];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
    
    
}


#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"received response");
}
- (void)fbDidNotLogin:(BOOL)cancelled{
    
    
}
/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        if ([result count]>0) {
            result = [result objectAtIndex:0];
            
        }
    }
    
    if ([result valueForKey:@"uid"]!=nil) {
        [[NSUserDefaults standardUserDefaults] setValue:[result valueForKey:@"uid"] forKey:@"facebookIdFB"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBIdUpdate" object:self userInfo:nil];
        [self performSelector:@selector(getfriends)];
        return;
    }
    [self killHUD];
    NSLog(@"value of result %@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        if ([result valueForKey:@"data"]!=nil) {
            //[self killHUD];
            FriendEmailFbViewController *obj=[[FriendEmailFbViewController alloc] init];
            obj.strCheckFBandEmail=@"Facebook";
            obj.dicForFriendFB=(NSDictionary*)result;
            [self.navigationController pushViewController:obj animated:YES];
            //[self performSelector:@selector(callService:) withObject:(NSDictionary*)result];
        }
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
}

-(void)getfriends{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/friends" andDelegate:self];
    
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self showHUD];
    [self performSelector:@selector(callArrangeTop)];
    [self performSelector:@selector(callServiceGroup) withObject:nil afterDelay:0.2];
    
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



-(void)callServiceGroup{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(peoplesHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service peoples:strID];
        
}

-(void)peoplesHandler:(id)sender{
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
            [self killHUD];
            if ([strForResponce count]>0 && [strForResponce isKindOfClass:[NSArray class]]) {
                arrayAllServerData=[[NSMutableArray alloc] initWithArray:strForResponce];
                arrayForAfterSearch =[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                
                [tableForSearch reloadData];
            }else if ([strForResponce isKindOfClass:[NSDictionary class]]){
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"No friend found."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                
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

-(void)actionOnUserProfile:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    NSString *str=[btn currentTitle];
    if ([str length]>0) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=str;
        [self.navigationController pushViewController:obj animated:YES];
    }
}


-(IBAction)actionOnBack:(id)sender{

    //self.tabBarController.selectedIndex=1;
    //[self.tabBarController setTabBarHidden:NO animated:NO];
   //[self.tabBarController setTabBarHidden:NO animated:NO completion:NULL];
    
}

-(IBAction)actionOnFb:(id)sender{

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    checkForFB=6;
    if (![[appDelegate facebook] isSessionValid]) {
        NSArray * permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"read_stream",@"offline_access",@"email", nil];
        [[appDelegate facebook] authorize:permissions];
    } else {
        [self showHUD];
        [self performSelector:@selector(getAllfriends) withObject:nil afterDelay:0.2];
    }
    
}
-(IBAction)actionOnEmail:(id)sender{
    
    FriendEmailFbViewController *obj=[[FriendEmailFbViewController alloc] init];
    obj.strCheckFBandEmail=@"Email";
    [self.navigationController pushViewController:obj animated:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    //[self.tabBarController setTabBarHidden:YES animated:NO];
    //[self.tabBarController setTabBarHidden:YES animated:NO completion:NULL];
} 
-(void)viewWillDisappear:(BOOL)animated{
    //[self.tabBarController setTabBarHidden:NO animated:NO];
    //[self.tabBarController setTabBarHidden:NO animated:NO completion:NULL];
}

-(void)callArrangeTop{
    
    id sender=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"];
    NSLog(@"sender %@",sender);
    if ([sender isKindOfClass:[NSString class]]) {
        lblForUserName.text=sender;
    }
    //coverImg=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 320, 100)];
    [coverImg setBackgroundColor:[UIColor grayColor]];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"] hasPrefix:@"http://"]) {
        
        NSLog(@"value of cover image %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"]);
        [coverImg loadImage:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"]];
    }
    [coverImg addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:coverImg];
    
    NSString *strForProfile =[[NSUserDefaults standardUserDefaults] valueForKey:@"Userprofile_picture"];
    NSLog(@"value of profile image %@",strForProfile);
    profileImage=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 80, 120)];
    [profileImage loadImage:strForProfile];
    [profileImage setBackgroundColor:[UIColor whiteColor]];
    [profileImage addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
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
    //[tableForSearch setUserInteractionEnabled:NO];
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
    NSLog(@"searchBarSearchButtonClicked");
    [searchBar setShowsCancelButton:YES];
    [searchBar resignFirstResponder];
    for(id subview in [searchBar subviews])
    {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setEnabled:YES];
        }
    }
    NSLog(@"value of search Bar %@",searchBar.text);
    
    if (![searchBar.text isEqualToString:@""]||![searchBar.text isEqualToString:nil]) {
        
        NSString *searchText = searchBar.text;
        
        
        [self showHUD];
        [self performSelector:@selector(search_friend_on_people:) withObject:searchText afterDelay:0.2];
        
        /*
        if ([arrayForAfterSearch count]>0) {
            [arrayForAfterSearch removeAllObjects];
        }
        for (NSDictionary *sTemp in arrayAllServerData)
        {
            NSRange titleResultsRange = [[sTemp valueForKey:@"user_name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (titleResultsRange.length > 0)
                [arrayForAfterSearch addObject:sTemp];
        }
        [tableForSearch setUserInteractionEnabled:YES];
        [tableForSearch reloadData];*/
    } 
    else{
        
    }
    
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
            [self killHUD];
            if ([strForResponce count]>0) {
                arrayAllServerData=[[NSMutableArray alloc] init];
                for (int i=0; i<[strForResponce count]; i++) {
                    if ([[[strForResponce objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"NO"]) {
                        [arrayAllServerData addObject:[strForResponce objectAtIndex:i]];
                    }
                }
                
                arrayForAfterSearch =[[NSMutableArray alloc] initWithArray:arrayAllServerData copyItems:YES];
                
                [tableForSearch reloadData];
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



- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
    [searchBar resignFirstResponder];
    [self.searchBarExplore setShowsCancelButton:NO animated:YES];
//    [tableForSearch setUserInteractionEnabled:NO];
//    arrayForAfterSearch =[[NSMutableArray alloc] initWithArray:arrayAllServerData copyItems:YES];
//    [tableForSearch reloadData];
//    [tableForSearch setUserInteractionEnabled:YES];
    
    
    [self showHUD];
    [self performSelector:@selector(callServiceGroup) withObject:nil afterDelay:0.2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  [arrayForAfterSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	//static NSString *CellIdentifier1 = @"Cell1";
    FollowAndFollowingCell *cell= (FollowAndFollowingCell*)[tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[FollowAndFollowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[[arrayAllServerData objectAtIndex:indexPath.row] valueForKey:@"profile_picture"] length]>0) {
        [cell.imgProfile loadImage:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
    }
    
    [cell.imgProfile setTitle:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"friend_user_id"] forState:UIControlStateNormal];
    [cell.imgProfile setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [cell.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
    
    //[cell.imgProfile setImage:[UIImage imageNamed:[[arrayAllServerData objectAtIndex:indexPath.row] valueForKey:@"userProfile"]] forState:UIControlStateNormal];
    cell.lblName.text=[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_name"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.lblForCountEntity.hidden=YES;
    cell.imgForAddSing.hidden=NO;
    cell.imgForAddSing.frame=CGRectMake(240, 10, 40, 25);
    cell.imgForAddSing.tag=indexPath.row;
    if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
        //cell.imgBg.hidden=NO;
        [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
        
        [cell.imgForAddSing addTarget:self action:@selector(callUnfollow:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
        [cell.imgForAddSing addTarget:self action:@selector(callfollow:) forControlEvents:UIControlEventTouchUpInside];
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<[arrayForAfterSearch count]) {
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"friend_user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
}

-(void)callUnfollow:(UIButton*)btn{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(unfollowHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strFriendID=[[arrayForAfterSearch objectAtIndex:btn.tag] valueForKey:@"friend_user_id"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForAfterSearch objectAtIndex:btn.tag]];
    [dic setValue:@"NO" forKey:@"status"];
    [arrayForAfterSearch replaceObjectAtIndex:btn.tag withObject:dic];
    [tableForSearch reloadData];
    [service unfollow:strID friend_user_id:strFriendID];
    
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
                //[self showHUD];
                self.searchDisplayController.searchBar.text=@"";
                [self.searchBarExplore setShowsCancelButton:NO animated:YES];
                [self showHUD];
                [self performSelector:@selector(callServiceGroup) withObject:nil afterDelay:0.2];
                //[self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
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


-(void)callfollow:(UIButton*)btn{
    
    //NSLog(@"value of Friend ID ***************** %@",strFriend);
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(addFriendByCategoryHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strFriendID=[[arrayForAfterSearch objectAtIndex:btn.tag] valueForKey:@"friend_user_id"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForAfterSearch objectAtIndex:btn.tag]];
    [dic setValue:@"YES" forKey:@"status"];
    
    [arrayForAfterSearch replaceObjectAtIndex:btn.tag withObject:dic];
    [tableForSearch reloadData];
    [service addFriendByCategory:strID friend_user_id:strFriendID user_category_id:@""];
    
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
//                [self showHUD];
//                [self.searchDisplayController.searchBar resignFirstResponder];
//                [self.searchBarExplore setShowsCancelButton:NO animated:YES];
//               [self performSelector:@selector(callServiceGroup) withObject:nil afterDelay:0.2];
                
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



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//	
//        
//        NSMutableArray *tempArray = [[NSMutableArray alloc] init] ;
//        [tempArray addObject:@"#"];
//        [tempArray addObject:@"A"];
//        [tempArray addObject:@"B"];
//        [tempArray addObject:@"C"];
//        [tempArray addObject:@"D"];
//        [tempArray addObject:@"E"];
//        [tempArray addObject:@"F"];
//        [tempArray addObject:@"G"];
//        [tempArray addObject:@"H"];
//        [tempArray addObject:@"I"];
//        [tempArray addObject:@"J"];
//        [tempArray addObject:@"K"];
//        [tempArray addObject:@"L"];
//        [tempArray addObject:@"M"];
//        [tempArray addObject:@"N"];
//        [tempArray addObject:@"O"];
//        [tempArray addObject:@"P"];
//        [tempArray addObject:@"Q"];
//        [tempArray addObject:@"R"];
//        [tempArray addObject:@"S"];
//        [tempArray addObject:@"T"];
//        [tempArray addObject:@"U"];
//        [tempArray addObject:@"V"];
//        [tempArray addObject:@"W"];
//        [tempArray addObject:@"X"];
//        [tempArray addObject:@"Y"];
//        [tempArray addObject:@"Z"];
//        
//        //arrayOfCharacters = tempArray;
//        return tempArray;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//	
//	NSInteger count = 0;
//	
//	NSMutableArray *arrayOfCharacters = [[NSMutableArray alloc] init];
//	
//	for (int iArray = 0; iArray<[arrayForAfterSearch count]; iArray++) {
//		NSString *arrUsername =[[arrayForAfterSearch objectAtIndex:iArray] valueForKey:@"user_name"];
//		////NSLog(@"arrUSer %@",arrUsername);
//		arrUsername = [arrUsername substringToIndex:1];
//		////NSLog(@"arrUSer %@",arrUsername);
//		[arrayOfCharacters addObject:arrUsername];
//		//NSString *user = [arrUsername valueForKey:@"username"];
//	}
//	
//	for(NSString *character in arrayOfCharacters)
//		
//	{
//		if([character caseInsensitiveCompare:title] == 0){
//			NSIndexPath * ndxPath= [NSIndexPath indexPathForRow:count inSection:0];
//			[tableView scrollToRowAtIndexPath:ndxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//			return count;
//		}
//		count ++;
//	}
//    
//	return 0;
//	//return index;
//}


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
