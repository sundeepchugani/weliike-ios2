//
//  AddFriendViewController.m
//  WeLiiKe
//
//  Created by techvalens on 09/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddFriendViewController.h"
#import "WelcomeSearchScreen.h"
#import "AggregateViewController.h"
#import "WelcomeViewController.h"
#import "FriendEmailFbViewController.h"

extern int checkForFB;
@implementation AddFriendViewController
@synthesize tableForAddFriend,lblForAddFriend;

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
    arrayForContacts=[[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleChange:)
                                                 name:@"FBGetFriend"
                                               object:nil];
    
    [self performSelector:@selector(collectContacts)];
    // Do any additional setup after loading the view from its nib.
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

-(void)collectContacts
{
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
        [myAddressBook setObject:arEmail forKey:@"Email"];
        [arrayForContacts addObject:myAddressBook];
    }
    
   //NSLog(@"value of array %@",arrayForContacts);
   //[tableViewContact reloadData];
}
-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)actionOnDone:(id)sender{
    
    WelcomeViewController *obj=[[WelcomeViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.textLabel.text=@"Facebook";
    }else if (indexPath.row==1){
        cell.textLabel.text=@"Email";
    }else if (indexPath.row==2){
        cell.textLabel.text=@"Email";
    }
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        checkForFB=1;
        if (![[appDelegate facebook] isSessionValid]) {
            NSArray * permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"read_stream",@"offline_access",@"email", nil];
            [[appDelegate facebook] authorize:permissions];
        } else {
            [self showHUD];
            [self performSelector:@selector(getAllfriends) withObject:nil afterDelay:0.2];
        }
        
		//[[FacebookController sharedController] getFriendList];
    }else if (indexPath.row==1){
        FriendEmailFbViewController *obj=[[FriendEmailFbViewController alloc] init];
        obj.strCheckFBandEmail=@"Email";
        //obj.dicForFriendFB=(NSDictionary*)result;
        [self.navigationController pushViewController:obj animated:YES];
        //[self performSelector:@selector(callAddFriendFromCont)];
        //cell.textLabel.text=@"Twitter";
    }else if (indexPath.row==2){
       // cell.textLabel.text=@"Email";
    }
}

-(void)getAllfriends{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    
    NSLog(@"value of result %@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        if ([result valueForKey:@"data"]!=nil) {
            [self killHUD];
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
                //[self performSelector:@selector(moveNextScreen)];
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"Add friend successfully."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
