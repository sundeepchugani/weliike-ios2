//
//  RespostViewController.m
//  WeLiiKe
//
//  Created by anoop gupta on 13/04/13.
//
//

#import "RespostViewController.h"
#import "UserForMessageController.h"

extern int checkForFB;
@interface RespostViewController ()

@end

@implementation RespostViewController

@synthesize btnForDone,tableForSearch,txtForGroup,txtForMessage;
@synthesize btnForFb,btnForEmail,btnForTwitter,scrollViewForRepost,txtViewForCaption,strForAddress;
@synthesize strForEntity,dicForDetail;

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
    dicForSelecteGroup=[[NSMutableDictionary alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleChange:)
                                                 name:@"FBLoginRepost"
                                               object:nil];
    
    checkForHideGroupAndMessage=0;
    arrayForServerData=[[NSMutableArray alloc] init];
    [self performSelector:@selector(makeScreen)];
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

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self performSelector:@selector(getAddressLocation) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(callWebServiceForGourp) withObject:nil afterDelay:0.5];
}

-(void)callWebServiceForGourp{
    
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetGroupHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetGroup:strID];
    
    
    
    
}

-(void)GetGroupHandler:(id)sender{
    
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
            
            if ([strForResponce count]>0) {
                //[self performSelector:@selector(moveNextScreen)];
                arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                arrayForSearchResult=[arrayForServerData mutableCopy];
                NSLog(@"array for %@",arrayForServerData);
                
                [tableForSearch reloadData];
            }else{
                
                
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

-(void)makeScreen{
//    
//    if ([[self.view subviews] count]>6) {
//        for (int i=[self.view.subviews count]; i>6; i--) {
//            NSLog(@"count of i = %d",i);
//            UIView *view=[self.view.subviews objectAtIndex:i-1];
//            [view removeFromSuperview];
//        }
//    }
    
    if ([[scrollViewForRepost subviews] count]>0) {
        for (int i=[scrollViewForRepost.subviews count]; i>0; i--) {
            NSLog(@"count of i = %d",i);
            id view=[scrollViewForRepost.subviews objectAtIndex:i-1];
            [view removeFromSuperview];
        }
    }
    UIView *viewForNewsFeedAndGroup=[[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 100)];
    [viewForNewsFeedAndGroup setBackgroundColor:[UIColor whiteColor]];
    
    
    UIImageView *imgViewForSaprator=[[UIImageView alloc] initWithFrame:CGRectMake(0, -2, 320, 4)];
    [imgViewForSaprator setImage:[UIImage imageNamed:@"seperator_line.png"]];
    [viewForNewsFeedAndGroup addSubview:imgViewForSaprator];
    
    UIButton *btnForNewsFeed=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 300, 40)];
    [btnForNewsFeed setTitle:@"Repost on my feed" forState:UIControlStateNormal];
    [btnForNewsFeed setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnForNewsFeed.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btnForNewsFeed setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForNewsFeed setBackgroundColor:[UIColor clearColor]];
    //btnForComment.layer.cornerRadius=5;
    //btnForComment.layer.masksToBounds=YES;
    //[btnForComment addTarget:self action:@selector(actionOnComment:) forControlEvents:UIControlEventTouchUpInside];
    [viewForNewsFeedAndGroup addSubview:btnForNewsFeed];
    
    //plus_inactive
    
    btnForFeedShare =[[UIButton alloc] initWithFrame:CGRectMake(240, 8, 40, 23)];
    btnForFeedShare.tag=1;
    [btnForFeedShare addTarget:self action:@selector(actionOnFeedShare:) forControlEvents:UIControlEventTouchUpInside];
    [btnForFeedShare setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
    [btnForNewsFeed addSubview:btnForFeedShare];
    
    UIImageView *imgViewForSaprator1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 4)];
    [imgViewForSaprator1 setImage:[UIImage imageNamed:@"seperator_line.png"]];
    [viewForNewsFeedAndGroup addSubview:imgViewForSaprator1];
    
    UIButton *btnForGroup=[[UIButton alloc] initWithFrame:CGRectMake(10, 50, 300, 40)];
    [btnForGroup setTitle:@"Groups" forState:UIControlStateNormal];
    [btnForGroup setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnForGroup.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btnForGroup setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForGroup setBackgroundColor:[UIColor clearColor]];
    //btnForComment.layer.cornerRadius=5;
    //btnForComment.layer.masksToBounds=YES;
    [btnForGroup addTarget:self action:@selector(actionOnGroup:) forControlEvents:UIControlEventTouchUpInside];
    [viewForNewsFeedAndGroup addSubview:btnForGroup];
    UIImageView *imgViewPlus1=[[UIImageView alloc] initWithFrame:CGRectMake(240, 8, 40, 23)];
    [imgViewPlus1 setImage:[UIImage imageNamed:@"plus_inactive.png"]];
    [btnForGroup addSubview:imgViewPlus1];
    
    UIImageView *imgViewForSaprator2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 98, 320, 4)];
    [imgViewForSaprator2 setImage:[UIImage imageNamed:@"seperator_line.png"]];
    [viewForNewsFeedAndGroup addSubview:imgViewForSaprator2];
    //[self.view addSubview:viewForNewsFeedAndGroup];
    [scrollViewForRepost addSubview:viewForNewsFeedAndGroup];
    
    tableForSearch=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 0)];
    [tableForSearch setDelegate:self];
    [tableForSearch setBackgroundColor:[UIColor clearColor]];
    [tableForSearch setDataSource:self];
    [viewForNewsFeedAndGroup addSubview:tableForSearch];
    
    
    
    UIView *viewForMessage=[[UIView alloc] initWithFrame:CGRectMake(0, 155, 320, 50)];
    [viewForMessage setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btnForMessage=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
    [btnForMessage setTitle:@"Messages" forState:UIControlStateNormal];
    [btnForMessage setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnForMessage.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btnForMessage setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForMessage setBackgroundColor:[UIColor clearColor]];
    //btnForComment.layer.cornerRadius=5;
    //btnForComment.layer.masksToBounds=YES;
    [btnForMessage addTarget:self action:@selector(actionOnMessage:) forControlEvents:UIControlEventTouchUpInside];
    [viewForMessage addSubview:btnForMessage];
    
    UIImageView *imgViewPlus2=[[UIImageView alloc] initWithFrame:CGRectMake(240, 8, 40, 23)];
    [imgViewPlus2 setImage:[UIImage imageNamed:@"plus_inactive.png"]];
    [btnForMessage addSubview:imgViewPlus2];
    
    
    UIImageView *imgViewForSaprator3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 4)];
    [imgViewForSaprator3 setImage:[UIImage imageNamed:@"seperator_line.png"]];
    [viewForMessage addSubview:imgViewForSaprator3];
    //[self.view addSubview:viewForMessage];
    [scrollViewForRepost addSubview:viewForMessage];
    
    UIImageView *imgViewForbg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 50)];
    imgViewForbg.hidden=YES;
    [imgViewForbg setImage:[UIImage imageNamed:@"center_bar.png"]];
    [viewForMessage addSubview:imgViewForbg];
    
    txtForMessage = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 280, 30)];
    [txtForMessage setBorderStyle:UITextBorderStyleRoundedRect];
    [txtForMessage setPlaceholder:@"To: Type a name"];
    [txtForMessage setTextColor:[UIColor darkGrayColor]];
    [txtForMessage setFont:[UIFont systemFontOfSize:15]];
    txtForMessage.delegate=self;
    txtForMessage.hidden=YES;
    [viewForMessage addSubview:txtForMessage];
    
    
    txtViewForCaption = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(20, 220, 280, 70)];
    [txtViewForCaption setFont:[UIFont systemFontOfSize:14]];
    txtViewForCaption.placeholder=@"write here Caption";
    //[txtViewForCaption setScrollEnabled:NO];
    //[txtViewForCaption setUserInteractionEnabled:NO];
    //[txtViewForCaption setBackgroundColor:[UIColor clearColor]];
    //[txtViewForCaption setText:@"A lot of text"];
    txtViewForCaption.layer.borderWidth=2.0;
    txtViewForCaption.delegate=self;
    txtViewForCaption.layer.borderColor=[UIColor colorWithRed:51.0/255.0 green:151.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
    txtViewForCaption.layer.cornerRadius=5.0;
    txtViewForCaption.layer.masksToBounds=YES;
    [scrollViewForRepost addSubview:txtViewForCaption];
    
    
    UIView *viewForShare=[[UIView alloc] initWithFrame:CGRectMake(0, 300, 320, 70)];
    [viewForShare setBackgroundColor:[UIColor clearColor]];
    
    UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    [lblForAddress setText:@"Other social networks"];
    [lblForAddress setFont:[UIFont boldSystemFontOfSize:15]];
    [lblForAddress setTextAlignment:UITextAlignmentLeft];
    [lblForAddress setBackgroundColor:[UIColor clearColor]];
    [lblForAddress setTextColor:[UIColor darkGrayColor]];
    [viewForShare addSubview:lblForAddress];
    
    //[self.view addSubview:viewForShare];
    [scrollViewForRepost addSubview:viewForShare];
    
    btnForFb=[[UIButton alloc] initWithFrame:CGRectMake(10, 30, 35, 35)];
    [btnForFb setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForFb setBackgroundColor:[UIColor clearColor]];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FBPostRepost"]) {
        
        //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FBPost"];
        btnForFb.tag=1;
        [btnForFb setImage:[UIImage imageNamed:@"fb_selectPost.png"] forState:UIControlStateNormal];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FBPostRepost"];
        btnForFb.tag=0;
        [btnForFb setImage:[UIImage imageNamed:@"fb_post.png"] forState:UIControlStateNormal];
        
    }
    
    [btnForFb addTarget:self action:@selector(actionOnFb:) forControlEvents:UIControlEventTouchUpInside];
    [viewForShare addSubview:btnForFb];
    
    
    btnForTwitter=[[UIButton alloc] initWithFrame:CGRectMake(60, 30, 45, 35)];
    
    [btnForTwitter setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForTwitter setBackgroundColor:[UIColor clearColor]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TWPostRepost"]) {
        
        btnForTwitter.tag=1;
        [btnForTwitter setImage:[UIImage imageNamed:@"twitter_selectPost.png"] forState:UIControlStateNormal];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TWPostRepost"];
        btnForTwitter.tag=0;
        [btnForTwitter setImage:[UIImage imageNamed:@"twitter_Post.png"] forState:UIControlStateNormal];
    }
    
    
    [btnForTwitter addTarget:self action:@selector(actionOnTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [viewForShare addSubview:btnForTwitter];
    
    btnForEmail=[[UIButton alloc] initWithFrame:CGRectMake(115, 30, 45, 35)];
    [btnForEmail setImage:[UIImage imageNamed:@"email_post.png"] forState:UIControlStateNormal];
    [btnForEmail setBackgroundColor:[UIColor clearColor]];
    btnForEmail.tag=0;
    [btnForEmail addTarget:self action:@selector(actionOnEmail:) forControlEvents:UIControlEventTouchUpInside];
    [viewForShare addSubview:btnForEmail];
    
    [scrollViewForRepost setContentSize:CGSizeMake(320, 500)];
    if (checkForHideGroupAndMessage==1) {
        
        [UIView beginAnimations:@"Resize" context:nil];
        [UIView setAnimationDuration:0.3];
        
        [tableForSearch setFrame:CGRectMake(0, 100, 320, 140)];
        [viewForNewsFeedAndGroup setFrame:CGRectMake(0, 55, 320, 240)];
        [viewForMessage setFrame:CGRectMake(0, 295, 320, 50)];
        [txtViewForCaption setFrame:CGRectMake(20, 360, 280, 70)];
        [viewForShare setFrame:CGRectMake(0, 450, 320, 70)];
        
        [UIView commitAnimations];
        [scrollViewForRepost setContentSize:CGSizeMake(320, 600)];
        
    }
    if (checkForHideGroupAndMessage==2) {
        //[tableForSearch setFrame:CGRectMake(0, 100, 320, 140)];
        //[viewForNewsFeedAndGroup setFrame:CGRectMake(0, 90, 320, 240)];
        
        [UIView beginAnimations:@"Resize" context:nil];
        [UIView setAnimationDuration:0.3];
        [viewForMessage setFrame:CGRectMake(0, 155, 320, 100)];
        txtForMessage.hidden=NO;
        imgViewForbg.hidden=NO;
        [txtViewForCaption setFrame:CGRectMake(20, 270, 280, 70)];
        [viewForShare setFrame:CGRectMake(0, 360, 320, 70)];
        [UIView commitAnimations];
        [scrollViewForRepost setContentSize:CGSizeMake(320, 500)];
    }
    
}

-(void)actionOnFeedShare:(UIButton*)sender{

    if (sender.tag==1) {
        sender.tag=0;
        [sender setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
    }else {
        sender.tag=1;
        [sender setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]) {
        [txtViewForCaption resignFirstResponder];
    }
    if ([txtViewForCaption.text length]==1 && [text isEqualToString:@" "]) {
        txtViewForCaption.placeholder=@"write here Caption";
    }
    //NSLog(@"value of TEXT %@",text);
    return YES;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [scrollViewForRepost setContentSize:CGSizeMake(320, scrollViewForRepost.contentSize.height+150)];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [scrollViewForRepost setContentSize:CGSizeMake(320, scrollViewForRepost.contentSize.height-150)];
    return YES;
}

-(void)actionOnFb:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (btn.tag==0) {
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        // HackbookAppDelegate *delegate = (HackbookAppDelegate *)[[UIApplication sharedApplication] delegate];
        checkForFB=5;
        if (![[appDelegate facebook] isSessionValid]) {
            NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"read_stream",@"offline_access",@"email", nil];
            [[appDelegate facebook] authorize:permissions];
        } else {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FBPostRepost"];
            btn.tag=1;
            [btn setImage:[UIImage imageNamed:@"fb_selectPost.png"] forState:UIControlStateNormal];
            [self apiFQLIMe];
        }
        
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FBPostRepost"];
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
        btnForFb.tag=5;
        [btnForFb setImage:[UIImage imageNamed:@"fb_selectPost.png"] forState:UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FBPostRepost"];
    }
}

-(void)actionOnTwitter:(id)sender{
    
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
                                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TWPostRepost"];
                                    //[self performSelector:@selector(fetchData)];
                                    //return ;
                                    
                                });
             }else{
                 
             }
         }];
        
        
    }else{
        btn.tag=0;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TWPostRepost"];
        [btn setImage:[UIImage imageNamed:@"twitter_Post.png"] forState:UIControlStateNormal];
    }
}

