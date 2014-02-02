//
//  WeLiikeWebService.h
//  WeLiiKe
//
//  Created by techvalens on 17/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeLiikeWebService: NSObject<NSURLConnectionDelegate> {
	NSMutableData *responseData;
    NSURLConnection *connection;
	id _delegate;
	SEL _callback;
}
@property(nonatomic, retain) 	id _delegate;
@property(nonatomic, assign) 	SEL _callback;
-(id)initWithDelegate:(id)delegate callback:(SEL)callback;

-(void)SaveUser:(NSString*)FirstName lastname:(NSString*)lastName Email:(NSString*)email Password:(NSString*)password profile:(NSString *)profile cover:(NSString*)cover;

-(void)SaveUserFromFB:(NSString*)FirstName lastname:(NSString*)lastName Email:(NSString*)email facebook_id:(NSString*)facebook_id gender:(NSString *)gender cover_photo:(NSString*)cover_photo  profile_picture:(NSString*)profile_picture;

-(void)SaveUserFromTwitter:(NSString*)twitter_id screen_name:(NSString*)screen_name name:(NSString*)name profile_picture:(NSString*)profile_picture cover_photo:(NSString*)cover_photo;
-(void)AddFriend:(NSString*)friends_id facebook_id:(NSString*)facebook_id  user_id:(NSString*)user_id;

-(void)AddFriendEmail:(NSString*)friendsEmail_id user_id:(NSString*)user_id;
-(void)GetEntityByCategory:(NSString*)master_category_id page:(NSString*)page user_id:(NSString*)user_id;

-(void)AddCategory:(NSString*)master_category_id user_id:(NSString*)user_id;
-(void)LoginUser:(NSString*)email Password:(NSString*)password;

-(void)AddEntity:(NSString*)master_entity_id user_id:(NSString*)user_id user_category_id:(NSString*)user_category_id;

-(void)GetFriendsByCategory:(NSString*)master_category_id;

-(void)GetCategoryByUserID:(NSString*)userID;

//curl -X POST -d "api_id=43$%&entity_name=Yogesh&comment=&address=1224&lat=22.12548&longitude=72.12489&master_category_id=5130ad0df7e4f30efe000001&entity_image=&user_id=51502b8df7e4f3ef9b000002&user_category_id=5140075bf7e4f34bd1000002&rating_count=5&group_id=&email_list=yogesh.waghmare@techvalens.com,deepak.jsadon@techvalens.com&is_new_message=1&messages=1&message_body=Hi everyone&receiver_id=51502b8df7e4f3ef9b000002" http://localhost:3000/user_entity/save_media.json

-(void)saveMedia:(NSString *)entity_name comment:(NSString*)comment address:(NSString*)address lat:(NSString*)lat longitude:(NSString*)longitude master_category_id:(NSString*)master_category_id entity_image:(NSString*)entity_image user_id:(NSString*)user_id user_category_id:(NSString*)user_category_id api_id:(NSString*)api_id rating_count:(NSString*)rating_count group_id:(NSString*)group_id email:(NSString*)email receiver_id:(NSString*)receiver_id feed:(NSString*)feed sub_category:(NSString*)sub_category city:(NSString*)city def:(BOOL)def is_active:(BOOL)is_active;

-(void)addFriendByCategory:(NSString *)user_id friend_user_id:(NSString*)friend_user_id user_category_id:(NSString*)user_category_id;


-(void)getEntityByCategoryID:(NSString *)user_id user_category_id:(NSString*)user_category_id page:(NSString*)page address:(NSString*)address;
-(void)GetAllCategoryByUserID:(NSString*)userID;
-(void)entityInfo:(NSString*)userID entityID:(NSString*)entityID;



-(void)GetAllFriendUserID:(NSString*)userID;

-(void)EntitySearch:(NSString*)charchater;


-(void)changePassword:(NSString*)email password:(NSString*)password passwordNew:(NSString*)passwordNew;

