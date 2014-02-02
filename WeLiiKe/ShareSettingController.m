//
//  ShareSettingController.m
//  WeLiiKe
//
//  Created by techvalens on 12/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ShareSettingController.h"
#import "EmailContects.h"


extern int checkForFB;
@implementation ShareSettingController
@synthesize lblForEmail,lblForTwitter,lblForFacebook;

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleChange:)
                                                 name:@"FBLoginSharing"
                                               object:nil];
    

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    lblForEmail.text=[NSString stringWithFormat:@"%d share",[delegate.arrayOfEmailContact count]];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"TwitterUserName"] length]>0) {
        lblForTwitter.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"TwitterUserName"];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"FacebookUserName"] length]>0) {
        lblForFacebook.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"FacebookUserName"];
        
    }
    
}
- (void)handleChange:(NSNotification *)note {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        //[self showLoggedOut];
    } else {
        [self apiFQLIMe];
    }

    
}
-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)actionOnFacebook:(id)sender{

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    // HackbookAppDelegate *delegate = (HackbookAppDelegate *)[[UIApplication sharedApplication] delegate];
    checkForFB=3;
    if (![[appDelegate facebook] isSessionValid]) {
        NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"read_stream",@"offline_access",@"email", nil];
        [[appDelegate facebook] authorize:permissions];
    } else {
        //btn.tag=1;
        //[btn setImage:[UIImage imageNamed:@"fb_selectPost.png"] forState:UIControlStateNormal];
        [self apiFQLIMe];
    }
    
}

- (void)apiFQLIMe {
    [self showHUD];
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if ([[appDelegate facebook] isSessionValid]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"SELECT uid, first_name, last_name, name, pic,pic_small, pic_big, birthday_date, sex, current_location,profile_url, email, is_app_user,pic_cover FROM user WHERE uid=me()", @"query",
                                       nil];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[delegate facebook] requestWithMethodName:@"fql.query"
                                         andParams:params
                                     andHttpMethod:@"POST"
                                       andDelegate:self];
    
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
    if ([result valueForKey:@"uid"]!=nil) {
        [[NSUserDefaults standardUserDefaults] setValue:[result valueForKey:@"uid"] forKey:@"facebookIdFB"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBIdUpdate" object:self userInfo:nil];
    }
    NSLog(@"value of result %@",result);
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {
         lblForFacebook.text=[result objectForKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setValue:[result objectForKey:@"name"] forKey:@"FacebookUserName"];
    } else {
       
    }
    [self killHUD];
}


-(IBAction)actionOnTwitter:(id)sender{

    AppDelegate *appDelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    //Get Twitter account, stored in on the device, for the first time.
    [appDelegate getTwitterAccountOnCompletion:^(ACAccount *twitterAccount)
     {
         //If we successfully retrieved a Twitter account
         if(twitterAccount)
         {
             //Make sure anything UI related happens on the main queue
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                ACAccountStore  *accountStore=[[ACAccountStore alloc] init];
                                ACAccountType *twitterType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
                                NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterType];
                                ACAccount *account;
                                if ([twitterAccounts count]>0) {
                                    account=[twitterAccounts objectAtIndex:0];
                                }
                                
                                lblForTwitter.text=account.username;
                                [[NSUserDefaults standardUserDefaults] setValue:account.username forKey:@"TwitterUserName"];
                            });
         }else{
             
         }
     }];

    
}

-(IBAction)actionOnEmail:(id)sender{
    EmailContects *obj=[[EmailContects alloc] init];
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
