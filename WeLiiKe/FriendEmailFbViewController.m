//
//  FriendEmailFbViewController.m
//  WeLiiKe
//
//  Created by anoop gupta on 20/04/13.
//
//

#import "FriendEmailFbViewController.h"

@interface FriendEmailFbViewController ()

@end

@implementation FriendEmailFbViewController
@synthesize tableForAddFriend,dicForFriendFB,strCheckFBandEmail;
@synthesize  lblForCountFriend,btnAllFriendFollow,searchBarExplore;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //arrayForContacts=[[NSMutableArray alloc] init];
    arrayAllServerData=[[NSMutableArray alloc] init];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self showHUD];
    if ([strCheckFBandEmail isEqualToString:@"Facebook"]) {
        [self performSelector:@selector(callService:) withObject:dicForFriendFB afterDelay:0.2];
    }else {
        [self performSelector:@selector(collectContacts) withObject:nil afterDelay:0.2];
    }
}
-(IBAction)actionOnBack:(id)sender
{
    [self showHUD];
    [self performSelector:@selector(callWebserviceForAddFriend:) withObject:@"" afterDelay:0.2];
    
}

-(void)collectContacts
{
   
    if (ABAddressBookRequestAccessWithCompletion != NULL) { 
    
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                // First time access has been granted, add the contact
                [self _addContactToAddressBook];
            });
        }
        else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            // The user has previously given access, add the contact
            [self _addContactToAddressBook];
        }
        else {
            // The user has previously denied access
            // Send an alert telling user to change privacy setting in settings app
            [self killHUD];
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Message"
                                       message: @"Please change privacy setting in setting app."
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
        }

        
    
    }else{
        [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please change privacy setting in setting app."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];

    
    }
    
    
}

-(void)_addContactToAddressBook{

    if ([arrayForContacts count]>0) {
        [arrayForContacts removeAllObjects];
    }
    arrayForContacts=[[NSMutableArray alloc] init];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    CFArrayRef people  = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for(int i = 0;i<ABAddressBookGetPersonCount(addressBook);i++)
    {
        NSMutableDictionary *myAddressBook = [[NSMutableDictionary alloc] init];
        ABRecordRef ref = CFArrayGetValueAtIndex(people, i);
        
        NSString *firstName = (__bridge NSString *)ABRecordCopyValue(ref,kABPersonFirstNameProperty);
        NSString *lastName = (__bridge NSString *)ABRecordCopyValue(ref,kABPersonLastNameProperty);
        
        if ([firstName length]==0 || firstName==nil) {
            firstName=@"";
        }
        if ([lastName length]==0 || lastName==nil) {
            lastName=@"";
        }
        NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(ref);
        
        UIImage  *img = [UIImage imageWithData:imgData];
        if (img !=nil) {
            [myAddressBook setObject:img forKey:@"picture"];
            
        }else{
            [myAddressBook setObject:[UIImage imageNamed:@"default_user.png"] forKey:@"picture"];
        }
        [myAddressBook setObject:firstName forKey:@"firstName"];
        [myAddressBook setObject:lastName forKey:@"lastName"];
        ABMultiValueRef emails = ABRecordCopyValue(ref, kABPersonEmailProperty);
        NSMutableArray *arEmail = [[NSMutableArray alloc] init];
        for(CFIndex idx = 0; idx < ABMultiValueGetCount(emails); idx++)
        {
            CFStringRef emailRef = ABMultiValueCopyValueAtIndex(emails, idx);
            NSString *strLbl = (__bridge NSString*) ABAddressBookCopyLocalizedLabel (ABMultiValueCopyLabelAtIndex (emails, idx));
            NSString *strEmail_old = (__bridge NSString*)emailRef;
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
            [temp setObject:strEmail_old forKey:@"strEmail_old"];
            [temp setObject:strLbl forKey:@"strLbl"];
            [arEmail addObject:temp];
            // [temp release];
        }
        if ([arEmail count]>0) {
            [myAddressBook setObject:arEmail forKey:@"Email"];
            [arrayForContacts addObject:myAddressBook];
        }
        
    }
    NSLog(@"value of array %@",arrayForContacts);
    [self performSelector:@selector(callAddFriendFromCont) withObject:nil afterDelay:0.2];

    
}

