//
//  WeLiikeWebService.m
//  WeLiiKe
//
//  Created by techvalens on 17/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "WeLiikeWebService.h"

@implementation WeLiikeWebService
@synthesize	_delegate;
@synthesize _callback;


static WeLiikeWebService* sharedInstance = nil;

+(WeLiikeWebService*) sharedController
{
	if(sharedInstance==nil)
	{
		sharedInstance = [[WeLiikeWebService alloc] init];
	}
	return sharedInstance;
}

-(id)initWithDelegate:(id)delegate callback:(SEL)callback{
    
	if (self = [super init]) {
		self._delegate = delegate;
		self._callback = callback;
        responseData = [[NSMutableData alloc] init] ;	
	}
	return self;
}


-(void)SaveUser:(NSString*)FirstName lastname:(NSString*)lastName Email:(NSString*)email Password:(NSString*)password profile:(NSString *)profile cover:(NSString*)cover{
    
    NSString *post = [NSString stringWithFormat:@"user[first_name]=%@&user[last_name]=%@&user[email]=%@&user[password]=%@&profile_picture=%@&cover_photo=%@",FirstName,lastName,email,password,profile,cover];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSLog(@"post data size %d",[postData length]);
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/create.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
//**********************************Login Method

//POST -d "login[email]=dj@g.com&login[password]=1234" http://localhost:3000/login/create.json

-(void)LoginUser:(NSString*)email Password:(NSString*)password{
    
    NSString *post = [NSString stringWithFormat:@"login[email]=%@&login[password]=%@",email,password];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/login/create.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//********Get category *******************

-(void)categoryList{
    
    NSString *str=[NSString stringWithFormat:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/category/category_list.json"];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60];
    [request setHTTPMethod:@"GET"];
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//**************************** save user from facebook *******************************
//curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[email]=yogeshwaghmare0gmail.com&user[fb_token]=AAABiLW4ZCpgEBAMGzZAVYKR1EZCI0IEliM6iQblRZBnDEx22ngIhRQSi5IRAy4ZAZBIoLYeCaTJSALXfES3jZAZAmracO978hsAicsXvSRk9nQZDZD&user[facebook_id]=100001112611740&user[gender]=male&user[provider]=facebook&user[name]=YogeshWaghmare" http://localhost:3000/facebook/create.json

-(void)SaveUserFromFB:(NSString*)FirstName lastname:(NSString*)lastName Email:(NSString*)email facebook_id:(NSString*)facebook_id gender:(NSString *)gender cover_photo:(NSString*)cover_photo  profile_picture:(NSString*)profile_picture;
{
    
    NSString *post = [NSString stringWithFormat:@"user[first_name]=%@&user[last_name]=%@&user[email]=%@&user[facebook_id]=%@&user[gender]=%@&user[provider]=facebook&user[cover_photo]=%@&user[profile_picture]=%@",FirstName,lastName,email,facebook_id,gender,cover_photo,profile_picture];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/facebook/create.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user[twitter_id]=100001112611740&user[provider]=twitter&user[screen_name]=ywaghmare5203&user[name]=Yogesh Waghmare" http://localhost:3000/twitter/create.json
-(void)SaveUserFromTwitter:(NSString*)twitter_id screen_name:(NSString*)screen_name name:(NSString*)name profile_picture:(NSString*)profile_picture cover_photo:(NSString*)cover_photo;{
    
    NSString *post = [NSString stringWithFormat:@"user[twitter_id]=%@&user[provider]=twitter&user[screen_name]=%@&user[name]=%@&user[profile_picture]=%@&user[cover_photo]=%@",twitter_id,screen_name,name,profile_picture,cover_photo];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/twitter/twitters.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//curl -X POST -d "friends[friends_id]=&friends[provider]=facebook&friends[facebook_id]=100001112611740&" http://localhost:3000/friends/create.json

-(void)AddFriend:(NSString*)friends_id facebook_id:(NSString*)facebook_id  user_id:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"friends[friends_id]=%@&friends[provider]=facebook&friends[facebook_id]=%@&user_id=%@",friends_id,facebook_id,user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/create.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
//"friends[email]=%@&friends[provider]=email&friends[friends_email]=%@" http://localhost:3000/friends/email_friends.json
//curl -X POST -d "friends[provider]=email&friends[friends_email]="%@"&" http://localhost:3000/friends/email_friends.json
-(void)AddFriendEmail:(NSString*)friendsEmail_id user_id:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"friends[provider]=email&friends[friends_email]=%@&user_id=%@",friendsEmail_id,user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/email_friends.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//curl -X POST -d "master_category_id=5121d8d7236f175488000001"  http://localhost:3000/user_entity/get_entity_by_category_id.json
//"entity[master_category_id]=%@" http://localhost:3000/master_entity/show.json
-(void)GetEntityByCategory:(NSString*)master_category_id page:(NSString*)page user_id:(NSString*)user_id{
    
    //NSString *post = [NSString stringWithFormat:@"entity[master_category_id]=510646adf7e4f33e2c000005",@"510646adf7e4f33e2c000005"];
    NSString *post = [NSString stringWithFormat:@"master_category_id=%@&page=%@&user_id=%@",master_category_id,page,user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/get_entity_by_category_id.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//&user_category[master_category_id]="12345,123456,145632,456879"&user_category[user_id]=510b81adf7e4f36ef2000002" http://localhost:3000/user_category/create.json

-(void)AddCategory:(NSString*)master_category_id user_id:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_category[master_category_id]=%@&user_category[user_id]=%@",master_category_id,user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];///user_category/create.json
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_category/create.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "entity[user_id]=510f5cd5f7e4f33070000026&entity[user_category_id]=510f638df7e4f33070000029&entity[master_entity_id]="510a772af7e4f3488c000001,510a77b3f7e4f3488c000002,510a7858f7e4f3488c000003"" http://localhost:3000/user_entity/create.json
// curl -X POST -d "user_id=512dbbb9236f17829900005f&user_category_id=512dbbc7236f178299000060&user_entity_id="512c54ae236f170e15000006,512c7b91236f17e7d1000002"" http://localhost:3000/user_entity/create.json
// curl -X POST -d "user_id=512dbbb9236f17829900005f&user_category_id=512dbbc7236f178299000060&user_entity_id="512c54ae236f170e15000006,512c7b91236f17e7d1000002"" http://localhost:3000/user_entity/create.json
-(void)AddEntity:(NSString*)master_entity_id user_id:(NSString*)user_id user_category_id:(NSString*)user_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&user_entity_id=%@",user_id,user_category_id,master_entity_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];///user_category/create.json
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/create.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//category[master_category_id]=510646adf7e4f33e2c000005" http://localhost:3000/user_category/get_friend.json
//## curl -X GET  "category[master_category_id]=510646adf7e4f33e2c000005" http://localhost:3000/user_category/get_friend.json
-(void)GetFriendsByCategory:(NSString*)master_category_id{
    
    NSString *post = [NSString stringWithFormat:@"category[master_category_id]=%@",master_category_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_category/get_friend.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//curl -X POST -d "category[user_id]=510f5cd5f7e4f33070000026" http://localhost:3000/user_category/aggrigrator.json
//#curl -X GET -d "category[user_id]=510f5cd5f7e4f33070000026" http://localhost:3000/user_category/aggrigrator.json
-(void)GetCategoryByUserID:(NSString*)userID{
    
    NSString *post = [NSString stringWithFormat:@"category[user_id]=%@",userID];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_category/aggrigrator.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//user_id=51134f8af7e4f352c7000020" http://localhost:3000/user_category/all_category.json
-(void)GetAllCategoryByUserID:(NSString*)userID{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@",userID];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_category/all_category.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}


-(void)saveMedia:(NSString *)entity_name comment:(NSString*)comment address:(NSString*)address lat:(NSString*)lat longitude:(NSString*)longitude master_category_id:(NSString*)master_category_id entity_image:(NSString*)entity_image user_id:(NSString*)user_id user_category_id:(NSString*)user_category_id api_id:(NSString*)api_id rating_count:(NSString*)rating_count group_id:(NSString*)group_id email:(NSString*)email receiver_id:(NSString*)receiver_id feed:(NSString*)feed sub_category:(NSString*)sub_category city:(NSString *)city def:(BOOL)def is_active:(BOOL)is_active {
    
    
    NSString *post = [NSString stringWithFormat:@"api_id=%@&entity_name=%@&comment=%@&address=%@&lat=%@&longitude=%@&master_category_id=%@&entity_image=%@&user_id=%@&user_category_id=%@&rating_count=%@&group_id=%@&email_list=%@&receiver_id=%@&feed=%@&sub_category=%@&city=%@&def=%d&is_active=%d",api_id,entity_name,comment,address,lat,longitude,master_category_id,entity_image,user_id,user_category_id,rating_count,group_id,email,receiver_id,feed,sub_category,city,def,is_active];
    //NSLog(@"value of **************** %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/save_media.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)addFriendByCategory:(NSString *)user_id friend_user_id:(NSString*)friend_user_id user_category_id:(NSString*)user_category_id {
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&friend_user_id=%@&user_category_id=%@",user_id,friend_user_id,user_category_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/category_friends.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//"user_id=51134f8af7e4f352c7000020&user_category_id=511351dff7e4f352c7000023" http://localhost:3000/user_entity/get_entity_by_user_id_cat_id.json

//curl -X POST -d "user_id=51a325b7f5cbb76e7a000001&user_category_id=51a325bef5cbb76e7a000002&master_category_id=518737c5b554cfd51d000001&address=Apple Store, San Francisco,1800 Ellis St,San Francisco, CA  94115-4004,United States" http://ec2-54-225-243-66.compute-1.amazonaws.com/search/i_liike_sort.json

-(void)getEntityByCategoryIDOther:(NSString *)user_id user_category_id:(NSString*)user_category_id page:(NSString*)page{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&page=%@",user_id,user_category_id,page];
    // NSString *post = [NSString stringWithFormat:@"user_id=51134f8af7e4f352c7000020&user_category_id=511351dff7e4f352c7000023"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/get_entity_by_user_id_cat_id.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}


-(void)getEntityByCategoryID:(NSString *)user_id user_category_id:(NSString*)user_category_id page:(NSString*)page address:(NSString*)address{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&page=%@&address=%@",user_id,user_category_id,page,address];
    // NSString *post = [NSString stringWithFormat:@"user_id=51134f8af7e4f352c7000020&user_category_id=511351dff7e4f352c7000023"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/i_liikes/i_liike_sort.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}


//curl -X GET -d "user_id=51134f8af7e4f352c7000020&user_entity_id=511356d4f7e4f352c7000029" http://localhost:3000/user_entity/entity_info.json
-(void)entityInfo:(NSString*)userID entityID:(NSString*)entityID{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_entity_id=%@",userID,entityID];
    // NSString *post = [NSString stringWithFormat:@"user_id=51134f8af7e4f352c7000020&user_category_id=511351dff7e4f352c7000023"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/entity_info.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


-(void)updateProfile:(NSString*)FirstName user_id:(NSString*)user_id lastname:(NSString*)lastName bio:(NSString*)bio Email:(NSString*)email Password:(NSString*)password city:(NSString*)city birthday:(NSString*)birthday profile_picture:(NSString *)profile_picture{
    
    NSString *post = [NSString stringWithFormat:@"user[first_name]=%@&user[user_id]=%@&user[last_name]=%@&user[bio]=%@&user[email]=%@&password]=%@&user[phone]=8109481001&user[city]=%@&user[birthday]=%@&profile_picture=%@",FirstName,user_id,lastName,bio,email,password,city,birthday,profile_picture];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/update.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

-(void)GetAllFriendUserID:(NSString*)userID{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@",userID];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/all_friends.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//"entity[char]=Fortune" http://localhost:3000/user_entity/entity_search.json
-(void)EntitySearch:(NSString*)charchater{
    
    NSString *post = [NSString stringWithFormat:@"entity[char]=%@",charchater];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/entity_search.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//curl -X POST -d "email=yogesh.waghmare@techvalens.com&password=12345&change[password]=yogesh" http://localhost:3000/user/change_password.json
-(void)updateProfile:(NSString*)FirstName user_id:(NSString*)user_id bio:(NSString*)bio Email:(NSString*)email phone:(NSString*)phone gender:(NSString *)gender birthday:(NSString*)birthday website:(NSString*)website save_photo_phone:(NSString*)save_photo_phone geotag_post:(NSString*)geotag_post post_are_private:(NSString*)post_are_private profile_picture:(NSString*)profile_picture cover_photo:(NSString*)cover_photo{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user[first_name]=%@&user[bio]=%@&user[email]=%@&user[phone]=%@&user[gender]=%@&user[birthday]=%@&user[website]=%@&user[save_photo_phone]=%@&user[geotag_post]=%@&user[post_are_private]=%@&profile_picture=%@&cover_photo=%@",user_id,FirstName,bio,email,phone,gender,birthday,website, save_photo_phone, geotag_post,post_are_private,profile_picture,cover_photo];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/update.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)Update:(NSString*)user_id friend_like_my_activity_for_pn:(NSString*)friend_like_my_activity_for_pn friend_like_my_activity_for_mail:(NSString*)friend_like_my_activity_for_mail any_one_like_my_activity_for_pn:(NSString*)any_one_like_my_activity_for_pn any_one_like_my_activity_for_mail:(NSString*)any_one_like_my_activity_for_mail friend_mention_me_in_comment_for_pn:(NSString*)friend_mention_me_in_comment_for_pn a_friend_follow_my_category_for_mail:(NSString*)a_friend_follow_my_category_for_mail any_one_mention_me_in_comment_for_pn:(NSString*)any_one_mention_me_in_comment_for_pn any_one_mention_me_in_comment_for_mail:(NSString*)any_one_mention_me_in_comment_for_mail a_friend_follow_my_category_for_pn:(NSString*)a_friend_follow_my_category_for_pn  any_one_friend_follow_my_category_for_pn:(NSString*)any_one_friend_follow_my_category_for_pn any_one_friend_follow_my_category_for_mail:(NSString*)any_one_friend_follow_my_category_for_mail a_friend_shares_a_place_tip_or_entity_with_me_for_pn:(NSString*)a_friend_shares_a_place_tip_or_entity_with_me_for_pn a_friend_shares_a_place_tip_or_entity_with_me_for_mail:(NSString*)a_friend_shares_a_place_tip_or_entity_with_me_for_mail any_one_shares_a_place_tip_or_entity_with_me_for_pn:(NSString*)any_one_shares_a_place_tip_or_entity_with_me_for_pn any_one_shares_a_place_tip_or_entity_with_me_for_mail:(NSString*)any_one_shares_a_place_tip_or_entity_with_me_for_mail i_receive_a_friend_request_of_friend_confirmation_for_pn:(NSString*)i_receive_a_friend_request_of_friend_confirmation_for_pn i_receive_a_friend_request_of_friend_confirmation_for_mail:(NSString*)i_receive_a_friend_request_of_friend_confirmation_for_mail a_new_friend_from_facebook_join_we_like_for_pn:(NSString*)a_new_friend_from_facebook_join_we_like_for_pn fkeep_me_up_to_date_with_welike_news_and_update_for_pn:(NSString*)fkeep_me_up_to_date_with_welike_news_and_update_for_pn keep_me_up_to_date_with_welike_news_and_update_for_mail:(NSString*)keep_me_up_to_date_with_welike_news_and_update_for_mail send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn:(NSString*)send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail:(NSString*)send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail{
    
    
    NSLog(@"value of button ==>%@ ==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@==>%@", friend_like_my_activity_for_pn
          , friend_like_my_activity_for_mail
          ,any_one_like_my_activity_for_pn
          , any_one_like_my_activity_for_mail
          , friend_mention_me_in_comment_for_pn
          , a_friend_follow_my_category_for_mail
          , any_one_mention_me_in_comment_for_pn
          , any_one_mention_me_in_comment_for_mail
          , a_friend_follow_my_category_for_pn
          , any_one_friend_follow_my_category_for_pn
          , any_one_friend_follow_my_category_for_mail
          , a_friend_shares_a_place_tip_or_entity_with_me_for_pn
          ,  a_friend_shares_a_place_tip_or_entity_with_me_for_mail
          ,  any_one_shares_a_place_tip_or_entity_with_me_for_pn
          , any_one_shares_a_place_tip_or_entity_with_me_for_mail
          , i_receive_a_friend_request_of_friend_confirmation_for_pn
          , i_receive_a_friend_request_of_friend_confirmation_for_mail
          , a_new_friend_from_facebook_join_we_like_for_pn
          , fkeep_me_up_to_date_with_welike_news_and_update_for_pn
          , keep_me_up_to_date_with_welike_news_and_update_for_mail
          , send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn
          , send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail);
    
    // NSString *post=[[NSString alloc] init];
    // post = [[NSString stringWithFormat:@"user[first_name]=%@Yogesh&user[user_id]=%@&user[bio]=%@&user[email]=%@&user[password]=%@&user[phone]=%@&user[city]=%@&user[birthday]=%@&user[friend_like_my_activity_for_pn]=%@&user[friend_like_my_activity_for_mail]=%@&user[any_one_like_my_activity_for_pn]=%@&user[any_one_like_my_activity_for_mail]=%@&user[friend_mention_me_in_comment_for_pn]=%@&user[friend_mention_me_in_comment_for_mail]=%@&user[any_one_mention_me_in_comment_for_pn]=%@&user[any_one_mention_me_in_comment_for_mail]=%@&user[a_friend_follow_my_category_for_pn]=%@&user[a_friend_follow_my_category_for_mail]=%@&user[any_one_friend_follow_my_category_for_pn]=%@&user[any_one_friend_follow_my_category_for_mail]=%@&user[a_friend_shares_a_place_tip_or_entity_with_me_for_pn]=%@&user[a_friend_shares_a_place_tip_or_entity_with_me_for_mail]=%@&user[any_one_shares_a_place_tip_or_entity_with_me_for_pn]=%@&user[any_one_shares_a_place_tip_or_entity_with_me_for_mail]=%@&user[i_receive_a_friend_request_of_friend_confirmation_for_pn]=%@&user[i_receive_a_friend_request_of_friend_confirmation_for_mail]=%@&user[a_new_friend_from_facebook_join_we_like_for_pn]=%@&user[fkeep_me_up_to_date_with_welike_news_and_update_for_pn]=%@&user[keep_me_up_to_date_with_welike_news_and_update_for_mail]=%@&user[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn]=%@&user[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail]=%@",first_name,user_id, bio,email, password, phone, city, birthday, friend_like_my_activity_for_pn, friend_like_my_activity_for_mail,any_one_like_my_activity_for_pn, any_one_like_my_activity_for_mail, friend_mention_me_in_comment_for_pn, a_friend_follow_my_category_for_mail, any_one_mention_me_in_comment_for_pn, any_one_mention_me_in_comment_for_mail, a_friend_follow_my_category_for_pn, any_one_friend_follow_my_category_for_pn, any_one_friend_follow_my_category_for_mail, a_friend_shares_a_place_tip_or_entity_with_me_for_pn,  a_friend_shares_a_place_tip_or_entity_with_me_for_mail,  any_one_shares_a_place_tip_or_entity_with_me_for_pn, any_one_shares_a_place_tip_or_entity_with_me_for_mail, i_receive_a_friend_request_of_friend_confirmation_for_pn, i_receive_a_friend_request_of_friend_confirmation_for_mail, a_new_friend_from_facebook_join_we_like_for_pn, fkeep_me_up_to_date_with_welike_news_and_update_for_pn, keep_me_up_to_date_with_welike_news_and_update_for_mail, send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn, send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail] copy];
    
    
    //NSString *post = [NSString stringWithFormat:@"user[first_name]=%@Yogesh&user[user_id]=%@&user[bio]=%@&user[email]=%@&user[password]=%@&user[phone]=%@&user[city]=%@&user[birthday]=%@&user[friend_like_my_activity_for_pn]=%@&user[friend_like_my_activity_for_mail]=%@&user[any_one_like_my_activity_for_pn]=%@&user[any_one_like_my_activity_for_mail]=%@&user[friend_mention_me_in_comment_for_pn]=%@&user[friend_mention_me_in_comment_for_mail]=%@&user[any_one_mention_me_in_comment_for_pn]=%@&user[any_one_mention_me_in_comment_for_mail]=%@&user[a_friend_follow_my_category_for_pn]=%@&user[a_friend_follow_my_category_for_mail]=%@&user[any_one_friend_follow_my_category_for_pn]=%@&user[any_one_friend_follow_my_category_for_mail]=%@&user[a_friend_shares_a_place_tip_or_entity_with_me_for_pn]=%@&user[a_friend_shares_a_place_tip_or_entity_with_me_for_mail]=%@",first_name,user_id, bio,email, password, phone, city, birthday, friend_like_my_activity_for_pn, friend_like_my_activity_for_mail,any_one_like_my_activity_for_pn, any_one_like_my_activity_for_mail, friend_mention_me_in_comment_for_pn, a_friend_follow_my_category_for_mail, any_one_mention_me_in_comment_for_pn, any_one_mention_me_in_comment_for_mail, a_friend_follow_my_category_for_pn, any_one_friend_follow_my_category_for_pn, any_one_friend_follow_my_category_for_mail, a_friend_shares_a_place_tip_or_entity_with_me_for_pn, a_friend_shares_a_place_tip_or_entity_with_me_for_mail];
    
    NSString *stringPost=[[NSString alloc] initWithFormat:@"user[user_id]=%@&user[friend_like_my_activity_for_pn]=%@&user[friend_like_my_activity_for_mail]=%@&user[any_one_like_my_activity_for_pn]=%@&user[any_one_like_my_activity_for_mail]=%@&user[friend_mention_me_in_comment_for_pn]=%@&user[friend_mention_me_in_comment_for_mail]=%@&user[any_one_mention_me_in_comment_for_pn]=%@&user[any_one_mention_me_in_comment_for_mail]=%@&user[a_friend_follow_my_category_for_pn]=%@&user[a_friend_follow_my_category_for_mail]=%@&user[any_one_friend_follow_my_category_for_pn]=%@&user[any_one_friend_follow_my_category_for_mail]=%@",user_id, friend_like_my_activity_for_pn, friend_like_my_activity_for_mail,any_one_like_my_activity_for_pn, any_one_like_my_activity_for_mail, friend_mention_me_in_comment_for_pn, a_friend_follow_my_category_for_mail, any_one_mention_me_in_comment_for_pn, any_one_mention_me_in_comment_for_mail, a_friend_follow_my_category_for_pn, any_one_friend_follow_my_category_for_pn, any_one_friend_follow_my_category_for_mail];
    
    NSString *stringPost1=[[NSString alloc] initWithFormat:@"&user[a_friend_shares_a_place_tip_or_entity_with_me_for_pn]=%@&user[a_friend_shares_a_place_tip_or_entity_with_me_for_mail]=%@&user[any_one_shares_a_place_tip_or_entity_with_me_for_pn]=%@&user[any_one_shares_a_place_tip_or_entity_with_me_for_mail]=%@&user[i_receive_a_friend_request_of_friend_confirmation_for_pn]=%@&user[i_receive_a_friend_request_of_friend_confirmation_for_mail]=%@&user[a_new_friend_from_facebook_join_we_like_for_pn]=%@&user[fkeep_me_up_to_date_with_welike_news_and_update_for_pn]=%@&user[keep_me_up_to_date_with_welike_news_and_update_for_mail]=%@&user[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn]=%@&user[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail]=%@",a_friend_shares_a_place_tip_or_entity_with_me_for_pn,  a_friend_shares_a_place_tip_or_entity_with_me_for_mail,  any_one_shares_a_place_tip_or_entity_with_me_for_pn, any_one_shares_a_place_tip_or_entity_with_me_for_mail, i_receive_a_friend_request_of_friend_confirmation_for_pn, i_receive_a_friend_request_of_friend_confirmation_for_mail, a_new_friend_from_facebook_join_we_like_for_pn, fkeep_me_up_to_date_with_welike_news_and_update_for_pn, keep_me_up_to_date_with_welike_news_and_update_for_mail, send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn, send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail];
    
    NSString *post = [NSString stringWithFormat:@"%@%@",stringPost,stringPost1];
    
    
    
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/update_notifications.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//"email=yogesh.waghmare@techvalens.com&password=12345&change[password]=yogesh" http://localhost:3000/user/change_password.json
-(void)changePassword:(NSString*)email password:(NSString*)password passwordNew:(NSString*)passwordNew{
    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@&change[password]=%@",email,password,passwordNew];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/change_password.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
//curl -X GET -d "user_id=512dd6e0236f1742ef000033&master_category_id=5121d8d7236f175488000001" http://localhost:3000/user_entity/welike.json
// curl -X POST -d "user_id=5163f6db36601ad46900000a&user_category_id=5163f6e136601ad46900000c&master_category_id51624b7d9b3809ada1000001" http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/welike.json

//curl -X POST -d "user_id=51516a8bf7e4f322d6000001&user_category_id=515171fbf7e4f3fac4000003&search=i_liike&master_category_id=5130b57cf7e4f34f9d000005&entity_name[char]=yogesh&address=Nayay Nagar, Near Bapat Squire, Indore" http://localhost:3000/search/weliike_sort.json

-(void)weLiike:(NSString*)user_category_id user_id:(NSString*)user_id master_category_id:(NSString*)master_category_id page:(NSString *)page address:(NSString*)address{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&master_category_id=%@&page=%@&address=%@",user_id,user_category_id,master_category_id,page,address];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/weliikes/weliike_sort.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)GetFollowing:(NSString*)user_id user_category_id:(NSString*)user_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@",user_id,user_category_id];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/following.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
-(void)GetFollower:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&master_category_id=%@",user_id,user_category_id,master_category_id];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/followers.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
//curl -X POST -d "user_id=512f02ee236f17c818000044&user_category_id=512f02f9236f17c818000045" http://localhost:3000/friends/following_data.json
-(void)GetFollowingUser:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&master_category_id=%@",user_id,user_category_id,master_category_id];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/following_data.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//http://localhost:3000
//curl -X POST -d "user_id=513471b2f7e4f330e9000097&user_category_id=513471baf7e4f330e9000098&master_category_id=5130ad0df7e4f30efe000001" http://localhost:3000/friends/followers_data.json
-(void)GetFollowerUser:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&master_category_id=%@",user_id,user_category_id,master_category_id];
    NSLog(@"valeu of ********%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/followers_data.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user_id=513471b2f7e4f330e9000097&user_category_list=513471baf7e4f330e9000098,513471baf7e4f330e9000099&user_category_id=513471baf7e4f330e9000098&master_category_id=5130ad0df7e4f30efe000001" http://localhost:3000/friends/friend_clouds.json

-(void)GetFriendCloud:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_list=%@&master_category_id=%@",user_id,user_category_id,master_category_id];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/friend_clouds.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "user_id=5131bcc9f7e4f3ef4500000d&user_category_id=5131bccdf7e4f3ef4500000e&master_category_id=5130ad0df7e4f30efe000001" http://localhost:3000/friends/traids.json

//curl -X POST -d "user_id=51516a8bf7e4f322d6000001&user_category_id=515171fbf7e4f3fac4000003&search=i_liike&master_category_id=5130b57cf7e4f34f9d000005&entity_name[char]=yogesh&address=Nayay Nagar, Near Bapat Squire, Indore" http://localhost:3000/search/trends_sort.json


-(void)GetTrends:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id page:(NSString*)page address:(NSString*)address{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&master_category_id=%@&page=%@&address=%@",user_id,user_category_id,master_category_id,page,address];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/trends/trends_sort.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "user_id=51516a8bf7e4f322d6000001&user_category_id=515171fbf7e4f3fac4000003&search=i_liike&master_category_id=5130b57cf7e4f34f9d000005&entity_name[char]=yogesh&address=Nayay Nagar, Near Bapat Squire, Indore" http://localhost:3000/search/friend_sort.json

-(void)GetAllFriend:(NSString*)user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id page:(NSString *)page address:(NSString*)address{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&master_category_id=%@&page=%@&address=%@",user_id,user_category_id,master_category_id,page,address];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends_sort/friend_sort.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//http://localhost:3000
//curl -X POST -d "group_owner_id=513471b2f7e4f330e9000097" http://localhost:3000/group/get_group_by_user_id.json
-(void)GetGroup:(NSString*)user_id{
    NSString *post = [NSString stringWithFormat:@"group_owner_id=%@",user_id];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/group/get_group_by_owner_id.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
//curl -X POST -d "comment_text=This is Nice for all Users&user_id=51419daef7e4f31bea000032&post_id=51431983f7e4f371ee000006&rating_count=5&self_user_id=51419daef7e4f31bea000032" http://localhost:3000/comment/post_comment.json
//curl -X POST -d "post_id=5118e7e6f7e4f3899a00004c&rating_count=&comment_text=xyz&user_id=123&user_entity_id=" http://localhost:3000/comment/post_comment.json
-(void)PostComment:(NSString*)post_id rating_count:(NSString*)rating_count comment_text:(NSString*)comment_text user_id:(NSString*)user_id selfUserId:(NSString *)selfUserId{
    
    NSString *post = [NSString stringWithFormat:@"post_id=%@&rating_count=%@&comment_text=%@&user_id=%@&self_user_id=%@",post_id,rating_count,comment_text,user_id,selfUserId];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/comment/post_comment.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

//curl -X POST -d "comment_text=This is Nice for all Users&user_id=513471b2f7e4f330e9000097&user_entity_id=513dd21bf7e4f3b1dd000016&rating_count=5&self_user_id=513471b2f7e4f330e9000097" http://localhost:3000/comment/entity_comment.json
-(void)EntityComment:(NSString*)rating_count comment_text:(NSString*)comment_text user_id:(NSString*)user_id user_entity_id:(NSString*)user_entity_id selfUserId:(NSString *)selfUserId{
    
     NSString *post = [NSString stringWithFormat:@"comment_text=%@&user_id=%@&user_entity_id=%@&rating_count=%@&self_user_id=%@",comment_text,user_id,user_entity_id,rating_count,selfUserId];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/comment/entity_comment.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user_id=51401058f7e4f34bd1000015&first_name[char]=d" http://localhost:3000/friends/group_friend_search.json
-(void)GroupFriendSearch:(NSString*)user_id first_name:(NSString*)first_name{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&first_name[char]=%@",user_id,first_name];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/group_friend_search.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "user_id=51401058f7e4f34bd1000015" http://localhost:3000/friends/group_friend.json
-(void)GroupFriend:(NSString*)user_id page:(NSString *)page;{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&page=%@",user_id,page];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/group_friend.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//"group_name=Hi Hello&group_owner_id=514063a6f7e4f34bd1000031&status=1&is_active=1&member_user_id=514062b4f7e4f34bd1000030,51405518f7e4f34bd100002f&notification=1&group_image=" http://localhost:3000/group/group_create.json
//curl -X POST -d "group[group_name]=Hi Hello&group[group_owner]=Hay&group[status]=1&is_active=1&member_user_id=&notification=1" http://localhost:3000/group/group_create.json
-(void)GroupCreate:(NSString*)group_name group_owner:(NSString*)group_owner member_user_id:(NSString*)member_user_id notification:(NSString*)notification groupImage:(NSString *)groupImage{
    
    NSString *post = [NSString stringWithFormat:@"group_name=%@&group_owner_id=%@&status=1&is_active=1&member_user_id=%@&notification=%@&group_image=%@",group_name,group_owner,member_user_id,notification,groupImage];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/group/group_create.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//"group_id=514178c9f7e4f31bea000002" http://localhost:3000/group/group_details.json

-(void)GroupDetail:(NSString*)group_id user_id:(NSString *)user_id page:(NSString *)page{
    
    NSString *post = [NSString stringWithFormat:@"group_id=%@&user_id=%@&page=%@",group_id,user_id,page];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/group/group_details.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "group_id=514195cdf7e4f31bea000005&group_name=UP&member_id=514062b4f7e4f34bd1000030&group_name=Hi Hello&group_owner_id=&notification=1&group_image=" http://localhost:3000/group/edit_group.json
//http://ec2-54-225-243-66.compute-1.amazonaws.com/
-(void)EditGroup:(NSString*)group_id group_name:(NSString*)group_name member_id:(NSString*)member_id notification:(NSString*)notification group_owner_id:(NSString *)group_owner_id groupImage:(NSString *)groupImage{
    
    NSString *post = [NSString stringWithFormat:@"group_id=%@&group_name=%@&member_id=%@&group_owner_id=%@&notification=%@&group_image=%@",group_id,group_name,member_id,group_owner_id,notification,groupImage];
    //NSString *post = [NSString stringWithFormat:@"category[user_id]=510f5cd5f7e4f33070000026"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/group/edit_group.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//"user_entity_id=51419db9f7e4f31bea000036" http://localhost:3000/friends/likers.json
-(void)getLiker:(NSString*)user_entity_id{
    
    NSString *post = [NSString stringWithFormat:@"user_entity_id=%@",user_entity_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/likers.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//curl -X POST -d "user_id=51419daef7e4f31bea000032&message=FGDSGDSFGDFGDSFGDGFDGF& subject=Hi&user_name=Yogesh&email=yogesh.waghmare@techvalens.com" http://ec2-54-225-243-66.compute-1.amazonaws.com/feedback/feedback_user.json
//url -X POST -d "user_id=51419daef7e4f31bea000032&message=FGDSGDSFGDFGDSFGDGFDGF& subject=Hi&user_name=Yogesh" http://localhost:3000/feedback/feedback_user.json
-(void)feedback_user:(NSString*)user_id message:(NSString*)message subject:(NSString*)subject user_name:(NSString*)user_name email:(NSString*)email{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&message=%@&subject=%@&user_name=%@&email=%@",user_id,message,subject,user_name,email];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/feedback/feedback_user.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
}
//curl -X POST -d "user_entity_id=51641a4736601a7cd4000002&user_id=5163f6db36601ad46900000a" http://ec2-54-225-243-66.compute-1.amazonaws.com/comment/all_entity_comments.json
-(void)all_entity_comments:(NSString*)user_entity_id user_id:(NSString*)user_id{
    
    
    NSString *post = [NSString stringWithFormat:@"user_entity_id=%@&user_id=%@",user_entity_id,user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/comment/all_entity_comments.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

-(void)all_post_comments:(NSString*)user_entity_id user_id:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"post_id=%@&user_id=%@",user_entity_id,user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/comment/all_post_comments.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "user_id=51502b8df7e4f3ef9b000002&post_id=51642c09f7e4f315e8000001&lat=21.67&longitude=12.34&entity_name=Yogesh new post&sub_category=pub&comment=cvxzvzxcvxcv dfgdsfg &rating_count=3&address=de rtgrt dds&user_entity_id=5164162ef7e4f377a500000a&post=0"  http://localhost:3000/user_entity/repost.json
-(void)Repost:(NSString*)user_id post_id:(NSString*)post_id lat:(NSString*)lat longitude:(NSString*)longitude entity_name:(NSString*)entity_name sub_category:(NSString*)sub_category comment:(NSString*)comment rating_count:(NSString*)rating_count address:(NSString*)address user_entity_id :(NSString*)user_entity_id post:(NSString*)post1 receiver_id:(NSString*)receiver_id group_id:(NSString*)group_id feed:(NSString*)feed {
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&post_id=%@&lat=%@&longitude=%@&entity_name=%@&sub_category=%@&comment=%@&rating_count=%@&address=%@&user_entity_id=%@&post=%@&receiver_id=%@&group_id=%@&feed=%@",user_id,post_id,lat,longitude,entity_name,sub_category,comment,rating_count,address,user_entity_id,post1,receiver_id,group_id,feed];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/repost.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

//curl -X POST -d "user_id=516e6b5737a15d12f2000001" http://ec2-54-225-243-66.compute-1.amazonaws.com/user/other_user.json
//$ curl -X POST -d "user_id=516e6b5737a15d12f2000001&other_user_id=" http://localhost:3000/user/other_user.json

-(void)other_user:(NSString*)user_id other_user_id :(NSString*)other_user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&other_user_id=%@",user_id ,other_user_id ];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/other_user.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//curl -X POST -d "user_id=51419daef7e4f31bea000032" http://ec2-54-225-243-66.compute-1.amazonaws.com/user/peoples.json
-(void)peoples:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@",user_id  ];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/peoples.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "user_id=51400713f7e4f34bd1000001&user_category_id=5140075bf7e4f34bd1000002" http://localhost:3000/user_category/remove_category.json
-(void)remove_category:(NSString*)user_id user_category_id:(NSString*)user_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@",user_id,user_category_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_category/remove_category.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

//curl -X POST -d "email=1&email_friend_id=&user_id=12df23&facebook_friend_id=100001112611740" http://localhost:3000/add_friend_form_facebook_and_email.json
-(void)add_friend_form_facebook_and_email:(NSString*)email email_friend_id:(NSString *)email_friend_id user_id:(NSString *)user_id facebook_friend_id:(NSString *)facebook_friend_id{
    
    NSString *post = [NSString stringWithFormat:@"email=%@&email_friend_id=%@&user_id=%@&facebook_friend_id=%@",email,email_friend_id,user_id,facebook_friend_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/add_friend_form_facebook_and_email.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)unfollow:(NSString*)user_id friend_user_id:(NSString*)friend_user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&friend_user_id=%@",user_id,friend_user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/friends/unfollow.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

-(void)remove_post:(NSString*)user_entity_id{
    NSString *post = [NSString stringWithFormat:@"user_entity_id=%@",user_entity_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/remove_post.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)remove_entity:(NSString*)user_entity_id{
    
    NSString *post = [NSString stringWithFormat:@"user_entity_id=%@",user_entity_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/remove_entity.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
//curl -X POST -d "user_id=51516a8bf7e4f322d6000001&entity_name[char]=Yogesh&master_category_id=5130b57cf7e4f34f9d000005" http://localhost:3000/user_entity/sort_and_narrow.json

-(void)sort_entity:(NSString*)user_id sort_by:(NSString*)sort_by narrow_by_city:(NSString*)narrow_by_city narrow_by_sub_cateogy:(NSString*)narrow_by_sub_cateogy{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&sort_by=%@&narrow_by_city=%@&narrow_by_sub_cateogy=%@",user_id,sort_by,narrow_by_city,narrow_by_sub_cateogy];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/sort_entity.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//curl -X POST -d "user_id=5" http://localhost:3000/user_entity/soring_setting.json
-(void)soring_setting:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@",user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/sorting_setting.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user_id=5143ff14f7e4f39ce5000001" http://localhost:3000/user/user_feed.json
-(void)user_feed:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@",user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/user_feed.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)news_feed1:(NSString*)page userID:(NSString*)uid{
    
    NSString *post = [NSString stringWithFormat:@"page=%@&user_id=%@",page,uid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/news_feed.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
//curl -X POST -d "user_id=518797b1b554cfd09a000001&user_category_id=518797bbb554cfd09a000002&search=trends&master_category_id=518737f1b554cfd51d000002&entity_name[char]=re" http://ec2-54-225-243-66.compute-1.amazonaws.com/search/search_all.json

//curl -X POST -d "user_id=51516a8bf7e4f322d6000001&user_category_id=515171fbf7e4f3fac4000003&search=i_liike&master_category_id=518737f1b554cfd51d000002&entity_name[char]=yoges" http://localhost:3000/user_entity/search_all.json

//Latest :- curl -X POST -d "user_id=51516a8bf7e4f322d6000001&user_category_id=515171fbf7e4f3fac4000003&search=i_liike&master_category_id=518737f1b554&entity_name[char]=yog" http://localhost:3000/search/search_all.json


-(void)searchEntityForAll:(NSString*)user_id user_category_id:(NSString*)user_category_id search:(NSString*)search master_category_id:(NSString*)master_category_id entity_name:(NSString*)entity_name address:(NSString *)address{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&search=%@&master_category_id=%@&entity_name[char]=%@&address=%@",user_id,user_category_id,search,master_category_id,entity_name,address];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/search/search_all.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

//curl -X POST -d "user_id=514199a1f7e4f31bea000009&user_entity_id=514199abf7e4f31bea00000e&rating_count=5&self_user_id=51483122f7e4f371b4000001" http://localhost:3000/rating/rating_entity.json
-(void)ratingEntity:(NSString*)user_id user_entity_id:(NSString*)user_entity_id rating_count:(NSString*)rating_count self_user_id:(NSString*)self_user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_entity_id=%@&rating_count=%@&self_user_id=%@",user_id,user_entity_id,rating_count,self_user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/rating/rating_entity.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

//curl -X POST -d "user_id=&friend_user_id=&user_category_id=&master_category_id=" http://localhost:3000/user_category/follow_category.json
-(void)follow_category:(NSString*)user_id friend_user_id:(NSString*)friend_user_id user_category_id:(NSString*)user_category_id master_category_id:(NSString*)master_category_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&friend_user_id=%@&user_category_id=%@&master_category_id=%@",user_id,friend_user_id,user_category_id,master_category_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_category/follow_category.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user_id=5143ff14f7e4f39ce5000001&entity[char]=deepak" http://localhost:3000/user/friend_search.json
-(void)friend_search:(NSString*)user_id entity:(NSString*)entity{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&entity[char]=%@",user_id,entity];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/friend_search.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


-(void)search_friend_on_people:(NSString*)user_id user_name:(NSString*)user_name{

    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_name[char]=%@",user_id,user_name];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/search_friend_on_people.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user_id=51502b8df7e4f3ef9b000002" http://localhost:3000/message/get_all_message_threads.json
-(void)get_all_message_threads:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@",user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/message/get_all_message_threads.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//curl -X POST -d "master_category_id=5130ad0df7e4f30efe000001&entity[char]=saya" http://localhost:3000/user_entity/entity_search_sign_up.json
-(void)entity_search_sign_up:(NSString*)master_category_id searchString:(NSString*)searchString{
    
    NSString *post = [NSString stringWithFormat:@"master_category_id=%@&entity[char]=%@",master_category_id,searchString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/entity_search_sign_up.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user_id=51419daef7e4f31bea000032&facebook_id=12" http://localhost:3000/user/add_facebook_id.json


-(void)add_facebook_id:(NSString*)user_id facebook_id:(NSString*)facebook_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&facebook_id=%@",user_id,facebook_id];
    //NSLog(@"value of POst %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user/add_facebook_id.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//curl -X POST -d "user_id=51419daef7e4f31bea000032&user_category_id=51419db3f7e4f31bea000034&search=friend&master_category_id=5130b527f7e4f34f9d000001" http://localhost:3000/user_entity/get_city_and_sub_category.json
-(void)get_city_and_sub_category:(NSString*)user_id user_category_id:(NSString*)user_category_id search:(NSString*)search master_category_id:(NSString*)master_category_id{

    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_category_id=%@&search=%@&master_category_id=%@",user_id,user_category_id,search,master_category_id];
    //NSLog(@"value of POst %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/get_city_and_sub_category.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "email=yogesh.waghmare@techvalens.com&user_id=51502c77f7e4f3ef9b000009&friend_name=Deepak" http://localhost:3000/feedback/invite_user.json
-(void)invite_user:(NSString*)email user_id:(NSString*)user_id friend_name:(NSString*)friend_name{

    NSString *post = [NSString stringWithFormat:@"email=%@&user_id=%@&friend_name=%@",email,user_id,friend_name];
    //NSLog(@"value of POst %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/feedback/invite_user.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

//curl -X POST -d "user_id=5126079d236f17c4bc000014&master_category_id=5125fdec236f17c4bc000001&entity_name=Surya Hotel&address=M.G. Road Indore&lat=20.3436&longitude=78.25424&sub_category=&entity_image=&comment=nice one&rating_count=4&information=&city=" http://localhost:3000/user_entities/suggested_entity.json
-(void)suggested_entity:(NSString*)user_id master_category_id:(NSString*)master_category_id entity_name:(NSString*)entity_name address:(NSString*)address lat:(NSString*)lat longitude:(NSString*)longitude sub_category:(NSString*)sub_category entity_image:(NSString*)entity_image comment:(NSString*)comment rating_count:(NSString*)rating_count information:(NSString*)information city:(NSString*)city{

    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&master_category_id=%@&entity_name=%@&address=%@&lat=%@&longitude=%@&sub_category=%@&entity_image=%@&comment=%@&rating_count=%@&information=%@&city=%@",user_id,master_category_id,entity_name,address,lat,longitude,sub_category,entity_image,comment,rating_count,information,city];
    //NSLog(@"value of POst %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entities/suggested_entity.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];

    
}
//curl -X POST -d "user_id=" http://localhost:3000/user_entity/update_sort_setting.json

-(void)update_sort_setting:(NSString*)user_id{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@",user_id];
    //NSLog(@"value of POst %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-225-243-66.compute-1.amazonaws.com/user_entity/update_sort_setting.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
//**************added by vinod*****************************************************
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if ([self._delegate respondsToSelector:self._callback]) {
		[self._delegate performSelector:self._callback withObject:error];
	}else {
		NSLog(@"Callback is not responding.");
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	//[connection release];
    
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	//[responseData release];
    //
	NSError *error;
    //	SBJSON *json = [SBJSON new] ;
    //	NSDictionary *loginResponse = [json objectWithString:responseString error:&error];
    ////	[responseString release];
    
    //NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *string = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
    string = [string stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    string = [string stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
    string = [string stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
    // NSDictionary *responseDict = (NSDictionary *)[string JSONValue];
    //NSLog(@"response=**********%@",string);
    
    
	if (string == nil){
		if ([self._delegate respondsToSelector:self._callback]) {
			[self._delegate performSelector:self._callback withObject:error];
		}
	}
	else{
		if([self._delegate respondsToSelector:self._callback]) {
			[self._delegate performSelector:self._callback withObject:responseString];
		}else{
			NSLog(@"Callback is not responding.");
		}
	}
}

@end
