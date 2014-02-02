//
//  EntityViewController.m
//  WeLiiKe
//
//  Created by techvalens on 01/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EntityViewController.h"
#import "WelcomeSearchScreen.h"
#import "AggregateViewController.h"
#import "AddFriendForCategory.h"
#import "FriendCloudViewController.h"

extern NSMutableArray *arrayForCateSelected;
extern BOOL checkForLogInAndSignUp;
extern int countSelectedCategory;

@implementation EntityViewController
@synthesize searchBarExplore,tableViewForCategoty,strForCateID,btnForDone,labelForName,strForCome;

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
    
            NSArray *array=self.navigationController.viewControllers;
            int countView=[array count];
            countView=countView-4;
            [self.navigationController popToViewController:[array objectAtIndex:[array count]-countView] animated:YES];
   // countSelectedCategory=countSelectedCategory+1;
   // [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - search bar delegates
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBarExplore setShowsCancelButton:YES animated:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
  
    [UIView commitAnimations];
    [self.view bringSubviewToFront:self.searchBarExplore];
    //[tableForSearch setUserInteractionEnabled:NO];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    //searchString=searchText;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked");
    [searchBar setShowsCancelButton:YES];
    [searchBar resignFirstResponder];
    for(id subview in [searchBar subviews])
    {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setEnabled:YES];
        }
    }
    NSLog(@"value of search Bar %@",searchBar.text);
    if (![searchBar.text isEqualToString:@""]||![searchBar.text isEqualToString:nil]) {
        
        NSString *searchText = searchBar.text;
        [self showHUD];
        [self performSelector:@selector(callSearch:) withObject:searchText afterDelay:0.2];
    }
    else{
        
    }

    
}

-(void)callSearch:(NSString *)string{

    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(entity_search_sign_upHandler:)];
    int countObj=[arrayForCateSelected count]-countSelectedCategory;
    labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"user_category_name"];
    //NSArray *strForResponce=[service GetEntityByCategory:[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"master_category_id"]];
    
    [service entity_search_sign_up:[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"master_category_id"] searchString:string];
        
}

-(void)entity_search_sign_upHandler:(id)sender{
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
                NSLog(@"value of %d",[strForResponce count]);
                NSLog(@"value of %@",strForResponce);
                NSLog(@"value of response dictionary %@",[[strForResponce class] description]);
                if ([[strForResponce class] isSubclassOfClass:[NSDictionary class]]) {
                    NSLog(@"Yes ");
                    NSDictionary *dic=(NSDictionary *)strForResponce;
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle:@"Message"
                                               message: [dic valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                }else if ([[strForResponce class] isSubclassOfClass:[NSArray class]]) {
                    arrayForServerData=[[NSMutableArray alloc] init];
                    for (int i=0; i<[strForResponce count]; i++) {
                        BOOL check=NO;
                        NSString *strForCateIDMast=[[strForResponce objectAtIndex:i] valueForKey:@"entity_name"];
                        for (int j=0; j<[arrayForServerData count]; j++) {
                            NSString *strForCate=[[arrayForServerData objectAtIndex:j] valueForKey:@"entity_name"];
                            if ([strForCate isEqualToString:strForCateIDMast]) {
                                check=YES;
                            }
                        }
                        if (check==NO) {
                            [arrayForServerData addObject:[strForResponce objectAtIndex:i]];
                        }
                        
                    }
                    
                    //arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                    NSLog(@"value of aara %@",arrayForServerData);
                    [tableViewForCategoty reloadData];
                }
                
                
            }else{
                [arrayForServerData removeAllObjects];
                [tableViewForCategoty reloadData];
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

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
    [searchBar resignFirstResponder];
    self.searchBarExplore.text=@"";
    [self.searchBarExplore setShowsCancelButton:NO animated:YES];
    [self showHUD];
    //[NSThread detachNewThreadSelector:@selector(callWebService) toTarget:self withObject:nil];
    [self performSelector:@selector(callWebService)];
//    [tableForSearch setUserInteractionEnabled:NO];
//    arrayForAfterSearch =[[NSMutableArray alloc] initWithArray:arrayForAllData copyItems:YES];
//    [tableForSearch reloadData];
//    [tableForSearch setUserInteractionEnabled:YES];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //arrayForServerData=[[NSMutableArray alloc] init];
    btnForDone.hidden=YES;
    pageNo=1;
    dicForCheckEntity=[[NSMutableDictionary alloc] init];
    arrayForServerData=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self performSelector:@selector(callWebService)];
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
}
-(void)callWebService{

    if (countSelectedCategory>0) {
        
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetEntityByCategoryHandler:)];
    int countObj=[arrayForCateSelected count]-countSelectedCategory;
    labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"user_category_name"];
    [service GetEntityByCategory:[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"master_category_id"] page:[NSString stringWithFormat:@"%d",pageNo]];
    }else{
        labelForName.text=@"";
       [arrayForServerData removeAllObjects];
       [tableViewForCategoty reloadData];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"No data found."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
    
    }
}

