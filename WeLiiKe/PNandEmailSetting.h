//
//  PNandEmailSetting.h
//  WeLiiKe
//
//  Created by techvalens on 13/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"

@interface PNandEmailSetting : UIViewController{

    UIScrollView *scrollViewPN;
    
    UIButton *friend_like_my_activity_for_pn;
    UIButton *friend_like_my_activity_for_mail; 
    UIButton *any_one_like_my_activity_for_pn; 
    UIButton *any_one_like_my_activity_for_mail ;
    UIButton *friend_mention_me_in_comment_for_pn ;
    UIButton *friend_mention_me_in_comment_for_mail; 
    UIButton *any_one_mention_me_in_comment_for_pn; 
    UIButton *any_one_mention_me_in_comment_for_mail;
    UIButton *a_friend_follow_my_category_for_pn;
    UIButton *friend_follow_my_category_for_mail;
    UIButton *any_one_friend_follow_my_category_for_pn ;
    UIButton *any_one_friend_follow_my_category_for_mail; 
    UIButton *a_friend_shares_a_place_tip_or_entity_with_me_for_pn ;
    UIButton *a_friend_shares_a_place_tip_or_entity_with_me_for_mail; 
    UIButton *any_one_shares_a_place_tip_or_entity_with_me_for_pn ;
    UIButton *any_one_shares_a_place_tip_or_entity_with_me_for_mail; 
    UIButton *i_receive_a_friend_request_of_friend_confirmation_for_pn;
    UIButton *i_receive_a_friend_request_of_friend_confirmation_for_mail;
    UIButton *a_new_friend_from_facebook_join_we_like_for_pn ;
    UIButton *keep_me_up_to_date_with_welike_news_and_update_for_pn;
    UIButton *keep_me_up_to_date_with_welike_news_and_update_for_mail ;
    UIButton *send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn; 
    UIButton *send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail;
    
}
@property(nonatomic,retain)IBOutlet UIButton *friend_like_my_activity_for_pn,*friend_like_my_activity_for_mail,*any_one_like_my_activity_for_pn
,*any_one_like_my_activity_for_mail
,*friend_mention_me_in_comment_for_pn
,*friend_mention_me_in_comment_for_mail
,*any_one_mention_me_in_comment_for_pn
,*any_one_mention_me_in_comment_for_mail
,*a_friend_follow_my_category_for_pn
,*friend_follow_my_category_for_mail
,*any_one_friend_follow_my_category_for_pn
,*any_one_friend_follow_my_category_for_mail
,*a_friend_shares_a_place_tip_or_entity_with_me_for_pn
,*a_friend_shares_a_place_tip_or_entity_with_me_for_mail
,*any_one_shares_a_place_tip_or_entity_with_me_for_pn
,*any_one_shares_a_place_tip_or_entity_with_me_for_mail
,*i_receive_a_friend_request_of_friend_confirmation_for_pn
,*i_receive_a_friend_request_of_friend_confirmation_for_mail
,*a_new_friend_from_facebook_join_we_like_for_pn
,*keep_me_up_to_date_with_welike_news_and_update_for_pn
,*keep_me_up_to_date_with_welike_news_and_update_for_mail
,*send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn
,*send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollViewPN;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)friendlikemyactivityforpn:(id)sender;
-(IBAction)friendlikemyactivityformail:(id)sender;
-(IBAction)anyonelikemyactivityforpn:(id)sender;
-(IBAction)anyonelikemyactivityformail:(id)sender;
-(IBAction)friendmentionmeincommentforpn:(id)sender;
-(IBAction)friendmentionmeincommentformail:(id)sender;
-(IBAction)anyonementionmeincommentforpn:(id)sender;
-(IBAction)anyonementionmeincommentformail:(id)sender;
-(IBAction)afriendfollowmycategoryforpn:(id)sender;
-(IBAction)friendfollowmycategoryformail:(id)sender;
-(IBAction)anyonefriendfollowmycategoryforpn:(id)sender;
-(IBAction)anyonefriendfollowmycategoryformail:(id)sender;
-(IBAction)afriendsharesaplacetiporentitywithmeforpn:(id)sender;
-(IBAction)afriendsharesaplacetiporentitywithmeformail:(id)sender;
-(IBAction)anyonesharesaplacetiporentitywithmeforpn:(id)sender;
-(IBAction)anyonesharesaplacetiporentitywithmeformail:(id)sender;
-(IBAction)ireceiveafriendrequestoffriendconfirmationforpn:(id)sender;
-(IBAction)ireceiveafriendrequestoffriendconfirmationformail:(id)sender;
-(IBAction)anewfriendfromfacebookjoinwelikeforpn:(id)sender;
-(IBAction)keepmeuptodatewithwelikenewsandupdateforpn:(id)sender;
-(IBAction)keepmeuptodatewithwelikenewsandupdateformail:(id)sender;
-(IBAction)sendmeweeklyupdatesaboutwhatsmyfriendsareuptoforpn:(id)sender;
-(IBAction)sendmeweeklyupdatesaboutwhatsmyfriendsareuptoformail:(id)sender;
-(IBAction)saveStatus:(id)sender;

@end
