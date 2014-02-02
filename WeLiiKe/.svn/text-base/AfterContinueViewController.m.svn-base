//
//  AfterContinueViewController.m
//  WeLiiKe
//
//  Created by techvalens on 12/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AfterContinueViewController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "WelcomeSearchScreen.h"
#import "AddFriendViewController.h"
extern int checkForFB;
extern BOOL checkForLogIn;
@implementation AfterContinueViewController
@synthesize signUpBtn;
@synthesize accounts,accountStore;

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

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    NSLog(@" IN view will appear");
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)actionOnCreateAccount:(id)sender{

    SignInViewController *obj=[[SignInViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(IBAction)actionOnLoginWithFB:(id)sender{
 
   AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
   
   // HackbookAppDelegate *delegate = (HackbookAppDelegate *)[[UIApplication sharedApplication] delegate];
    checkForFB=0;
    if (![[appDelegate facebook] isSessionValid]) {
        [[appDelegate facebook] authorize:permissions];
    } else {
        [self apiFQLIMe];
    }
    
}

- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    [self showHUD];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, first_name, last_name, name, pic,pic_small, pic_big, birthday_date, sex, current_location,profile_url, email, is_app_user,pic_cover FROM user WHERE uid=me()", @"query",
                                   nil];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.facebook requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}


//- (void)apiGraphUserPermissions {
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [[delegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
//}

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
- (void)fbSessionInvalidated{

}
- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt{

}

- (void)fbDidLogin{

}
- (void)fbDidLogout{

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
        
    }
    NSLog(@"value of result %@",result);
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {
        [[NSUserDefaults standardUserDefaults] setValue:[result objectForKey:@"name"] forKey:@"FacebookUserName"];
        WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(SaveUserFromFBHandler:)];
        NSString *strForCover=@"";
        if ([result valueForKey:@"pic_cover"]!=nil) {
            if ([[result valueForKey:@"pic_cover"] valueForKey:@"source"]!=nil) {
                strForCover=[[result valueForKey:@"pic_cover"] valueForKey:@"source"];
            }
        }
        //NSString *strForImageData=[self Base64Encode:imageData];
        [service SaveUserFromFB:[result valueForKey:@"first_name"] lastname:[result valueForKey:@"last_name"] Email:[result valueForKey:@"email"] facebook_id:[result valueForKey:@"uid"] gender:[result valueForKey:@"sex"] cover_photo:strForCover profile_picture:[result valueForKey:@"pic_big"]];
        
        
        return;
        // [self apiGraphUserPermissions];
    } else {
        // Processing permissions information
       // HackbookAppDelegate *delegate = (HackbookAppDelegate *)[[UIApplication sharedApplication] delegate];
       // [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
    }
    [self killHUD];
}

-(void)SaveUserFromFBHandler:(id)sender{
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
            NSLog(@"value of FB response %@",strForResponce);
            if ([strForResponce count]>0) {
                NSDictionary *dic;
                if ([strForResponce isKindOfClass:[NSArray class]]) {
                    if ([strForResponce count]>0) {
                        dic=[strForResponce objectAtIndex:0];
                    }
                }
                NSString *strFor=[NSString stringWithFormat:@"%@",[dic valueForKey:@"profile_picture_url"]];
                [[NSUserDefaults standardUserDefaults] setValue:strFor forKey:@"Userprofile_picture"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"UserName"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"user_id"] forKey:@"UserID"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"bio"] forKey:@"Userbio"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"email"] forKey:@"UserEmail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"birthday"] forKey:@"Userbirthday"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"city"] forKey:@"Usercity"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"gender"] forKey:@"Usergender"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"mobile_no"] forKey:@"Usermobile_no"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"Userfirst_name"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"last_name"] forKey:@"Userlast_name"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"website"] forKey:@"Userwebsite"];//phone
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"phone"] forKey:@"Userphone"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"geotag_post"] forKey:@"Usergeotag_post"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"privacy"] forKey:@"Userprivacy"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"save_photo_phone"] forKey:@"Usersave_photo_phone"];
                
                //geotag_post
                //privacy = 0;
                //"save_photo_phone" = 1;
                
                NSString *strFor1=[NSString stringWithFormat:@"%@",[dic valueForKey:@"cover_photo_url"]];
                [[NSUserDefaults standardUserDefaults] setValue:strFor1 forKey:@"UserCover_photo"];
                //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@""] forKey:@"UserName"];
                //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@""] forKey:@"UserName"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_follow_my_category_for_mail"] forKey:@"a_friend_follow_my_category_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_follow_my_category_for_pn"] forKey:@"a_friend_follow_my_category_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"] forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"] forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_new_friend_from_facebook_join_we_like_for_pn"] forKey:@"a_new_friend_from_facebook_join_we_like_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_friend_follow_my_category_for_mail"] forKey:@"any_one_friend_follow_my_category_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_friend_follow_my_category_for_pn"] forKey:@"any_one_friend_follow_my_category_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_like_my_activity_for_mail"] forKey:@"any_one_like_my_activity_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_like_my_activity_for_pn"] forKey:@"any_one_like_my_activity_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_mention_me_in_comment_for_mail"] forKey:@"any_one_mention_me_in_comment_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_mention_me_in_comment_for_pn"] forKey:@"any_one_mention_me_in_comment_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"] forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"] forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_like_my_activity_for_mail"] forKey:@"friend_like_my_activity_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_like_my_activity_for_pn"] forKey:@"friend_like_my_activity_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_mention_me_in_comment_for_mail"] forKey:@"friend_mention_me_in_comment_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_mention_me_in_comment_for_pn"] forKey:@"friend_mention_me_in_comment_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"] forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"] forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"] forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"] forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"] forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"] forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"];
                NSLog(@"value of already_exists %@",[[[dic valueForKey:@"already_exists"] class] description]);
                
                if ([[dic valueForKey:@"already_exists"] isEqualToString:@"1"]) {
                    checkForLogIn=YES;
                    WelcomeSearchScreen *obj=[[WelcomeSearchScreen alloc] init];
                    [self.navigationController pushViewController:obj animated:YES];
                }else{
                    [self performSelector:@selector(moveNextScreen)];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FBIdUpdate" object:self userInfo:nil];
                
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

-(void)getAllfriends{

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/friends" andDelegate:self];
    
}

-(void)postOnFb{

    // Download a sample photo
    //NSURL *url = [NSURL URLWithString:@"http://www.facebook.com/images/devsite/iphone_connect_btn.jpg"];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *img  = [UIImage imageNamed:@"Splash1.png"];
    NSData *imageData = UIImagePNGRepresentation(img);

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Test message", @"message", imageData, @"source", nil];
    [[delegate facebook] requestWithGraphPath:@"me/photos" andParams:params andHttpMethod:@"POST" andDelegate:self];

      
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   img, @"picture",
//                                   nil];
//    [params setValue:@"as gajfh jfgadsvfgjk avh" forKey:@"message"];
//    [[delegate facebook] requestWithGraphPath:@"me/photos"
//                                    andParams:params
//                                andHttpMethod:@"POST"
//                                  andDelegate:self];
    
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}

-(IBAction)actionOnLoginWithTwitter:(id)sender{
  
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
                                ACAccountStore  *accountStore1=[[ACAccountStore alloc] init];
                                ACAccountType *twitterType = [accountStore1 accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
                                NSArray *twitterAccounts = [accountStore1 accountsWithAccountType:twitterType];
                                ACAccount *account;
                                if ([twitterAccounts count]>0) {
                                    account=[twitterAccounts objectAtIndex:0];
                                }
                                [[NSUserDefaults standardUserDefaults] setValue:account.username forKey:@"TwitterUserName"];
                                [self showHUD];
                                [self fetchData];
                                //[self performSelector:@selector(fetchData)];
                                //return ;

                            });
         }else{
         
         }
     }];
  
    //[self performSelector:@selector(fetchData)];

    
}

