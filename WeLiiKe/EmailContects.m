//
//  EmailContects.m
//  HFH
//
//  Created by mini on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EmailContects.h"
#import "AddNewEmailAdress.h"
//#import "ProfileScreen.h"
// import delegate class
#import "AppDelegate.h"

BOOL checked;
BOOL iscomeFromAddNewEmail;
NSString *check;
BOOL imagechangeFlag = NO;
int count = 0;
AppDelegate *appDelegate;

@implementation EmailContects
@synthesize tableEmailContect,btnEdit,btnback;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:NO];
    
      
    tableEmailContect.delegate=self;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)backToshareScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5)  {
        
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        //self.navigationController.navigationBar.layer.contents=(id)[UIImage imageNamed:@"apps_header_without_text.png"].CGImage;
        
    }else{
        
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"apps_header_without_text.png"] forBarMetrics:UIBarMetricsDefault];
    }

    
    
	if ([appDelegate.arrayOfEmailContact count]==0 )
    {
        if(self.navigationItem.rightBarButtonItem==nil)
        {
            UIBarButtonItem *editButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(EditTable:)];
            self.navigationItem.rightBarButtonItem=editButton;
        }
        btnEdit.userInteractionEnabled=NO;
        [btnEdit setTitle:@"Done" forState:UIControlStateNormal];
		[btnEdit setBackgroundImage:[UIImage imageNamed:@"btn_bg_follow.png"] forState:UIControlStateNormal];
        [btnEdit.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    
    }else
    {
        if(self.navigationItem.rightBarButtonItem==nil)
        {
            UIBarButtonItem *editButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(EditTable:)];
            self.navigationItem.rightBarButtonItem=editButton;
        }

        btnEdit.userInteractionEnabled = YES;
        [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
		[btnEdit setBackgroundImage:[UIImage imageNamed:@"btn_bg_follow.png"] forState:UIControlStateNormal];
        [btnEdit.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    
    }
	if ([appDelegate.arrayOfEmailContact count] != 0 && iscomeFromAddNewEmail) {
		//tableEmailContect.delegate=self;
		[tableEmailContect reloadData];
		iscomeFromAddNewEmail=NO;
	}
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem=nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    //#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //if (section==0) {
	if ([appDelegate.arrayOfEmailContact count] == 0) {
        
        return 1;
        
    }else {
		
		return [appDelegate.arrayOfEmailContact count]+1;
	}
    // return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;//@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];//CellIdentifier];
	if ([appDelegate.arrayOfEmailContact count] != 0 && indexPath.row<=[appDelegate.arrayOfEmailContact count]) 
	{
		if (indexPath.row == [appDelegate.arrayOfEmailContact count]) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			cell.textLabel.text=@"Add Email";
			[cell.textLabel setBackgroundColor:[UIColor lightGrayColor]];
			//cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
			cell.selectionStyle=UITableViewCellSelectionStyleNone;
			
		}else {
			
			NSUInteger count = [appDelegate.arrayOfEmailContact count]; // here listData is your data source
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.selectionStyle=UITableViewCellSelectionStyleNone;
			NSMutableString *cellText = [NSMutableString stringWithFormat:@"%@",[[appDelegate.arrayOfEmailContact objectAtIndex:(count-1-indexPath.row)] valueForKey:@"NAME"]];
			[cellText appendFormat:@"					"];
			[cellText appendString:[[appDelegate.arrayOfEmailContact objectAtIndex:(count-1-indexPath.row)] valueForKey:@"EMAIL"]];
			
			cell.textLabel.text = cellText;
			[cell.textLabel setBackgroundColor:[UIColor lightGrayColor]];
			
			UIButton *imagecheck = [[UIButton alloc]initWithFrame:CGRectMake(270,13, 20, 20)];
			
			
			if (indexPath.row<[appDelegate.arrayOfEmailContact count]) {
				checked = [[[appDelegate.arrayOfEmailContact objectAtIndex:(count-1-indexPath.row)] objectForKey:@"CHACKED"] boolValue];
			}
			if (checked) {
				UIImage *image = [UIImage imageNamed:@"image_checkCircle_image.png"];
				[imagecheck setBackgroundImage:image forState:UIControlStateNormal];
			}else if(checked==0) {
				UIImage *image = [UIImage imageNamed:@"image_checkCircleBlank25x25.png"];
				[imagecheck setBackgroundImage:image forState:UIControlStateNormal];
			}
			
			[imagecheck addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
			[cell addSubview:imagecheck];
			
			
			//cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
			cell.selectionStyle=UITableViewCellSelectionStyleNone;
		}
		return cell;
		
	}else {
		
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
		
		if (indexPath.section==0) {
			
			switch (indexPath.row) {
				case 0:
					
					cell.textLabel.text=@"Add Email";
					[cell.textLabel setBackgroundColor:[UIColor lightGrayColor]];
					cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
					cell.selectionStyle=UITableViewCellSelectionStyleNone;
					break;
			}
		}
		return cell;
	}  
    // Configure the cell...
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */






#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[appDelegate.arrayOfEmailContact count] ||([appDelegate.arrayOfEmailContact count]==0 && indexPath.row==0)) {
		
		UIActionSheet *actionSheet = [[UIActionSheet alloc]
									  initWithTitle:nil
									  delegate:self
									  cancelButtonTitle:@"Cancel"
									  destructiveButtonTitle:nil
									  otherButtonTitles:@"From my contact list",@"Enter new address",nil];
		[actionSheet showInView:self.view];
	}else {
		imagechangeFlag = YES;
	}    
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    if (section==0) {
        
        NSString *str=[[NSString alloc]initWithFormat:@"Tap to select who will receive an email with the photo."];
        
		return str;
    }
    
    return 0;
}

