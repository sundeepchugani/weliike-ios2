//
//  CityAndSubCategoryViewController.m
//  WeLiiKe
//
//  Created by Techvalens on 8/28/13.
//
//

#import "CityAndSubCategoryViewController.h"
#import "SortingViewController.h"
@interface CityAndSubCategoryViewController ()

@end

@implementation CityAndSubCategoryViewController
@synthesize arry,strForCitySubCategory;
NSString *s1;
NSString *s2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)actionOnBackButton:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  	return   [arry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell";
    
    UITableViewCell *cellSug= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cellSug == nil) {
        cellSug = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    cellSug.selectionStyle=UITableViewCellSelectionStyleNone;
    cellSug.textLabel.text=[arry objectAtIndex:indexPath.row];//suggest_btn
    [cellSug.textLabel setFont:[UIFont boldSystemFontOfSize:15]];;
    [cellSug.textLabel setTextColor:[UIColor darkGrayColor]];
    
    return cellSug;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"array = = = = = = = %@", arry);
    if (indexPath.row<[arry count]) {
        
        if ([strForCitySubCategory isEqualToString:@"City"]) {
            s1 = [arry objectAtIndex:indexPath.row];
//            .txtFieldForCity.text=[arry objectAtIndex:indexPath.row];
        }else{
            s2  = [arry objectAtIndex:indexPath.row];
           
        }
        [self dismissModalViewControllerAnimated:YES];
    }
//    tableViewForCitySub.hidden=YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [NSString stringWithFormat:@"Select %@",strForCitySubCategory];
   }
    return @"";
}


@end
