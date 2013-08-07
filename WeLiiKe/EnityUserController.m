//
//  EnityUserController.m
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EnityUserController.h"
#import "WelcomeSearchScreen.h"
#import "AggregateViewController.h"
#import "AddFriendForCategory.h"
#import "MediadetailViewController.h"
#import "OtherUserProfile.h"

@implementation EnityUserController
@synthesize tableViewForCategoty,strForCateID,btnForDone,labelForName,btnForTitle,tableViewForWeliike,strForMastCateID,viewForFollowFollowing,strForClass;
@synthesize strForCateName,btnForFollowing,btnForEntity,btnForFollower,imgViewForHeader;
@synthesize strUserID,viewForHeaderBot,strForSearchName,btnForSort;
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

-(IBAction)actionOnBack:(id)sender{
    
//    NSArray *array=self.navigationController.viewControllers;
//    int countView=[array count];
//    countView=countView-4;
//    [self.navigationController popToViewController:[array objectAtIndex:[array count]-countView] animated:YES];
    // countSelectedCategory=countSelectedCategory+1;
     [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    page_No=1;
    checkForGridAndList=0;
    //arrayForServerData=[[NSMutableArray alloc] init];
    btnForDone.hidden=YES;
    selectedItmeFromWeLiike=0;
     
    labelForName.text=strForCateName;
    btnForTitle=[[UIButton alloc] initWithFrame:CGRectMake(60, 50, 200, 35)];
    //[btnForTitle setBackgroundColor:[UIColor redColor]];
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if ([strUserID length]>0) {
        if (![strUserID isEqualToString:strID]) {
            viewForHeaderBot.hidden=YES;
            btnForSort.hidden=YES;
            [self.tableViewForCategoty setFrame:CGRectMake(self.tableViewForCategoty.frame.origin.x, self.tableViewForCategoty.frame.origin.y-35, self.tableViewForCategoty.frame.size.width, self.tableViewForCategoty.frame.size.height+35)];
        }else{
            [btnForTitle.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
            [btnForTitle setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [btnForTitle setTitle:[NSString stringWithFormat:@"My %@",strForCateName] forState:UIControlStateNormal];
            [btnForTitle addTarget:self action:@selector(actionOnTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btnForTitle];
            viewForHeaderBot.hidden=NO;
        }
    }else{
         viewForHeaderBot.hidden=NO;
        [btnForTitle.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [btnForTitle setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnForTitle setTitle:[NSString stringWithFormat:@"My %@",strForCateName] forState:UIControlStateNormal];
        [btnForTitle addTarget:self action:@selector(actionOnTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnForTitle];

    }
    
        
    dicForCheckEntity=[[NSMutableDictionary alloc] init];
    strForSearchName=[NSString stringWithFormat:@"i_liike"];
    [self performSelector:@selector(callWebServiceForCityAndSubCate) withObject:nil afterDelay:0.2];
    //[self performSelector:@selector(callWebService)];
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"popEntity"];
    //[self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
    // Do any additional setup after loading the view from its nib.
}
-(void)callPopUp{

    
    UIView *keyView = self.view;
	
	backgroundViewPop = [[WETouchableView alloc] initWithFrame:keyView.bounds];
	backgroundViewPop.contentMode = UIViewContentModeScaleToFill;
	backgroundViewPop.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
									   UIViewAutoresizingFlexibleWidth |
									   UIViewAutoresizingFlexibleRightMargin |
									   UIViewAutoresizingFlexibleTopMargin |
									   UIViewAutoresizingFlexibleHeight |
									   UIViewAutoresizingFlexibleBottomMargin);
	backgroundViewPop.backgroundColor = [UIColor clearColor];
	backgroundViewPop.delegate = self;
	
	[keyView addSubview:backgroundViewPop];
    UIImageView *imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(20, 75, 280, 170)];
    [imgBg setImage:[UIImage imageNamed:@"pop_up1.png"]];
    [backgroundViewPop addSubview:imgBg];

}
-(void)actionOnTitleBtn:(id)sender{

    [self performSelector:@selector(weliikwPopUp)];
    
}

-(void)weliikwPopUp{
    
    UIView *keyView = self.view;
	
	backgroundView = [[WETouchableView alloc] initWithFrame:keyView.bounds];
	backgroundView.contentMode = UIViewContentModeScaleToFill;
	backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
									   UIViewAutoresizingFlexibleWidth |
									   UIViewAutoresizingFlexibleRightMargin |
									   UIViewAutoresizingFlexibleTopMargin |
									   UIViewAutoresizingFlexibleHeight |
									   UIViewAutoresizingFlexibleBottomMargin);
	backgroundView.backgroundColor = [UIColor clearColor];
	backgroundView.delegate = self;
	
	[keyView addSubview:backgroundView];
    
    viewForWeliike=[[UIView alloc] initWithFrame:CGRectMake(20, 90, 280, 200)];
    [viewForWeliike setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewForWeliike];
   
    UIImageView *imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, -15, 280, 220)];
    [imgBg setImage:[UIImage imageNamed:@"blank_bubble.png"]];
    [viewForWeliike addSubview:imgBg];
    
    tableViewForWeliike=[[UITableView alloc] initWithFrame:CGRectMake(10, 10, 260, 187)];
    tableViewForWeliike.delegate=self;
    [tableViewForWeliike setBackgroundColor:[UIColor clearColor]];
    tableViewForWeliike.dataSource=self;
    [viewForWeliike addSubview:tableViewForWeliike];
    
}
- (void)viewWasTouched:(WETouchableView *)view {
    
    if (backgroundView==view) {
        [self performSelector:@selector(removeBg)];
    }else if(backgroundViewPop==view) {
        [backgroundViewPop removeFromSuperview];
    }
}
-(void)removeBg{

    for (NSInteger ko=0; ko<[[viewForWeliike subviews] count]; ko++){
        id l=[[viewForWeliike subviews] objectAtIndex:ko];
        [l removeFromSuperview];
    }
    [viewForWeliike removeFromSuperview];
    [backgroundView removeFromSuperview];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([arrayForServerData count]>0) {
        [arrayForServerData removeAllObjects];
        [self performSelector:@selector(makeCell)];
    }
    
    if (selectedItmeFromWeLiike==0) {
        [btnForTitle setTitle:[NSString stringWithFormat:@"My %@",strForCateName] forState:UIControlStateNormal];
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"i_liike"];
        
        [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
        
    }else if (selectedItmeFromWeLiike==1) {
        
        
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"weliike"];
        [btnForTitle setTitle:[NSString stringWithFormat:@"WeLiike"] forState:UIControlStateNormal];
        
        [self performSelector:@selector(actionOnWeliike) withObject:nil afterDelay:0.2];
    }else if (selectedItmeFromWeLiike==2) {
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"friend"];
        [btnForTitle setTitle:[NSString stringWithFormat:@"All Friends"] forState:UIControlStateNormal];
        
        [self performSelector:@selector(actionOnAllFriend) withObject:nil afterDelay:0.2];
        
    }else if (selectedItmeFromWeLiike==3) {
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"trends"];
        [btnForTitle setTitle:[NSString stringWithFormat:@"Trends"] forState:UIControlStateNormal];
        
        [self performSelector:@selector(actionOnTrends) withObject:nil afterDelay:0.2];
        
    }
    
    [self performSelector:@selector(callWebServiceForCityAndSubCate)];
    
}
-(void)callWebService{
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"i_liike"];
        WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(getEntityByCategoryIDHandler:)];

        //int countObj=[arrayForCateSelected count]-countSelectedCategory;
        //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
        NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        if ([strUserID length]>0) {
            if (![strUserID isEqualToString:strID]) {
                strID=strUserID;
            }
        }
        AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([strForClass isEqualToString:@"Other"]) {
        [service getEntityByCategoryIDOther:strID user_category_id:strForCateID page:[NSString stringWithFormat:@"%d",page_No]];
    }else{
       [service getEntityByCategoryID:strID user_category_id:strForCateID page:[NSString stringWithFormat:@"%d",page_No] address:delegate.strForAddressDelegate];
    }
        
        
}
-(void)getEntityByCategoryIDHandler:(id)sender{
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
            if ([strForResponce count]>0) {
                if ([strForResponce isKindOfClass:[NSDictionary class]] && [strForResponce count]==1) {
                    
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [strForResponce valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    
                }else{
                    
                    //NSLog(@"value of %d",[strForResponce count]);
                    arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                    //NSLog(@"value of aara %@",arrayForServerData);
                    
                    [self performSelector:@selector(makeCell)];
                    
                }
                
                
                
            }else{
                [arrayForServerData removeAllObjects];
                [self performSelector:@selector(makeCell)];
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"No data found."
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

-(void)callWebServiceWeliike{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(weLiikeHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
     AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [service weLiike:strForCateID user_id:strID master_category_id:strForMastCateID page:[NSString stringWithFormat:@"%d",page_No] address:delegate.strForAddressDelegate];
}

-(void)weLiikeHandler:(id)sender{
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
            if ([strForResponce count]>0) {
                
                if ([strForResponce isKindOfClass:[NSDictionary class]] && [strForResponce count]==1) {
                    
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [strForResponce valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    
                }else{
                    
                    //NSLog(@"value of %d",[strForResponce count]);
                    arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                    NSLog(@"value of aara %@",arrayForServerData);
                    [btnForEntity setTitle:[NSString stringWithFormat:@"%d",[arrayForServerData count]] forState:UIControlStateNormal];
                    [self performSelector:@selector(makeCell)];
                }
                
                
                
            }else{
                [arrayForServerData removeAllObjects];
                [self performSelector:@selector(makeCell)];
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

-(void)callWebServiceTrends{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetTrendsHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [service GetTrends:strID user_category_id:strForCateID master_category_id:strForMastCateID page:[NSString stringWithFormat:@"%d",page_No] address:delegate.strForAddressDelegate];
    }

-(void)GetTrendsHandler:(id)sender{
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
            if ([strForResponce count]>0) {
                
                if ([strForResponce isKindOfClass:[NSDictionary class]] && [strForResponce count]==1) {
                    
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [strForResponce valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    
                }else{
                    
                    //NSLog(@"value of %d",[strForResponce count]);
                    arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                    //NSLog(@"value of aara %@",arrayForServerData);
                    [self performSelector:@selector(makeCell)];
                    
                }
               
            }else{
                [arrayForServerData removeAllObjects];
                [self performSelector:@selector(makeCell)];
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

-(IBAction)actionOnGridAndList:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    
    if (checkForGridAndList==0) {
        checkForGridAndList=1;
        [btn setImage:[UIImage imageNamed:@"mosaic_btn.png"] forState:UIControlStateNormal];
    }else{
        checkForGridAndList=0;
        [btn setImage:[UIImage imageNamed:@"list_icon.png"] forState:UIControlStateNormal];
    }
    [self performSelector:@selector(makeCell)];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==tableViewForWeliike) {
        return 5;
    }else{
        if ([arrayForServerData count]==0) {
            return 0;
        }
        if (checkForGridAndList==0) {
            
            int coutForArray=[arrayForServerData count];
            
            int cell=0;
            
            if ([arrayForServerData count] >= 10) {
                cell=2;
            }else{
                cell=1;
            }
            
            if (coutForArray<=3) {
                return cell;
            }else {
                int countForRow=coutForArray/3;
                if (coutForArray%3 !=0) {
                    return countForRow+cell;
                }else{
                    return countForRow+cell-1;
                }
            }
        }else{
            return [arrayForServerData count];
        }

    }
        
    
    return  6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
	static NSString *CellIdentifier1 = @"CellTest";
    UITableViewCell *cell111= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell111 == nil) {
        cell111 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    if (tableView==tableViewForWeliike) {
        [cell111.textLabel setFont:[UIFont boldSystemFontOfSize:15]];
        cell111.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell111.textLabel.text=[NSString stringWithFormat:@"     My %@",strForCateName];
            
        }else if (indexPath.row==1) {
            
            cell111.textLabel.text=@"     WeLiike";
            
        }else if (indexPath.row==2) {
            cell111.textLabel.text=@"     All Friends";
            
        }else if (indexPath.row==3) {
            cell111.textLabel.text=@"     Trends";
            
        }else if (indexPath.row==4) {
            
            UIImageView *imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 280, 50)];
            [imgBg setImage:[UIImage imageNamed:@"cloud_box.png"]];
            [cell111.selectedBackgroundView addSubview:imgBg];
            cell111.textLabel.text=@"     Friend cloud";
            
        }
        if (selectedItmeFromWeLiike==indexPath.row) {
            cell111.textLabel.textColor=[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0];
        }else{
            cell111.textLabel.textColor=[UIColor darkGrayColor];
        }
        
    }else{
        
        return [arrayForCell objectAtIndex:indexPath.row];
        
    }
    
        
    
    //***************************
	return cell111;
}

-(void)makeCell{

    if ([arrayForCell count]>0) {
        [arrayForCell removeAllObjects];
    }
    
    if ([arrayForServerData count]>0) {
        if ([[[arrayForServerData objectAtIndex:0] valueForKey:@"is"] isEqualToString:@"Rating"]){
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                        initWithKey:@"rating_count"
                                        ascending:NO
                                        selector:@selector(localizedStandardCompare:)];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
            [arrayForServerData sortUsingDescriptors:sortDescriptors];
        }else if ([[[arrayForServerData objectAtIndex:0] valueForKey:@"is"] isEqualToString:@"Recent"]) {
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                        initWithKey:@"created_at"
                                        ascending:NO
                                        selector:@selector(localizedStandardCompare:)];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
            [arrayForServerData sortUsingDescriptors:sortDescriptors];
        }else if ([[[arrayForServerData objectAtIndex:0] valueForKey:@"is"] isEqualToString:@"Proxy"]){
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                        initWithKey:@"distance"
                                        ascending:YES
                                        selector:@selector(localizedStandardCompare:)];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
            [arrayForServerData sortUsingDescriptors:sortDescriptors];
        }
    }
    NSLog(@"Array for server %@",arrayForServerData);
    
    arrayForCell=[[NSMutableArray alloc] init];
    for (int i=0; i<[arrayForServerData count]; i++) {
        
        if (checkForGridAndList==0) {
            
            EnitityCell *cell= [[EnitityCell alloc] init];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //***************************
            
            int countForRow=[arrayForServerData count]/3;
            if ([arrayForServerData count]%3 !=0) {
                countForRow= countForRow+1;
            }
            
            if (i==countForRow) {
                
                UITableViewCell *cell1= [[UITableViewCell alloc] init];
                
                if (cell1 == nil) {
                    cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                }
                
                UIButton *btnForSeemore=[[UIButton alloc] init];
                [btnForSeemore setFrame:CGRectMake(112, 20, 75, 30)];
                btnForSeemore.tag=i;
                btnForSeemore.userInteractionEnabled=YES;
                [btnForSeemore addTarget:self action:@selector(actionOnSeeMore:) forControlEvents:UIControlEventTouchUpInside];
                [btnForSeemore setBackgroundImage:[UIImage imageNamed:@"see_more.png"] forState:UIControlStateNormal];
                [cell1 addSubview:btnForSeemore];
                cell1.selectionStyle=UITableViewCellSelectionStyleNone;
                [arrayForCell addObject:cell1];
                break;
            }
            
            
            
            
            int coutForLoop=3;
            if (i==countForRow-1 && [arrayForServerData count]>3 && [arrayForServerData count]%3 !=0) {
                coutForLoop=[arrayForServerData count]%3;
            }else if ([arrayForServerData count]<=3){
                coutForLoop=[arrayForServerData count];
            }
            
            for (int j=0; j<coutForLoop; j++) {
                if ((i *3)+j <[arrayForServerData count]) {
                    NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"entity_image"]];
                    NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"profile_picture"]];
                    if (coutForLoop==1) {
                        cell.image2.hidden=YES;
                        cell.lbl2.hidden=YES;
                        cell.profileImage2.hidden=YES;
                        cell.image3.hidden=YES;
                        cell.lbl3.hidden=YES;
                        cell.profileImage3.hidden=YES;
                        cell.starRate2.hidden=YES;
                        cell.starRate3.hidden=YES;
                    }else if (coutForLoop==2) {
                        cell.image3.hidden=YES;
                        cell.lbl3.hidden=YES;
                        cell.profileImage3.hidden=YES;
                        cell.starRate3.hidden=YES;
                    }
                    if (j==0 && [str hasPrefix:@"http"]) {
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        cell.image1.tag=(i *3)+j;
                        cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                        cell.image1.layer.borderWidth=1.5;
                        [cell.image1 loadImage:str];
                        [cell.profileImage1 loadImage:strProfile];
                        cell.profileImage1.tag=(i *3)+j;
                        [cell.profileImage1 addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                        if ([[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"user_id"] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]]) {
                            cell.profileImage1.hidden=YES;
                        }
                        cell.imgViewForGra1.hidden=NO;
                        [cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.lbl1 setTextColor:[UIColor whiteColor]];
                        
                        id displayNameTypeValue = [[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"entity_name"];
                        NSString *displayNameType = @"";
                        if (displayNameTypeValue != [NSNull null])
                            displayNameType = (NSString *)displayNameTypeValue;
                        
                        [cell.lbl1 setText:displayNameType];//category_name
                        cell.lbl1.tag=0;
                        
                        [cell.starRate1 setStrImage:@"star_small.png"];
                        [cell.starRate1 setStrStarActImage:@"star_active_small.png"];
                        if ([[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"rating_count"]!=[NSNull null]) {
                            [cell.starRate1 setValue:[[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"rating_count"] intValue]];
                        }else{
                            [cell.starRate1 setValue:0];
                        }
                        
                        
                    }
                    
                    if (j==1 && [str hasPrefix:@"http"]) {
                        cell.image2.tag=(i *3)+j;
                        [cell.image2 loadImage:str];
                        cell.profileImage2.tag=(i *3)+j;
                        [cell.profileImage2 addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.profileImage2 loadImage:strProfile];
                        cell.imgViewForGra2.hidden=NO;
                        cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                        cell.image2.layer.borderWidth=1.5;
                        [cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        [cell.lbl2 setTextColor:[UIColor whiteColor]];
                        id displayNameTypeValue = [[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"entity_name"];
                        NSString *displayNameType = @"";
                        if (displayNameTypeValue != [NSNull null])
                            displayNameType = (NSString *)displayNameTypeValue;
                        
                        [cell.lbl2 setText:displayNameType];//category_name
                        
                        cell.lbl2.tag=0;
                        if ([[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"user_id"] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]]) {
                            cell.profileImage2.hidden=YES;
                        }
                        [cell.starRate2 setStrImage:@"star_small.png"];
                        [cell.starRate2 setStrStarActImage:@"star_active_small.png"];
                        if ([[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"rating_count"]!=[NSNull null]) {
                            [cell.starRate2 setValue:[[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"rating_count"] intValue]];
                        }else{
                            [cell.starRate2 setValue:0];
                        }
                        
                    }
                    
                    if (j==2 && [str hasPrefix:@"http"]) {
                        
                        cell.image3.tag=(i *3)+j;
                        [cell.image3 loadImage:str];
                        cell.profileImage3.tag=(i *3)+j;
                        [cell.profileImage3 addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.profileImage3 loadImage:strProfile];
                        cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                        cell.image3.layer.borderWidth=1.5;
                        cell.imgViewForGra3.hidden=NO;
                        [cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        [cell.lbl3 setTextColor:[UIColor whiteColor]];
                        
                        id displayNameTypeValue = [[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"entity_name"];
                        NSString *displayNameType = @"";
                        if (displayNameTypeValue != [NSNull null])
                            displayNameType = (NSString *)displayNameTypeValue;
                        
                        [cell.lbl3 setText:displayNameType];//category_name
                        
                        cell.lbl3.tag=0;
                        
                        if ([[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"user_id"] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]]) {
                            cell.profileImage3.hidden=YES;
                        }
                        [cell.starRate3 setStrImage:@"star_small.png"];
                        [cell.starRate3 setStrStarActImage:@"star_active_small.png"];
                        if ([[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"rating_count"]!=[NSNull null]) {
                            [cell.starRate3 setValue:[[[arrayForServerData objectAtIndex:(i *3)+j] valueForKey:@"rating_count"] intValue]];
                        }else{
                            [cell.starRate3 setValue:0];
                        }
                        
                        
                    }
                }
            }

            [arrayForCell addObject:cell];
        }else{
            static NSString *CellIdentifier = @"Cell";
            EntityListCell *cell1= [[EntityListCell alloc] init];
            if (cell1 == nil) {
                cell1 = [[EntityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([arrayForServerData count]>i) {
                
                NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:i ] valueForKey:@"entity_image"]];
                NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:i ] valueForKey:@"profile_picture"]];
                cell1.imgForEntity.tag=i;
                [cell1.imgForEntity addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                [cell1.imgForEntity loadImage:str];
                
                cell1.imgForProfile.tag=i;
                [cell1.imgForProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell1.imgForProfile loadImage:strProfile];
                [cell1.lblForEntityName setText:[[arrayForServerData objectAtIndex:i ] valueForKey:@"entity_name"]];
                [cell1.lblForEntityType setText:strForCateName];
                [cell1.lblForEntityAddress setText:[[arrayForServerData objectAtIndex:i ] valueForKey:@"entity_name"]];
                //[cell1 loadStar:3];
                [cell1.starRate setStrImage:@"star_small.png"];
                [cell1.starRate setStrStarActImage:@"star_active_small.png"];
                
                if ([[arrayForServerData objectAtIndex:i] valueForKey:@"rating_count"]!=[NSNull null]) {
                    [cell1.starRate  setValue:[[[arrayForServerData objectAtIndex:i] valueForKey:@"rating_count"] intValue]];
                }else{
                    [cell1.starRate setValue:0];
                }
                //[cell1 setStarCount:3];
                [arrayForCell addObject:cell1];
            }
            
        }

        
    }
   
    //NSLog(@"value of array of cell %@",arrayForCell);
    [tableViewForCategoty reloadData];
}

-(void)actionOnUserProfile:(id)sender{

    UIButton *btn=(UIButton*)sender;
    if (btn.tag<[arrayForServerData count]) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
}
-(IBAction)actionOnFilterSorting:(id)sender{

    SortingViewController *obj=[[SortingViewController alloc] init];
    obj.dicForCityAndSub=dicForCitySubcate;
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(void)callWebServiceForCityAndSubCate{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(get_city_and_sub_categoryHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service get_city_and_sub_category:strID user_category_id:strForCateID search:strForSearchName master_category_id:strForMastCateID];
    
}

-(void)get_city_and_sub_categoryHandler:(id)sender{
    
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
            
            //[self killHUD];
            if ([strForResponce count]>0) {
                if ([strForResponce isKindOfClass:[NSDictionary class]] && [strForResponce count]==1) {
                    
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [strForResponce valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    
                }else{
                    dicForCitySubcate=[[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)strForResponce copyItems:YES];
                    //NSLog(@"value of %@",dicForCitySubcate);
                }
            }else{
                
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"No data found."
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView==tableViewForWeliike) {
    
        [self performSelector:@selector(removeBg)];
        if ([arrayForServerData count]>0) {
            [arrayForServerData removeAllObjects];
            [self performSelector:@selector(makeCell)];
        }
        if (indexPath.row==0) {
            page_No=1;
            //[self performSelector:@selector(actionOnWeliike)];
            selectedItmeFromWeLiike=indexPath.row;
            [btnForTitle setTitle:[NSString stringWithFormat:@"My %@",strForCateName] forState:UIControlStateNormal];
            [self showHUD];
            strForSearchName=[NSString stringWithFormat:@"i_liike"];
            [self performSelector:@selector(callWebServiceForCityAndSubCate)];
            [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
            
        }else if (indexPath.row==1) {
                  page_No=1;    
            selectedItmeFromWeLiike=indexPath.row;
           //
            [self showHUD];
            strForSearchName=[NSString stringWithFormat:@"weliike"];
            [btnForTitle setTitle:[NSString stringWithFormat:@"WeLiike"] forState:UIControlStateNormal];
            [self performSelector:@selector(callWebServiceForCityAndSubCate)];
            [self performSelector:@selector(actionOnWeliike) withObject:nil afterDelay:0.2];
        }else if (indexPath.row==2) {
            [self showHUD];
            page_No=1;
            selectedItmeFromWeLiike=indexPath.row;
            strForSearchName=[NSString stringWithFormat:@"friend"];
            [btnForTitle setTitle:[NSString stringWithFormat:@"All Friends"] forState:UIControlStateNormal];
            [self performSelector:@selector(callWebServiceForCityAndSubCate)];
            [self performSelector:@selector(actionOnAllFriend) withObject:nil afterDelay:0.2];
        
        }else if (indexPath.row==3) {
            page_No=1;
            [self showHUD];
            strForSearchName=[NSString stringWithFormat:@"trends"];
            selectedItmeFromWeLiike=indexPath.row;
            [btnForTitle setTitle:[NSString stringWithFormat:@"Trends"] forState:UIControlStateNormal];
            [self performSelector:@selector(callWebServiceForCityAndSubCate)];
            [self performSelector:@selector(actionOnTrends) withObject:nil afterDelay:0.2];
        
        }else if (indexPath.row==4) {
           
            [self performSelector:@selector(actionOnFreindsCloud)];
        } 
        
        if (selectedItmeFromWeLiike==1) {
            
            [imgViewForHeader setImage:[UIImage imageNamed:@"nav_bar_home_blank.png"]];
            [self performSelector:@selector(makeFollowFollowingView)];
            [tableViewForCategoty setFrame:CGRectMake(0, 135, 320, 276)];
        }else{
            [imgViewForHeader setImage:[UIImage imageNamed:@"blank_header.png"]];
            //[tableViewForCategoty setFrame:CGRectMake(0, 0, 320, 200)];
            if (viewForFollowFollowing!=nil) {
                for (NSInteger ko=0; ko<[[viewForFollowFollowing subviews] count]; ko++){
                    id l=[[viewForFollowFollowing subviews] objectAtIndex:ko];
                    [l removeFromSuperview];
                }
                [viewForFollowFollowing removeFromSuperview];
            }
            
            [tableViewForCategoty setFrame:CGRectMake(0, 85, 320, 326)];
        }

        
    }else if(tableView==tableViewForCategoty){
       if (checkForGridAndList!=0) {
        MediadetailViewController *obj=[[MediadetailViewController alloc] init];
        //NSLog(@"value of %@",[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"entity_id"]);
        obj.strForEntity=[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"entity_id"];
        obj.strUserID=[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
       }
    }
}

-(void)makeFollowFollowingView{
    
    //[NSThread detachNewThreadSelector:@selector(callWebServiceFollow) toTarget:self withObject:nil];
    [self performSelector:@selector(callWebServiceFollowing)];
    //[NSThread detachNewThreadSelector:@selector(callWebServiceFollowing) toTarget:self withObject:nil];
    //segment_bar
    if ([viewForFollowFollowing superview] != nil) {
        [viewForFollowFollowing removeFromSuperview];
    }
    viewForFollowFollowing=[[UIView alloc] initWithFrame:CGRectMake(0, 85, 320, 50)];
    [viewForFollowFollowing setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:viewForFollowFollowing];
    UIImageView *imgViewGb=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 300, 40)];
    [imgViewGb setImage:[UIImage imageNamed:@"segment_bar.png"]];
    [viewForFollowFollowing addSubview:imgViewGb];
    //[btnForFollowing setTitle: forState:UIControlStateNormal];
    btnForEntity=[[UIButton alloc] initWithFrame:CGRectMake(16, 0, 90, 45)];
    [btnForEntity setTitle:[NSString stringWithFormat:@"%d",[arrayForServerData count]] forState:UIControlStateNormal];
    //[btnForEntity setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnForEntity.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btnForEntity setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForEntity setBackgroundColor:[UIColor clearColor]];
    //btnForComment.layer.cornerRadius=5;
    //btnForComment.layer.masksToBounds=YES;
    [btnForEntity addTarget:self action:@selector(actionOnEntity:) forControlEvents:UIControlEventTouchUpInside];
    [viewForFollowFollowing addSubview:btnForEntity];
    
    btnForFollowing=[[UIButton alloc] initWithFrame:CGRectMake(115, 0, 90, 45)];
    [btnForFollowing setTitle:@"0" forState:UIControlStateNormal];
    //[btnForFollowing setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnForFollowing.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btnForFollowing setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForFollowing setBackgroundColor:[UIColor clearColor]];
    //btnForComment.layer.cornerRadius=5;
    //btnForComment.layer.masksToBounds=YES;
    [btnForFollowing addTarget:self action:@selector(actionOnFollowing:) forControlEvents:UIControlEventTouchUpInside];
    [viewForFollowFollowing addSubview:btnForFollowing];

    
    btnForFollower=[[UIButton alloc] initWithFrame:CGRectMake(215, 0, 90, 45)];
    [btnForFollower setTitle:@"0" forState:UIControlStateNormal];
    //[btnForFollower setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnForFollower.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btnForFollower setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnForFollower setBackgroundColor:[UIColor clearColor]];
    //btnForComment.layer.cornerRadius=5;
    //btnForComment.layer.masksToBounds=YES;
    [btnForFollower addTarget:self action:@selector(actionOnFollower:) forControlEvents:UIControlEventTouchUpInside];
    [viewForFollowFollowing addSubview:btnForFollower];
    
        
}
-(void)actionOnSeeMore:(UIButton*)sender{
    
    page_No=page_No+1;
    
    if (selectedItmeFromWeLiike==0) {
        [btnForTitle setTitle:[NSString stringWithFormat:@"My %@",strForCateName] forState:UIControlStateNormal];
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"i_liike"];
        [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
        
    }else if (selectedItmeFromWeLiike==1) {
        
        
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"weliike"];
        [btnForTitle setTitle:[NSString stringWithFormat:@"WeLiike"] forState:UIControlStateNormal];
        [self performSelector:@selector(actionOnWeliike) withObject:nil afterDelay:0.2];
    }else if (selectedItmeFromWeLiike==2) {
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"friend"];
        [btnForTitle setTitle:[NSString stringWithFormat:@"All Friends"] forState:UIControlStateNormal];
        [self performSelector:@selector(actionOnAllFriend) withObject:nil afterDelay:0.2];
        
    }else if (selectedItmeFromWeLiike==3) {
        [self showHUD];
        strForSearchName=[NSString stringWithFormat:@"trends"];
        [btnForTitle setTitle:[NSString stringWithFormat:@"Trends"] forState:UIControlStateNormal];
        [self performSelector:@selector(actionOnTrends) withObject:nil afterDelay:0.2];
        
    }

    
}

-(void)callWebServiceFollowing{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetFollowingHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetFollowing:strID user_category_id:strForCateID];
    
    WeLiikeWebService *service1=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetFollowerHandler:)];
    
    [service1 GetFollower:strID user_category_id:strForCateID master_category_id:strForMastCateID];
    [self killHUD];
        
    
}