-(void)callAddFriendFromCont{
    
    NSMutableArray *arrayForFinalEmail=[[NSMutableArray alloc] init];
    
    for (int i=0; i<[arrayForContacts count]; i++) {
        NSArray *arrayForEmail=[[arrayForContacts objectAtIndex:i] valueForKey:@"Email"];
        if ([arrayForEmail count]>0) {
            NSString *strForEmail=[NSString stringWithFormat:@"%@",[[arrayForEmail objectAtIndex:0] valueForKey:@"strEmail_old"]];
            [arrayForFinalEmail addObject:strForEmail];
        }
    }
    NSString *strEmail=[arrayForFinalEmail componentsJoinedByString:@","];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];   
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(AddFriendEmailHandler:)];
    [service AddFriendEmail:strEmail user_id:strID];
    }


-(void)AddFriendEmailHandler:(id)sender{
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
            NSLog(@"value of response %@",strForResponce);
            if ([strForResponce count]>0) {
                
                if ([strForResponce isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic=(NSDictionary*)strForResponce;
                    if ([dic valueForKey:@"message"] != nil) {
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle: @"Message"
                                                   message: @"None of your contacts are on Welike yet"
                                                   delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
                        [errorAlert show];
                        //return;
                        arrayForAfterSearch=[[NSMutableArray alloc] init];
                    }
                    
                }else{
                    arrayForAfterSearch=[[NSMutableArray alloc] initWithArray:strForResponce];
                }
                
                
                
                
                for (int i=0; i<[arrayForContacts count]; i++) {
                    
                    NSArray *arrayForEmail=[[arrayForContacts objectAtIndex:i] valueForKey:@"Email"];
                    NSString *strForEmail=@"";
                    if ([arrayForEmail count]>0) {
                        strForEmail=[NSString stringWithFormat:@"%@",[[arrayForEmail objectAtIndex:0] valueForKey:@"strEmail_old"]];
                        
                    }
                    BOOL check=NO;
                    for (int j=0; j<[arrayForAfterSearch count]; j++) {
                        
                        if ([[[arrayForAfterSearch objectAtIndex:j] valueForKey:@"email"] isEqualToString:strForEmail]) {
                            check=YES;
                        }
                        
                    }
                    if (check!=YES) {
                        NSMutableDictionary *dicForData=[[NSMutableDictionary alloc] init];
                        [dicForData setValue:[[arrayForContacts objectAtIndex:i] valueForKey:@"picture"] forKey:@"profile_picture_url"];
                        [dicForData setValue:[NSString stringWithFormat:@"%@ %@",[[arrayForContacts objectAtIndex:i] valueForKey:@"firstName"],[[arrayForContacts objectAtIndex:i] valueForKey:@"lastName"]] forKey:@"user_name"];
                        [dicForData setValue:@"invite" forKey:@"is_friend"];
                        [dicForData setValue:strForEmail forKey:@"email"];
                        [arrayForAfterSearch addObject:dicForData];
                    }                    
                }
        
                //********************************
                NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                            initWithKey:@"user_name"
                                            ascending:YES
                                            selector:@selector(localizedCaseInsensitiveCompare:)] ;
                
                NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
                NSArray *sortedArray = [arrayForAfterSearch sortedArrayUsingDescriptors:sortDescriptors];
                arrayForAfterSearch=[[NSMutableArray alloc] initWithArray:sortedArray copyItems:YES];
                arrayAllServerData=[arrayForAfterSearch mutableCopy];
                
                [tableForAddFriend reloadData];
                
                NSLog(@"value of array ********* %@",arrayForAfterSearch);
                
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

-(void)callService:(NSDictionary *)dic{
    
    NSArray *arrayForData=[dic valueForKey:@"data"];
    
    NSMutableArray *arrayForId=[[NSMutableArray alloc] init];
    
    for (int i=0; i<[arrayForData count]; i++) {
        NSDictionary *dict=[arrayForData objectAtIndex:i];
        [arrayForId addObject:[dict valueForKey:@"id"]];
    }
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strId=[arrayForId componentsJoinedByString:@","];
    //NSArray *array=[[[dic valueForKey:@"paging"] objectAtIndex:0] componentsSeparatedByString:@"/"];
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(AddFriendHandler:)];
    NSString *strForID=[[NSUserDefaults standardUserDefaults] valueForKey:@"facebookIdFB"];
    [service AddFriend:strId facebook_id:strForID user_id:strID];

}


-(void)AddFriendHandler:(id)sender{
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
            NSLog(@"value of response %@",strForResponce);
            if ([strForResponce count]>0) {
                NSDictionary *dic=(NSDictionary*)strForResponce;
                if ([strForResponce isKindOfClass:[NSDictionary class]]) {
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [dic valueForKey:@"status"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    //return;
                    arrayForAfterSearch=[[NSMutableArray alloc] init];
                }else{
                arrayForAfterSearch=[[NSMutableArray alloc] initWithArray:strForResponce];
                }
                
                
                
                NSMutableArray *arrayForData=[[NSMutableArray alloc] initWithArray:[dicForFriendFB valueForKey:@"data"]];
                NSLog(@"COunt of FB friends %d",[arrayForData count]);
                for (int i=0; i<[arrayForData count]; i++) {
                    
                    NSString *fbId=[[arrayForData objectAtIndex:i] valueForKey:@"id"];
                    
                    BOOL check=NO;
                    for (int j=0; j<[arrayForAfterSearch count]; j++) {
                        
                        if ([[[arrayForAfterSearch objectAtIndex:j] valueForKey:@"facebook_id"] isEqualToString:fbId]) {
                            check=YES;
                        }
                        
                    }
                    if (check!=YES) {
                        NSMutableDictionary *dicForData=[[NSMutableDictionary alloc] init];
                        NSString *str=[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",[[arrayForData objectAtIndex:i] valueForKey:@"id"]];
                        [dicForData setValue:str forKey:@"profile_picture_url"];
                        [dicForData setValue:[[arrayForData objectAtIndex:i] valueForKey:@"id"] forKey:@"facebook_id"];
                        [dicForData setValue:[[arrayForData objectAtIndex:i] valueForKey:@"name"] forKey:@"user_name"];
                        [dicForData setValue:@"invite" forKey:@"is_friend"];
                        
                        [arrayForAfterSearch addObject:dicForData];
                    }
                    
                }
                
                NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                            initWithKey:@"user_name"
                                            ascending:YES
                                            selector:@selector(localizedCaseInsensitiveCompare:)] ;
                
                NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
                NSArray *sortedArray = [arrayForAfterSearch sortedArrayUsingDescriptors:sortDescriptors];
                arrayForAfterSearch=[[NSMutableArray alloc] initWithArray:sortedArray copyItems:YES];
                //[tableForFollowing reloadData];
                arrayAllServerData=[arrayForAfterSearch mutableCopy];
                
                NSLog(@"value of arrrat %@",arrayForAfterSearch);
                NSLog(@"COunt arrayForAfterSearch of FB friends %d",[arrayForAfterSearch count]);
                [tableForAddFriend reloadData];
                
                
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
        //[self showHUD];
        //[self performSelector:@selector(search_friend_on_people:) withObject:searchText afterDelay:0.2];
        
        
         if ([arrayForAfterSearch count]>0) {
         [arrayForAfterSearch removeAllObjects];
         }
         for (NSDictionary *sTemp in arrayAllServerData)
         {
         NSRange titleResultsRange = [[sTemp valueForKey:@"user_name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
         
         if (titleResultsRange.length > 0)
         [arrayForAfterSearch addObject:sTemp];
         }
         [tableForAddFriend setUserInteractionEnabled:YES];
         [tableForAddFriend reloadData];
    }
    else{
        
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
    [searchBar resignFirstResponder];
    [self.searchBarExplore setShowsCancelButton:NO animated:YES];
    //    [tableForSearch setUserInteractionEnabled:NO];
    arrayForAfterSearch =[[NSMutableArray alloc] initWithArray:arrayAllServerData copyItems:YES];
    [tableForAddFriend reloadData];
    //    [tableForSearch setUserInteractionEnabled:YES];
    
    
    //[self showHUD];
    //[self performSelector:@selector(callServiceGroup) withObject:nil afterDelay:0.2];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return  [arrayForAfterSearch count];
    }
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell1";
    
    UITableViewCell *cellF= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellF == nil) {
        cellF = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0) {
        
        UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:nil];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        
        if (lblForCountFriend==nil) {
            lblForCountFriend=[[RTLabel alloc] initWithFrame:CGRectMake(20, 10, 200, 50)];
        }
        NSString *strText=[NSString stringWithFormat:@"<font size=20 color ='#707070'><b>You have <font color ='0099FF'> %d </font> %@ friends on weliike</b></font>",[arrayForAfterSearch count],strCheckFBandEmail];
        [lblForCountFriend setText:strText];
        [cell addSubview:lblForCountFriend];
    
        if (btnAllFriendFollow==nil) {
          btnAllFriendFollow=[[UIButton alloc] initWithFrame:CGRectMake(210, 7, 100, 40)];
        }
        [btnAllFriendFollow setTitle:@"Invite All" forState:UIControlStateNormal];
        [btnAllFriendFollow.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [btnAllFriendFollow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnAllFriendFollow setBackgroundImage:[UIImage imageNamed:@"blank_btn.png"] forState:UIControlStateNormal];
        [btnAllFriendFollow addTarget:self action:@selector(actionOnFriend:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnAllFriendFollow];
        
        return cell;
        
    }else if (indexPath.section==1){
    
        //static NSString *CellIdentifier1 = @"Cell1";
        
        FollowAndFollowingCell *cell= (FollowAndFollowingCell*)[tableView dequeueReusableCellWithIdentifier:nil];
        
        if (cell == nil) {
            cell = [[FollowAndFollowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([strCheckFBandEmail isEqualToString:@"Facebook"]) {
            if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"profile_picture_url"] length]>0) {
                [cell.imgProfile loadImage:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"profile_picture_url"]];
            }
        }else{
            
            if ([[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_id"] !=nil){
                [cell.imgProfile loadImage:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"profile_picture_url"]];
            }else{
               [cell.imgProfile setImage:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"profile_picture_url"] forState:UIControlStateNormal];
            
            }
            
        }
        
        [cell.imgProfile setTitle:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_id"] forState:UIControlStateNormal];
        [cell.imgProfile setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        //[cell.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
        
        //[cell.imgProfile setImage:[UIImage imageNamed:[[arrayAllServerData objectAtIndex:indexPath.row] valueForKey:@"userProfile"]] forState:UIControlStateNormal];
        cell.lblName.text=[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_name"];
        cell.lblForCountEntity.hidden=YES;
        if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"is_friend"] isEqualToString:@"YES"]) {
            //cell.imgBg.hidden=NO;
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
            cell.imgForAddSing.hidden=NO;
            [cell.imgForAddSing setFrame:CGRectMake(255, 10, 40, 22)];
        }else if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"is_friend"] isEqualToString:@"invite"]) {
            
            cell.imgForAddSing.hidden=NO;
            [cell.imgForAddSing setFrame:CGRectMake(240, 8, 60, 28)];
            [cell.imgForAddSing setBackgroundImage:[UIImage imageNamed:@"blank_btn.png"] forState:UIControlStateNormal];
            [cell.imgForAddSing.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [cell.imgForAddSing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.imgForAddSing setTitle:@"Invite" forState:UIControlStateNormal];
            [cell.imgForAddSing setUserInteractionEnabled:NO];
            
        }else if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"is_friend"] isEqualToString:@"NO"]){
        
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
            cell.imgForAddSing.hidden=NO;
            [cell.imgForAddSing setFrame:CGRectMake(255, 10, 40, 22)];
        }else{
            cell.imgForAddSing.hidden=NO;
            [cell.imgForAddSing setFrame:CGRectMake(230, 8, 70, 28)];
            [cell.imgForAddSing setBackgroundImage:[UIImage imageNamed:@"blank_btn.png"] forState:UIControlStateNormal];
            [cell.imgForAddSing.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [cell.imgForAddSing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.imgForAddSing setTitle:@"Re-Invite" forState:UIControlStateNormal];
            [cell.imgForAddSing setUserInteractionEnabled:NO];
//            WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(invite_user:)];
//            NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
//            [service invite_user:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"email"] user_id:strID friend_name:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_name"]];
//            cell.imgForAddSing.hidden=YES;
        }
        [cell.imgForAddSing setUserInteractionEnabled:NO];
        //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    
    }
    return cellF;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 60;
    }
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        if (indexPath.row<[arrayForAfterSearch count]) {
        
            if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"is_friend"] isEqualToString:@"YES"]) {
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForAfterSearch objectAtIndex:indexPath.row]];
                [dic setValue:@"NO" forKey:@"is_friend"];
                [arrayForAfterSearch replaceObjectAtIndex:indexPath.row withObject:dic];
                [tableForAddFriend reloadData];//user_id
                [self showHUD];
                [self performSelector:@selector(friendUnFollow:) withObject:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_id"] afterDelay:0.2];
                
            }else if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"is_friend"] isEqualToString:@"invite"]){
                
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForAfterSearch objectAtIndex:indexPath.row]];
                [dic setValue:nil forKey:@"is_friend"];
                [arrayForAfterSearch replaceObjectAtIndex:indexPath.row withObject:dic];

                
                //[[arrayForAfterSearch objectAtIndex:indexPath.row] setValue:nil forKey:@"is_friend"];
                [tableForAddFriend reloadData];
                
                //****************** invite ******************************
                
                if ([strCheckFBandEmail isEqualToString:@"Facebook"]) {
                    [self performSelector:@selector(inviteFriend:) withObject:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"facebook_id"] afterDelay:0];
                }else {
                    
                    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(invite_user:)];
                    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
                    [service invite_user:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"email"] user_id:strID friend_name:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_name"]];
                    
                }
                
            }else if ([[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"is_friend"] isEqualToString:@"NO"]) {
                
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForAfterSearch objectAtIndex:indexPath.row]];
                [dic setValue:@"YES" forKey:@"is_friend"];
                [arrayForAfterSearch replaceObjectAtIndex:indexPath.row withObject:dic];
            }
            else {
                WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(invite_user:)];
                NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
                 [service invite_user:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"email"] user_id:strID friend_name:[[arrayForAfterSearch objectAtIndex:indexPath.row] valueForKey:@"user_name"]];
                
            }
            [tableForAddFriend reloadData];
        }
    }    
}