-(void)GetEntityByCategoryHandler:(id)sender{
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
                NSLog(@"value of %d",[strForResponce count]);
                NSLog(@"value of %@",strForResponce);
                NSLog(@"value of response dictionary %@",[[strForResponce class] description]);
                if ([[strForResponce class] isSubclassOfClass:[NSDictionary class]]) {
                    NSLog(@"Yes ");
                    NSDictionary *dic=(NSDictionary *)strForResponce;
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle:@"Message"
                                               message: [dic valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                }else if ([[strForResponce class] isSubclassOfClass:[NSArray class]]) {
                    
                    for (int i=0; i<[strForResponce count]; i++) {
                        BOOL check=NO;
                        NSString *strForCateIDMast=[[strForResponce objectAtIndex:i] valueForKey:@"entity_name"];
                        for (int j=0; j<[arrayForServerData count]; j++) {
                            NSString *strForCate=[[arrayForServerData objectAtIndex:j] valueForKey:@"entity_name"];
                            if ([strForCate isEqualToString:strForCateIDMast]) {
                                check=YES;
                            }
                        }
                        if (check==NO) {
                            [arrayForServerData addObject:[strForResponce objectAtIndex:i]];
                        }
                        
                    }
                    
                    //arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                    NSLog(@"value of aara %@",arrayForServerData);
                    [tableViewForCategoty reloadData];
                }
                
                
            }else{
                [arrayForServerData removeAllObjects];
                [tableViewForCategoty reloadData];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([arrayForServerData count]==0) {
        return 0;
    }
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
    
    return  6;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	//static NSString *CellIdentifier1 = @"Cell1";
    EnitityCell *cell= (EnitityCell*)[tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[EnitityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    //[cell.profileImage1 setImage:[UIImage imageNamed:@"sunset.png"] forState:UIControlStateNormal];
    //[cell.profileImage2 setImage:[UIImage imageNamed:@"sunset.png"] forState:UIControlStateNormal];
    //[cell.profileImage3 setImage:[UIImage imageNamed:@"sunset.png"] forState:UIControlStateNormal];

    [cell.profileImage1 setHidden:YES];
    [cell.profileImage2 setHidden:YES];
    [cell.profileImage3 setHidden:YES];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
    
    //***************************
    
    int countForRow=[arrayForServerData count]/3;
    if ([arrayForServerData count]%3 !=0) {
        countForRow= countForRow+1;
    }
//    NSLog(@"value of index path %d",indexPath.row);
//    NSLog(@"value of countForRow %d",countForRow);
    //
    if (indexPath.row==countForRow) {
        
        UITableViewCell *cell1= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:nil];
        
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        
        UIButton *btnForSeemore=[[UIButton alloc] init];
        [btnForSeemore setFrame:CGRectMake(112, 20, 75, 30)];
        btnForSeemore.tag=indexPath.row;
        btnForSeemore.userInteractionEnabled=YES;
        [btnForSeemore addTarget:self action:@selector(actionOnSeeMore:) forControlEvents:UIControlEventTouchUpInside];
        [btnForSeemore setBackgroundImage:[UIImage imageNamed:@"see_more.png"] forState:UIControlStateNormal];
        [cell1 addSubview:btnForSeemore];
        cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell1;
    }
    
    
    
    int coutForLoop=3;
    if (indexPath.row==countForRow-1 && [arrayForServerData count]>3 && [arrayForServerData count]%3 !=0) {
        coutForLoop=[arrayForServerData count]%3;
    }else if ([arrayForServerData count]<=3){
        coutForLoop=[arrayForServerData count];
    }
    
      
    for (int i=0; i<coutForLoop; i++) {
        if ((indexPath.row *3)+i <[arrayForServerData count]) {
            NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_image"]];
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
            if (i==0 && [str hasPrefix:@"http"]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.image1.tag=(indexPath.row *3)+i;
                cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image1.layer.borderWidth=1.5;
                [cell.image1 loadImage:str];
                cell.imgViewForGra1.hidden=NO;
                //[cell.image1 setImage:[UIImage imageNamed:@"Splash1.png"] forState:UIControlStateNormal];
                [cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                [cell.image1 setTitle:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_id"] forState:UIControlStateNormal];
                [cell.image1 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                if ([[dicForCheckEntity valueForKey:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_id"]] isEqualToString:@"check"]) {
                    [cell.lbl1 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];   
                    
                }else{
                    [cell.lbl1 setTextColor:[UIColor whiteColor]];
                }
                
                //category_name
                
                id displayNameTypeValue = [[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_name"];
                NSString *displayNameType = @"";
                if (displayNameTypeValue != [NSNull null])
                    displayNameType = (NSString *)displayNameTypeValue;
                
                [cell.lbl1 setText:displayNameType];
                
                cell.lbl1.tag=0;
                [cell.starRate1 setStrImage:@"star_small.png"];
                [cell.starRate1 setStrStarActImage:@"star_active_small.png"];
                
                if ([[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"rating_count"]!=[NSNull null]) {
                    [cell.starRate1 setValue:[[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"rating_count"] intValue]];
                }else{
                    [cell.starRate1 setValue:0];
                }
                
                
            }
            
            if (i==1 && [str hasPrefix:@"http"]) {
                cell.image2.tag=(indexPath.row *3)+i;
               
                [cell.image2 loadImage:str];
                cell.imgViewForGra2.hidden=NO;
                cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image2.layer.borderWidth=1.5;
                [cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.image2 setTitle:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_id"] forState:UIControlStateNormal];
                [cell.image2 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                if ([[dicForCheckEntity valueForKey:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_id"]] isEqualToString:@"check"]) {
                    [cell.lbl2 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];
                    
                }else{
                    [cell.lbl2 setTextColor:[UIColor whiteColor]];
                }
                
                id displayNameTypeValue = [[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_name"];
                NSString *displayNameType = @"";
                if (displayNameTypeValue != [NSNull null])
                    displayNameType = (NSString *)displayNameTypeValue;
                
                [cell.lbl2 setText:displayNameType];
                
                cell.lbl2.tag=0;
                [cell.starRate2 setStrImage:@"star_small.png"];
                [cell.starRate2 setStrStarActImage:@"star_active_small.png"];
                if ([[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"rating_count"]!=[NSNull null]) {
                    [cell.starRate2 setValue:[[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"rating_count"] intValue]];
                }else{
                    [cell.starRate2 setValue:0];
                }
                
            }
            
            if (i==2 && [str hasPrefix:@"http"]) {
                
                cell.image3.tag=(indexPath.row *3)+i;
                
                [cell.image3 loadImage:str];
                cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image3.layer.borderWidth=1.5;
                cell.imgViewForGra3.hidden=NO;
                [cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.image3 setTitle:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_id"] forState:UIControlStateNormal];
                [cell.image3 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                if ([[dicForCheckEntity valueForKey:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_id"]] isEqualToString:@"check"]) {
                    [cell.lbl3 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];
                    
                }else{
                    [cell.lbl3 setTextColor:[UIColor whiteColor]];
                }
                id displayNameTypeValue = [[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"entity_name"];
                NSString *displayNameType = @"";
                if (displayNameTypeValue != [NSNull null])
                    displayNameType = (NSString *)displayNameTypeValue;
                
                [cell.lbl3 setText:displayNameType];
                
                cell.lbl3.tag=0;
                [cell.starRate3 setStrImage:@"star_small.png"];
                [cell.starRate3 setStrStarActImage:@"star_active_small.png"];
                if ([[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"rating_count"]!=[NSNull null]) {
                    [cell.starRate3 setValue:[[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"rating_count"] intValue]];
                }else{
                    [cell.starRate3 setValue:0];
                }
            }
        }
    }
    //***************************
	return cell;
}

-(void)actionOnSeeMore:(UIButton*)sender{

    pageNo=pageNo+1;
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
    
}

- (void)checkButtonTapped:(UIButton*)sender 
{
    NSArray *array=[sender subviews];
    for (int i=0; i<[array count]; i++) {
        if ([[array objectAtIndex:i] isKindOfClass:[UILabel class]]) {
            UILabel *lbl=[array objectAtIndex:i];
            if (lbl.tag==0) {
                lbl.tag=1;
                [dicForCheckEntity setValue:@"check" forKey:[sender currentTitle]];
                [lbl setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];
            }else{
                [dicForCheckEntity removeObjectForKey:[sender currentTitle]];
                lbl.tag=0;
                [lbl setTextColor:[UIColor whiteColor]];
            }
        }
    }

    if ([dicForCheckEntity count]>=1) {
        btnForDone.hidden=NO;
    }else{
        btnForDone.hidden=YES;
    }
}


-(IBAction)actionOnDone:(id)sender{
    
    checkForLogInAndSignUp=YES;
    [self showHUD];
    //[NSThread detachNewThreadSelector:@selector(addCategoryEntity) toTarget:self withObject:nil];
    [self performSelector:@selector(addCategoryEntity)];
    
}

-(void)addCategoryEntity{

    NSMutableArray *arrayForCate=[[NSMutableArray alloc] init];
    for (id key in dicForCheckEntity) {
        //if ([key intValue]<[arrayForServerData count]) {
            [arrayForCate addObject:key];
        //}
    }
    NSString *str=[arrayForCate componentsJoinedByString:@","];
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(AddEntityHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    int countObj=[arrayForCateSelected count]-countSelectedCategory;
    [service AddEntity:str user_id:strID user_category_id:[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"user_category_id"]];
        
    
}

-(void)AddEntityHandler:(id)sender{
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
            [self killHUD];
            if ([strForResponce count]>0) {
                if (countSelectedCategory>1) {
                    countSelectedCategory=countSelectedCategory-1;
                    //[arrayForCateSelected removeObjectAtIndex:0];
                    EntityViewController *obj=[[EntityViewController alloc] init];
                    [self.navigationController pushViewController:obj animated:YES];
                }else{
                    
                    if ([strForCome isEqualToString:@"AddCate"]) {
                        
            FriendCloudViewController *obj=[[FriendCloudViewController alloc] init];
            obj.strForClass=@"AddCate";
            obj.strForCategoryId=[[arrayForCateSelected objectAtIndex:0] valueForKey:@"user_category_id"];
            obj.strForCategoryName=[[arrayForCateSelected objectAtIndex:0] valueForKey:@"user_category_name"];
            obj.strForMasterId=[[arrayForCateSelected objectAtIndex:0] valueForKey:@"master_category_id"];
            [self.navigationController pushViewController:obj animated:YES];

                        
                    }else{
                    
                        countSelectedCategory=[arrayForCateSelected count];
                        AddFriendForCategory *obj=[[AddFriendForCategory alloc] init];
                        [self.navigationController pushViewController:obj animated:YES];
                    
                    }
                    
                    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