-(void)Update:(NSString*)user_id friend_like_my_activity_for_pn:(NSString*)friend_like_my_activity_for_pn friend_like_my_activity_for_mail:(NSString*)friend_like_my_activity_for_mail any_one_like_my_activity_for_pn:(NSString*)any_one_like_my_activity_for_pn any_one_like_my_activity_for_mail:(NSString*)any_one_like_my_activity_for_mail friend_mention_me_in_comment_for_pn:(NSString*)friend_mention_me_in_comment_for_pn a_friend_follow_my_category_for_mail:(NSString*)a_friend_follow_my_category_for_mail any_one_mention_me_in_comment_for_pn:(NSString*)any_one_mention_me_in_comment_for_pn any_one_mention_me_in_comment_for_mail:(NSString*)any_one_mention_me_in_comment_for_mail a_friend_follow_my_category_for_pn:(NSString*)a_friend_follow_my_category_for_pn any_one_friend_follow_my_category_for_pn:(NSString*)any_one_friend_follow_my_category_for_pn any_one_friend_follow_my_category_for_mail:(NSString*)any_one_friend_follow_my_category_for_mail a_friend_shares_a_place_tip_or_entity_with_me_for_pn:(NSString*)a_friend_shares_a_place_tip_or_entity_with_me_for_pn a_friend_shares_a_place_tip_or_entity_with_me_for_mail:(NSString*)a_friend_shares_a_place_tip_or_entity_with_me_for_mail any_one_shares_a_place_tip_or_entity_with_me_for_pn:(NSString*)any_one_shares_a_place_tip_or_entity_with_me_for_pn any_one_shares_a_place_tip_or_entity_with_me_for_mail:(NSString*)any_one_shares_a_place_tip_or_entity_with_me_for_mail i_receive_a_friend_request_of_friend_confirmation_for_pn:(NSString*)i_receive_a_friend_request_of_friend_confirmation_for_pn i_receive_a_friend_request_of_friend_confirmation_for_mail:(NSString*)i_receive_a_friend_request_of_friend_confirmation_for_mail a_new_friend_from_facebook_join_we_like_for_pn:(NSString*)a_new_friend_from_facebook_join_we_like_for_pn fkeep_me_up_to_date_with_welike_news_and_update_for_pn:(NSString*)fkeep_me_up_to_date_with_welike_news_and_update_for_pn keep_me_up_to_date_with_welike_news_and_update_for_mail:(NSString*)keep_me_up_to_date_with_welike_news_and_update_for_mail send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn:(NSString*)send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail:(NSString*)send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail;

-(void)updateProfile:(NSString*)FirstName user_id:(NSString*)user_id bio:(NSString*)bio Email:(NSString*)email phone:(NSString*)phone gender:(NSString *)gender birthday:(NSString*)birthday website:(NSString*)website save_photo_phone:(NSString*)save_photo_phone geotag_post:(NSString*)geotag_post post_are_private:(NSString*)post_are_private profile_picture:(NSString*)profile_picture cover_photo:(NSString*)cover_photo;



-(void)weLiike:(NSString*)user_category_id user_id:(NSString*)user_id master_category_id:(NSString*)master_category_id page:(NSString*)page address:(NSString*)address;
//curl -X POST -d "user_id=512e2ae4236f171697000044&user_category_id=512ee435236f17997f000003" http://localhost:3000/friends/following.json
-(void)GetFollowing:(NSString*)user_id user_category_id:(NSString*)user_category_id;
-(void)GetFollower:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id;


-(void)GetFollowingUser:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id;
-(void)GetFollowerUser:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id;


-(void)GetFriendCloud:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id;



-(void)GetTrends:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id page:(NSString*)page address:(NSString*)address;

-(void)GetAllFriend:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id page :(NSString *)page address:(NSString*)address;
-(void)GetGroup:(NSString*)user_id;
-(void)PostComment:(NSString*)post_id rating_count:(NSString*)rating_count comment_text:(NSString*)comment_text user_id:(NSString*)user_id selfUserId:(NSString *)selfUserId;

-(void)EntityComment:(NSString*)rating_count comment_text:(NSString*)comment_text user_id:(NSString*)user_id user_entity_id:(NSString*)user_entity_id selfUserId:(NSString *)selfUserId;

-(void)GroupFriendSearch:(NSString*)user_id first_name:(NSString*)first_name;
-(void)GroupFriend:(NSString*)user_id page:(NSString *)page;

-(void)GroupCreate:(NSString*)group_name group_owner:(NSString*)group_owner member_user_id:(NSString*)member_user_id notification:(NSString*)notification groupImage:(NSString *)groupImage;