-(void)fetchData{
    if (accountStore==nil) {
        accountStore=[[ACAccountStore alloc] init];
    }
    ACAccountType *twitterType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterType];
    ACAccount *account;
    if ([twitterAccounts count]>0) {
        account=[twitterAccounts objectAtIndex:0];
    }
    //  this is where you *should* apply the ACAccountCredential, but we're not going to
    [accountStore saveAccount:account withCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
             dispatch_sync(dispatch_get_main_queue(), ^{
                 
                 
                      [self performSelector:@selector(getNormalInfo) withObject:nil afterDelay:0];
                  });
                }else {
                //[self twitterAlert];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                   
                    [self killHUD];
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Twitter Authorisation" message:@"Please log into Twitter in the Settings please, then try again!" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
                    [alert show];
                         });

            }
        }];

}

-(void)getNormalInfo{
    
    if (accountStore==nil) {
        accountStore=[[ACAccountStore alloc] init];
    }
    ACAccountType *twitterType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterType];
    
    ACAccount *account;
    if ([twitterAccounts count]>0) {
        account=[twitterAccounts objectAtIndex:0];
    }
    NSLog(@"valeu of array **** %@",account.username);
    NSLog(@"valeu of identifier **** %@",account.identifier);
    
    /*
     
     if ([twitterAccounts count] > 0) {
     
     // Use the first account for simplicity
     ACAccount *account = [twitterAccounts objectAtIndex:0];
     
     // Now make an authenticated request to our endpoint
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
     [params setObject:@"1" forKey:@"include_entities"];
     [params setObject:account.username forKey:@"screen_name"];
     
     //  The endpoint that we wish to call
     NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"];
     
     //  Build the request with our parameter
     TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:params requestMethod:TWRequestMethodGET];
     
     // Attach the account object to this request
     [request setAccount:account];
     
     [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
     
     if (!responseData) {
     // inspect the contents of error
     NSLog(@"error = %@", error);
     }
     else {
     
     NSError *jsonError;
     
     NSArray *timeline = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError];
     
     if (timeline) {
     
     // at this point, we have an object that we can parse
     NSLog(@"timeline = %@", timeline);
     
     
     }
     
     else {
     // inspect the contents of jsonError
     NSLog(@"jsonerror = %@", jsonError);
     }
     
     }
     }];
     
     }

     
     */
    
    
    //return;
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"1" forKey:@"include_entities"];
    [params setObject:account.username forKey:@"screen_name"];
    
    TWRequest *fetchAdvancedUserProperties = [[TWRequest alloc]
                                              initWithURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"]
                                              parameters:params
                                              requestMethod:TWRequestMethodGET];
    [fetchAdvancedUserProperties setAccount:account];
    [fetchAdvancedUserProperties performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
       
        id userInfo1 = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        NSLog(@"value of URL********** %@",userInfo1);
        [self killHUD];
        if ([urlResponse statusCode] == 200) {
            NSError *error;
            id userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
            if (userInfo != nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    
                    //*************************************************
                    NSLog(@"value of twitter rsponse %@",userInfo);
                    
                    [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"name"] forKey:@"twitterName"];
                    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(SaveUserFromTwitterHandler:)];
                    //NSString *strForImageData=[self Base64Encode:imageData];
                   
                    [service SaveUserFromTwitter:[userInfo valueForKey:@"id"] screen_name:[userInfo valueForKey:@"screen_name"] name:[userInfo valueForKey:@"name"] profile_picture:[userInfo valueForKey:@"profile_image_url"] cover_photo:[userInfo valueForKey:@"profile_background_image_url"]];
                                        
                });
            }
        }else{
            [self performSelector:@selector(killHUD)];
            [self performSelector:@selector(showAlert) withObject:nil afterDelay:0.2];
             
        }
    }];
    
}
-(void)showAlert{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle: @"Error"
                               message: @"Error from server please try again later."
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [errorAlert show];
}
-(void)SaveUserFromTwitterHandler:(id)sender{
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
            NSLog(@"value of %@",strForResponce);
            
            //[self performSelector:@selector(postOnTwitter)];
            if ([strForResponce count]>0) {
                
                NSDictionary *dic;
                if ([strForResponce isKindOfClass:[NSArray class]]) {
                    if ([strForResponce count]>0) {
                        dic=[strForResponce objectAtIndex:0];
                    }
                }
                NSString *strFor=[NSString stringWithFormat:@"%@",[dic valueForKey:@"profile_picture_url"]];
                [[NSUserDefaults standardUserDefaults] setValue:strFor forKey:@"Userprofile_picture"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"UserName"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"user_id"] forKey:@"UserID"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"bio"] forKey:@"Userbio"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"email"] forKey:@"UserEmail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"birthday"] forKey:@"Userbirthday"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"city"] forKey:@"Usercity"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"gender"] forKey:@"Usergender"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"mobile_no"] forKey:@"Usermobile_no"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"Userfirst_name"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"last_name"] forKey:@"Userlast_name"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"website"] forKey:@"Userwebsite"];//phone
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"phone"] forKey:@"Userphone"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"geotag_post"] forKey:@"Usergeotag_post"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"privacy"] forKey:@"Userprivacy"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"save_photo_phone"] forKey:@"Usersave_photo_phone"];
                
                //geotag_post
                //privacy = 0;
                //"save_photo_phone" = 1;
                
                NSString *strFor1=[NSString stringWithFormat:@"%@",[dic valueForKey:@"cover_photo_url"]];
                [[NSUserDefaults standardUserDefaults] setValue:strFor1 forKey:@"UserCover_photo"];
                //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@""] forKey:@"UserName"];
                //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@""] forKey:@"UserName"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_follow_my_category_for_mail"] forKey:@"a_friend_follow_my_category_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_follow_my_category_for_pn"] forKey:@"a_friend_follow_my_category_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"] forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"] forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_new_friend_from_facebook_join_we_like_for_pn"] forKey:@"a_new_friend_from_facebook_join_we_like_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_friend_follow_my_category_for_mail"] forKey:@"any_one_friend_follow_my_category_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_friend_follow_my_category_for_pn"] forKey:@"any_one_friend_follow_my_category_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_like_my_activity_for_mail"] forKey:@"any_one_like_my_activity_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_like_my_activity_for_pn"] forKey:@"any_one_like_my_activity_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_mention_me_in_comment_for_mail"] forKey:@"any_one_mention_me_in_comment_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_mention_me_in_comment_for_pn"] forKey:@"any_one_mention_me_in_comment_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"] forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"] forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_like_my_activity_for_mail"] forKey:@"friend_like_my_activity_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_like_my_activity_for_pn"] forKey:@"friend_like_my_activity_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_mention_me_in_comment_for_mail"] forKey:@"friend_mention_me_in_comment_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_mention_me_in_comment_for_pn"] forKey:@"friend_mention_me_in_comment_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"] forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"] forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"] forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"] forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"] forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"] forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"];
                
                
                if ([[dic valueForKey:@"already_exists"] isEqualToString:@"1"]) {
                    checkForLogIn=YES;
                    WelcomeSearchScreen *obj=[[WelcomeSearchScreen alloc] init];
                    [self.navigationController pushViewController:obj animated:YES];
                }else{
                    [self performSelector:@selector(moveNextScreen)];
                }
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

