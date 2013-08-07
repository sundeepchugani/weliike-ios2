//
//  SignUpViewController.m
//  WeLiiKe
//
//  Created by techvalens on 12/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SignUpViewController.h"
#import "WelcomeViewController.h"
#import "AddFriendViewController.h"
#import "AggregateViewController.h"
#import "WelcomeSearchScreen.h"
#import "WeliikeCropViewController.h"


@implementation SignUpViewController
@synthesize txtViewForName,txtViewForSurname,txtViewForEmail,txtViewForpassword,scrollViewForRegi;
@synthesize imgViewProfile;

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




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkForImage=0;
    [imgViewProfile setContentMode:UIViewContentModeScaleToFill];
    [imgViewProfile setClipsToBounds:YES];
    [scrollViewForRegi setContentSize:CGSizeMake(320, 400)];
    
    UITapGestureRecognizer *tapgesture_on_imgViewProfile = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionOnCamera:)];
    tapgesture_on_imgViewProfile.delegate = self;
    tapgesture_on_imgViewProfile.numberOfTapsRequired=1;
    [imgViewProfile addGestureRecognizer:tapgesture_on_imgViewProfile];
   
    //    txtViewForName.layer.borderWidth=2;
    //    txtViewForName.layer.borderColor=[UIColor grayColor].CGColor;
    //
    //    txtViewForSurname.layer.borderWidth=2;
    //    txtViewForSurname.layer.borderColor=[UIColor grayColor].CGColor;
    //
    //    txtViewForEmail.layer.borderWidth=2;
    //    txtViewForEmail.layer.borderColor=[UIColor grayColor].CGColor;
    //
    //    txtViewForpassword.layer.borderWidth=2;
    //    txtViewForpassword.layer.borderColor=[UIColor grayColor].CGColor;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
-(IBAction)actionOnCookieUse:(id)sender{
    
}
-(IBAction)actionOnSignUp:(id)sender{
    
    //[self performSelector:@selector(moveNextScreen)];
    //return;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([txtViewForName.text length]==0 || [[txtViewForName.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]==0) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please enter your FirstName."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        return;
    }else if (![txtViewForSurname.text length]>0 || ![[txtViewForSurname.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]>0) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please enter your Surname."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        return;
    }else if (![txtViewForEmail.text length]>0 || ![[txtViewForEmail.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]>0) {
        
        
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please enter your Email."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        
        return;
        
        
    }else if (![emailTest evaluateWithObject:txtViewForEmail.text]) {
        
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please enter valid Email."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
    else if (![txtViewForpassword.text length]>0 || ![[txtViewForpassword.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]>0) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please enter your Password."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
   
    [self showHUD];
    [self performSelector:@selector(callService) withObject:nil afterDelay:0.2];
    
    // WelcomeViewController *obj=[[WelcomeViewController alloc] init];
    // [self.navigationController pushViewController:obj animated:YES];
    
}
-(void)callService{
    
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(SaveUserHandler:)];
    //service.delegateService=self;
    //UIImage *img=[UIImage imageNamed:@"Splash2.png"];
    //filObj.imageOrg=[imageFinal thumbnailImage:640 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
    //UIImage *img=[imgViewProfile.image thumbnailImage:200 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
    NSData *imageData=UIImageJPEGRepresentation(imgViewProfile.image, 0.7);
    NSString *strBase=[self Base64Encode:imageData];
    //UIImage *imgeeee=[imageForCover thumbnailImage:200 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
    NSData *imageDataCover=UIImageJPEGRepresentation(imageForCover, 0.7);
    NSString *strBaseCover=[self Base64Encode:imageDataCover];
    //NSString *strForImageData=[self Base64Encode:imageData];
    if (imageData == nil)  {
         [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please Upload Profile Image."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
      
    }
    else if (imageDataCover == nil){
        [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please Upload Cover Photo."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];

    }
    else {
    [service SaveUser:txtViewForName.text lastname:txtViewForSurname.text Email:txtViewForEmail.text Password:txtViewForpassword.text profile:strBase cover:strBaseCover];
    }
}


-(void)SaveUserHandler:(id)sender{
    
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
            //NSLog(@"value of %@",[[strForResponce  class] description]);
            //NSLog(@"value of %@",[(NSDictionary*)strForResponce  valueForKey:@"email"]);
            
            if ([strForResponce count]>0) {
                NSLog(@"value of %d",[strForResponce count]);
                if ([strForResponce count]==1) {
                    NSString *str=[[(NSDictionary*)strForResponce  valueForKey:@"email"] objectAtIndex:0];
                    NSLog(@"value of str %@",str);
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle: @"Error"
                                               message: str
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [errorAlert show];
                }else{
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
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"website"] forKey:@"Userwebsite"];//phone
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"phone"] forKey:@"Userphone"];
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"geotag_post"] forKey:@"Usergeotag_post"];
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"privacy"] forKey:@"Userprivacy"];
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"save_photo_phone"] forKey:@"Usersave_photo_phone"];
                    
                    //geotag_post
                    //privacy = 0;
                    //"save_photo_phone" = 1;
                    
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
                    
                    [self performSelector:@selector(moveNextScreen)];
                    
                    
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



