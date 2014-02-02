//
//  PNandEmailSetting.m
//  WeLiiKe
//
//  Created by techvalens on 13/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PNandEmailSetting.h"

@implementation PNandEmailSetting
@synthesize scrollViewPN;
@synthesize friend_like_my_activity_for_pn,friend_like_my_activity_for_mail,any_one_like_my_activity_for_pn
,any_one_like_my_activity_for_mail
,friend_mention_me_in_comment_for_pn
,friend_mention_me_in_comment_for_mail
,any_one_mention_me_in_comment_for_pn
,any_one_mention_me_in_comment_for_mail
,a_friend_follow_my_category_for_pn
,friend_follow_my_category_for_mail
,any_one_friend_follow_my_category_for_pn
,any_one_friend_follow_my_category_for_mail
,a_friend_shares_a_place_tip_or_entity_with_me_for_pn
,a_friend_shares_a_place_tip_or_entity_with_me_for_mail
,any_one_shares_a_place_tip_or_entity_with_me_for_pn
,any_one_shares_a_place_tip_or_entity_with_me_for_mail
,i_receive_a_friend_request_of_friend_confirmation_for_pn
,i_receive_a_friend_request_of_friend_confirmation_for_mail
,a_new_friend_from_facebook_join_we_like_for_pn
,keep_me_up_to_date_with_welike_news_and_update_for_pn
,keep_me_up_to_date_with_welike_news_and_update_for_mail
,send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn
,send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [scrollViewPN setFrame:CGRectMake(0, 52, 320, 368)];
    [scrollViewPN setContentSize:CGSizeMake(320, 950)];
    
    NSUserDefaults *defaultValue=[NSUserDefaults standardUserDefaults];
    
    //NSDictionary *dicforKy=[defaultValue dictionaryRepresentation];
    //NSLog(@"value of all valeu of User default %@",dicforKy);
    
    [self performSelector:@selector(callForArrangeBtn)];
        // Do any additional setup after loading the view from its nib.
}
-(void)callForArrangeBtn{

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"a_friend_follow_my_category_for_mail"]) {
        [friend_follow_my_category_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [friend_follow_my_category_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [friend_follow_my_category_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [friend_follow_my_category_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_friend_follow_my_category_for_mail"]) {
        [any_one_friend_follow_my_category_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [any_one_friend_follow_my_category_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_friend_follow_my_category_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [any_one_friend_follow_my_category_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"] ) {
        [keep_me_up_to_date_with_welike_news_and_update_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [keep_me_up_to_date_with_welike_news_and_update_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [keep_me_up_to_date_with_welike_news_and_update_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [keep_me_up_to_date_with_welike_news_and_update_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
   
//      if ([[NSUserDefaults standardUserDefaults] boolForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"]) {
//          [keep_me_up_to_date_with_welike_news_and_update_for_pn setTitle:@"1" forState:UIControlStateNormal];
//          [keep_me_up_to_date_with_welike_news_and_update_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
//      }else{
//          [keep_me_up_to_date_with_welike_news_and_update_for_pn setTitle:@"0" forState:UIControlStateNormal];
//          [keep_me_up_to_date_with_welike_news_and_update_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
//      }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"friend_like_my_activity_for_mail"]) {
        [friend_like_my_activity_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [friend_like_my_activity_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [friend_like_my_activity_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [friend_like_my_activity_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"] ) {
        [i_receive_a_friend_request_of_friend_confirmation_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [i_receive_a_friend_request_of_friend_confirmation_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [i_receive_a_friend_request_of_friend_confirmation_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [i_receive_a_friend_request_of_friend_confirmation_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"]) {
        [i_receive_a_friend_request_of_friend_confirmation_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [i_receive_a_friend_request_of_friend_confirmation_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [i_receive_a_friend_request_of_friend_confirmation_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [i_receive_a_friend_request_of_friend_confirmation_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"friend_mention_me_in_comment_for_mail"]) {
        [friend_mention_me_in_comment_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [friend_mention_me_in_comment_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [friend_mention_me_in_comment_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [friend_mention_me_in_comment_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"friend_like_my_activity_for_pn"]) {
        [friend_like_my_activity_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [friend_like_my_activity_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [friend_like_my_activity_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [friend_like_my_activity_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"friend_mention_me_in_comment_for_pn"]) {
        [friend_mention_me_in_comment_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [friend_mention_me_in_comment_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [friend_mention_me_in_comment_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [friend_mention_me_in_comment_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"] ) {
        [any_one_shares_a_place_tip_or_entity_with_me_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [any_one_shares_a_place_tip_or_entity_with_me_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_shares_a_place_tip_or_entity_with_me_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [any_one_shares_a_place_tip_or_entity_with_me_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"] ) {
        [any_one_shares_a_place_tip_or_entity_with_me_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [any_one_shares_a_place_tip_or_entity_with_me_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_shares_a_place_tip_or_entity_with_me_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [any_one_shares_a_place_tip_or_entity_with_me_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_mention_me_in_comment_for_pn"]) {
        [any_one_mention_me_in_comment_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [any_one_mention_me_in_comment_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_mention_me_in_comment_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [any_one_mention_me_in_comment_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_mention_me_in_comment_for_mail"]) {
        [any_one_mention_me_in_comment_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [any_one_mention_me_in_comment_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_mention_me_in_comment_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [any_one_mention_me_in_comment_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_like_my_activity_for_pn"]) {
        [any_one_like_my_activity_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [any_one_like_my_activity_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_like_my_activity_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [any_one_like_my_activity_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_like_my_activity_for_mail"]) {
        [any_one_like_my_activity_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [any_one_like_my_activity_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_like_my_activity_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [any_one_like_my_activity_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"any_one_friend_follow_my_category_for_pn"] ) {
        [any_one_friend_follow_my_category_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [any_one_friend_follow_my_category_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [any_one_friend_follow_my_category_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [any_one_friend_follow_my_category_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"a_new_friend_from_facebook_join_we_like_for_pn"] ) {
        [a_new_friend_from_facebook_join_we_like_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [a_new_friend_from_facebook_join_we_like_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [a_new_friend_from_facebook_join_we_like_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [a_new_friend_from_facebook_join_we_like_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"] ) {
        [a_friend_shares_a_place_tip_or_entity_with_me_for_pn setTitle:@"1" forState:UIControlStateNormal];
        [a_friend_shares_a_place_tip_or_entity_with_me_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [a_friend_shares_a_place_tip_or_entity_with_me_for_pn setTitle:@"0" forState:UIControlStateNormal];
        [a_friend_shares_a_place_tip_or_entity_with_me_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"] ) {
        [a_friend_shares_a_place_tip_or_entity_with_me_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [a_friend_shares_a_place_tip_or_entity_with_me_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [a_friend_shares_a_place_tip_or_entity_with_me_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [a_friend_shares_a_place_tip_or_entity_with_me_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"]) {
        [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail setTitle:@"1" forState:UIControlStateNormal];
        [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
    }else{
        [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail setTitle:@"0" forState:UIControlStateNormal];
        [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
    }
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"] ) {
//          [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn setTitle:@"1" forState:UIControlStateNormal];
//          [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal];
//    }else{
//          [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn setTitle:@"0" forState:UIControlStateNormal];
//          [send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal];
//      }

    
}
-(IBAction)friendlikemyactivityforpn:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
}
-(IBAction)friendlikemyactivityformail:(id)sender{

    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }

}
-(IBAction)anyonelikemyactivityforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anyonelikemyactivityformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)friendmentionmeincommentforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)friendmentionmeincommentformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anyonementionmeincommentforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anyonementionmeincommentformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)afriendfollowmycategoryforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)friendfollowmycategoryformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anyonefriendfollowmycategoryforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anyonefriendfollowmycategoryformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)afriendsharesaplacetiporentitywithmeforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)afriendsharesaplacetiporentitywithmeformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anyonesharesaplacetiporentitywithmeforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anyonesharesaplacetiporentitywithmeformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)ireceiveafriendrequestoffriendconfirmationforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)ireceiveafriendrequestoffriendconfirmationformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)anewfriendfromfacebookjoinwelikeforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)keepmeuptodatewithwelikenewsandupdateforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)keepmeuptodatewithwelikenewsandupdateformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)sendmeweeklyupdatesaboutwhatsmyfriendsareuptoforpn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}
-(IBAction)sendmeweeklyupdatesaboutwhatsmyfriendsareuptoformail:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([[btn currentTitle] isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box_blnk.png"] forState:UIControlStateNormal]; 
    }else{
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chk_box2.png"] forState:UIControlStateNormal]; 
    }
    
}

-(IBAction)saveStatus:(id)sender{

    [self performSelector:@selector(callService)];
    
}

-(void)callService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(UpdateHandler:)];
        
    NSLog(@"value of titile %@",[friend_like_my_activity_for_mail currentTitle]);
    NSLog(@"value of titile %@",[any_one_like_my_activity_for_pn currentTitle]);
    NSLog(@"value of titile %@",[any_one_like_my_activity_for_mail currentTitle]);
    NSLog(@"value of titile %@",[friend_mention_me_in_comment_for_pn currentTitle]);
    NSLog(@"value of titile %@",[friend_follow_my_category_for_mail currentTitle]);
    NSLog(@"value of titile %@",[any_one_mention_me_in_comment_for_pn currentTitle]);
    NSLog(@"value of titile %@",[any_one_mention_me_in_comment_for_mail currentTitle]);
    NSLog(@"value of titile %@",[a_friend_follow_my_category_for_pn currentTitle]);
    NSLog(@"value of titile %@",[any_one_friend_follow_my_category_for_pn currentTitle]);
    NSLog(@"value of titile %@",[any_one_friend_follow_my_category_for_mail currentTitle]);
    NSLog(@"value of titile %@",[a_friend_shares_a_place_tip_or_entity_with_me_for_pn currentTitle]);
    
    NSLog(@"value of titile %@",[a_friend_shares_a_place_tip_or_entity_with_me_for_mail currentTitle]);
    NSLog(@"value of titile %@",[any_one_shares_a_place_tip_or_entity_with_me_for_pn currentTitle]);
    NSLog(@"value of titile %@",[any_one_shares_a_place_tip_or_entity_with_me_for_mail currentTitle]);
    NSLog(@"value of titile %@",[i_receive_a_friend_request_of_friend_confirmation_for_pn currentTitle]);
    NSLog(@"value of titile %@",[i_receive_a_friend_request_of_friend_confirmation_for_mail currentTitle]);
    NSLog(@"value of titile %@",[a_new_friend_from_facebook_join_we_like_for_pn currentTitle]);
    NSLog(@"value of titile %@",[keep_me_up_to_date_with_welike_news_and_update_for_pn currentTitle]);
    NSLog(@"value of titile %@",[keep_me_up_to_date_with_welike_news_and_update_for_mail currentTitle]);
    NSLog(@"value of titile %@",[any_one_friend_follow_my_category_for_pn currentTitle]);
    NSLog(@"value of titile %@",[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn currentTitle]);
    //NSLog(@"value of titile %@",[a_friend_shares_a_place_tip_or_entity_with_me_for_pn currentTitle]);

    
//    NSLog(@"value of titile %@",);
//    NSLog(@"value of titile %@",);
//    NSLog(@"value of titile %@",);
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
//    NSLog(@"value of titile %@");
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service Update:strID friend_like_my_activity_for_pn:[friend_like_my_activity_for_pn currentTitle] friend_like_my_activity_for_mail:[friend_like_my_activity_for_mail currentTitle] any_one_like_my_activity_for_pn:[any_one_like_my_activity_for_pn currentTitle] any_one_like_my_activity_for_mail:@"0" friend_mention_me_in_comment_for_pn:[friend_mention_me_in_comment_for_pn currentTitle] a_friend_follow_my_category_for_mail:[friend_follow_my_category_for_mail currentTitle] any_one_mention_me_in_comment_for_pn:[any_one_mention_me_in_comment_for_pn currentTitle] any_one_mention_me_in_comment_for_mail:[any_one_mention_me_in_comment_for_mail currentTitle] a_friend_follow_my_category_for_pn:[a_friend_follow_my_category_for_pn currentTitle] any_one_friend_follow_my_category_for_pn:[any_one_friend_follow_my_category_for_pn currentTitle] any_one_friend_follow_my_category_for_mail:@"0" a_friend_shares_a_place_tip_or_entity_with_me_for_pn:[a_friend_shares_a_place_tip_or_entity_with_me_for_pn currentTitle] a_friend_shares_a_place_tip_or_entity_with_me_for_mail:[a_friend_shares_a_place_tip_or_entity_with_me_for_mail currentTitle] any_one_shares_a_place_tip_or_entity_with_me_for_pn:[any_one_shares_a_place_tip_or_entity_with_me_for_pn currentTitle] any_one_shares_a_place_tip_or_entity_with_me_for_mail:[any_one_shares_a_place_tip_or_entity_with_me_for_mail currentTitle] i_receive_a_friend_request_of_friend_confirmation_for_pn:[i_receive_a_friend_request_of_friend_confirmation_for_pn currentTitle] i_receive_a_friend_request_of_friend_confirmation_for_mail:[i_receive_a_friend_request_of_friend_confirmation_for_mail currentTitle] a_new_friend_from_facebook_join_we_like_for_pn:[a_new_friend_from_facebook_join_we_like_for_pn currentTitle] fkeep_me_up_to_date_with_welike_news_and_update_for_pn:[keep_me_up_to_date_with_welike_news_and_update_for_pn currentTitle] keep_me_up_to_date_with_welike_news_and_update_for_mail:[keep_me_up_to_date_with_welike_news_and_update_for_mail currentTitle] send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn:[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn currentTitle] send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail:[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail currentTitle]];
        //[self killHUD];
}

-(void)UpdateHandler:(id)sender{
    //[self killHUD];
    
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
            
            if ([strForResponce count]>0) {
                //[self performSelector:@selector(moveNextScreen)];
                NSLog(@"value of response %@",strForResponce);
                
                NSDictionary *dic=(NSDictionary*)strForResponce;
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
                
                
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"Update settings successfully."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                
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


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
