//
//  HomeViewController.m
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "MediadetailViewController.h"
#import "WeLiikeWebService.h"
#import "AddCategoryInUser.h"
#import "EnityUserController.h"
#import "AddGroupViewController.h"
#import "zoomViewController.h"
#import "MessagesViewController.h"
#import "TJSpinner.h"

extern BOOL checkForSignUp;
//********************** Selecte category **********************
NSDictionary *dicForSelectedCate;
extern NSDictionary *dicForCategorySelected;
@implementation HomeViewController
@synthesize tableViewForCategoty,lblForTitle,spinner;

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
//-(void)stopSpinner{
//    [spinner stopAnimating];
//}

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
     spinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeActivityIndicator];
    [spinner setCenter:CGPointMake(125, (self.view.frame.size.height)/100*(80)-(spinner.frame.size.height))];
    [spinner setColor:[UIColor darkGrayColor]];
    [spinner setStrokeWidth:20];
    [spinner setInnerRadius:5];
    [spinner setOuterRadius:25];
    [spinner setNumberOfStrokes:8];
    spinner.hidesWhenStopped = NO;
    [spinner setPatternStyle:TJActivityIndicatorPatternStylePetal];
    [self.view addSubview:spinner];
    
     if (checkForSignUp==YES) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"popEntity"];
        [self performSelector:@selector(makeTopAlert) withObject:nil afterDelay:1.0];
    }    
    //UserCover_photo
    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(swipeRightAction:)];
