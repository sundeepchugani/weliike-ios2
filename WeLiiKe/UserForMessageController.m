//
//  UserForMessageController.m
//  WeLiiKe
//
//  Created by anoop gupta on 08/05/13.
//
//

#import "UserForMessageController.h"

@interface UserForMessageController ()

@end

@implementation UserForMessageController
@synthesize tableViewForFriend,strForSearch;

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
    
    dicForSelecte=[[NSMutableDictionary alloc] init];
    //arrayForUserList=[[NSMutableArray alloc] init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view from its nib.
    [self showHUD];
    [self performSelector:@selector(callServiceSearch) withObject:nil afterDelay:0.2];
}

-(void)callServiceSearch{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(friend_searchHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service friend_search:strID entity:strForSearch];
        
}


-(void)friend_searchHandler:(id)sender{
    
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
            
            NSLog(@"value of string %@",strForResponce);
            NSLog(@"value of string %@",[[strForResponce class] description]);
            [self killHUD];
            if ([strForResponce count]>0) {
                if ([strForResponce isKindOfClass:[NSArray class]]) {
                    arrayForUserList=[[NSMutableArray alloc] initWithArray:strForResponce];
                    //[self performSelector:@selector(makeCell)];
                    [tableViewForFriend reloadData];
                }else{
                    arrayForUserList=[[NSMutableArray alloc] initWithObjects:@"No friends found", nil];
                    [tableViewForFriend reloadData];
                }
                
                //
                //[self performSelector:@selector(killHUD) withObject:nil afterDelay:0.5];
                
            }else{
                //        UIAlertView *errorAlert = [[UIAlertView alloc]
                //                                   initWithTitle: @"Error"
                //                                   message: @"Error from server please try again later."
                //                                   delegate:nil
                //                                   cancelButtonTitle:@"OK"
                //                                   otherButtonTitles:nil];
                //        [errorAlert show];
                arrayForUserList=[[NSMutableArray alloc] initWithObjects:@"No friends found", nil];
                [tableViewForFriend reloadData];
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


-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)actionOnDone:(id)sender{
    
    for (NSString *key in dicForSelecte) {
        if ([[dicForSelecte valueForKey:key] isEqualToString:@"YES"]) {
            if (![appDelegate.arrayOfUserForMessage containsObject:[arrayForUserList objectAtIndex:[key intValue]]]) {
                [appDelegate.arrayOfUserForMessage addObject:[arrayForUserList objectAtIndex:[key intValue]]];
            }
        
        }
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [arrayForUserList count];
    }else if (section==1){
        return  [appDelegate.arrayOfUserForMessage count];
    }
	return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    FollowAndFollowingCell *cell1= (FollowAndFollowingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell1 == nil) {
        cell1 = [[FollowAndFollowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.row==0 && [[arrayForUserList objectAtIndex:0] isKindOfClass:[NSString class]]) {
        cell1.textLabel.text=@"No friends found";
        [cell1.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [cell1.textLabel setTextColor:[UIColor darkGrayColor]];
        return cell1;
    }
    if (indexPath.section==0) {
        
    if (indexPath.row<[arrayForUserList count]) {
        
    
    NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForUserList objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
    cell1.imgProfile.tag=indexPath.row;
    [cell1.imgProfile loadImage:strProfile];
    //[cell1.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.lblName setText:[[arrayForUserList objectAtIndex:indexPath.row] valueForKey:@"user_name"]];//user_name
    //[cell1.lblForCountEntity setTextColor:[UIColor whiteColor]];
    //[cell.lblForCountEntity setBackgroundColor:[UIColor lightGrayColor]];
    //[cell1.lblForCountEntity setText:[[[arrayForUserList objectAtIndex:indexPath.row] valueForKey:@"entity_count"] stringValue]];
    //NSLog(@"value of %@",[[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] class] description]);
    cell1.lblForCountEntity.hidden=YES;
    cell1.imgForAddSing.hidden=NO;
    if ([[dicForSelecte valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"YES"]) {
        //cell.imgBg.hidden=NO;
        [cell1.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
    }else{
        [cell1.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
    }
    return cell1;
    }
        
    }else if (indexPath.section==1){
    
        
        NSString *strProfile=[NSString stringWithFormat:@"%@",[[appDelegate.arrayOfUserForMessage objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
        cell1.imgProfile.tag=indexPath.row;
        [cell1.imgProfile loadImage:strProfile];
        //[cell1.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
        [cell1.lblName setText:[[appDelegate.arrayOfUserForMessage objectAtIndex:indexPath.row] valueForKey:@"user_name"]];//user_name
        //[cell1.lblForCountEntity setTextColor:[UIColor whiteColor]];
        //[cell.lblForCountEntity setBackgroundColor:[UIColor lightGrayColor]];
        //[cell1.lblForCountEntity setText:[[[arrayForUserList objectAtIndex:indexPath.row] valueForKey:@"entity_count"] stringValue]];
        //NSLog(@"value of %@",[[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] class] description]);
        cell1.lblForCountEntity.hidden=YES;
        cell1.imgForAddSing.hidden=NO;
        //if ([[dicForSelecte valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"YES"]) {
            //cell.imgBg.hidden=NO;
            [cell1.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
        //}else{
            //[cell1.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"]];
        //}
        return cell1;
        
    }
    return cell1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<[arrayForUserList count] && indexPath.section==0) {
        if ([[dicForSelecte valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"YES"]) {
            [dicForSelecte setValue:@"NO" forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        }else{
            [dicForSelecte setValue:@"YES" forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        }
        
        [tableViewForFriend reloadData];
    }else if (indexPath.section==1 && indexPath.row<[appDelegate.arrayOfUserForMessage count]){
        
        [appDelegate.arrayOfUserForMessage removeObjectAtIndex:indexPath.row];
        [tableViewForFriend reloadData];
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if (section==0) {
       return @"Search friends";
    }else{
       return @"Selected friends";
    }
    return @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