-(void)friendUnFollow:(NSString*)userID{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(unfollowHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service unfollow:strID friend_user_id:userID];

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
        NSLog(@"value of data %@",str);
        id strForResponce = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (error==nil) {
            
            [self killHUD];
            if ([strForResponce count]>0) {
                //[self showHUD];
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

-(void)inviteFriend:(NSString *)FbId{

    if ([strCheckFBandEmail isEqualToString:@"Facebook"]) {
        NSString *selectIDsStr = FbId;
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"It's your turn to visit the Weliike for iOS app.",  @"message",
                                       selectIDsStr, @"suggestions",
                                       nil];
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[delegate facebook] dialog:@"apprequests"
                          andParams:params
                        andDelegate:self];
        
        
    }
}



-(void)invite_user:(id)sender{
    
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
            NSLog(@"value of responce %@",strForResponce);
                        
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
    
    NSLog(@"value of result %@",result);
    
    
}

- (void)requestLoading:(FBRequest *)request{
    
    //NSLog(@"valkue iof %@",request);
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data{
    // NSLog(@"valkue iof %@",data);
}



-(void)actionOnFriend:(id)sender{
    
    [self showHUD];
    [self performSelector:@selector(callWebserviceForAddFriend:) withObject:@"all" afterDelay:0.2];

}

-(void)callWebserviceFor{
        
    NSMutableArray *arrayForFriend=[[NSMutableArray alloc] init];
    for (int i=0 ;i<[arrayForAfterSearch count]; i++) {
        //if ([key intValue]<[arrayForServerData count]) {
        if ([[[arrayForAfterSearch objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:@"added"]) {
            [arrayForFriend addObject:[[arrayForAfterSearch objectAtIndex:i] valueForKey:@"user_id"]];
        }
    }
    NSString *strFriend=[arrayForFriend componentsJoinedByString:@","];
    NSLog(@"value of Friend ID ***************** %@",strFriend);
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(addFriendByCategoryHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    [service addFriendByCategory:strID friend_user_id:strFriend user_category_id:@""];
        
    
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
            NSLog(@"value of responce %@",strForResponce);
            if ([strForResponce count]>0) {
                NSDictionary *dic=(NSDictionary*)strForResponce;
                if ([strForResponce isKindOfClass:[NSDictionary class]]) {
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [dic valueForKey:@"status"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                }
                
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


-(void)callWebserviceForAddFriend:(NSString *)strIndex{
    
    
    NSString *strForEmail=@"";
    NSString *strForFriendID=@"";
    if ([strIndex isEqualToString:@"all"]) {
        NSMutableArray *arrayForFriend=[[NSMutableArray alloc] init];
        for (int i=0 ;i<[arrayForAfterSearch count]; i++) {
            if ([[arrayForAfterSearch objectAtIndex:i] valueForKey:@"user_id"]!=nil) {
                [arrayForFriend addObject:[[arrayForAfterSearch objectAtIndex:i] valueForKey:@"user_id"]];
            }
                
        }
        strForFriendID=[arrayForFriend componentsJoinedByString:@","];
    }else{
        NSMutableArray *arrayForFriend=[[NSMutableArray alloc] init];
        for (int i=0 ;i<[arrayForAfterSearch count]; i++) {
             if ([[[arrayForAfterSearch objectAtIndex:i] valueForKey:@"is_friend"] isEqualToString:@"YES"]) {
            [arrayForFriend addObject:[[arrayForAfterSearch objectAtIndex:i] valueForKey:@"user_id"]];
             }
        }
        strForFriendID=[arrayForFriend componentsJoinedByString:@","];

    }
    if ([strForFriendID length]==0) {
        [self killHUD];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([strCheckFBandEmail isEqualToString:@"Facebook"]) {
        strForEmail=@"0";
    }else {
        strForEmail=@"1";
    }
    
    //NSLog(@"value of Friend ID ***************** %@",strFriend);
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(add_friend_form_facebook_and_emailHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if ([strForEmail isEqualToString:@"0"]) {
        [service add_friend_form_facebook_and_email:strForEmail email_friend_id:@"" user_id:strID facebook_friend_id:strForFriendID];
    }else{
        [service add_friend_form_facebook_and_email:strForEmail email_friend_id:strForFriendID user_id:strID facebook_friend_id:@""];
    }
    
       
}

-(void)add_friend_form_facebook_and_emailHandler:(id)sender{
    
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
            NSLog(@"value of responce %@",strForResponce);
            if ([strForResponce count]>0) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