-(void)actionOnEmail:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (btn.tag==0) {
        btn.tag=1;
        [btn setImage:[UIImage imageNamed:@"email_selectPost.png"] forState:UIControlStateNormal];
        EmailContects *obj=[[EmailContects alloc] init];
        [self.navigationController pushViewController:obj animated:YES];
        
    }else{
        btn.tag=0;
        [btn setImage:[UIImage imageNamed:@"email_post.png"] forState:UIControlStateNormal];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  [arrayForSearchResult count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    FollowAndFollowingCell *cell= (FollowAndFollowingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[FollowAndFollowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    if (indexPath.row<[arrayForSearchResult count]) {
        cell.lblName.text=[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"group_name"];
        cell.imgBg.hidden=NO;
        NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"group_image_url"]];
        [cell.imgProfile loadImage:strProfile];
        [cell.imgProfile setBackgroundColor:[UIColor grayColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        
        
        cell.imgProfile.tag=indexPath.row;
        //[cell.imgProfile loadImage:strProfile];
        [cell.lblName setText:[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"group_name"]];//user_name
        cell.lblForCountEntity.hidden=YES;
        cell.imgForAddSing.hidden=NO;
        if ([[dicForSelecteGroup valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"YES"]) {
            //cell.imgBg.hidden=NO;
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
        }else{
            [cell.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
        }
        return cell;
        
        
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<[arrayForSearchResult count] && indexPath.section==0) {
        if ([[dicForSelecteGroup valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"YES"]) {
            [dicForSelecteGroup setValue:@"NO" forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        }else{
            [dicForSelecteGroup setValue:@"YES" forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        }
        
        [tableForSearch reloadData];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *viewForHeader=[[UIView alloc] initWithFrame:CGRectMake(0, -5, 320, 45)];
    UIImageView *imgViewForBg=[[UIImageView alloc] initWithFrame:CGRectMake(0,-5, 320, 45)];
    [imgViewForBg setImage:[UIImage imageNamed:@"center_bar.png"]];
    [viewForHeader addSubview:imgViewForBg];
    //search_bar
    UIImageView *imgViewForSaprator3=[[UIImageView alloc] initWithFrame:CGRectMake(20, 3, 280, 32)];
    [imgViewForSaprator3 setImage:[UIImage imageNamed:@"search_bar.png"]];
    [viewForHeader addSubview:imgViewForSaprator3];
    [viewForHeader setBackgroundColor:[UIColor clearColor]];
    
    txtForGroup = [[UITextField alloc] initWithFrame:CGRectMake(55, 9, 220, 25)];
    [txtForGroup setPlaceholder:@"Type a group name"];
    [txtForGroup setTextColor:[UIColor darkGrayColor]];
    [txtForGroup setFont:[UIFont systemFontOfSize:15]];
    txtForGroup.delegate=self;
    [viewForHeader addSubview:txtForGroup];
    
    return viewForHeader;
    
}

-(void)actionOnGroup:(id)sender{
    if (checkForHideGroupAndMessage==1) {
        checkForHideGroupAndMessage=0;
    }else{
        checkForHideGroupAndMessage=1;
    }
    
    [self performSelector:@selector(makeScreen)];
}

-(void)actionOnMessage:(id)sender{
    if (checkForHideGroupAndMessage==2) {
        checkForHideGroupAndMessage=0;
    }else{
        checkForHideGroupAndMessage=2;
    }
    
    [self performSelector:@selector(makeScreen)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[arrayForSearchResult removeAllObjects];
    //arrayForSearchResult=[arrayForServerData mutableCopy];
    [textField resignFirstResponder];
    //[tableForSearch reloadData];
    
    if (txtForMessage==textField) {
        
        if ([txtForMessage.text length]>1) {
            
            UserForMessageController *obj=[[UserForMessageController alloc] init];
            obj.strForSearch=textField.text;
            [self.navigationController pushViewController:obj animated:YES];
            
        }else{
            //                    UIAlertView *errorAlert = [[UIAlertView alloc]
            //                                               initWithTitle: @"Message"
            //                                               message: @"Please enter more one character to search friends."
            //                                               delegate:nil
            //                                               cancelButtonTitle:@"OK"
            //                                               otherButtonTitles:nil];
            //                    [errorAlert show];
        }
    }

    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextView *)textView{
    
    CGPoint currentCenter = [self.view center];
    CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y - 150);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.view setCenter:newCenter];
    [UIView commitAnimations];
    
    
}
- (void)textFieldDidEndEditing:(UITextView *)textView{
    
    CGPoint currentCenter = [self.view center];
    CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y + 150);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.view setCenter:newCenter];
    [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text length]>0) {
        //resultObjectsArray = [NSMutableArray array];
        [arrayForSearchResult removeAllObjects];
        for(NSDictionary *wine in arrayForServerData)
        {
            NSString *wineName = [wine objectForKey:@"first_name"];
            NSRange range = [wineName rangeOfString:textField.text options:NSCaseInsensitiveSearch];
            if(range.location != NSNotFound)
                [arrayForSearchResult addObject:wine];
        }
        [tableForSearch reloadData];
    }
    return YES;
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
                NSLog(@"Twitter response, HTTP response: %i", [urlResponse statusCode]);
             }];
            
            //[self performSelector:@selector(getTwitterFriendsForAccount:) withObject:acct afterDelay:0.0];
            
        }
        
    }
}


-(void)postOnFb:(NSDictionary*)dic{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[delegate facebook] isSessionValid]) {
        
        if([delegate.dictionaryForImageCacheing objectForKey:[dic valueForKey:@"source"]]){
            UIImage *img=   [UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:[dic valueForKey:@"source"]]];
            NSData *imageData = UIImagePNGRepresentation(img);
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [dic valueForKey:@"message"],@"message", imageData, @"source", nil];
            [[delegate facebook] requestWithGraphPath:@"me/photos" andParams:params andHttpMethod:@"POST" andDelegate:self];
        }
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



