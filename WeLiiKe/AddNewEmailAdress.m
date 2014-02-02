//
//  AddNewEmailAdress.m
//  HFH
//
//  Created by mini on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddNewEmailAdress.h"
#import "SignUpCustomCell.h"
#import "EmailContects.h"
// import delegate class
#import "AppDelegate.h"
extern  BOOL iscomeFromAddNewEmail;

NSString *oldornewcontact;
// userDefaultWeliike
NSUserDefaults *userDefaultWeliike;
// int value for identify cell textView of table
int cellFlag = 0;
// Mutable dictionary for name/email of enter new email address
NSMutableDictionary *contactInfoForNewEmail;
// globle cell
SignUpCustomCell *cell;

@implementation AddNewEmailAdress
@synthesize tablenewcontact,btncancel,btnDone,contacts;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)backToEmailContectfromcancel:(id)sender;

{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)backToEmailcontectfromDone:(id)sender
{
    iscomeFromAddNewEmail=YES;
	[cell.textView resignFirstResponder];
	
	if ([[userDefaultWeliike valueForKey:@"PersonNameProperty"] length] == 0 || [[userDefaultWeliike valueForKey:@"PersonNameProperty"] isEqualToString:@" "] == YES || [[userDefaultWeliike valueForKey:@"EmailIdproperty"] isEqualToString:@" "] == YES) {
//		[self.navigationController popViewControllerAnimated:YES];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please select Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];

	}else {
    
        if ([self validEmail:[userDefaultWeliike valueForKey:@"EmailIdproperty"]]) {
            
            
            NSMutableDictionary *contactInfo = [NSMutableDictionary dictionaryWithObject:[userDefaultWeliike valueForKey:@"PersonNameProperty"] forKey:@"NAME"];
            [contactInfo setObject:[userDefaultWeliike valueForKey:@"EmailIdproperty"] forKey:@"EMAIL"];
            [contactInfo setObject:@"1" forKey:@"CHACKED"];
            [userDefaultWeliike setObject:@" " forKey:@"PersonNameProperty"];
            [userDefaultWeliike setObject:@" " forKey:@"EmailIdproperty"];
            
            // create delegate class object and add object in arrayOfEmailContact
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if ([appDelegate.arrayOfEmailContact count] == 0) {
                [appDelegate.arrayOfEmailContact addObject:contactInfo];
            }else {
                BOOL isFoundName;
                for (int i = 0; i < [appDelegate.arrayOfEmailContact count]; i++) {
                    
                    if ([[[appDelegate.arrayOfEmailContact objectAtIndex:i] valueForKey:@"NAME"] isEqualToString:[contactInfo valueForKey:@"NAME"]] == YES && [[[appDelegate.arrayOfEmailContact objectAtIndex:i] valueForKey:@"EMAIL"] isEqualToString:[contactInfo valueForKey:@"EMAIL"]] == YES) {
                        isFoundName=YES;
                        break;
                        //[appDelegate.arrayOfEmailContact addObject:contactInfo];
                    }else {
                        isFoundName=NO;
                    }
                    
                }
                if (!isFoundName) {
                    [appDelegate.arrayOfEmailContact addObject:contactInfo];
                }
            }		
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter a valid Email Id." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            
        }
    }	
    
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [self.navigationController setNavigationBarHidden:NO];
       
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToEmailContectfromcancel:)];
    self.navigationItem.leftBarButtonItem=cancelButton;
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backToEmailcontectfromDone:)];
    self.navigationItem.rightBarButtonItem=doneButton;
	tablenewcontact.delegate = self;
	contactInfoForNewEmail = [[NSMutableDictionary alloc] init];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5)  {
        
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        //self.navigationController.navigationBar.layer.contents=(id)[UIImage imageNamed:@"apps_header_without_text.png"].CGImage;
        
    }else{
        
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"apps_header_without_text.png"] forBarMetrics:UIBarMetricsDefault];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (section==0) {
		return 2;
	}
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
    
	
    cell = (SignUpCustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SignUpCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textView.delegate=self;
    
	userDefaultWeliike = [[NSUserDefaults alloc]init];
	oldornewcontact= [userDefaultWeliike valueForKey:@"fromcontectlist"];
    
    if (indexPath.section==0) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:
				
                cell.textLable.text=@"Name";
                [cell.textView setAutocapitalizationType:UITextAutocorrectionTypeDefault];
				if ([oldornewcontact isEqualToString:@"hi"]) {
                    cell.textView.text = [userDefaultWeliike valueForKey:@"PersonNameProperty"];
					cell.textView.returnKeyType = UIReturnKeyNext;
                }
                [cell.textView setKeyboardType:UIKeyboardTypeDefault];
                [cell.textView becomeFirstResponder];
                break;
            case 1:
                cell.textLable.text=@"Email";
				[cell.textView setAutocapitalizationType:UITextAutocorrectionTypeDefault];
                [cell.textView setKeyboardType:UIKeyboardTypeEmailAddress];
                if ([oldornewcontact isEqualToString:@"hi"]) {
					NSString *emailStr = [NSString stringWithFormat:@"%@",[userDefaultWeliike valueForKey:@"EmailIdproperty"]];
					if ([emailStr length] == 0 || [emailStr isEqualToString:@" "] ||[emailStr isEqualToString:@"(null)"]) {
						cell.textView.text = @"";
					}else {
						cell.textView.text = emailStr;
					}
                }
                break;
            default:
                break;
        }
	}	
	return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	
	if (cellFlag == 0) {
		[userDefaultWeliike setValue:textField.text forKey:@"EmailIdproperty"];
	}else {
		[userDefaultWeliike setValue:textField.text forKey:@"PersonNameProperty"];
	}
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
	if (cellFlag == 1) {
		cellFlag = 0;
	}else {
		cellFlag = 1;
	}
}  

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	cellFlag = indexPath.row;
}

-(BOOL) validEmail:(NSString*) emailString {
   // NSLog(@"emailString:-%@", emailString);
    emailString = [emailString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   // NSLog(@"emailString:-%@", emailString);
  
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:emailString];
    
    
}

@end
