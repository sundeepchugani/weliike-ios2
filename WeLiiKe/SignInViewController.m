//
//  SignInViewController.m
//  WeLiiKe
//
//  Created by techvalens on 12/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SignInViewController.h"
#import "WelcomeSearchScreen.h"
#import "WeLiikeWebService.h"

BOOL checkForLogInAndSignUp;
BOOL checkForLogIn;

@implementation SignInViewController
@synthesize txtFieldUserName,txtFieldPassword;

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
-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)actionOnSignIn:(id)sender{
    //checkForLogInAndSignUp=YES;
    //WelcomeSearchScreen *obj=[[WelcomeSearchScreen alloc] init];
    //[self.navigationController pushViewController:obj animated:YES];
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
    
}

-(void)callWebService{

    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(LoginUserHandler:)];
    [service LoginUser:txtFieldUserName.text Password:txtFieldPassword.text];
    

    
}


-(void)LoginUserHandler:(id)sender{
    
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
            
            NSLog(@"value of %@",[[strForResponce class] description]);
            if ([strForResponce count]>0) {
                NSLog(@"value of %d",[strForResponce count]);
                if ([strForResponce count]==1) {
                    [self killHUD];
                    NSString *str=[(NSDictionary*)strForResponce  valueForKey:@"errors"];
                    NSLog(@"value of str %@",str);
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Error"
                                               message: str
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    return;
                }else{
                    NSDictionary *dic=(NSDictionary*)strForResponce;
                    NSLog(@"value of dictionary %@",dic);
                    
                    
                    NSString *strFor=[NSString stringWithFormat:@"%@",[dic valueForKey:@"profile_picture_url"]];
                    [[NSUserDefaults standardUserDefaults] setValue:strFor forKey:@"Userprofile_picture"];
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"UserName"];
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"_id"] forKey:@"UserID"];
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
            
            
            NSLog(@"value of %@",strForResponce);
            
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


-(void)moveNextScreen{

    checkForLogIn=YES;
    WelcomeSearchScreen *obj=[[WelcomeSearchScreen alloc] init];
    [self.navigationController pushViewController:obj animated:YES];

}

-(void)failWithError:(NSError *)error{

    UIAlertView *errorAlert = [[UIAlertView alloc]
    						   initWithTitle: [error localizedDescription]
    						   message: [error localizedFailureReason]
    						   delegate:nil
    						   cancelButtonTitle:@"OK"
    						   otherButtonTitles:nil];
    [errorAlert show];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==txtFieldUserName) {
        [txtFieldPassword becomeFirstResponder];
    }else if (textField==txtFieldPassword) {
        
    }else {
        
    }
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self performSelector:@selector(moveNextScreen)];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [txtFieldUserName becomeFirstResponder];
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