-(void)GroupDetail:(NSString*)group_id user_id:(NSString *)user_id page:(NSString *)page;

-(void)feedback_user:(NSString*)user_id message:(NSString*)message subject:(NSString*)subject user_name:(NSString*)user_name email:(NSString*)email;
-(void)EditGroup:(NSString*)group_id group_name:(NSString*)group_name member_id:(NSString*)member_id notification:(NSString*)notification group_owner_id:(NSString *)group_owner_id groupImage:(NSString *)groupImage;

//"user_entity_id=51419db9f7e4f31bea000036" http://localhost:3000/friends/likers.json
-(void)getLiker:(NSString*)user_entity_id;
-(void)all_entity_comments:(NSString*)user_entity_id user_id:(NSString*)user_id;
-(void)all_post_comments:(NSString*)user_entity_id user_id:(NSString*)user_id;
-(void)Repost:(NSString*)user_id post_id:(NSString*)post_id lat:(NSString*)lat longitude:(NSString*)longitude entity_name:(NSString*)entity_name sub_category:(NSString*)sub_category comment:(NSString*)comment rating_count:(NSString*)rating_count address:(NSString*)address user_entity_id :(NSString*)user_entity_id post:(NSString*)post1 receiver_id:(NSString*)receiver_id group_id:(NSString*)group_id feed:(NSString*)feed;
-(void)other_user:(NSString*)user_id other_user_id :(NSString*)other_user_id;
-(void)peoples:(NSString*)user_id;
-(void)add_friend_form_facebook_and_email:(NSString*)email email_friend_id:(NSString *)email_friend_id user_id:(NSString *)user_id facebook_friend_id:(NSString *)facebook_friend_id;
-(void)remove_category:(NSString*)user_id user_category_id:(NSString*)user_category_id;
-(void)unfollow:(NSString*)user_id friend_user_id:(NSString*)friend_user_id;
-(void)remove_post:(NSString*)user_entity_id;
-(void)remove_entity:(NSString*)user_entity_id;
-(void)sort_entity:(NSString*)user_id sort_by:(NSString*)sort_by narrow_by_city:(NSString*)narrow_by_city narrow_by_sub_cateogy:(NSString*)narrow_by_sub_cateogy;
-(void)soring_setting:(NSString*)user_id;
-(void)user_feed:(NSString*)user_id;
-(void)searchEntityForAll:(NSString*)user_id user_category_id:(NSString*)user_category_id search:(NSString*)search master_category_id:(NSString*)master_category_id entity_name:(NSString*)entity_name address:(NSString*)address;
-(void)ratingEntity:(NSString*)user_id user_entity_id:(NSString*)user_entity_id rating_count:(NSString*)rating_count self_user_id:(NSString*)self_user_id;
-(void)follow_category:(NSString*)user_id friend_user_id:(NSString*)friend_user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id;
-(void)friend_search:(NSString*)user_id entity:(NSString*)entity;
-(void)get_all_message_threads:(NSString*)user_id;
-(void)getEntityByCategoryIDOther:(NSString *)user_id user_category_id:(NSString*)user_category_id page:(NSString*)page;
-(void)entity_search_sign_up:(NSString*)master_category_id searchString:(NSString*)searchString;
-(void)add_facebook_id:(NSString*)user_id facebook_id:(NSString*)facebook_id;
-(void)news_feed1:(NSString*)page userID:(NSString*)uid;
-(void)categoryList;
-(void)search_friend_on_people:(NSString*)user_id user_name:(NSString*)user_name;
-(void)get_city_and_sub_category:(NSString*)user_id user_category_id:(NSString*)user_category_id search:(NSString*)search master_category_id:(NSString*)master_category_id;
-(void)invite_user:(NSString*)email user_id:(NSString*)user_id friend_name:(NSString*)friend_name;
-(void)suggested_entity:(NSString*)user_id master_category_id:(NSString*)master_category_id entity_name:(NSString*)entity_name address:(NSString*)address lat:(NSString*)lat longitude:(NSString*)longitude sub_category:(NSString*)sub_category entity_image:(NSString*)entity_image comment:(NSString*)comment rating_count:(NSString*)rating_count information:(NSString*)information city:(NSString*)city;


-(void)update_sort_setting:(NSString*)user_id;

+(WeLiikeWebService*) sharedController;

@end