-(void)getAddressLocation{
    
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:delegate.locationManager.location // You can pass aLocation here instead
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       dispatch_async(dispatch_get_main_queue(),^ {
                           if (placemarks.count == 1) {
                               CLPlacemark *place = [placemarks objectAtIndex:0];
                               //NSString *zipString = [place.addressDictionary valueForKey:@"ZIP"];
                               NSArray *arrayForAddress=[place.addressDictionary valueForKey:@"FormattedAddressLines"];
                               [self performSelectorInBackground:@selector(showWeatherFor:) withObject:[arrayForAddress componentsJoinedByString:@","]];
                               
                           }
                           
                       });
                       
                   }];
}

-(void)showWeatherFor:(NSString *)zipString{
    strForAddress=zipString;
}


-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)actionOnDone:(id)sender{
    
    [self showHUD];
    
    NSMutableArray *arrayForGroupID=[[NSMutableArray alloc] init];
    
    for (NSString *key in dicForSelecteGroup) {
        if ([[dicForSelecteGroup valueForKey:key] isEqualToString:@"YES"]) {
            //if (![appDelegate.arrayOfUserForMessage containsObject:[arrayForUserList objectAtIndex:[key intValue]]]) {
            [arrayForGroupID addObject:[[arrayForSearchResult objectAtIndex:[key intValue]] valueForKey:@"_id"]];
            //}
            
        }
        
    }
    NSString *strForGroupID=[arrayForGroupID componentsJoinedByString:@","];
    [[NSUserDefaults standardUserDefaults] setValue:strForGroupID forKey:@"GroupIdToShare"];
    
    [self performSelector:@selector(callWebserviceForRepost) withObject:nil afterDelay:0.2];
    
    
}