-(void)postOnTwitter{

    if ([TWTweetComposeViewController canSendTweet])
    {
        // Create account store, followed by a twitter account identifier
        // At this point, twitter is the only account type available
        if (accountStore==nil) {
            accountStore=[[ACAccountStore alloc] init];
        }
        ACAccountType *twitterType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterType];
        
        if ([twitterAccounts count]>0) {
            
            ACAccount *acct = [twitterAccounts objectAtIndex:0];
            
            
            UIImage * image = [UIImage imageNamed:@"Splash1.png"];
            
            TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"] parameters:nil requestMethod:TWRequestMethodPOST];
            [postRequest setAccount:acct];
            
            //add text
            [postRequest addMultiPartData:[@"jhbfgk bdfsgkbdf kbdfg " dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data"];
            //add image
            [postRequest addMultiPartData:UIImagePNGRepresentation(image) withName:@"media" type:@"multipart/form-data"];
            
            // Set the account used to post the tweet.
            [postRequest setAccount:acct];
            
            // Post the request
            // Block handler to manage the response
            [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
             {
                 NSLog(@"Twitter response, HTTP response: %i", [urlResponse statusCode]);
             }];
            
            [self performSelector:@selector(getTwitterFriendsForAccount:) withObject:acct afterDelay:0.0];

        }
        
    }

    
    
}

-(void)getTwitterFriendsForAccount:(ACAccount*)account {
    // In this case I am creating a dictionary for the account
    // Add the account screen name
    NSMutableDictionary *accountDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:account.username, @"screen_name", nil];
    
    NSURL *followingURL = [NSURL URLWithString:@"http://api.twitter.com/1/friends/ids.json"];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:account.username, @"screen_name", nil];
    // Setup the request
    TWRequest *twitterRequest = [[TWRequest alloc] initWithURL:followingURL
                                                    parameters:parameters
                                                 requestMethod:TWRequestMethodGET];
    [twitterRequest setAccount:account];
    // Perform the request for Twitter friends
    [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (error) {
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Error"
                                       message: @"Error from server please try again later."
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
            return ;
        }
        NSError *jsonError = nil;
        // Convert the response into a dictionary
        NSDictionary *twitterFriends = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONWritingPrettyPrinted error:&jsonError];
        // Grab the Ids that Twitter returned and add them to the dictionary we created earlier
        
        [accountDictionary setObject:[twitterFriends objectForKey:@"ids"] forKey:@"friends_ids"];
        NSString *str=[[twitterFriends objectForKey:@"ids"] componentsJoinedByString:@","];
        [self getTwitterFriendsDetail:str];
        NSLog(@"%@", twitterFriends);
    }];
}
//http://api.twitter.com/1/users/lookup.json?user_id=77687121,43662011,6253282


