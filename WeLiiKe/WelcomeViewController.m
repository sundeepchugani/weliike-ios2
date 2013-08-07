//
//  WelcomeViewController.m
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WelcomeSearchScreen.h"
#import "EntityViewController.h"

NSMutableArray *arrayForCateSelected;
int countSelectedCategory;
@implementation WelcomeViewController
@synthesize btnForDone,tableViewForCategoty;

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
    // Do any additional setup after loading the view from its nib.
    btnForDone.hidden=YES;
    dicForCheckCate=[[NSMutableDictionary alloc] init];
    [self showHUD];
    [self performSelector:@selector(callService) withObject:nil afterDelay:0.2];
    
    // WelcomeViewController *obj=[[WelcomeViewController alloc] init];
    // [self.navigationController pushViewController:obj animated:YES];
    
}
-(void)callService{
    
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(categoryListHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    [service categoryList];
    
       
}


-(void)categoryListHandler:(id)sender{
    
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
                //[self performSelector:@selector(moveNextScreen)];
                arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                NSLog(@"hhgabfsdj habsghj %@",arrayForServerData);
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


-(void)moveNextScreen{
    
    WelcomeViewController *obj=[[WelcomeViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];    
}

-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    return  6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    CellForWelcomeCategory *cell= (CellForWelcomeCategory*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
        if (cell == nil) {
            cell = [[CellForWelcomeCategory alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
    
    //***************************
    
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
            
              NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_image_url"]];
            
            if (i==0 && [str hasPrefix:@"http"]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.image1.tag=(indexPath.row *3)+i;
                cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image1.layer.borderWidth=1.5;
                [cell.image1 loadImage:str];
                cell.imgViewForGra1.hidden=NO;
                //[cell.image1 setImage:[UIImage imageNamed:@"Splash1.png"] forState:UIControlStateNormal];
                [cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                if ([[dicForCheckCate valueForKey:[NSString stringWithFormat:@"%d",(indexPath.row *3)+i]] isEqualToString:@"check"]) {
                    [cell.lbl1 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];   
                    
                }else{
                    [cell.lbl1 setTextColor:[UIColor whiteColor]];
                }
                
                [cell.lbl1 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];//category_name
                cell.lbl1.tag=0;

            }
            
            if (i==1 && [str hasPrefix:@"http"]) {
                cell.image2.tag=(indexPath.row *3)+i;
                [cell.image2 loadImage:str];
                cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image2.layer.borderWidth=1.5;
                cell.imgViewForGra2.hidden=NO;
                [cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([[dicForCheckCate valueForKey:[NSString stringWithFormat:@"%d",(indexPath.row *3)+i]] isEqualToString:@"check"]) {
                    [cell.lbl2 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];   
                  
                }else{
                    [cell.lbl2 setTextColor:[UIColor whiteColor]];
                }
                [cell.lbl2 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];
                cell.lbl2.tag=0;

            }
            
            if (i==2 && [str hasPrefix:@"http"]) {
                
                cell.image3.tag=(indexPath.row *3)+i;
                [cell.image3 loadImage:str];
                cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                cell.image3.layer.borderWidth=1.5;
                cell.imgViewForGra3.hidden=NO;
                [cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([[dicForCheckCate valueForKey:[NSString stringWithFormat:@"%d",(indexPath.row *3)+i]] isEqualToString:@"check"]) {
                    [cell.lbl3 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];   
                    
                }else{
                    [cell.lbl3 setTextColor:[UIColor whiteColor]];
                }
                
                [cell.lbl3 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];
                cell.lbl3.tag=0;
            }
        }
    }
    //***************************
   
    return cell;
}

- (void)checkButtonTapped:(UIButton*)sender 
{
    NSArray *array=[sender subviews];
    
    for (int i=0; i<[array count]; i++) {
        if ([[array objectAtIndex:i] isKindOfClass:[UILabel class]]) {
            UILabel *lbl=[array objectAtIndex:i];
            if (lbl.tag==0) {
                lbl.tag=1;
                [dicForCheckCate setValue:@"check" forKey:[NSString stringWithFormat:@"%d",sender.tag]];
                [lbl setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];
            }else{
                [dicForCheckCate removeObjectForKey:[NSString stringWithFormat:@"%d",sender.tag]];
                lbl.tag=0;
                [lbl setTextColor:[UIColor whiteColor]];
            }
        }
    }
    
    if ([dicForCheckCate count]>=2) {
        btnForDone.hidden=NO;
    }else{
        btnForDone.hidden=YES;
    }
}

-(UIColor *)colorWithHexString:(NSString *)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}


-(IBAction)actionOnDone:(id)sender{
    [self showHUD];
    NSMutableArray *arrayForCateSelectedNew=[[NSMutableArray alloc] init];
    for (id key in dicForCheckCate) {
        if ([key intValue]<[arrayForServerData count]) {
            
            NSString *strForCateID=[[arrayForServerData objectAtIndex:[key intValue]] valueForKey:@"_id"];
            NSString *strForCateName=[[arrayForServerData objectAtIndex:[key intValue]] valueForKey:@"category_name"];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
            [dic setValue:strForCateID forKey:@"ID"];
            [dic setValue:strForCateName forKey:@"Name"];
            
            [arrayForCateSelectedNew addObject:strForCateID];
            //[arrayForCateSelected addObject:dic];
        }
    }
    NSString *str=[arrayForCateSelectedNew componentsJoinedByString:@","];
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(AddCategoryHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service AddCategory:str user_id:strID];

    
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
                [self killHUD];
                //[self performSelector:@selector(moveNextScreen)];
                arrayForCateSelected=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                countSelectedCategory=[arrayForCateSelected count];
                EntityViewController *obj=[[EntityViewController alloc] init];
                [self.navigationController pushViewController:obj animated:YES];
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



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