-(void)showPeoplePickerController
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
							   [NSNumber numberWithInt:kABPersonEmailProperty],
							   [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	
	picker.displayedProperties = displayedItems;
	// Show the picker 
	[self presentModalViewController:picker animated:YES];
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissModalViewControllerAnimated:YES];
	
}

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
	
	
	return NO;
}


//#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller. 
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


//#pragma mark ABUnknownPersonViewControllerDelegate methods
// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact. 
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	
    
	return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
	
	personnameProperty = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	check=@"hi";
	NSUserDefaults *userDefaultFoodie = [[NSUserDefaults alloc]init];
	[userDefaultFoodie setValue:personnameProperty forKey:@"PersonNameProperty"];
	
	ABMultiValueRef emailProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
	CFIndex emailCount = ABMultiValueGetCount(emailProperty);
	
	if (emailCount <= 0) {
		[self dismissModalViewControllerAnimated:YES];
	}else {
		if (emailCount == 1) {
			CFStringRef emailRef = ABMultiValueCopyValueAtIndex(emailProperty, 0);
			Emailproperty = [NSString stringWithFormat:@"%@",emailRef];
			CFRelease(emailRef);
			
			[userDefaultFoodie setValue:Emailproperty forKey:@"EmailIdproperty"];
			[userDefaultFoodie setValue:check forKey:@"fromcontectlist"];
			[self dismissModalViewControllerAnimated:YES];
			
			AddNewEmailAdress *newmail=[[AddNewEmailAdress alloc] init];
			[self.navigationController pushViewController:newmail animated:YES];
			
		}else {// the selected contact has many email addresses, continue to the alternate method
			
			CFStringRef emailRef = ABMultiValueCopyValueAtIndex(emailProperty, identifier);
			Emailproperty = [NSString stringWithFormat:@"%@",emailRef];
			CFRelease(emailRef);
			
			[userDefaultFoodie setValue:Emailproperty forKey:@"EmailIdproperty"];
			[userDefaultFoodie setValue:check forKey:@"fromcontectlist"];
			[self dismissModalViewControllerAnimated:YES];
			
			AddNewEmailAdress *newmail=[[AddNewEmailAdress alloc] init];
			[self.navigationController pushViewController:newmail animated:YES];
			
		}
		
	}
	
	CFRelease(emailProperty);
	//personnameProperty=[[NSString alloc]initWithFormat:@"%@",   ABMultiValueCopyArrayOfAllValues(personname)];
	return NO;
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *str=[actionSheet  buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"Enter new address"]) {
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"PersonNameProperty"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"EmailIdproperty"];
        
        AddNewEmailAdress *newAddress=[[AddNewEmailAdress alloc]init];
        [self.navigationController pushViewController:newAddress animated:YES];
        
    }
    
    if ([str isEqualToString:@"From my contact list"]) {
        
        [self showPeoplePickerController];
        
    }
}

- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableEmailContect];
	NSIndexPath *indexPath = [self.tableEmailContect indexPathForRowAtPoint: currentTouchPosition];
	
	if (indexPath != nil)
	{
		NSMutableArray *emailContacts = [[NSMutableArray alloc] init];
		for (int i = [appDelegate.arrayOfEmailContact count]; i > 0; i--) {
			[emailContacts addObject:[appDelegate.arrayOfEmailContact objectAtIndex:i-1]];
			[appDelegate.arrayOfEmailContact removeObjectAtIndex:i-1];
		}
		
		NSMutableDictionary *item = [emailContacts objectAtIndex:indexPath.row];
		
		BOOL checked = [[item objectForKey:@"CHACKED"] boolValue];
		
		if (checked) {
			[[emailContacts objectAtIndex:indexPath.row] setObject:[NSNumber numberWithBool:!checked] forKey:@"CHACKED"];
			UIImage *newImage = [UIImage imageNamed:@"image_checkCircleBlank25x25.png"];
			[sender setBackgroundImage:newImage forState:UIControlStateNormal];
		}else {
			checked = YES;
			[[emailContacts objectAtIndex:indexPath.row] setObject:[NSNumber numberWithBool:checked] forKey:@"CHACKED"];
			[item setObject:[NSNumber numberWithBool:checked] forKey:@"CHACKED"];
			
			UIImage *newImage = [UIImage imageNamed:@"image_checkCircle_image.png"];
			[sender setBackgroundImage:newImage forState:UIControlStateNormal];
		}
		
		for (int i = [emailContacts count]; i > 0; i--) {
			[appDelegate.arrayOfEmailContact addObject:[emailContacts objectAtIndex:i-1]];
		}
	}
}

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (tableEmailContect.editing && indexPath.row<[appDelegate.arrayOfEmailContact count] && [appDelegate.arrayOfEmailContact count]!=0 ) {
		return UITableViewCellEditingStyleDelete;
	}else {
		return UITableViewCellEditingStyleNone;
	}
}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[appDelegate.arrayOfEmailContact removeObjectAtIndex:([appDelegate.arrayOfEmailContact count]-1)-(indexPath.row)];
		[tableEmailContect reloadData];
//        if ([appDelegate.arrayOfEmailContact count]==0 )
//        {
//            btnEdit.userInteractionEnabled=NO;
//            [btnEdit setTitle:@"Done" forState:UIControlStateNormal];
//            [btnEdit setBackgroundImage:[UIImage imageNamed:@"btn_bg_follow.png"] forState:UIControlStateNormal];
//            [btnEdit.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
//            
//        }
	} else if (editingStyle == UITableViewCellEditingStyleInsert)
	{
	}
}

- (IBAction) EditTable:(UIButton *)sender
{
	
	if(self.editing)
	{
		[super setEditing:NO animated:NO];
		[tableEmailContect setEditing:NO animated:NO];
		[tableEmailContect reloadData];
	}
	else
	{
		[super setEditing:YES animated:YES];
		[tableEmailContect setEditing:YES animated:YES];
		[tableEmailContect reloadData];
	}
	
}


@end
