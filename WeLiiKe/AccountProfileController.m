//
//  AccountProfileController.m
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AccountProfileController.h"
#import "WeliikeCropViewController.h"

@implementation AccountProfileController
@synthesize lblForGender,lblForBirthday,scrollViewForAccountDetail;
@synthesize datePicker,toolBarForPicker;
@synthesize txtForName,txtForWebSite,txtForBio,txtForEmail,txtForPhone;
@synthesize switchForSave,switchForPrivate,switchForSaveGeo;

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
    
    [self performSelector:@selector(callArrangeTop)];
    
    
    datePicker.hidden=YES;
    toolBarForPicker.hidden=YES;
    [datePicker setFrame:CGRectMake(0, 317, 320, 25)];
    [toolBarForPicker setFrame:CGRectMake(0,307, 320, 40)];
    [self.view addSubview:toolBarForPicker];
    
    arrayForGender = [[NSArray alloc]initWithObjects:@"Male",@"Female", nil];
    pickerForGender = [[UIPickerView alloc] 
                  initWithFrame:CGRectMake(0, 317, 320, 25)];
	pickerForGender.delegate = self;
	pickerForGender.dataSource = nil;
	pickerForGender.backgroundColor=[UIColor blueColor];
	pickerForGender.showsSelectionIndicator=YES;
	[pickerForGender selectRow:0 inComponent:0 animated:YES]; 
    //App crashing here
    [pickerForGender reloadAllComponents];
	pickerForGender.hidden=YES;
    
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
	[pickerDateToolbar sizeToFit];
	pickerDateToolbar.tintColor= [UIColor blackColor];
	NSMutableArray *barItems = [[NSMutableArray alloc] init];
	
	UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
	[barItems addObject:flexSpace];
	//Memory leak handling
	
	UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonClicked:)];
	[barItems addObject:doneBtn];
	[pickerDateToolbar setItems:barItems animated:YES];
	//Memory leak handling
	//	[bgImage1 release];
	[pickerForGender addSubview:pickerDateToolbar];
    UIWindow *win=[[UIApplication sharedApplication] keyWindow];
	[win addSubview:pickerForGender];
    [win addSubview:datePicker];
    
    [scrollViewForAccountDetail setFrame:CGRectMake(0, 220, 320, 270)];
    [scrollViewForAccountDetail setContentSize:CGSizeMake(320, 500)];
    
    
   
    //lblForGender.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"Usergender"];
    //lblForBirthday.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"Userbirthday"];
        // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Usergender"] isKindOfClass:[NSString class]]) {
        [lblForGender setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"Usergender"] forState:UIControlStateNormal];
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Userbirthday"] isKindOfClass:[NSString class]]) {
        
        
        [lblForBirthday setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"Userbirthday"] forState:UIControlStateNormal];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserEmail"] isKindOfClass:[NSString class]]) {
        txtForEmail.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserEmail"];
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Userfirst_name"] isKindOfClass:[NSString class]]) {
        txtForName.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"Userfirst_name"];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Userwebsite"] isKindOfClass:[NSString class]]) {
        txtForWebSite.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"Userwebsite"];
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Userbio"] isKindOfClass:[NSString class]]) {
        txtForBio.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"Userbio"];
        
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Userphone"] isKindOfClass:[NSString class]]) {
        txtForPhone.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"Userphone"];
    }
    
    
    
    
    
    //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"geotag_post"] forKey:@"Usergeotag_post"];
    //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"privacy"] forKey:@"Userprivacy"];
    //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"save_photo_phone"] forKey:@"Usersave_photo_phone"];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Usergeotag_post"]) {
        switchForSaveGeo.on=YES;
    }else{
        switchForSaveGeo.on=NO;
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Userprivacy"]) {
        switchForPrivate.on=YES;
    }else{
        switchForPrivate.on=NO;
    }
    
//    NSUserDefaults *userdefault=[[NSUserDefaults alloc] init];
//    [userdefault setBool:YES forKey:@"Usersave_photo_phone"];
//    [userdefault synchronize];
//    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithBool:switchForSave.on]  forKey:@
//     "Usersave_photo_phones"];
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Usersave_photo_phone"] ) {
//        switchForSave.on=YES;
//    }else{
//        switchForSave.on=NO;
//    }
    
//    NSUserDefaults *userdefault=[[NSUserDefaults alloc] init];
//    //
//    //
//    //    if ([userdefault boolForKey:@"isSkipWelcomeScreen"])
//    //    {

    
}

