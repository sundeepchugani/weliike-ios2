//
//  SortingViewController.m
//  WeLiiKe
//
//  Created by techvalens on 06/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SortingViewController.h"
#import "CityAndSubCategoryViewController.h"
@implementation SortingViewController
@synthesize txtFieldForCity,txtFieldSubCategory,imgViewForSorting,dicForCityAndSub;


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
    selectedSort=0;
//    tableViewForCitySub=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 410) style:UITableViewStyleGrouped];
//    tableViewForCitySub.delegate=self;
//    tableViewForCitySub.dataSource=self;
//    tableViewForCitySub.hidden=YES;
//    [self.view addSubview:tableViewForCitySub];
    
    arrayForData=[[NSMutableArray alloc] init];
    NSLog(@"value is = = = =  %@",txtFieldForCity.text);
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
    
    if ([s1 length]>0) {
         txtFieldForCity.text =s1;
       // [self showHUD];
       // [self performSelector:@selector(callWebServiceSave) withObject:nil afterDelay:0.2];
    }
    if ([s2 length]>0){
        txtFieldSubCategory.text = s2;
    }
}

-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(soring_settingHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service soring_setting:strID];
}


-(void)soring_settingHandler:(id)sender{
    
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
                    NSDictionary *dic=(NSDictionary*)strForResponce;
                    if ([[dic valueForKey:@"sort_by"] isEqualToString:@"Rating"]) {
                        
                        selectedSort=0;
                        [imgViewForSorting setImage:[UIImage imageNamed:@"rating_active.png"]];
                        
                    }else if ([[dic valueForKey:@"sort_by"] isEqualToString:@"Friend"]){
                        selectedSort=1;
                        [imgViewForSorting setImage:[UIImage imageNamed:@"friend_active.png"]];
                        
                    }else if ([[dic valueForKey:@"sort_by"] isEqualToString:@"Proximity"]){
                        
                        selectedSort=2;
                        [imgViewForSorting setImage:[UIImage imageNamed:@"proximity.png"]];
                        
                    }else if ([[dic valueForKey:@"sort_by"] isEqualToString:@"Recent"]){
                        
                        selectedSort=3;
                        [imgViewForSorting setImage:[UIImage imageNamed:@"recent_active.png"]];
                        
                    }
                    if ([dic valueForKey:@"narrow_by_city"]!=[NSNull null]) {
                        if ([[dic valueForKey:@"narrow_by_city"] isKindOfClass:[NSArray class]]) {
                            if ([[dic valueForKey:@"narrow_by_city"] count]>0) {
                                txtFieldForCity.text=[[dic valueForKey:@"narrow_by_city"] objectAtIndex:0];
                            }else{
                                txtFieldForCity.text=@"show all";
                            }
                            
                        }else{
                            txtFieldForCity.text=@"show all";
                        }
                        
                    }else{
                        txtFieldForCity.text=@"show all";
                    }
                    if ([dic valueForKey:@"narrow_by_sub_category"] !=[NSNull null]) {
                        
                        if ([[dic valueForKey:@"narrow_by_sub_category"] isKindOfClass:[NSArray class]]) {
                            
                            if ([[dic valueForKey:@"narrow_by_sub_category"] count]>0) {
                                txtFieldSubCategory.text=[[dic valueForKey:@"narrow_by_sub_category"] objectAtIndex:0];
                            }else{
                                txtFieldSubCategory.text=@"show all";
                            }
                           
                        }else{
                            txtFieldSubCategory.text=@"show all";
                        }
                        
                        
                    }else{
                        txtFieldSubCategory.text=@"show all";
                    }
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


-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)actionOnDone:(id)sender{
    [self showHUD];
    [self performSelector:@selector(callWebServiceSave) withObject:nil afterDelay:0.2];
    
}
-(void)callWebServiceSave{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(sort_entityHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strForSort=@"";
    if (selectedSort==0) {
        strForSort=@"Rating";
    }else if (selectedSort==1){
        strForSort=@"Friend";
    }else if (selectedSort==2){
        strForSort=@"Proximity";
    }else if (selectedSort==3){
        strForSort=@"Recent";
    }
    if ([txtFieldForCity.text isEqualToString:@"show all"] && [txtFieldSubCategory.text isEqualToString:@"show all"]) {
        [service sort_entity:strID sort_by:strForSort narrow_by_city:@"" narrow_by_sub_cateogy:@""];
    }else if (![txtFieldForCity.text isEqualToString:@"show all"] && [txtFieldSubCategory.text isEqualToString:@"show all"]) {
        [service sort_entity:strID sort_by:strForSort narrow_by_city:txtFieldForCity.text narrow_by_sub_cateogy:@""];
    }else if ([txtFieldForCity.text isEqualToString:@"show all"] && ![txtFieldSubCategory.text isEqualToString:@"show all"]) {
        [service sort_entity:strID sort_by:strForSort narrow_by_city:@"" narrow_by_sub_cateogy:txtFieldSubCategory.text];
    }else{
        [service sort_entity:strID sort_by:strForSort narrow_by_city:txtFieldForCity.text narrow_by_sub_cateogy:txtFieldSubCategory.text];
    }
    
    }



-(void)sort_entityHandler:(id)sender{
    
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
                [self.navigationController popViewControllerAnimated:YES];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  [arrayForData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell";
    
    UITableViewCell *cellSug= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cellSug == nil) {
        cellSug = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    cellSug.selectionStyle=UITableViewCellSelectionStyleNone;
    cellSug.textLabel.text=[arrayForData objectAtIndex:indexPath.row];//suggest_btn
    [cellSug.textLabel setFont:[UIFont boldSystemFontOfSize:15]];;
    [cellSug.textLabel setTextColor:[UIColor darkGrayColor]];
    
    return cellSug;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row<[arrayForData count]) {
        
        if ([strForCitySubCate isEqualToString:@"City"]) {
            txtFieldForCity.text=[arrayForData objectAtIndex:indexPath.row];
        }else{
            txtFieldSubCategory.text=[arrayForData objectAtIndex:indexPath.row];
        }
    }
    tableViewForCitySub.hidden=YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [NSString stringWithFormat:@"Select %@",strForCitySubCate];
    }
    return @"";
}
-(IBAction)actionOnRating:(id)sender{

    selectedSort=0;
    [imgViewForSorting setImage:[UIImage imageNamed:@"rating_active.png"]];
    
}
-(IBAction)actionOnFriend:(id)sender{

    selectedSort=1;
    [imgViewForSorting setImage:[UIImage imageNamed:@"friend_active.png"]];
}
-(IBAction)actionOnProximity:(id)sender{
   
    selectedSort=2;
    [imgViewForSorting setImage:[UIImage imageNamed:@"proximity.png"]];
    txtFieldForCity.text=@"show all";
}
-(IBAction)actionOnRecent:(id)sender{
    
    selectedSort=3;
    [imgViewForSorting setImage:[UIImage imageNamed:@"recent_active.png"]];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextView *)textView{
    
//    CGPoint currentCenter = [self.view center];
//    CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y - 150);
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    [self.view setCenter:newCenter];
//    [UIView commitAnimations];
    
    
}
- (void)textFieldDidEndEditing:(UITextView *)textView{
    
//    CGPoint currentCenter = [self.view center];
//    CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y + 150);
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    [self.view setCenter:newCenter];
//    [UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([arrayForData count]>0) {
        [arrayForData removeAllObjects];
    }
    
    if (selectedSort==2 && txtFieldForCity==textField) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"You can't select city when search by Proximity."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        return NO;
    }
    if (txtFieldForCity==textField) {
        
        strForCitySubCate=[NSString stringWithFormat:@"City"];
               NSArray *arry=[dicForCityAndSub valueForKey:@"city"];
     
        for (int i=0; i<[arry count]; i++) {
            if (![[arry objectAtIndex:i] isEqual:[NSNull null]] && [arry objectAtIndex:i] !=nil && [[arry objectAtIndex:i] length]>0 && ![[arry objectAtIndex:i] isEqualToString:@"(null)"]) {
                [arrayForData addObject:[arry objectAtIndex:i]];
            }
        }
        
        arry = [(NSArray*)arrayForData sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [arrayForData insertObject:@"show all" atIndex:0];
        CityAndSubCategoryViewController *obj = [[CityAndSubCategoryViewController alloc]init];
        obj.arry = arrayForData;
        obj.strForCitySubCategory = strForCitySubCate;
      
        [self presentModalViewController:obj animated:YES];
    }else{
        strForCitySubCate=[NSString stringWithFormat:@"Subcategory"];
        NSArray *arry=[dicForCityAndSub valueForKey:@"sub_category"];
        for (int i=0; i<[arry count]; i++) {
            if (![[arry objectAtIndex:i] isEqual:[NSNull null]] && [arry objectAtIndex:i] !=nil && [[arry objectAtIndex:i] length]>0 && ![[arry objectAtIndex:i] isEqualToString:@"(null)"]) {
                [arrayForData addObject:[arry objectAtIndex:i]];
            }
        }
        arry = [(NSArray*)arrayForData sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        arrayForData=[[NSMutableArray alloc] initWithArray:arry copyItems:YES];
        [arrayForData insertObject:@"show all" atIndex:0];
        CityAndSubCategoryViewController *obj = [[CityAndSubCategoryViewController alloc]init];
        obj.arry = arrayForData;
        obj.strForCitySubCategory = strForCitySubCate;
        [self presentModalViewController:obj animated:YES];
    }
    if ([arrayForData count]==0) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: [NSString stringWithFormat:@"No data found for %@",strForCitySubCate]
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        return NO;
    }
    
    tableViewForCitySub.hidden=NO;
    [tableViewForCitySub reloadData];
    return NO;
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

- (IBAction)actionOnReset:(id)sender {
      txtFieldForCity.text = @"show all";
      txtFieldSubCategory.text = @"show all";
      [self performSelector:@selector(callWebServiceSave) withObject:nil afterDelay:0.2];
      selectedSort=3;
      [imgViewForSorting setImage:[UIImage imageNamed:@"recent_active.png"]];

}
@end
