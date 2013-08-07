//
//  AggregateViewController.m
//  WeLiiKe
//
//  Created by techvalens on 10/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AggregateViewController.h"
#import "WelcomeSearchScreen.h"
#import "EnityUserController.h"

extern BOOL checkForLogInAndSignUp;
@implementation AggregateViewController
@synthesize tableViewForCategoty;

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

-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(callWebService)];
    // Do any additional setup after loading the view from its nib.
}
-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GetCategoryByUserIDHandler:)];
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
        
    }else{
        NSError *error=nil;
        NSString *str=[sender stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        //NSLog(@"value of data %@",str);
        id strForResponce = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (error==nil) {
            
            NSLog(@"value of string %@",strForResponce);
            if ([strForResponce count]>0) {
                
                arrayForServerData=[[NSMutableArray alloc] init];
                for (int i=0; i<[strForResponce count]; i++) {
                    if (i%2 !=0) {
                        [arrayForServerData addObject:[strForResponce objectAtIndex:i]];
                    }
                }
                NSLog(@"array for %@",arrayForServerData);
                [tableViewForCategoty reloadData];
                
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
    AggreegatorCell *cell= (AggreegatorCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[AggreegatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
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
            NSString *str=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_image"]];
            if (i==0 && [str hasPrefix:@"http"]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.image1.tag=(indexPath.row *3)+i;
                //cell.image1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                //cell.image1.layer.borderWidth=1.5;
                [cell.image1 loadImage:str];
                //[cell.image1 setImage:[UIImage imageNamed:@"Splash1.png"] forState:UIControlStateNormal];
                [cell.image1 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
                [cell.lbl1 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];//category_name
                cell.lbl1.tag=0;
                
            }
            
            if (i==1 && [str hasPrefix:@"http"]) {
                cell.image2.tag=(indexPath.row *3)+i;
               
                [cell.image2 loadImage:str];
                //cell.image2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                //cell.image2.layer.borderWidth=1.5;
                [cell.image2 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.lbl2 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];
                cell.lbl2.tag=0;
                
            }
            
            if (i==2 && [str hasPrefix:@"http"]) {
                
                cell.image3.tag=(indexPath.row *3)+i;
                [cell.image3 loadImage:str];
                //cell.image3.layer.borderColor=[UIColor lightGrayColor].CGColor;
                //cell.image3.layer.borderWidth=1.5;
                [cell.image3 addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.lbl3 setText:[[arrayForServerData objectAtIndex:(indexPath.row *3)+i] valueForKey:@"category_name"]];
                cell.lbl3.tag=0;
            }
        }
    }
    //***************************
    
	return cell;
}

-(void)checkButtonTapped:(id)sender{
    UIButton *btn=(UIButton*)sender;
    
    EnityUserController *obj=[[EnityUserController alloc] init];
    obj.strForCateID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"category_id"];
    [self.navigationController pushViewController:obj animated:YES];
    
    
}

-(IBAction)actionOnDone:(id)sender{
    
    checkForLogInAndSignUp=YES;
    WelcomeSearchScreen *obj=[[WelcomeSearchScreen alloc] init];
    [self.navigationController pushViewController:obj animated:YES];

    //    MenuScreenViewController *obj=[[MenuScreenViewController alloc] init];
    //    [self.navigationController pushViewController:obj animated:YES];
    
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
