//
//  MessagesViewController.m
//  WeLiiKe
//
//  Created by anoop gupta on 02/05/13.
//
//

#import "MessagesViewController.h"
#import "OtherUserProfile.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController
@synthesize tableViewForGroup,btnForActi,btnForAll,btnForMessage,btnForReq;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    dicForServerData=[[NSMutableDictionary alloc] init];
    arrayForMessage=[[NSMutableArray alloc] init];
    arrayForFriendReq=[[NSMutableArray alloc] init];
    arrayForActivity=[[NSMutableArray alloc] init];
    indexForSelection=0;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)actionOnBack:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
}

-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(Aget_all_message_threadsHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service get_all_message_threads:strID];
    
}


-(void)Aget_all_message_threadsHandler:(id)sender{
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
            if ([strForResponce count]>0) {
                if ([strForResponce isKindOfClass:[NSDictionary class]]) {
                    
                    dicForServerData=[[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)strForResponce];
                    arrayForMessage =[[NSMutableArray alloc] initWithArray:[dicForServerData valueForKey:@"message"] copyItems:YES];
                    
                    arrayForActivity =[[NSMutableArray alloc] initWithArray:[dicForServerData valueForKey:@"activity"] copyItems:YES];
                    arrayForFriendReq =[[NSMutableArray alloc] initWithArray:[dicForServerData valueForKey:@"friend_request"] copyItems:YES];
                    [tableViewForGroup reloadData];
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


-(float)calculateHeightOfLabel:(NSString*)text{
    RTLabel *lblForHeight=[[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 250, 1000)];
    [lblForHeight setText:text];
    CGSize optimumSize = [lblForHeight optimumSize];
    if (optimumSize.height<20) {
        return 20+55;
    }
    return optimumSize.height+55;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (indexForSelection!=0) {
            return 1;
    }
    return  3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
    if (indexForSelection!=0) {
        if (indexForSelection==1) {
            return [arrayForMessage count];
        }else if (indexForSelection==2) {
            return [arrayForFriendReq count];
        }else if (indexForSelection==3) {
            return [arrayForActivity count];
        }
    }
    
    if (section==0) {
        return [arrayForMessage count];
    }
    if (section==1) {
        return [arrayForFriendReq count];
    }
    if (section==2) {
        return [arrayForActivity count];
    }
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    if (indexForSelection!=0) {
        if (indexForSelection==1) {
            
            NSDictionary *dicForMessage=[arrayForMessage objectAtIndex:indexPath.row];
            CommentCell *cellComment= (CommentCell*)[tableView dequeueReusableCellWithIdentifier:nil];
            
            if (cellComment == nil) {
                cellComment = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            }
            cellComment.selectionStyle=UITableViewCellSelectionStyleNone;
            NSString *str=[NSString stringWithFormat:@"%@",[dicForMessage valueForKey:@"profile_picture"]];
            [cellComment.imgForProfile loadImage:str];
            [cellComment.imgForProfile setTitle:[dicForMessage valueForKey:@"user_id"] forState:UIControlStateNormal];
            [cellComment.imgForProfile setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [cellComment.imgForProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
            [cellComment.btnForName setTitle:[dicForMessage valueForKey:@"user_name"] forState:UIControlStateNormal];
            int height=0;
            if (![[dicForMessage valueForKey:@"message_body"] isEqual:[NSNull null]]) {
                if ([[dicForMessage valueForKey:@"message_body"] length]>0) {
                    NSString *strForComment=[NSString stringWithFormat:@"%@",[dicForMessage valueForKey:@"message_body"]];
                    cellComment.lblForComment.text=strForComment;
                    height=[self calculateHeightOfLabel:[dicForMessage valueForKey:@"comment_text"]];
                    [cellComment.lblForComment setFrame:CGRectMake(50, 25, 250, height)];
                }
            }
            
            
            [cellComment.starRate setHidden:YES];
            
            [cellComment.lblForDate setText:@"20 Hr"];
            if (height==0) {
                height=75;
            }
            [cellComment.lblForDate setFrame:CGRectMake(260, height-25, 45, 20)];
            
            return cellComment;

        }else if (indexForSelection==2) {

        }else if (indexForSelection==3) {
        
        }
    }else{
        if (indexPath.section==0) {
            
            NSDictionary *dicForMessage=[arrayForMessage objectAtIndex:indexPath.row];
            CommentCell *cellComment= (CommentCell*)[tableView dequeueReusableCellWithIdentifier:nil];
            
            if (cellComment == nil) {
                cellComment = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            }
            cellComment.selectionStyle=UITableViewCellSelectionStyleNone;
            NSString *str=[NSString stringWithFormat:@"%@",[dicForMessage valueForKey:@"profile_picture"]];
            [cellComment.imgForProfile loadImage:str];
            [cellComment.imgForProfile setTitle:[dicForMessage valueForKey:@"user_id"] forState:UIControlStateNormal];
            [cellComment.imgForProfile setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [cellComment.imgForProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
            [cellComment.btnForName setTitle:[dicForMessage valueForKey:@"user_name"] forState:UIControlStateNormal];
            int height=0;
            if (![[dicForMessage valueForKey:@"message_body"] isEqual:[NSNull null]]) {
                if ([[dicForMessage valueForKey:@"message_body"] length]>0) {
                    NSString *strForComment=[NSString stringWithFormat:@"%@",[dicForMessage valueForKey:@"message_body"]];
                    cellComment.lblForComment.text=strForComment;
                    height=[self calculateHeightOfLabel:[dicForMessage valueForKey:@"comment_text"]];
                    [cellComment.lblForComment setFrame:CGRectMake(50, 25, 250, height)];
                }
            }
            
            
            [cellComment.starRate setHidden:YES];
            
            [cellComment.lblForDate setText:@"20 Hr"];
            if (height==0) {
                height=75;
            }
            [cellComment.lblForDate setFrame:CGRectMake(260, height-25, 45, 20)];
            
            return cellComment;
            
        }else if (indexPath.section==1){
            
        }else if (indexPath.section==2){
            
            
        }
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        NSString *strMessage;
        if (![[[arrayForMessage objectAtIndex:indexPath.row] valueForKey:@"message_body"] isEqual:[NSNull null]]) {
            strMessage=[[arrayForMessage objectAtIndex:indexPath.row] valueForKey:@"message_body"];
        }
        
        int height=(int)[self calculateHeightOfLabel:strMessage];
        return height;
    }else if (indexPath.section==1){
        
    }else if (indexPath.section==2){
        
        
    }

    return 0;
}

-(void)actionOnUserProfile:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    NSString *str=[btn currentTitle];
    if ([str length]>0) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=str;
        [self.navigationController pushViewController:obj animated:YES];
    }
}



-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewForHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];        
    
    UIImageView *viewForCommentAndLike=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    viewForCommentAndLike.userInteractionEnabled=YES;
    [viewForCommentAndLike setImage:[UIImage imageNamed:@"center_bar.png"]];
    [viewForCommentAndLike setBackgroundColor:[UIColor clearColor]];
    [viewForHeader addSubview:viewForCommentAndLike];
    
    
    UILabel *lblForTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    [lblForTitle setBackgroundColor:[UIColor clearColor]];
    [lblForTitle setTextColor:[UIColor darkGrayColor]];
    [lblForTitle setFont:[UIFont boldSystemFontOfSize:15]];
    NSString *strTitle=@"";
    if (indexForSelection!=0) {
        if (indexForSelection==1) {
            strTitle=@"Messages & groups";
        }else if (indexForSelection==2) {
            strTitle=@"Friends Requests";
        }else if (indexForSelection==3) {
            strTitle=@"Activity";
        }
    }else{
        if (section==0) {
            strTitle=@"Messages & groups";
        }
        if (section==1) {
            strTitle=@"Friends Requests";
        }
        if (section==2) {
            strTitle=@"Activity";
        }
    }
    [lblForTitle setText:strTitle];
    [viewForHeader addSubview:lblForTitle];
    
    return viewForHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (indexForSelection!=0) {
        if (section==0) {
            return 30;
        }else{
        
        }
        return 0;
    }
    return 30;
}

-(IBAction)actionOnAll:(id)sender{
    indexForSelection=0;
    [tableViewForGroup reloadData];
}
-(IBAction)actionOnMessage:(id)sender{
    indexForSelection=1;
    [tableViewForGroup reloadData];
}
-(IBAction)actionOnReq:(id)sender{
    indexForSelection=2;
    [tableViewForGroup reloadData];
}
-(IBAction)actionOnActivity:(id)sender{
    indexForSelection=3;
    [tableViewForGroup reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
