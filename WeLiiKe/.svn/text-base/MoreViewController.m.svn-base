//
//  MoreViewController.m
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "PrivacyAndTerm.h"
#import "AccountProfileController.h"
#import "LoginDeatilController.h"
#import "FeedbackViewController.h"
#import "ShareSettingController.h"
#import "PNandEmailSetting.h"

BOOL logoutCheck;
@implementation MoreViewController
@synthesize scrollViewSetting;

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
-(void)actionOnLogout:(id)sender{

    
    NSUserDefaults *defaultUser=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=[defaultUser dictionaryRepresentation];
    //NSLog(@"value of Dic %@",dic);
    for (id key in dic) {
        //[[NSUserDefaults standardUserDefaults] setValue:nil forKey:key];
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
   
    if ([appDelegate.facebook.session isOpen]) {
        [appDelegate.facebook.session closeAndClearTokenInformation];
        [appDelegate.facebook.session close];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"FBAccessTokenKey"];
    [defaults setObject:nil forKey:@"FBExpirationDateKey"];
    [defaults synchronize];

    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"TwitterUserName"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"FacebookUserName"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"popEntity"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FBPost"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TWPost"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userprofile_picture"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userbio"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"UserEmail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userbirthday"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Usercity"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Usergender"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Usermobile_no"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userfirst_name"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userlast_name"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userwebsite"];//phone
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userphone"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Usergeotag_post"];
    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"privacy"] forKey:@"Userprivacy"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Usersave_photo_phone"];
    
    //geotag_post
    //privacy = 0;
    //"save_photo_phone" = 1;
    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"UserCover_photo"];
   
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"a_friend_follow_my_category_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"a_friend_follow_my_category_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"a_new_friend_from_facebook_join_we_like_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_friend_follow_my_category_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_friend_follow_my_category_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_like_my_activity_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_like_my_activity_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_mention_me_in_comment_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_mention_me_in_comment_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"friend_like_my_activity_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"friend_like_my_activity_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"friend_mention_me_in_comment_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"friend_mention_me_in_comment_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"];

    
    //[[FacebookController sharedController] logout];
    //[[TwitterHelper sharedController] logOut];
    logoutCheck=YES;
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [[delegate.tabBarController.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:NO];
    [[delegate.tabBarController.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:NO];
    [[delegate.tabBarController.viewControllers objectAtIndex:2] popToRootViewControllerAnimated:NO];
    [[delegate.tabBarController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
    [[delegate.tabBarController.viewControllers objectAtIndex:4] popToRootViewControllerAnimated:NO];

    //NSArray *array=delegate.navControllerApp.viewControllers;
    //[delegate.navControllerApp popToViewController:[array objectAtIndex:1] animated:YES];
    [delegate.navControllerApp popToRootViewControllerAnimated:YES];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scrollViewSetting setFrame:CGRectMake(0, 96, 320, 367)];
    [scrollViewSetting setContentSize:CGSizeMake(320, 400)];
    //AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
               
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)actionOnYourProfile:(id)sender{
    AccountProfileController *obj=[[AccountProfileController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];

}
-(IBAction)actionOnChangePassAndLogin:(id)sender{

    LoginDeatilController *obj=[[LoginDeatilController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];

}
-(IBAction)actionOnShareSetting:(id)sender{

    ShareSettingController *obj=[[ShareSettingController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];

}
-(IBAction)actionOnPushNotification:(id)sender{
    PNandEmailSetting *obj=[[PNandEmailSetting alloc] init];
    [self.navigationController pushViewController:obj animated:YES];

}
-(IBAction)actionOnAboutTermService:(id)sender{

    PrivacyAndTerm *obj=[[PrivacyAndTerm alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}
-(IBAction)actionOnFeedback:(id)sender{

    FeedbackViewController *obj=[[FeedbackViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
