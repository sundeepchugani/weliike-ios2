//
//  SearchEntityViewController.m
//  WeLiiKe
//
//  Created by techvalens on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SearchEntityViewController.h"
#import "MediadetailViewController.h"
#import "SortingViewController.h"
#import "OtherUserProfile.h"

@implementation SearchEntityViewController
@synthesize lblForTitle,txtFieldForSearch,tableViewForSearchEntity,strForEnityName,strForCateID,strForMasterID,strFoSearchName;

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
    arrayForLatLng=[[NSMutableArray alloc] init];
    
    checkForGridAndList=0;
    checkForMap=0;
    lblForTitle.text=strForEnityName;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)actionOnLocation:(id)sender{
   
    if ([arrayForServerData count]>0) {
        if (checkForMap>0) {
            checkForMap=0;
        }else{
            checkForMap=1;
        }
    }
    
    [tableViewForSearchEntity reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(callWebServiceForCityAndSubCate) withObject:nil afterDelay:0.2];
    //[self performSelector:@selector(callWebService)];
}
-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(searchEntityForAllHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    //NSArray *strForResponce=[service EntitySearch:txtFieldForSearch.text];
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSLog(@"text field for search = = = = = %@", txtFieldForSearch.text);
    [service searchEntityForAll:strID user_category_id:strForCateID search:strFoSearchName master_category_id:strForMasterID entity_name:txtFieldForSearch.text address:delegate.strForAddressDelegate];
}
-(void)searchEntityForAllHandler:(id)sender{
    
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
                if ([strForResponce isKindOfClass:[NSDictionary class]]) {
                    
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Message"
                                               message: [strForResponce valueForKey:@"message"]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                    
                }else{
                    NSLog(@"value of %d",[strForResponce count]);
                    arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                    
                    if ([arrayForServerData count]>0) {
                        if ([[[arrayForServerData objectAtIndex:0] valueForKey:@"is"] isEqualToString:@"Rating"]) {
                            
                            NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                                        initWithKey:@"rating_count"
                                                        ascending:NO
                                                        selector:@selector(localizedStandardCompare:)];
                            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
                            [arrayForServerData sortUsingDescriptors:sortDescriptors];
                        }
                    }
                    
                    if ([arrayForLatLng count]>0) {
                        [arrayForLatLng removeAllObjects];
                    }
                    for (int i=0; i<[arrayForServerData count]; i++) {
                        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
                        
                        if ([[arrayForServerData objectAtIndex:i] valueForKey:@"lat"]!=nil && ![[[arrayForServerData objectAtIndex:i] valueForKey:@"lat"] isEqual:[NSNull null]]) {
                            [dic setValue:[[arrayForServerData objectAtIndex:i] valueForKey:@"lat"] forKey:@"lat"];
                            [dic setValue:[[arrayForServerData objectAtIndex:i] valueForKey:@"longitude"] forKey:@"lng"];
                            [arrayForLatLng addObject:dic];
                        }
                        
                    }
                    
                    static NSString *CellIdentifierMap = @"CellMap";
                    cellMap= [[MapCell alloc] init];
                    if (cellMap == nil) {
                        cellMap = [[MapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierMap];
                    }
                    if (checkForMap==2) {
                        cellMap.MapViewForLocation.frame=CGRectMake(0, 0, 320, 300);
                        cellMap.btnForZoom.frame=CGRectMake(274, 260, 36, 30);
                        [cellMap.btnForZoom setImage:[UIImage imageNamed:@"zoom_out.png"] forState:UIControlStateNormal];
                    }else{
                        cellMap.MapViewForLocation.frame=CGRectMake(0, 0, 320, 150);
                        cellMap.btnForZoom.frame=CGRectMake(274, 110, 36, 30);
                        [cellMap.btnForZoom setImage:[UIImage imageNamed:@"zoom.png"] forState:UIControlStateNormal];
                    }
                    [cellMap showpin:(NSArray*)arrayForLatLng];
                    [cellMap.btnForZoom addTarget:self action:@selector(actionOnZoom:event:) forControlEvents:UIControlEventTouchUpInside];
                    [cellMap.btnForZoom setBackgroundColor:[UIColor clearColor]];
                    
                    [tableViewForSearchEntity reloadData];
                }
            }else{
                [arrayForServerData removeAllObjects];
                [tableViewForSearchEntity reloadData];
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


-(void)callWebServiceForCityAndSubCate{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(get_city_and_sub_categoryHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service get_city_and_sub_category:strID user_category_id:strForCateID search:strFoSearchName master_category_id:strForMasterID];
    
}

-(void)get_city_and_sub_categoryHandler:(id)sender{
    
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
        NSLog(@"value of data %@",str);
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
                    dicForCitySubcate=[[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)strForResponce copyItems:YES];
                    NSLog(@"value of %@",dicForCitySubcate);
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
    if (checkForGridAndList==0) {
        
        int coutForArray=[arrayForServerData count];
        if (coutForArray<=3) {
            if (checkForMap>0) {
                return 2;
            }
            return 1;
        }else {
            int countForRow=coutForArray/3;
            if (coutForArray%3 !=0) {
                if (checkForMap>0) {
                    return countForRow+2;
                }
                return countForRow+1;
            }else{
                if (checkForMap>0) {
                    return countForRow+1;
                }
                return countForRow;
            }
        }
    }else{
        if (checkForMap>0) {
            return [arrayForServerData count]+1;
        }
        return [arrayForServerData count];
    }
    
    
    return  6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"CellTest";
    UITableViewCell *cell111= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell111 == nil) {
        cell111 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    int indexValue=indexPath.row;
    
    if (checkForMap>0 && indexValue==0) {
        //indexValue=indexValue-1;
        
        return cellMap;
        
    }
    
    if (checkForMap>0) {
        indexValue=indexValue-1;
    }
    
    if (checkForGridAndList==0) {
        
        EnitityCell *cell= (EnitityCell*)[tableView dequeueReusableCellWithIdentifier:nil];
        
        if (cell == nil) {
            cell = [[EnitityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //***************************
        
        int countForRow=[arrayForServerData count]/3;
        if ([arrayForServerData count]%3 !=0) {
            countForRow= countForRow+1;
        }
        int coutForLoop=3;
        if (indexValue==countForRow-1 && [arrayForServerData count]>3) {
            coutForLoop=[arrayForServerData count]%3;
        }else if ([arrayForServerData count]<=3){
            coutForLoop=[arrayForServerData count];
        }
        for (int i=0; i<coutForLoop; i++) {
            if ((indexValue *3)+i <[arrayForServerData count]) {
                NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"entity_image"]];
                NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"profile_picture"]];
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
                if (i==0 ) {
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.image1.tag=(indexValue *3)+i;
                    cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image1.layer.borderWidth=1.5;
                    [cell.image1 loadImage:str];
                    [cell.profileImage1 loadImage:strProfile];
                    cell.imgViewForGra1.hidden=NO;
                    cell.profileImage1.tag=(indexPath.row *3)+i;
                    [cell.profileImage1 addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.lbl1 setTextColor:[UIColor whiteColor]];
                    
                    [cell.lbl1 setText:[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"entity_name"]];//category_name
                    cell.lbl1.tag=0;
                    [cell.starRate1 setStrImage:@"star_small.png"];
                    [cell.starRate1 setStrStarActImage:@"star_active_small.png"];
                    if ([[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"rating_count"]!=[NSNull null]) {
                        [cell.starRate1 setValue:[[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"rating_count"] intValue]];
                    }else{
                        [cell.starRate1 setValue:0];
                    }
                    
                }
                
                if (i==1 ) {
                    cell.image2.tag=(indexValue *3)+i;
                    [cell.image2 loadImage:str];
                    [cell.profileImage2 loadImage:strProfile];
                    cell.imgViewForGra2.hidden=NO;
                    cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image2.layer.borderWidth=1.5;
                    
                    cell.profileImage2.tag=(indexPath.row *3)+i;
                    [cell.profileImage2 addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    [cell.lbl2 setTextColor:[UIColor whiteColor]];
                    [cell.lbl2 setText:[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"entity_name"]];
                    cell.lbl2.tag=0;
                    [cell.starRate2 setStrImage:@"star_small.png"];
                    [cell.starRate2 setStrStarActImage:@"star_active_small.png"];
                    if ([[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"rating_count"]!=[NSNull null]) {
                        [cell.starRate2 setValue:[[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"rating_count"] intValue]];
                    }else{
                        [cell.starRate2 setValue:0];
                    }
                    
                }
                
                if (i==2 ) {
                    
                    cell.image3.tag=(indexValue *3)+i;
                    [cell.image3 loadImage:str];
                    [cell.profileImage3 loadImage:strProfile];
                    cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    cell.image3.layer.borderWidth=1.5;
                    cell.imgViewForGra3.hidden=NO;
                    [cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    cell.profileImage3.tag=(indexPath.row *3)+i;
                    [cell.profileImage3 addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.lbl3 setTextColor:[UIColor whiteColor]];
                    
                    [cell.lbl3 setText:[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"entity_name"]];
                    cell.lbl3.tag=0;
                    [cell.starRate3 setStrImage:@"star_small.png"];
                    [cell.starRate3 setStrStarActImage:@"star_active_small.png"];
                    if ([[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"rating_count"]!=[NSNull null]) {
                        [cell.starRate3 setValue:[[[arrayForServerData objectAtIndex:(indexValue *3)+i] valueForKey:@"rating_count"] intValue]];
                    }else{
                        [cell.starRate3 setValue:0];
                    }
                }
            }
        }
        return cell;
    }else{
        //static NSString *CellIdentifier = @"Cell";
        EntityListCell *cell1= (EntityListCell*)[tableView dequeueReusableCellWithIdentifier:nil];
        if (cell1 == nil) {
            cell1 = [[EntityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([arrayForServerData count]>indexValue) {
            
            NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:indexValue ] valueForKey:@"entity_image"]];
            NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:indexValue ] valueForKey:@"profile_picture"]];
            
            [cell1.imgForEntity loadImage:str];
            [cell1.imgForProfile loadImage:strProfile];
            
            cell1.imgForEntity.tag=indexValue;
            [cell1.imgForEntity addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            cell1.imgForProfile.tag=indexValue;
            [cell1.imgForProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
            
            cell1.imgForEntity.tag=indexValue;
            [cell1.imgForEntity addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell1.lblForEntityName setText:[[arrayForServerData objectAtIndex:indexValue ] valueForKey:@"entity_name"]];
            [cell1.lblForEntityType setText:strForEnityName];
            [cell1.lblForEntityAddress setText:[[arrayForServerData objectAtIndex:indexValue ] valueForKey:@"created_at"]];
            if ([[arrayForServerData objectAtIndex:indexValue] valueForKey:@"rating_count"]!= [NSNull null]) {
                [cell1.starRate setValue:[[[arrayForServerData objectAtIndex:indexValue] valueForKey:@"rating_count"] intValue]];
            }else{
                [cell1.starRate setValue:0];
            }
            
            //
            return cell1;
        }

    }    
    //***************************
	return cell111;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    int index=indexPath.row;
    if (checkForMap>0) {
        index=index-1;
    }
    if ([arrayForServerData count]>index) {
        if (checkForGridAndList==1){
    MediadetailViewController *obj=[[MediadetailViewController alloc] init];
    obj.strForEntity=[[arrayForServerData objectAtIndex:index] valueForKey:@"user_entity_id"];
    obj.strUserID=[[arrayForServerData objectAtIndex:index] valueForKey:@"user_id"];
    [self.navigationController pushViewController:obj animated:YES];
    }
    
    }
}

-(void)actionOnZoom:(id)sender event:(id)event{
    
    //:event:
    if (checkForMap==1) {
        checkForMap=2;
    }else{
        checkForMap=1;
        
    }
   
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
        CGPoint currentTouchPosition = [touch locationInView:self.tableViewForSearchEntity];
        NSIndexPath *indexPath = [self.tableViewForSearchEntity indexPathForRowAtPoint: currentTouchPosition];
        if (indexPath != nil)
        {
            static NSString *CellIdentifierMap = @"CellMap";
            cellMap= [[MapCell alloc] init];
            if (cellMap == nil) {
                cellMap = [[MapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierMap];
            }
            if (checkForMap==2) {
                cellMap.MapViewForLocation.frame=CGRectMake(0, 0, 320, 300);
                cellMap.btnForZoom.frame=CGRectMake(274, 260, 36, 30);
                [cellMap.btnForZoom setImage:[UIImage imageNamed:@"zoom_out.png"] forState:UIControlStateNormal];
            }else{
                cellMap.MapViewForLocation.frame=CGRectMake(0, 0, 320, 150);
                cellMap.btnForZoom.frame=CGRectMake(274, 110, 36, 30);
                [cellMap.btnForZoom setImage:[UIImage imageNamed:@"zoom.png"] forState:UIControlStateNormal];
            }
            [cellMap showpin:(NSArray*)arrayForLatLng];
            [cellMap.btnForZoom addTarget:self action:@selector(actionOnZoom:event:) forControlEvents:UIControlEventTouchUpInside];
            [cellMap.btnForZoom setBackgroundColor:[UIColor clearColor]];
            [self.tableViewForSearchEntity reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    //[tableViewForSearchEntity reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (checkForMap>0) {
        if (indexPath.row==0) {
            if (checkForMap==1) {
                return 150;
            }else{
                return 300;
            }
            
        }
        //return [arrayForServerData count]+1;
    }
    
    if (checkForGridAndList==0) {
        return 130;
    }else{
        return 75;
    }
    return 130;
}
-(void)actionOnUserProfile:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    int check=btn.tag;
    if (checkForMap==1) {
        check=check-3;
    }
    if (check<[arrayForServerData count]) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForServerData objectAtIndex:check] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    
}

- (void)checkButtonTapped:(UIButton*)sender
{
    
    UIButton *btn=(UIButton*)sender;
    MediadetailViewController *obj=[[MediadetailViewController alloc] init];
    obj.strForEntity=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_entity_id"];
    obj.strUserID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_id"];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([textField.text length]>1) {
        [self showHUD];
       [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter at least 2 character." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.clearsOnBeginEditing = NO;
//    if ([textField.text isEqualToString:@""])
//    {
//        textField.returnKeyType=UIReturnKeyDefault;
//    }
//    else{
        textField.returnKeyType=UIReturnKeyGo;
//    }
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([textField.text isEqualToString:NULL])
//    {
//       [textField setReturnKeyType:UIReturnKeyGo];
//        [textField becomeFirstResponder];
//    }
//    else{
//       [textField setReturnKeyType:UIReturnKeyDefault];
//    }
//    return YES;
//}

-(IBAction)actionOnback:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)actionOnSort:(id)sender{

    SortingViewController *obj=[[SortingViewController alloc] init];
    obj.dicForCityAndSub=dicForCitySubcate;
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(IBAction)actionOnGridAndList:(id)sender{

    UIButton *btn=(UIButton*)sender;
    if ([arrayForServerData count]>0) {
        if (checkForGridAndList==0) {
            checkForGridAndList=1;
            [btn setImage:[UIImage imageNamed:@"mosaic_btn.png"] forState:UIControlStateNormal];
        }else{
            checkForGridAndList=0;
            [btn setImage:[UIImage imageNamed:@"list_icon.png"] forState:UIControlStateNormal];
        }
    }
    [tableViewForSearchEntity reloadData];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