-(void)buttonClicked:(id)sender{
    [pickerForGender setHidden:YES];
    
}
-(IBAction)actionOnDonePicker:(id)sender{
    
    NSDate *selected = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strForDate11 = [dateFormatter stringFromDate:selected];
    
    //[dicForData setValue:strForDate11 forKey:@"birthdateMakaMaka"];
    //[self performSelector:@selector(reloadTable) withObject:nil afterDelay:0];
    NSLog(@"value of string %@",strForDate11);
    [lblForBirthday setTitle:strForDate11 forState:UIControlStateNormal];
    datePicker.hidden=YES;
    toolBarForPicker.hidden=YES;
    
    //[self showHUD];
    //[self performSelector:@selector(callWebService) withObject:nil afterDelay:0.0];
}

-(IBAction)actionOnSwitch:(id)sender{
    
    UISwitch *switchBtn=(UISwitch*)sender;
    
    if (switchBtn.tag==0) {
        
    }else if (switchBtn.tag==1) {
        
    }else if (switchBtn.tag==2) {
        
    }
}

-(IBAction)actionOnDate:(id)sender{

    [txtForName resignFirstResponder];
    [txtForBio resignFirstResponder];
    [txtForEmail resignFirstResponder];
    [txtForPhone resignFirstResponder];
    [txtForWebSite resignFirstResponder];

    datePicker.hidden=NO;
    toolBarForPicker.hidden=NO;

    
}
-(IBAction)actionOnGender:(id)sender{
    
    [txtForName resignFirstResponder];
    [txtForBio resignFirstResponder];
    [txtForEmail resignFirstResponder];
    [txtForPhone resignFirstResponder];
    [txtForWebSite resignFirstResponder];
    
    [pickerForGender reloadAllComponents];
	pickerForGender.hidden=NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
	[lblForGender setTitle:[arrayForGender objectAtIndex:row] forState:UIControlStateNormal];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)componen{
    
	
	return 2;//[status count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
	NSString *returnStr = @"";
   returnStr = [arrayForGender objectAtIndex:row];
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
	CGFloat componentWidth = 0.0;
	
    componentWidth = 250.0;	// second column is narrower to show numbers
	
	return componentWidth;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //if (textField==txtForWebsite1 || textField==txtForWebsite2){
        CGPoint currentCenter = [self.view center];
        CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y - 150);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [self.view setCenter:newCenter];
        [UIView commitAnimations];
        return YES;
    //}
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //if (textField==txtForWebsite1 || textField==txtForWebsite2){
        CGPoint currentCenter = [self.view center];
        CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y + 150);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [self.view setCenter:newCenter];
        [UIView commitAnimations];
        return YES;
    //}
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(IBAction)actionOnBack:(id)sender{
    [toolBarForPicker setHidden:YES];
    [datePicker setHidden:YES];
    [pickerForGender setHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [toolBarForPicker setHidden:YES];
    [datePicker setHidden:YES];
    [pickerForGender setHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [toolBarForPicker setHidden:YES];
    [datePicker setHidden:YES];
    [pickerForGender setHidden:YES];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)actionOnSubmit:(id)sender{
    
//    if ([[lblForGender currentTitle] length]==0 || [lblForGender currentTitle] == nil ) {
//        UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please select Gender." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [alertview show];
//        return;
//    }else if ([[lblForBirthday currentTitle] length]==0 || [lblForBirthday currentTitle] == nil ) {
//        UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter your DOB." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [alertview show];
//        return;
//    }
    [self showHUD];
    [self performSelector:@selector(callService) withObject:nil afterDelay:0.2];
    //[self performSelector:@selector(alertSuccess) withObject:nil afterDelay:2.0];

}

-(void)callService{
    
  
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(updateProfileHandler:)];
    NSString *strForSave=@"";
    
    if (switchForSave.on) {
        strForSave=@"1";
    }else{
        strForSave=@"0";
    }
    
    NSString *strForGeo=@"";
    if (switchForSaveGeo.on) {
        strForGeo=@"1";
    }else{
        strForGeo=@"0";
    }
    
    NSString *strForPri=@"";
    if (switchForPrivate.on) {
        strForPri=@"1";
    }else{
        strForPri=@"0";
    }
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    //if ([txtForName.text length]>0 &&[txtForWebSite.text length]  &&[txtForBio.text length] &&[txtForPhone.text length] ) {
        UIImage *img=[profileImage currentImage];
        
        NSData *imageData=UIImageJPEGRepresentation(img, 0.7);
        NSString *strBase=[self Base64Encode:imageData];
        NSData *imageDataCover=UIImageJPEGRepresentation([coverImg currentImage], 0.7);
        NSString *strBaseCover=[self Base64Encode:imageDataCover];
    
    NSString *strForGender;
    if ([lblForGender currentTitle]!=nil) {
        strForGender=[lblForGender currentTitle];
    }else{
        strForGender=@"";
    }
    
    NSString *strForBirthday;
    if ([lblForBirthday currentTitle]!=nil) {
        strForBirthday=[lblForBirthday currentTitle];
    }else{
        strForBirthday=@"";
    }
    
        [service updateProfile:txtForName.text user_id:strID bio:txtForBio.text Email:txtForEmail.text phone:txtForPhone.text gender:strForGender birthday:strForBirthday website:txtForWebSite.text save_photo_phone:strForSave  geotag_post:strForGeo post_are_private:strForPri profile_picture:strBase cover_photo:strBaseCover];
                
   // }

}

-(void)updateProfileHandler:(id)sender{
    [self killHUD];
    [self.navigationController popViewControllerAnimated:YES];
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
                
        if (error!=nil) {
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Error"
                                       message: @"Error from server please try again later."
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
            
            
        }else{
            
            [self killHUD];
            if ([strForResponce count]>0) {
                NSLog(@"value of response %@",strForResponce);
                
                NSDictionary *dic=(NSDictionary*)strForResponce;
                NSLog(@"value of dictionary %@",dic);
                NSString *strFor=[NSString stringWithFormat:@"%@",[dic valueForKey:@"profile_picture_url"]];
                [[NSUserDefaults standardUserDefaults] setValue:strFor forKey:@"Userprofile_picture"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"UserName"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"_id"] forKey:@"UserID"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"bio"] forKey:@"Userbio"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"email"] forKey:@"UserEmail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"birthday"] forKey:@"Userbirthday"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"city"] forKey:@"Usercity"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"gender"] forKey:@"Usergender"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"mobile_no"] forKey:@"Usermobile_no"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"Userfirst_name"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"last_name"] forKey:@"Userlast_name"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"website"] forKey:@"Userwebsite"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"phone"] forKey:@"Userphone"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"geotag_post"] forKey:@"Usergeotag_post"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"privacy"] forKey:@"Userprivacy"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"save_photo_phone"] forKey:@"Usersave_photo_phone"];
                NSString *strFor1=[NSString stringWithFormat:@"%@",[dic valueForKey:@"cover_photo_url"]];
                [[NSUserDefaults standardUserDefaults] setValue:strFor1 forKey:@"UserCover_photo"];
                //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@""] forKey:@"UserName"];
                //[[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@""] forKey:@"UserName"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_follow_my_category_for_mail"] forKey:@"a_friend_follow_my_category_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_follow_my_category_for_pn"] forKey:@"a_friend_follow_my_category_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"] forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"] forKey:@"a_friend_shares_a_place_tip_or_entity_with_me_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"a_new_friend_from_facebook_join_we_like_for_pn"] forKey:@"a_new_friend_from_facebook_join_we_like_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_friend_follow_my_category_for_mail"] forKey:@"any_one_friend_follow_my_category_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_friend_follow_my_category_for_pn"] forKey:@"any_one_friend_follow_my_category_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_like_my_activity_for_mail"] forKey:@"any_one_like_my_activity_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_like_my_activity_for_pn"] forKey:@"any_one_like_my_activity_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_mention_me_in_comment_for_mail"] forKey:@"any_one_mention_me_in_comment_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_mention_me_in_comment_for_pn"] forKey:@"any_one_mention_me_in_comment_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"] forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"] forKey:@"any_one_shares_a_place_tip_or_entity_with_me_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_like_my_activity_for_mail"] forKey:@"friend_like_my_activity_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_like_my_activity_for_pn"] forKey:@"friend_like_my_activity_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_mention_me_in_comment_for_mail"] forKey:@"friend_mention_me_in_comment_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"friend_mention_me_in_comment_for_pn"] forKey:@"friend_mention_me_in_comment_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"] forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"] forKey:@"i_receive_a_friend_request_of_friend_confirmation_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"] forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"] forKey:@"keep_me_up_to_date_with_welike_news_and_update_for_pn"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"] forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"] forKey:@"send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn"];
                
//                UIAlertView *errorAlert = [[UIAlertView alloc]
//                                           initWithTitle: @"Message"
//                                           message: @"User successfully Updated"
//                                           delegate:nil
//                                           cancelButtonTitle:@"OK"
//                                           otherButtonTitles:nil];
//                [errorAlert show];
                
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
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    [textField resignFirstResponder];
    return YES;
    
}
-(void)callArrangeTop{
    
    coverImg=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(80, 44, 250, 140)];
    [coverImg setBackgroundColor:[UIColor grayColor]];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"] hasPrefix:@"http://"]) {
        [coverImg loadImage:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserCover_photo"]];
    }
    [coverImg addTarget:self action:@selector(changeCover:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:coverImg];
    
    UILabel *lblForTitle=[[UILabel alloc] initWithFrame:CGRectMake(80, 154, 240, 30)];
    [lblForTitle setBackgroundColor:[UIColor grayColor]];
    [lblForTitle setText:@" Tap to edit each picture"];
    [lblForTitle setFont:[UIFont boldSystemFontOfSize:15]];
    [lblForTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:lblForTitle];
    
    NSString *strForProfile =[[NSUserDefaults standardUserDefaults] valueForKey:@"Userprofile_picture"];
    profileImage=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 44, 80, 140)];
    [profileImage loadImage:strForProfile];
    [profileImage setBackgroundColor:[UIColor whiteColor]];
    [profileImage addTarget:self action:@selector(changeProfile:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:profileImage];    
    
}
-(void)changeCover:(id)sender{
    checkForPicture=1;
    UIActionSheet *aSheet=[[UIActionSheet alloc] initWithTitle:@"How would you like to set your cover?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture",@"Choose Picture",nil ];
    [aSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)changeProfile:(id)sender{
    checkForPicture=0;
    UIActionSheet *aSheet=[[UIActionSheet alloc] initWithTitle:@"How would you like to set your picture?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture",@"Choose Picture",nil ];
    [aSheet showInView:[UIApplication sharedApplication].keyWindow];
}
-(void)alertSuccess{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle: @"Message"
                               message: @"Update profile successfully."
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [errorAlert show];
}

-(NSString *)Base64Encode:(NSData *)theData{
	const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title=[actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Take Picture"]) {
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
    }
    if ([title isEqualToString:@"Choose Picture"]) {
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
}
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
		UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.sourceType=sourceType;
        picker.editing=YES;
        picker.delegate=self;
        //picker.allowsEditing=YES;
        
        [self presentModalViewController:picker animated:YES];
        //[picker release];
    }
}