-(void)GetFollowingHandler:(id)sender{
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
        NSString *strForResponce=[sender stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        //NSLog(@"value of data %@",str);
        id strForResponce1 = [NSJSONSerialization JSONObjectWithData: [strForResponce dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (strForResponce!=nil && [strForResponce intValue]>0) {
            
            
            //NSLog(@"value of aara %@",strForResponce);
            //NSLog(@"value of aara %@",[[strForResponce class] description]);
            
                if ([strForResponce length]>0) {
                    [btnForFollowing setTitle:[NSString stringWithFormat:@"%@",strForResponce] forState:UIControlStateNormal];
                }else{
                    [btnForFollowing setTitle:@"0" forState:UIControlStateNormal];
                }
                
                        
        }else if ([strForResponce intValue]==0) {
        
               [btnForFollowing setTitle:@"0" forState:UIControlStateNormal];
            
        }else if ([strForResponce1 isKindOfClass:[NSDictionary class]]) {
//            UIAlertView *errorAlert = [[UIAlertView alloc]
//                                       initWithTitle: @"Message"
//                                       message: [strForResponce1 valueForKey:@"message"]
//                                       delegate:nil
//                                       cancelButtonTitle:@"OK"
//                                       otherButtonTitles:nil];
//            [errorAlert show];
//            return;
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
-(void)GetFollowerHandler:(id)sender{
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
        NSString *strForResponce=[sender stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        //NSLog(@"value of data %@",str);
        id strForResponce1 = [NSJSONSerialization JSONObjectWithData: [strForResponce dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (strForResponce!=nil && [strForResponce intValue]>0) {
            
            
            //NSLog(@"value of aara %@",strForResponce);
            //NSLog(@"value of aara %@",[[strForResponce class] description]);
            
            if ([strForResponce length]>0) {
                [btnForFollower setTitle:[NSString stringWithFormat:@"%@",strForResponce] forState:UIControlStateNormal];
            }else{
                [btnForFollower setTitle:@"0" forState:UIControlStateNormal];
            }
            
            
        }else if ([strForResponce intValue]==0) {
            
            [btnForFollower setTitle:@"0" forState:UIControlStateNormal];
            
        }else if ([strForResponce1 isKindOfClass:[NSDictionary class]]) {
//            UIAlertView *errorAlert = [[UIAlertView alloc]
//                                       initWithTitle: @"Message"
//                                       message: [strForResponce1 valueForKey:@"message"]
//                                       delegate:nil
//                                       cancelButtonTitle:@"OK"
//                                       otherButtonTitles:nil];
//            [errorAlert show];
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



-(void)callWebServiceAllFriends{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetAllFriendHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [service GetAllFriend:strID user_category_id:strForCateID master_category_id:strForMastCateID page:[NSString stringWithFormat:@"%d",page_No] address:delegate.strForAddressDelegate];
        
}



-(void)GetAllFriendHandler:(id)sender{
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
            if ([strForResponce count]>0) {
                
                if ([strForResponce isKindOfClass:[NSArray class]]) {
                    
                    if ([strForResponce isKindOfClass:[NSDictionary class]] && [strForResponce count]==1) {
                        
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle: @"Message"
                                                   message: [strForResponce valueForKey:@"message"]
                                                   delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
                        [errorAlert show];
                        
                    }else{
                        
                        arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                        //NSLog(@"value of aara %@",arrayForServerData);
                        
                        [self performSelector:@selector(makeCell)];
                    }
                    
                    
                }else{
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [strForResponce valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    [self performSelector:@selector(makeCell)];
                }
                
                
            }else{
                [arrayForServerData removeAllObjects];
                [self performSelector:@selector(makeCell)];
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

-(void)actionOnEntity:(id)sender{

}

-(void)actionOnFollowing:(id)sender{
    
    //UIButton *btn=(UIButton*)sender;
    
    //if ([[btn currentTitle] intValue]>0) {
        FollowingViewController *obj=[[FollowingViewController alloc] init];
        obj.strForCategoryId=strForCateID;
        obj.strForMasterID=strForMastCateID;
        [self.navigationController pushViewController:obj animated:YES];
    //}else{
    
//        UIAlertView *errorAlert = [[UIAlertView alloc]
//                                   initWithTitle: @"Message"
//                                   message: @"You are not following any user."
//                                   delegate:nil
//                                   cancelButtonTitle:@"OK"
//                                   otherButtonTitles:nil];
//        [errorAlert show];
    
    //}
    
    
    
}

-(void)actionOnFollower:(id)sender{
    UIButton *btn=(UIButton*)sender;
    
    if ([[btn currentTitle] intValue]>0) {
        FollowerViewController *obj=[[FollowerViewController alloc] init];
        obj.strForCategoryId=strForCateID;
        obj.strForMasterCategoryId=strForMastCateID;
        [self.navigationController pushViewController:obj animated:YES];
    }else{
        
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Any user not follow you."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        
    }
    

}

-(void)actionOnWeliike{
    if ([arrayForServerData count]>0) {
        [arrayForServerData removeAllObjects];
    }
    [self performSelector:@selector(callWebServiceWeliike)];
}

-(void)actionOnAllFriend{
    if ([arrayForServerData count]>0) {
        [arrayForServerData removeAllObjects];
    }
    [self performSelector:@selector(callWebServiceAllFriends)];
}

-(void)actionOnTrends{
    //callWebServiceTrends
    if ([arrayForServerData count]>0) {
        [arrayForServerData removeAllObjects];
    }
    [self performSelector:@selector(callWebServiceTrends)];
}

-(void)actionOnFreindsCloud{
    
    //AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //delegate.tabBarController.selectedIndex=3;
    
    FriendCloudViewController *obj=[[FriendCloudViewController alloc] init];
    obj.strForCategoryId=strForCateID;
    obj.strForCategoryName=strForCateName;
    obj.strForMasterId=strForMastCateID;
    [self.navigationController pushViewController:obj animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==tableViewForWeliike) {
        return 40;
    }else{
        if (checkForGridAndList==0) {
            return 130;
        }else{
            return 75;
        }
    }
    
    
    return 130;
}

-(IBAction)actionOnListAndGrid:(id)sender{

}
-(IBAction)actionOnSearch:(id)sender{
    SearchEntityViewController *obj=[[SearchEntityViewController alloc] init];
    obj.strForEnityName=strForCateName;
    obj.strForCateID=strForCateID;
    obj.strForMasterID=strForMastCateID;
    obj.strFoSearchName=strForSearchName;
    [self.navigationController pushViewController:obj animated:YES];
}

- (void)checkButtonTapped:(UIButton*)sender
{
    UIButton *btn=(UIButton*)sender;
     MediadetailViewController *obj=[[MediadetailViewController alloc] init];
     //NSLog(@"value of array %@",[arrayForServerData objectAtIndex:btn.tag]);
     obj.strForEntity=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_entity_id"];
     obj.strUserID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_id"];
     [self.navigationController pushViewController:obj animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