-(void)moveNextScreen{
    
    //WelcomeSearchScreen *obj=[[WelcomeSearchScreen alloc] init];
    //[self.navigationController pushViewController:obj animated:YES];
    
    AddFriendViewController *obj=[[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
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


-(void)failWithError:(NSError *)error{
    
    UIAlertView *errorAlert = [[UIAlertView alloc]
    						   initWithTitle: [error localizedDescription]
    						   message: [error localizedFailureReason]
    						   delegate:nil
    						   cancelButtonTitle:@"OK"
    						   otherButtonTitles:nil];
    [errorAlert show];
    
}

-(IBAction)actionOnCamera:(id)sender{
    if (checkForImage==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upload Images" message:@"Upload Profile and Cover picture" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }else{
        UIActionSheet *aSheet=[[UIActionSheet alloc] initWithTitle:@"How would you like to set your cover?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture",@"Choose Picture",nil ];
        [aSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 1)
    {
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        UIActionSheet *aSheet=[[UIActionSheet alloc] initWithTitle:@"How would you like to set your picture?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture",@"Choose Picture",nil ];
        [aSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
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
//tracker 613 custom camera screen
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
    
    if (checkForImage==0) {
        //checkForImage=1;
        obj.sizeForCrop=CGRectMake(60, 55, 200, 350);
        obj.s = @"Profile Image";
        
        imgViewProfile.image=imgFinal;
    }else{
        //checkForImage=0;
        obj.sizeForCrop=CGRectMake(0, 130, 320, 150);
        obj.s = @"Cover Image";
        imageForCover=imgFinal;
    }
    
    [self.navigationController pushViewController:obj animated:YES];
    //[profileImage setImage:imageProfile forState:UIControlStateNormal];
    //[self performSelector:@selector(callWebService1) withObject:nil afterDelay:1.0];
    //[self showHUD];
    [picker dismissModalViewControllerAnimated:NO];
}
-(void)getCroppedImage:(UIImage *)image{
    if (checkForImage==0) {
        checkForImage=1;
        imgViewProfile.image=image;
    }else{
        checkForImage=0;
        imageForCover=image;
    }
}

#pragma mark- textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //    if (textField==txtViewForName) {
    //        [txtViewForSurname becomeFirstResponder];
    //    }else if (textField==txtViewForSurname) {
    //        [txtViewForEmail becomeFirstResponder];
    //    }else if (textField==txtViewForEmail){
    //        //[txtViewForEmail becomeFirstResponder];
    //        [txtViewForpassword becomeFirstResponder];
    //    }else if (textField==txtViewForpassword){
    [textField resignFirstResponder];
    //}
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==txtViewForpassword || textField==txtViewForEmail){
        //        CGPoint currentCenter = [self.view center];
        //        CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y - 150);
        //        [UIView beginAnimations:nil context:NULL];
        //        [UIView setAnimationDuration:0.5];
        //        [self.view setCenter:newCenter];
        //        [UIView commitAnimations];
        
        [scrollViewForRegi setContentSize:CGSizeMake(320, 550)];
        [scrollViewForRegi setContentOffset:CGPointMake(0, 80) animated:YES];
        return YES;
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==txtViewForpassword ){
        //        CGPoint currentCenter = [self.view center];
        //        CGPoint newCenter = CGPointMake(currentCenter.x, currentCenter.y + 150);
        //        [UIView beginAnimations:nil context:NULL];
        //        [UIView setAnimationDuration:0.5];
        //        [self.view setCenter:newCenter];
        //        [UIView commitAnimations];
        
        [scrollViewForRegi setContentSize:CGSizeMake(320, 400)];
        [scrollViewForRegi setContentOffset:CGPointMake(0, 0) animated:YES];
        return YES;
    }
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