//    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//    swipeRight.delegate = self;
//    [self.view addGestureRecognizer:swipeRight];
    
    //[self performSelector:@selector(callService)];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.navControllerApp.navigationBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    if ([dicForCategorySelected count]>0) {
        dicForCategorySelected=nil;
    }
    if (dicForSelectedCate!=nil) {
        
        EnityUserController *obj=[[EnityUserController alloc] init];
        obj.strForCateID=[dicForSelectedCate valueForKey:@"cateId"];
        obj.strForCateName=[dicForSelectedCate valueForKey:@"cateName"];
        obj.strForMastCateID=[dicForSelectedCate valueForKey:@"cateMasterId"];
        dicForSelectedCate=nil;
        [self.navigationController pushViewController:obj animated:YES];
        return;
    }
    
    //[self showHUD];
    [spinner startAnimating];
    [self performSelector:@selector(callupdate_sort_setting) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(callArrangeTop) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(updateScreen) withObject:nil afterDelay:0.3];
    //update_sort_setting

}
-(IBAction)actionOnMessage:(id)sender{

    MessagesViewController *obj=[[MessagesViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}
-(void)makeTopAlert{
    
    
    lblForPopUp=[[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 280, 90)];
    [lblForPopUp setImage:[UIImage imageNamed:@"pop_up2.png"]];
    //lblForPopUp.numberOfLines=0;
    //[lblForPopUp setFont:[UIFont boldSystemFontOfSize:21]];
    //[lblForPopUp setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
    //[lblForPopUp setText:@" We have aggregated what  your friends like into list"];
    //lblForPopUp.layer.cornerRadius=5.0;
    //lblForPopUp.layer.masksToBounds=YES;
    lblForPopUp.userInteractionEnabled=YES;
    [self.view addSubview:lblForPopUp];
    
    UIButton *btnForCross=[[UIButton alloc] initWithFrame:CGRectMake(255, -5, 40, 40)];
    [btnForCross setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [btnForCross addTarget:self action:@selector(actionOnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [lblForPopUp addSubview:btnForCross];
    
}
-(void)actionOnCancel:(UIButton *)btn{
    [btn removeFromSuperview];
    [lblForPopUp removeFromSuperview];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (lblForPopUp!=nil) {
        [lblForPopUp removeFromSuperview];
    }
}
-(void)callService{
    
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetCategoryByUserIDHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetCategoryByUserID:strID];
}

-(void)GetCategoryByUserIDHandler:(id)sender{
    //[self killHUD];
    
    if([sender isKindOfClass:[NSError class]]) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Error"
                                   message: @"Error from server please try again later."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        [spinner stopAnimating];    
        
    }else{
        NSError *error=nil;
        NSString *str=[sender stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        //NSLog(@"value of data %@",str);
        id strForResponce = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (error==nil) {
//            [spinner stopAnimating];
            NSLog(@"value of string %@",strForResponce);
            if ([strForResponce count]>0) {
                //[self performSelector:@selector(moveNextScreen)];
                arrayForServerData=[[NSMutableArray alloc] init];
                for (int i=0; i<[strForResponce count]; i++) {
                    // if (i%2 !=0) {
                    [arrayForServerData addObject:[strForResponce objectAtIndex:i]];
                    // }
                }
                NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
                [dictionary setValue:@"add category" forKey:@"category_image"];
                [arrayForServerData addObject:dictionary];
                NSLog(@"array for %@",arrayForServerData);
                //[self showHUD];
                [tableViewForCategoty reloadData];
                
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


-(void)callServiceGroup{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetGroupHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetGroup:strID];
        
}

-(void)GetGroupHandler:(id)sender{
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
            
            [spinner stopAnimating];
            [spinner removeFromSuperview];

            NSLog(@"value of string %@",strForResponce);
            //[self showHUD];
            if ([strForResponce count]>0) {
                //[self performSelector:@selector(moveNextScreen)];
                arrayForGroup=[[NSMutableArray alloc] init];
                for (int i=0; i<[strForResponce count]; i++) {
                    [arrayForGroup addObject:[strForResponce objectAtIndex:i]];
                }
                NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
                [dictionary setValue:@"add group" forKey:@"category_image"];
                [arrayForGroup addObject:dictionary];
                NSLog(@"array for %@",arrayForServerData);
                //[self showHUD];
                [tableViewForCategoty reloadData];
                //[self performSelector:@selector(killHUD) withObject:nil afterDelay:0.5];
                
            }else if(strForResponce !=nil){
                arrayForGroup=[[NSMutableArray alloc] init];
                NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
                [dictionary setValue:@"add group" forKey:@"category_image"];
                [arrayForGroup addObject:dictionary];
                [tableViewForCategoty reloadData];
                
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


- (void)swipeRightAction:(id)ignored
{
    NSLog(@"Swipe Right");
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navControllerApp popViewControllerAnimated:YES];
    //add Function
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([arrayForServerData count]==0) {
        return 0;
    }
    if (section == 0) {
        return 1;
    }
    if (section==1) {
        
    int coutForArray=[arrayForServerData count];
    if (coutForArray<=3) {
        return 1;
    }else {
        int countForRow=coutForArray/3;
        if (coutForArray%3 !=0) {
            return countForRow+1;
        }else{
            return countForRow;
        }
      }
    }
    
    if (section==2) {
        int coutForArray=[arrayForGroup count];
        if (coutForArray<=3) {
            return 1;
        }else {
            int countForRow=coutForArray/3;
            if (coutForArray%3 !=0) {
                return countForRow+1;
            }else{
                return countForRow;
            }
        }
       }
    
    return  6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    CellForWelcomeCategory *cell= (CellForWelcomeCategory*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[CellForWelcomeCategory alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    if(indexPath.section==0)
    {
        cell.textLabel.text =@"hello";
        NSString *strForProfile =[[NSUserDefaults standardUserDefaults] valueForKey:@"Userprofile_picture"];
        NSLog(@"value of profile image %@",strForProfile);
        profileImage=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 0, 80, 140)];
        [profileImage loadImage:strForProfile];
        [profileImage setBackgroundColor:[UIColor whiteColor]];
        [profileImage addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:profileImage];
        //y coordinate modified by SUNDEEP 1 line below
        coverImg=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(83, 0, 250, 140)];
        [coverImg setBackgroundColor:[UIColor grayColor]];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"] hasPrefix:@"http://"]) {
            
            NSLog(@"value of cover image %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"]);
            [coverImg loadImage:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"]];
        }
        [coverImg addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:coverImg];
       
        btn_Feed = [[UIButton alloc]initWithFrame:CGRectMake(269, 117,48,25)];
        [btn_Feed addTarget:self action:@selector(actionOnFeed:)forControlEvents:UIControlEventTouchDown];
        UIImage *btn_Img = [UIImage imageNamed:@"feedbtn.png"];
        [btn_Feed setImage:btn_Img forState:UIControlStateNormal];
        [cell addSubview:btn_Feed];
        btn_Feed = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn_Feed addTarget:self
                   action:@selector(actionOnFeed:)
         forControlEvents:UIControlEventTouchDown];
//        [btn_Feed setTitle:@"Feed" forState:UIControlStateNormal];
//        btn_Feed.frame = CGRectMake(280, 0, 160.0, 40.0);
//        [cell addSubview:btn_Feed];
//        cell.imageView.image = profileImage;
    }
    //***************************
    if (indexPath.section==1) {
    
    int countForRow=[arrayForServerData count]/3;
    if ([arrayForServerData count]%3 !=0) {
        countForRow= countForRow+1;
    }
    int coutForLoop=3;
    if (indexPath.row==countForRow-1 && [arrayForServerData count]>3 && [arrayForServerData count]%3 !=0) {
        coutForLoop=[arrayForServerData count]%3;
    }else if ([arrayForServerData count]<=3){
        coutForLoop=[arrayForServerData count];
    }
    for (int i=0; i<coutForLoop; i++) {
        
        
        if ((indexPath.row *3)+i <[arrayForServerData count]) {
            
            if ([[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_image"] isEqualToString:@"add category"]) {
                if (i==0) {
                    [cell.image1 setBackgroundColor:[UIColor whiteColor]];
                    [cell.image1 setTitle:@"Add caty" forState:UIControlStateNormal];
                    [cell.image1 setImage:[UIImage imageNamed:@"add_category_txt.png"] forState:UIControlStateNormal];
                    [cell.image1 addTarget:self action:@selector(actionOnCategory:) forControlEvents:UIControlEventTouchUpInside];
                }else if(i==1){
                    [cell.image2 setBackgroundColor:[UIColor whiteColor]];
                    [cell.image2 setTitle:@"Add caty" forState:UIControlStateNormal];
                    [cell.image2 setImage:[UIImage imageNamed:@"add_category_txt.png"] forState:UIControlStateNormal];
                    [cell.image2 addTarget:self action:@selector(actionOnCategory:) forControlEvents:UIControlEventTouchUpInside];
                }else if(i==2){
                    [cell.image3 setBackgroundColor:[UIColor whiteColor]];
                    [cell.image3 setTitle:@"Add caty" forState:UIControlStateNormal];
                    [cell.image3 setImage:[UIImage imageNamed:@"add_category_txt.png"] forState:UIControlStateNormal];
                    [cell.image3 addTarget:self action:@selector(actionOnCategory:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                return cell;
            }
            
            NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"user_category_image"]];
            if (i==0 && [str hasPrefix:@"http"]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.image1.tag=(indexPath.row *3)+i;
                cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image1.layer.borderWidth=0;
                [cell.image1 loadImage:str];
                cell.imgViewForGra1.hidden=NO;
                //[cell.image1 setImage:[UIImage imageNamed:@"Splash1.png"] forState:UIControlStateNormal];
                [cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//                if ([[dicForCheckCate valueForKey:[NSString stringWithFormat:@"%d",(indexPath.row *3)+i]] isEqualToString:@"check"]) {
//                    [cell.lbl1 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];   
//                    
//                }else{
//                    [cell.lbl1 setTextColor:[UIColor whiteColor]];
//                }
                
                [cell.lbl1 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"user_categy_name"]];//category_name
                cell.lbl1.tag=0;
                
            }
            
            if (i==1 && [str hasPrefix:@"http"]) {
                cell.image2.tag=(indexPath.row *3)+i;
                [cell.image2 loadImage:str];
                cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image2.layer.borderWidth=0;
                cell.imgViewForGra2.hidden=NO;
                [cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//                
//                if ([[dicForCheckCate valueForKey:[NSString stringWithFormat:@"%d",(indexPath.row *3)+i]] isEqualToString:@"check"]) {
//                    [cell.lbl2 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];   
//                    
//                }else{
//                    [cell.lbl2 setTextColor:[UIColor whiteColor]];
//                }
                [cell.lbl2 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"user_categy_name"]];
                cell.lbl2.tag=0;
                
            }
            
            if (i==2 && [str hasPrefix:@"http"]) {
                
                cell.image3.tag=(indexPath.row *3)+i;
                [cell.image3 loadImage:str];
                cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image3.layer.borderWidth=0;
                cell.imgViewForGra3.hidden=NO;
                [cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
//                if ([[dicForCheckCate valueForKey:[NSString stringWithFormat:@"%d",(indexPath.row *3)+i]] isEqualToString:@"check"]) {
//                    [cell.lbl3 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];   
//                    
//                }else{
//                    [cell.lbl3 setTextColor:[UIColor whiteColor]];
//                }
                
                [cell.lbl3 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"user_categy_name"]];
                cell.lbl3.tag=0;
            }
        }
      }
    }
    //***************************
    
    if (indexPath.section==2) {
        
        int countForRow=[arrayForGroup count]/3;
        if ([arrayForGroup count]%3 !=0) {
            countForRow= countForRow+1;
        }
        int coutForLoop=3;
        if (indexPath.row==countForRow-1 && [arrayForGroup count]>3 && [arrayForGroup count]%3 !=0) {
            coutForLoop=[arrayForGroup count]%3;
        }else if ([arrayForGroup count]<=3){
            coutForLoop=[arrayForGroup count];
        }
        for (int i=0; i<coutForLoop; i++) {
            
            
            if ((indexPath.row *3)+i <[arrayForGroup count]) {
                
                if ([[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_image"] isEqualToString:@"add group"]) {
                    if (i==0) {
                        [cell.image1 setBackgroundColor:[UIColor whiteColor]];
                        [cell.image1 setTitle:@" Add  Group" forState:UIControlStateNormal];
                        [cell.image1 setBackgroundImage:[UIImage imageNamed:@"add_category.png"] forState:UIControlStateNormal];
                        [cell.image1 addTarget:self action:@selector(actionOnGroup:) forControlEvents:UIControlEventTouchUpInside];
                    }else if(i==1){
                        [cell.image2 setBackgroundColor:[UIColor whiteColor]];
                        [cell.image2 setTitle:@" Add  Group" forState:UIControlStateNormal];
                        [cell.image2 setBackgroundImage:[UIImage imageNamed:@"add_category.png"] forState:UIControlStateNormal];
                        [cell.image2 addTarget:self action:@selector(actionOnGroup:) forControlEvents:UIControlEventTouchUpInside];
                    }else if(i==2){
                        [cell.image3 setBackgroundColor:[UIColor whiteColor]];
                        [cell.image3 setTitle:@" Add  Group" forState:UIControlStateNormal];
                        [cell.image3 setBackgroundImage:[UIImage imageNamed:@"add_category.png"] forState:UIControlStateNormal];
                        [cell.image3 addTarget:self action:@selector(actionOnGroup:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    return cell;
                }
               
                NSString *str=[NSString stringWithFormat:@"%@",[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_image_url"]];
                if (i==0 && [str hasPrefix:@"http"]) {
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.image1.tag=(indexPath.row *3)+i;
                    cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image1.layer.borderWidth=0;
                    [cell.image1 loadImage:str];
                    cell.imgViewForGra1.hidden=NO;
                    //[cell.image1 setImage:[UIImage imageNamed:@"Splash1.png"] forState:UIControlStateNormal];
                    [cell.image1 addTarget:self action:@selector(actionOnGroupEdit:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl1 setText:[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_name"]];//category_name
                    cell.lbl1.tag=0;
                    
                }
                
                if (i==1 && [str hasPrefix:@"http"]) {
                    cell.image2.tag=(indexPath.row *3)+i;
                    [cell.image2 loadImage:str];
                    cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image2.layer.borderWidth=0;
                    cell.imgViewForGra2.hidden=NO;
                    [cell.image2 addTarget:self action:@selector(actionOnGroupEdit:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.lbl2 setText:[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_name"]];
                    cell.lbl2.tag=0;
                    
                }
                
                if (i==2 && [str hasPrefix:@"http"]) {
                    
                    cell.image3.tag=(indexPath.row *3)+i;
                    [cell.image3 loadImage:str];
                    cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image3.layer.borderWidth=0;
                    cell.imgViewForGra3.hidden=NO;
                    [cell.image3 addTarget:self action:@selector(actionOnGroupEdit:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl3 setText:[[arrayForGroup objectAtIndex:(indexPath.row *3)+i] valueForKey:@"group_name"]];
                    cell.lbl3.tag=0;
                }
            }
        }
    }
    
    return cell;

    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 30;
    }
//    if (section==1) {
//        return 2;
//    }

    return  0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"section ki values = %d", section);
        if (section==2) {
        
        UIView *viewForHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UIImageView *imgViewForBg=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 30)];
        [imgViewForBg setImage:[UIImage imageNamed:@"nav_bottom_bar.png"]];
        [viewForHeader addSubview:imgViewForBg];
        //search_bar
        UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
        [lblForAddress setText:@"Group"];
        [lblForAddress setFont:[UIFont boldSystemFontOfSize:14]];
        [lblForAddress setTextAlignment:UITextAlignmentLeft];
        [lblForAddress setBackgroundColor:[UIColor clearColor]];
        [lblForAddress setTextColor:[UIColor darkGrayColor]];
        [viewForHeader addSubview:lblForAddress];
        
        return viewForHeader;
    }
//    if (section==1) {
//        
//        UIView *viewForHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
//        UIImageView *imgViewForBg=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 30)];
//        [imgViewForBg setImage:[UIImage imageNamed:@"nav_bottom_bar.png"]];
//        [viewForHeader addSubview:imgViewForBg];
//        //search_bar btn_Feed = [[UIButton alloc]initWithFrame:CGRectMake(267, 0,48,25)];
//      
//
//        UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
//        [lblForAddress setText:@"Add Category"];
//        [lblForAddress setFont:[UIFont boldSystemFontOfSize:14]];
//        [lblForAddress setTextAlignment:UITextAlignmentLeft];
//        [lblForAddress setBackgroundColor:[UIColor clearColor]];
//        [lblForAddress setTextColor:[UIColor darkGrayColor]];
//        [viewForHeader addSubview:lblForAddress];
//        
//        btn_Feed = [[UIButton alloc]initWithFrame:CGRectMake(267,2,48,25)];
//        [btn_Feed addTarget:self action:@selector(actionOnFeed:)forControlEvents:UIControlEventTouchDown];
//        UIImage *btn_Img = [UIImage imageNamed:@"feedbtn.png"];
//        [btn_Feed setImage:btn_Img forState:UIControlStateNormal];
//        [viewForHeader addSubview:btn_Feed];
//        return viewForHeader;
//    }

    return nil;
    
}

-(void)actionOnCategory:(id)sender{
    AddCategoryInUser *obj=[[AddCategoryInUser alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
  
}

-(void)actionOnGroupEdit:(id)sender{
    UIButton *btn=(UIButton*)sender;
    AddGroupViewController *obj=[[AddGroupViewController alloc] init];
    obj.strForCheckEdit=@"edit";
    if (btn.tag<[arrayForGroup count]) {
        obj.dicForGroupInfo=[arrayForGroup objectAtIndex:btn.tag];
    }
    obj.strForUserID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(void)actionOnZoom:(UIButton*)sender{
    
    UIImage *img=[sender.imageView image];
    if (img!=nil) {
        zoomViewController *obj=[[zoomViewController alloc] init];
        obj.imgOnZoom=img;
        obj.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:obj animated:YES];
    }
    
}

-(void)actionOnGroup:(id)sender{
   
    AddGroupViewController *obj=[[AddGroupViewController alloc] init];
    obj.strForUserID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (void)checkButtonTapped:(UIButton*)sender 
{
//    NSArray *array=[sender subviews];
//    if ([array count]>0 && [[array objectAtIndex:1] isKindOfClass:[UILabel class]]) {
//        UILabel *lbl=[array objectAtIndex:1];
//        if (lbl.tag==0) {
//            lbl.tag=1;
//            [lbl setTextColor:[UIColor blueColor]];     
//        }else{
//            lbl.tag=0;
//            [lbl setTextColor:[UIColor whiteColor]];
//        }
//    }
    
//    "master_category_id" = 518737f1b554cfd51d000002;
//    "master_category_image" = "http://s3.amazonaws.com/welike1/master_category/518737f1b554cfd51d000002/category_image/:medium.png?1367816177";
//    "master_category_name" = Books;
//    status = YES;
//    "user_category_id" = 5226fdd101ce2ec49c000002;
    UIButton *btn=(UIButton*)sender;
    dicForCategorySelected=[NSDictionary dictionaryWithObjectsAndKeys:[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"master_category_id"],@"master_category_id",[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_category_image"],@"master_category_image",[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_categy_name"],@"master_category_name",[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_id"],@"user_category_id", nil];
    
    
    
    EnityUserController *obj=[[EnityUserController alloc] init];
    //NSLog(@"value of %@",[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_category_id"]);
    obj.strForCateID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_category_id"];
    obj.strForCateName=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_categy_name"];
    obj.strForMastCateID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"master_category_id"];
    [self.navigationController pushViewController:obj animated:YES];
    
   // MediadetailViewController *obj=[[MediadetailViewController alloc] init];
   // [self.navigationController pushViewController:obj animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140;
    }
    else{
    return 105;    
    }
    
}

-(void)callArrangeTop{
    
    id sender=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"];
    NSLog(@"sender %@",sender);
    if ([sender isKindOfClass:[NSString class]]) {
        sender=[sender capitalizedString];
        lblForTitle.text=sender;
    }
    //coverImg=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 320, 130)];
    [coverImg setBackgroundColor:[UIColor grayColor]];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"] hasPrefix:@"http://"]) {
        
        NSLog(@"value of cover image %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"]);
        [coverImg loadImage:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"]];
    }
    [coverImg addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:coverImg];
    
//    NSString *strForProfile =[[NSUserDefaults standardUserDefaults] valueForKey:@"Userprofile_picture"];
//    NSLog(@"value of profile image %@",strForProfile);
//    profileImage=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 80, 120)];
//    [profileImage loadImage:strForProfile];
//    [profileImage setBackgroundColor:[UIColor whiteColor]];
//    [profileImage addTarget:self action:@selector(actionOnZoom:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:profileImage];
    
}


-(void)callupdate_sort_setting{
    
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(update_sort_settingHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service update_sort_setting:strID];
}

-(void)update_sort_settingHandler:(id)sender{
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
        
        NSLog(@"**********%@",strForResponce);
        [tableViewForCategoty reloadData];
//        if (error==nil) {
//            
//        
//        }else{
//            UIAlertView *errorAlert = [[UIAlertView alloc]
//                                       initWithTitle: @"Error"
//                                       message: @"Error from server please try again later."
//                                       delegate:nil
//                                       cancelButtonTitle:@"OK"
//                                       otherButtonTitles:nil];
//            [errorAlert show];
//            
//        }
        
    }
}

-(void)updateScreen{

    [self performSelector:@selector(callService) withObject:nil afterDelay:0.0];
    [self performSelector:@selector(callServiceGroup) withObject:nil afterDelay:0.0];

}
-(IBAction)actionOnFeed:(id)sender{

    //MessagesViewController *obj=[[MessagesViewController alloc] init];
    //[self.navigationController pushViewController:obj animated:YES];
  
    UserProfileFeedViewController *obj=[[UserProfileFeedViewController alloc] init];
    obj.strForUserId=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [self.navigationController pushViewController:obj animated:YES];
    
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