-(void)callWebserviceForRepost{

    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(RepostHandler:)];
    
    
    NSString *strForPostID=@"";
    NSString *strForPostName=@"";
    NSString *strForPostOrEnity=@"";
    NSMutableDictionary *params;
    if ([strForEntity isEqualToString:@"entity"]) {
        strForPostOrEnity=@"0";
        if ([dicForDetail valueForKey:@"user_entity_id"]==nil) {
            strForPostID=[dicForDetail valueForKey:@"entity_id"];
        }else{
            strForPostID=[dicForDetail valueForKey:@"user_entity_id"];
        }
        
        if ([dicForDetail valueForKey:@"user_entity_name"]==nil) {
            strForPostName=[dicForDetail valueForKey:@"entity_name"];
        }else{
            strForPostName=[dicForDetail valueForKey:@"user_entity_name"];
        }
        
        NSString *strForURL=@"";
        if ([dicForDetail valueForKey:@"user_entity_image"]==nil) {
            strForURL=[dicForDetail valueForKey:@"entity_image"];
        }else{
            strForURL=[dicForDetail valueForKey:@"user_entity_image"];
        }
       
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  [NSString stringWithFormat:@"%@ | %@",strForPostName,txtViewForCaption.text], @"message",strForURL, @"source", nil];
    }else{
        strForPostOrEnity=@"1";
        strForPostID=[dicForDetail valueForKey:@"post_id"];
        strForPostName=[dicForDetail valueForKey:@"post_name"];
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  [NSString stringWithFormat:@"%@ | %@",strForPostName,txtViewForCaption.text], @"message",[dicForDetail valueForKey:@"post_image"], @"source", nil];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TWPostRepost"]) {
        //[NSThread detachNewThreadSelector:@selector(postOnTwitter:) toTarget:self withObject:params];
        NSLog(@"In twitter post ************************");
        [self performSelector:@selector(postOnTwitter:) withObject:params];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FBPostRepost"]) {
        NSLog(@"In FB post ************************");
        [self performSelector:@selector(postOnFb:) withObject:params];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FBPostRepost"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TWPostRepost"];
    //return;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"value of array %@",appDelegate.arrayOfEmailContact);
    
    NSMutableArray *arrayForEmail=[[NSMutableArray alloc] init];
    for (int i=0; i<[appDelegate.arrayOfEmailContact count]; i++) {
        [arrayForEmail addObject:[[appDelegate.arrayOfEmailContact objectAtIndex:i] valueForKey:@"EMAIL"]];
    }
    
    
    //NSData *imageData=UIImagePNGRepresentation(img);
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *strForlate=[NSString stringWithFormat:@"%f",delegate.currentLatitude];
    NSString *strForlong=[NSString stringWithFormat:@"%f",delegate.currentLongitute];
    
    //NSArray *strForResponce=[service Repost:strID post_id:strForPostID lat:strForlate longitude:strForlong entity_name:strForPostName sub_category:@"" comment:txtViewForCaption.text rating_count:@"2" address:strForAddress user_entity_id:strForPostID post:strForPostOrEnity];
    NSMutableArray *array=[NSMutableArray array];
    for (int i=0; i<[appDelegate.arrayOfUserForMessage count] ; i++) {
        
        [array addObject:[[appDelegate.arrayOfUserForMessage objectAtIndex:i] valueForKey:@"user_id"]];
    }
    
    NSString *strForUserIDToShare=[array componentsJoinedByString:@","];
    
    [service Repost:strID post_id:strForPostID lat:strForlate longitude:strForlong entity_name:strForPostName sub_category:@"" comment:txtViewForCaption.text rating_count:@"2" address:strForAddress user_entity_id:strForPostID post:strForPostOrEnity receiver_id:strForUserIDToShare group_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"GroupIdToShare"] feed:[NSString stringWithFormat:@"%d",btnForFeedShare.tag]];
    // NSLog(@"value of savemedia response %@",strForResponce);
    
    
}

-(void)RepostHandler:(id)sender{
    
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
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"GroupIdToShare"];
            AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
            if ([delegate.arrayOfUserForMessage count]>0) {
                [delegate.arrayOfUserForMessage removeAllObjects];
            }
            
            txtViewForCaption.text=@"";
            [self performSelector:@selector(makeScreen)];
            //txtViewForCaption.placeholder=@"write caption";
            
            if ([strForResponce count]>0) {
                //[self performSelector:@selector(moveNextScreen)];
                [self.navigationController popViewControllerAnimated:YES];
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"Image Post Successfully..."
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end