//
//  AddCategoryInUser.m
//  WeLiiKe
//
//  Created by techvalens on 10/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddCategoryInUser.h"
#import "EntityViewController.h"

extern NSDictionary *dicForSelectedCate;
extern NSMutableArray *arrayForCateSelected;
extern int countSelectedCategory;

@implementation AddCategoryInUser
@synthesize tableViewForAddCate;

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
    arrayForSelectedData=[[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self showHUD];
    [self performSelector:@selector(callWebServiceForCategory) withObject:nil afterDelay:0.2];
}

-(IBAction)actionOnBack:(id)sender{
  
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)actionOnNext:(id)sender{

    FriendCloudViewController *obj=[[FriendCloudViewController alloc] init];
    obj.strForClass=@"AddCate";
    //obj.arrayForSelectedCategory=[arrayForSelectedData mutableCopy];
    [self.navigationController pushViewController:obj animated:YES];    
}

-(void)callWebServiceForCategory{
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetAllCategoryByUserIDHandler:)];;
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service GetAllCategoryByUserID:strID];
    //[self performSelector:@selector(killHUD) withObject:nil afterDelay:0.0];
}

-(void)GetAllCategoryByUserIDHandler:(id)sender{
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
                
                arrayForServerData=[[NSMutableArray alloc] init];
                for (int i=0; i<[strForResponce count]; i++) {
                    [arrayForServerData addObject:[strForResponce objectAtIndex:i]];
                }
                NSLog(@"array for %@",arrayForServerData);
                [tableViewForAddCate reloadData];
                
                //arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                //[tableViewForCategoty reloadData];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  [arrayForServerData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    CategoryAddCell *cell= (CategoryAddCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[CategoryAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }

    
    if ([[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
        cell.lblName.textColor=[UIColor redColor];
        //cell.imgAdd.hidden=NO;
        cell.imgAdd.image=[UIImage imageNamed:@"plus_active.png"];
        [cell.lblName setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        cell.lblName.text=[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"master_category_name"];
    }else{
        //cell.imgAdd.hidden=YES;
        cell.imgAdd.image=[UIImage imageNamed:@"plus_inactive.png"];
        //[cell.lblName setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [cell.lblName setTextColor:[UIColor blackColor]];
        cell.lblName.text=[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"master_category_name"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[cell.imgProfile setImage:[UIImage imageNamed:[[arrayAllServerData objectAtIndex:indexPath.row] valueForKey:@"userProfile"]] forState:UIControlStateNormal];
    //cell.lblName.text=[arrayForAfterSearch objectAtIndex:indexPath.row];
    
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([arrayForServerData count]>indexPath.row) {
        if ([[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"NO"]) {
        [[arrayForServerData objectAtIndex:indexPath.row] setValue:@"YES" forKey:@"status"];
        
            [self performSelector:@selector(callServiceAddcategory:) withObject:[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"master_category_id"] afterDelay:0.2];
            [tableViewForAddCate reloadData];
        }else if ([[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
            int countForCat=0;
            
            for (int i=0; i<[arrayForServerData count]; i++) {
                if ([[[arrayForServerData objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"YES"]){
                    countForCat++;
                }
            }
            if (countForCat>2) {
                [[arrayForServerData objectAtIndex:indexPath.row] setValue:@"NO" forKey:@"status"];
                
                [self performSelector:@selector(callServiceRemoveCategory:) withObject:[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"user_category_id"] afterDelay:0.2];
                [tableViewForAddCate reloadData];
            }else{
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"You can't remove last two categories."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
            }
        }
    }
}
//remove_category

-(void)callServiceRemoveCategory:(NSString *)idForCat{
    
    //[self showHUD];
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(remove_categoryHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service remove_category:strID user_category_id:idForCat];
    
        
}
-(void)remove_categoryHandler:(id)sender{
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
                [self performSelector:@selector(killHUD) withObject:nil afterDelay:0.0];
                
            }else{
                [self performSelector:@selector(killHUD) withObject:nil afterDelay:0.0];
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


-(void)callServiceAddcategory:(NSString *)idForCat{
    
    //[self showHUD];
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(AddCategoryHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service AddCategory:idForCat user_id:strID];
    
}

-(void)AddCategoryHandler:(id)sender{
    
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
                [self performSelector:@selector(killHUD) withObject:nil afterDelay:0.0];
                //NSLog(@"value of array resopnse %@",[[[strForResponce objectAtIndex:0] class] description]);
                if ([[strForResponce objectAtIndex:0] isKindOfClass:[NSDictionary class]]) {
                    
                    if ([[[strForResponce objectAtIndex:0] valueForKey:@"is_present"] isEqualToString:@"Yes"]) {
                         dicForSelectedCate=[NSDictionary dictionaryWithObjectsAndKeys:[[strForResponce objectAtIndex:0] valueForKey:@"user_category_id"],@"cateId",[[strForResponce objectAtIndex:0] valueForKey:@"user_category_name"],@"cateName",[[strForResponce objectAtIndex:0] valueForKey:@"master_category_id"],@"cateMasterId", nil];
                        [self.navigationController popToRootViewControllerAnimated:NO];
                    }else{
                        arrayForCateSelected=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                        countSelectedCategory=[arrayForCateSelected count];
                        EntityViewController *obj=[[EntityViewController alloc] init];
                        obj.strForCome=@"AddCate";
                        [self.navigationController pushViewController:obj animated:YES];
                    }
                    
                }
                
                //[arrayForSelectedData addObject:strForResponce];
                //[self performSelector:@selector(moveNextScreen)];
                
            }else{
                [self performSelector:@selector(killHUD) withObject:nil afterDelay:0.0];
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