-(void)getTwitterFriendsDetail:(NSString*)ids {
  
    NSString *str=[NSString stringWithFormat:@"http://api.twitter.com/1/users/lookup.json?user_id=%@",ids];
    NSURL *followingURL = [NSURL URLWithString:str];
    TWRequest *twitterRequest = [[TWRequest alloc] initWithURL:followingURL
                                                    parameters:nil
                                                 requestMethod:TWRequestMethodGET];
   
    [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (error) {
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Error"
                                       message: @"Error from server please try again later."
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
            return ;
        }
        NSError *jsonError = nil;
        NSDictionary *twitterFriends = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONWritingPrettyPrinted error:&jsonError];
        NSLog(@"%@", twitterFriends);
    }];
}



-(NSString *)Base64Encode:(NSData *)theData{
	const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
}


-(void)moveNextScreen{
    
    AddFriendViewController *obj=[[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];    
}




-(IBAction)actionOnLoginWithEmail:(id)sender{
    SignUpViewController *obj=[[SignUpViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleChange:)
                                                 name:@"FBLogin"
                                               object:nil];
   
    permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"read_stream",@"offline_access",@"email", nil];    
    
    [signUpBtn setHighlighted:NO];
    [signUpBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view from its nib.
}

- (void)handleChange:(NSNotification *)note {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        //[self showLoggedOut];
    } else {
        [self apiFQLIMe];
    }
    
}

- (IBAction)poststatus:(UIButton *)sender {
    NSString *message = [NSString stringWithFormat:@"Test staus update"];
    
    [FBRequestConnection startForPostStatusUpdate:message
                                completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                    
                                    [self showAlert:message result:result error:error];
                                    
                                }];
}
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = error.localizedDescription;
        alertTitle = @"Error";
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.\nPost ID: %@",
                    message, [resultDict valueForKey:@"id"]];
        alertTitle = @"Success";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
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
