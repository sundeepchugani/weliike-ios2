//
//  CommentViewController.m
//  WeLiiKe
//
//  Created by techvalens on 28/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CommentViewController.h"
#import "AppDelegate.h"

extern int checkForFB;
@implementation CommentViewController

@synthesize txtViewForComment,strForClass,strForEntity,btnForFb,dicForDetail;

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
-(IBAction)actionOnback:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"value of Dictionary %@",dicForDetail);
    customRank=[[CustomStarRank alloc] initWithFrame:CGRectMake(170, 60,125, 25)];
    [customRank setValue:0];
    [customRank setUserInteractionEnabled:YES];
    [self.view addSubview:customRank];
    
    txtViewForComment.layer.cornerRadius=5.0;
    txtViewForComment.layer.masksToBounds=YES;
    txtViewForComment.layer.borderWidth=1.5;
    txtViewForComment.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [txtViewForComment becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleChange:)
                                                 name:@"FBLoginComment"
                                               object:nil];
   
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
-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(EntityCommentHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if ([strForEntity isEqualToString:@"entity"]) {
        
        [service EntityComment:[NSString stringWithFormat:@"%d",(int)customRank.value] comment_text:txtViewForComment.text user_id:[dicForDetail valueForKey:@"user_id"] user_entity_id:[dicForDetail valueForKey:@"user_entity_id"] selfUserId:strID];
       
    }else{
         [service PostComment:[dicForDetail valueForKey:@"post_id"] rating_count:[NSString stringWithFormat:@"%d",(int)customRank.value] comment_text:txtViewForComment.text user_id:[dicForDetail valueForKey:@"user_id"] selfUserId:strID];
        
    }
    if ( FBSharing) {
    
    }else{
       [self killHUD];
    }
}

-(void)EntityCommentHandler:(id)sender{
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
            
            NSLog(@"value of %@",strForResponce);
            if ([strForResponce count]>0) {
                txtViewForComment.text=@"";
                //[self.navigationController popViewControllerAnimated:YES];
                
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

-(IBAction)actionOnDone:(id)sender{
   
    if ([txtViewForComment.text length]>0) {
        [self showHUD];
        
        NSMutableDictionary *params;
        if ([strForEntity isEqualToString:@"entity"]) {
            params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      txtViewForComment.text, @"message",[dicForDetail valueForKey:@"user_entity_image"], @"source", nil];
        }else{
            params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      txtViewForComment.text, @"message",[dicForDetail valueForKey:@"post_image"], @"source", nil];
        }
        
        
        if (FBSharing) {
            [self performSelector:@selector(postOnFb:) withObject:params];
        }
        if (TwitterSharing) {
            [self performSelector:@selector(postOnTwitter:) withObject:params];
        }
        
        
        [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
    }
}

-(IBAction)actionOnFacebook:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (btn.tag==0) {
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        // HackbookAppDelegate *delegate = (HackbookAppDelegate *)[[UIApplication sharedApplication] delegate];
        checkForFB=4;
        if (![[appDelegate facebook] isSessionValid]) {
            NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"read_stream",@"offline_access",@"email", nil];
            [[appDelegate facebook] authorize:permissions];
        } else {
            //btn.tag=1;
            //[btn setImage:[UIImage imageNamed:@"fb_selectPost.png"] forState:UIControlStateNormal];
            
            [self apiFQLIMe];
        }
        
    }else{
        FBSharing=NO;
        btn.tag=0;
        [btn setImage:[UIImage imageNamed:@"fb_post.png"] forState:UIControlStateNormal];
    }
    
}
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if ([[appDelegate facebook] isSessionValid]) {
        btnForFb.tag=1;
        [btnForFb setImage:[UIImage imageNamed:@"fb_selectPost.png"] forState:UIControlStateNormal];
        FBSharing=YES;
    }
}
-(IBAction)actionOnTwitter:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (btn.tag==0) {
        
        
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
                                    btn.tag=1;
                                    [btn setImage:[UIImage imageNamed:@"twitter_selectPost.png"] forState:UIControlStateNormal];
                                    TwitterSharing=YES;
                                    
                                });
             }else{
                 
             }
         }];
        
        
    }else{
        btn.tag=0;
        TwitterSharing=NO;
        [btn setImage:[UIImage imageNamed:@"twitter_Post.png"] forState:UIControlStateNormal];
    }
}

-(void)postOnTwitter:(NSDictionary*)dic{
    
    if ([TWTweetComposeViewController canSendTweet])
    {
        // Create account store, followed by a twitter account identifier
        // At this point, twitter is the only account type available
        
        ACAccountStore *accountStore=[[ACAccountStore alloc] init];
        ACAccountType *twitterType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterType];
        
        if ([twitterAccounts count]>0) {
            
            ACAccount *acct = [twitterAccounts objectAtIndex:0];
            UIImage *img;
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if([delegate.dictionaryForImageCacheing objectForKey:[dic valueForKey:@"source"]]){
                img=   [UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:[dic valueForKey:@"source"]]];
            }
            
            TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update_with_media.json"] parameters:nil requestMethod:TWRequestMethodPOST];
            [postRequest setAccount:acct];
            
            //add text
            [postRequest addMultiPartData:[[NSString stringWithFormat:@"%@",[dic valueForKey:@"message"]] dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data"];
            //add image
            [postRequest addMultiPartData:UIImagePNGRepresentation(img) withName:@"media" type:@"multipart/form-data"];
            
            // Set the account used to post the tweet.
            [postRequest setAccount:acct];
            
            // Post the request
            // Block handler to manage the response
            [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
             {
                 if (FBSharing==NO) {
                       //[self killHUD];
                 }
                 NSLog(@"Twitter response, HTTP response: %i", [urlResponse statusCode]);
             }];
            
            //[self performSelector:@selector(getTwitterFriendsForAccount:) withObject:acct afterDelay:0.0];
            
        }
        
    }
}



-(void)postOnFb:(NSDictionary*)dic{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[delegate facebook] isSessionValid]) {
        
        //if([delegate.dictionaryForImageCacheing objectForKey:[dic valueForKey:@"source"]]){
        // UIImage *img=   [UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:[dic valueForKey:@"source"]]];
       // NSData *imageData = UIImagePNGRepresentation(img);
        //NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dic valueForKey:@"message"],@"message", imageData, @"source", nil];
            
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"post", @"type",
                                           [dic valueForKey:@"source"], @"picture",
                                           @"http://my.web.com", @"link",
                                           [dic valueForKey:@"message"],@"message",
                                           nil];
        [[delegate facebook] requestWithGraphPath:@"me/feed" andParams:params andHttpMethod:@"POST" andDelegate:self];
        //}
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
    [self killHUD];
    NSLog(@"value of result %@",result);
    if ([result valueForKey:@"uid"]!=nil) {
        [[NSUserDefaults standardUserDefaults] setValue:[result valueForKey:@"uid"] forKey:@"facebookIdFB"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBIdUpdate" object:self userInfo:nil];
    }
    
}

- (void)requestLoading:(FBRequest *)request{
    
    //NSLog(@"valkue iof %@",request);
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data{
    // NSLog(@"valkue iof %@",data);
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