#pragma mark - UIImagePickerController delegate methods
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imgFinal=[[info objectForKey:UIImagePickerControllerOriginalImage] copy];
    WeliikeCropViewController *obj=[[WeliikeCropViewController alloc] init];
    obj.imgSet=[imgFinal copy];
    obj.delegate=self;
    
    if (checkForPicture==0) {
        //checkForImage=1;
        obj.sizeForCrop=CGRectMake(60, 55, 200, 350);
      
        //imgViewProfile.image=imgFinal;
    }else{
        //checkForImage=0;
        obj.sizeForCrop=CGRectMake(0, 130, 320, 200);
           
        //imageForCover=imgFinal;
    }
    
    [self.navigationController pushViewController:obj animated:YES];
    //[profileImage setImage:imageProfile forState:UIControlStateNormal];
    //[self performSelector:@selector(callWebService1) withObject:nil afterDelay:1.0];
    //[self showHUD];
    [picker dismissModalViewControllerAnimated:NO];
}
-(void)getCroppedImage:(UIImage *)image{
    if (checkForPicture==0) {
        checkForPicture=1;
        [profileImage setImage:image forState:UIControlStateNormal];
    }else{
        checkForPicture=0;
        [coverImg setImage:image forState:UIControlStateNormal];
        //imageForCover=image;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)switchOnOff:(id)sender {
    if (switchForSave.on==TRUE) {
      
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"swichOnOffStatus"];
          NSLog(@"on = = = =   %d",switchForSave.on);
    }
    else{
      
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"swichOnOffStatus"];
          NSLog(@"Off   = = = =   %d",switchForSave.on);
    }
}
@end
