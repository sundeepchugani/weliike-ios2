//
//  EntityDetailViewController.m
//  WeLiiKe
//
//  Created by anoop gupta on 13/04/13.
//
//

#import "EntityDetailViewController.h"
#import "WeLiikeWebService.h"

@interface EntityDetailViewController ()

@end

@implementation EntityDetailViewController
@synthesize tableViewForEntity,dicForDetail,strForEntity;

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
    arrayForServerData=[[NSMutableArray alloc] init];
    NSLog(@"valeu of Dic %@",dicForDetail);
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showHUD]; 
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
}

-(void)callWebService{
    
   WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(all_entity_commentsHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strForID=@"";
    if ([strForEntity isEqualToString:@"entity"]) {
        strForID=[dicForDetail valueForKey:@"user_entity_id"];
         [service all_entity_comments:strForID user_id:strID];
    }else{
        strForID=[dicForDetail valueForKey:@"post_id"];
         [service all_post_comments:strForID user_id:strID];
    }
    
}

-(void)all_entity_commentsHandler:(id)sender{
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
                arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce];
                [tableViewForEntity reloadData];
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

-(float)calculateHeightOfLabel:(NSString*)text{
    RTLabel *lblForHeight=[[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 250, 1000)];
    [lblForHeight setText:text];
    CGSize optimumSize = [lblForHeight optimumSize];
    if (optimumSize.height<20) {
        return 20+55;
    }
    return optimumSize.height+55;
}

-(IBAction)actionOnBack:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([dicForDetail count]>0) {
        return 1;
    }
    return  0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
    if ([dicForDetail count]>0) {
        return [arrayForServerData count]+1;
    }
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    if (indexPath.row==0) {
        AsyncImageViewSmall *image=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        NSString *strUrl=@"";
        if ([strForEntity isEqualToString:@"entity"]) {
            strUrl=[dicForDetail valueForKey:@"user_entity_image"];
        }else{
           strUrl=[dicForDetail valueForKey:@"post_image"];
        }
        [image loadImage:strUrl];
        [cell addSubview:image];
    }
    
    if (indexPath.row>0) {
        int index=indexPath.row-1;
        if (index<[arrayForServerData count]) {
    
        static NSString *CellIdentifierComment = @"CellComment";
        CommentCell *cellComment= (CommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifierComment];
        
        if (cellComment == nil) {
            cellComment = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierComment];
        }
        cellComment.selectionStyle=UITableViewCellSelectionStyleNone;
        NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:index] valueForKey:@"profile_picture"]];
        [cellComment.imgForProfile loadImage:str];
        [cellComment.btnForName setTitle:[[arrayForServerData objectAtIndex:index] valueForKey:@"user_name"] forState:UIControlStateNormal];
        int height=0;
        if ([[[arrayForServerData objectAtIndex:index] valueForKey:@"comment_text"] length]>0) {
            NSString *strForComment=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:index] valueForKey:@"comment_text"]];
            cellComment.lblForComment.text=strForComment;
            height=[self calculateHeightOfLabel:[[arrayForServerData objectAtIndex:index] valueForKey:@"comment_text"]];
            [cellComment.lblForComment setFrame:CGRectMake(50, 25, 250, height)];
        }
        
        [cellComment.starRate setStrImage:@"star_small.png"];
        [cellComment.starRate setStrStarActImage:@"star_active_small.png"];
        
        if ([[arrayForServerData objectAtIndex:index]
             valueForKey:@"rating_count"]!=[NSNull null]) {
            [cellComment.starRate setValue:[[[arrayForServerData objectAtIndex:index]
                                             valueForKey:@"rating_count"] intValue]];
        }else{
            [cellComment.starRate setValue:0];
        }
        
        [cellComment.lblForDate setText:@"20 Hr"];
        [cellComment.lblForDate setFrame:CGRectMake(260, height-25, 45, 20)];
        
        return cellComment;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index=indexPath.row;
   
    if (index==0) {
        return 250;
    }else if (index>0){
        //NSArray *arrayTemp=[arrayForServerData objectAtIndex:index];
        NSString *strComment= [[arrayForServerData objectAtIndex:index-1] valueForKey:@"comment_text"];
        int height=(int)[self calculateHeightOfLabel:strComment];
        return height;
    }
    return 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
