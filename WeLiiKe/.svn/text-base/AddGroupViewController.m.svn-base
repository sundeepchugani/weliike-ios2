//
//  AddGroupViewController.m
//  WeLiiKe
//
//  Created by techvalens on 13/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddGroupViewController.h"
#import "WeLiikeWebService.h"
#import "OtherUserProfile.h"

@implementation AddGroupViewController
@synthesize tableForGroupSetting,btnForGroupImage,txtForGroupName,swActive,strForCheckEdit,dicForGroupInfo,strForUserID;

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



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    swActive = [[UISwitch alloc] init];
    [swActive addTarget:self 
                 action:@selector(switchValueChange:) 
       forControlEvents:UIControlEventValueChanged];
    [swActive setOn:YES];
    
    [self performSelector:@selector(callservice) withObject:nil afterDelay:0.2];
    // Do any additional setup after loading the view from its nib.
}
-(void)callservice{

    if ([strForCheckEdit isEqualToString:@"edit"]) {
        NSString *strProfile=[NSString stringWithFormat:@"%@",[dicForGroupInfo valueForKey:@"group_image_url"]];
        [btnForGroupImage loadImage:strProfile];
        txtForGroupName.text=[dicForGroupInfo valueForKey:@"group_name"];
        [self showHUD];
        [self performSelector:@selector(callWebServiceForGetGroup) withObject:nil afterDelay:0.2];
        
        
    }else{
        [self showHUD];
        page=0;
        [self performSelector:@selector(callWebServiceForGroup) withObject:nil afterDelay:0.2];
        //});
        
        //[NSThread detachNewThreadSelector:@selector(callWebServiceForGroup) toTarget:self withObject:nil];
    }
    
}

-(void)switchValueChange:(id)sender{
   
    if (swActive.on) {
        //swActive.on=NO;
    }else{
       // swActive.on=YES;
    }

}
-(void)callWebServiceForGetGroup{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GroupDetailHandler:)];
    if (page>0) {
        page=page+1;
    }else{
        page=1;
    }
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if ([strForUserID length]>0) {
        if (![strForUserID isEqualToString:strID]) {
            strID=strForUserID;
            btnForGroupImage.userInteractionEnabled=NO;
            txtForGroupName.userInteractionEnabled=NO;
        }
    }
    [service GroupDetail:[dicForGroupInfo valueForKey:@"_id"] user_id:strID page:[NSString stringWithFormat:@"%d",page]];
        
}

-(void)GroupDetailHandler:(id)sender{
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
            
            NSLog(@"value of string %@",strForResponce);
            [self killHUD];
            if ([strForResponce count]>0) {
                NSDictionary *dic=(NSDictionary *)strForResponce;
                
                NSArray *array=[dic valueForKey:@"group_mambers"];
                
                arrayForServerData=[[NSMutableArray alloc] initWithArray:array copyItems:YES];
                //        for (int i=0; i<[array count]; i++) {
                //            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)[array objectAtIndex:i]];
                //            [dic setValue:@"YES" forKey:@"status"];
                //            [arrayForServerData addObject:dic];
                //        }
                
                //arrayForServerData=[[NSMutableArray alloc] initWithArray:array copyItems:YES];
                [tableForGroupSetting reloadData];
                
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


-(void)callWebServiceForGroup{
    //[self showHUD];
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GroupFriendHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if (page>0) {
        page=page+1;
    }else{
        page=1;
    }
    [service GroupFriend:strID page:[NSString stringWithFormat:@"%d",page]];
        
}

-(void)GroupFriendHandler:(id)sender{
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
            //NSLog(@"value of string %@",strForResponce);
            if ([strForResponce count]>0 && [strForResponce isKindOfClass:[NSArray class]]) {
                
                if ([arrayForServerData count]==0) {
                    arrayForServerData=[[NSMutableArray alloc] init];
                }
                
                for (int i=0; i<[strForResponce count]; i++) {
                    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)[strForResponce objectAtIndex:i]];
                    [dic setValue:@"NO" forKey:@"status"];
                    [arrayForServerData addObject:dic];
                }
                NSLog(@"array for %@",arrayForServerData);
                [tableForGroupSetting reloadData];
                
                //arrayForServerData=[[NSMutableArray alloc] initWithArray:strForResponce copyItems:YES];
                //[tableViewForCategoty reloadData];
            }else if ([strForResponce isKindOfClass:[NSDictionary class]]){
                
                NSDictionary *dic=(NSDictionary*)strForResponce;
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Error"
                                           message: [dic valueForKey:@"message"]
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                
                
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


-(IBAction)actionOnBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if (![strForUserID isEqualToString:strID]) {
        return 1;
    }
	return 4;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        if (![strForUserID isEqualToString:strID]) {
            return [arrayForServerData count];
        }
        return [arrayForServerData count]+1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 1;
    }else if (section==3){
        return 1;
    }
	return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    if (indexPath.section==0) {
        if (indexPath.row<[arrayForServerData count]) {
            FollowAndFollowingCell *cell1= (FollowAndFollowingCell*)[tableView dequeueReusableCellWithIdentifier:nil];
            
            if (cell1 == nil) {
                cell1 = [[FollowAndFollowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            }
            cell1.selectionStyle=UITableViewCellSelectionStyleNone;
            
            NSString *strProfile=[NSString stringWithFormat:@"%@",[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
            cell1.imgProfile.tag=indexPath.row;
            [cell1.imgProfile loadImage:strProfile];
            [cell1.imgProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
            [cell1.lblName setText:[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"user_name"]];//user_name
            [cell1.lblForCountEntity setTextColor:[UIColor whiteColor]];
            //[cell.lblForCountEntity setBackgroundColor:[UIColor lightGrayColor]];
            [cell1.lblForCountEntity setText:[[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"entity_count"] stringValue]];
            //NSLog(@"value of %@",[[[[arrayForSearchResult objectAtIndex:indexPath.row] valueForKey:@"status"] class] description]);
            cell1.lblForCountEntity.hidden=YES;
            cell1.imgForAddSing.hidden=NO;
            if ([[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"YES"]) {
                //cell.imgBg.hidden=NO;
                [cell1.imgForAddSing setImage:[UIImage imageNamed:@"plus_active.png"] forState:UIControlStateNormal];
            }else{
                [cell1.imgForAddSing setImage:[UIImage imageNamed:@"plus_inactive.png"] forState:UIControlStateNormal];
            }
            return cell1;
        }else{
            cell.textLabel.text=@"Add More";
            [cell.textLabel setTextAlignment:UITextAlignmentCenter];
        }
    }else if (indexPath.section==1){
        [swActive setFrame:CGRectMake(225, 7, 30, 20)];
        [cell addSubview:swActive];
       cell.textLabel.text=@"Notifications";
    }else if (indexPath.section==2){
       cell.textLabel.text=@"Leave Conversation";
       [cell.textLabel setTextAlignment:UITextAlignmentCenter];
    }else if (indexPath.section==3){
        cell.textLabel.text=@"Save";
        [cell.textLabel setTextAlignment:UITextAlignmentCenter];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
	return cell;
}


-(void)actionOnUserProfile:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<[arrayForServerData count]) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=[[arrayForServerData objectAtIndex:btn.tag] valueForKey:@"user_id"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //FollowAndFollowingCell *cell=(FollowAndFollowingCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        
        NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        if ([strForUserID length]>0) {
            if (![strForUserID isEqualToString:strID]) {
                return;
            }
        }
        
        if (indexPath.row<[arrayForServerData count]) {
        
            if ([[[arrayForServerData objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"NO"]) {
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[arrayForServerData objectAtIndex:indexPath.row]];
                [dic setValue:@"YES" forKey:@"status"];
                [arrayForServerData replaceObjectAtIndex:indexPath.row withObject:dic];
                [tableForGroupSetting reloadData];
            }else{
            }
        
        }else{
            [self showHUD];
            [self performSelector:@selector(callWebServiceForGroup) withObject:nil afterDelay:0.2];
        
        }
       
    }
    
    if (indexPath.section==1) {
        
    }else if (indexPath.section==2){
    
    }else if (indexPath.section==3){
        [self showHUD];
        if ([strForCheckEdit isEqualToString:@"edit"]) {
            [self performSelector:@selector(callSaveWebServiceUpdate) withObject:nil afterDelay:0.2];
        }else{
             [self performSelector:@selector(callSaveWebService) withObject:nil afterDelay:0.2];
        }
    }
}

-(void)callSaveWebService{
    if ([txtForGroupName.text length]>0) {
    
        NSMutableArray *arrayForCate=[[NSMutableArray alloc] init];
        for (int i=0 ;i<[arrayForServerData count]; i++) {
            //if ([key intValue]<[arrayForServerData count]) {
            if ([[[arrayForServerData objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"YES"]) {
                [arrayForCate addObject:[[arrayForServerData objectAtIndex:i] valueForKey:@"user_id"]];
            }
            
            //}
        }
        NSString *str=[arrayForCate componentsJoinedByString:@","];
        UIImage *imageBtn=[btnForGroupImage currentBackgroundImage];
        UIImage *img=[imageBtn thumbnailImage:200 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
        NSData *imageData=UIImageJPEGRepresentation(img, 0.7);
        NSString *strBase=[self Base64Encode:imageData];
        
        WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(GroupCreateHandler:)];
        NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        [service GroupCreate:txtForGroupName.text group_owner:strID member_user_id:str notification:@"1" groupImage:strBase];
                
    }else{
        [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please enter group name."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];

    }       
}

-(void)GroupCreateHandler:(id)sender{
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
            NSLog(@"value of string %@",strForResponce);
            [self killHUD];
            if ([strForResponce count]>0) {
                [self.navigationController popViewControllerAnimated:YES];
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

-(void)callSaveWebServiceUpdate{
    if ([txtForGroupName.text length]>0) {
        
        NSMutableArray *arrayForCate=[[NSMutableArray alloc] init];
        for (int i=0 ;i<[arrayForServerData count]; i++) {
            //if ([key intValue]<[arrayForServerData count]) {
            if ([[[arrayForServerData objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"YES"]) {
                if ([[arrayForServerData objectAtIndex:i] valueForKey:@"member_id"] !=nil) {
                    [arrayForCate addObject:[[arrayForServerData objectAtIndex:i] valueForKey:@"member_id"]];
                }else if ([[arrayForServerData objectAtIndex:i] valueForKey:@"user_id"] !=nil){
                    [arrayForCate addObject:[[arrayForServerData objectAtIndex:i] valueForKey:@"user_id"]];
                }
                
            }
            //}
        }
        NSString *str=[arrayForCate componentsJoinedByString:@","];
        UIImage *imageBtn=[btnForGroupImage currentBackgroundImage];
        UIImage *img=[imageBtn thumbnailImage:200 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
        NSData *imageData=UIImageJPEGRepresentation(img, 0.7);
        NSString *strBase=[self Base64Encode:imageData];
        
        WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(EditGroupHandler:)];
        NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        //NSArray *strForResponce=[service GroupCreate:txtForGroupName.text group_owner:strID member_user_id:str notification:@"1" groupImage:strBase];
        NSString *strForNotification=@"";
        if (swActive.on) {
            strForNotification=@"1";
        }else{
            strForNotification=@"0";
        }
        [service EditGroup:[dicForGroupInfo valueForKey:@"_id"] group_name:txtForGroupName.text member_id:str notification:strForNotification group_owner_id:strID groupImage:strBase];
                
    }else{
        [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Message"
                                   message: @"Please enter group name."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        
    }       
}


-(void)EditGroupHandler:(id)sender{
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
            NSLog(@"value of string %@",strForResponce);
            if ([strForResponce count]>0) {
                [self.navigationController popViewControllerAnimated:YES];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 50;
    }   
    return 40;
}

-(IBAction)actionOnGroupImage:(id)sender{
    UIActionSheet *aSheet=[[UIActionSheet alloc] initWithTitle:@"How would you like to set your group picture?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture",@"Choose Picture",nil ];
    [aSheet showInView:[UIApplication sharedApplication].keyWindow];
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
        picker.allowsEditing=YES;
        
        [self presentModalViewController:picker animated:YES];
        //[picker release];
    }
}

#pragma mark - UIImagePickerController delegate methods
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imgForProfilePic=[[info objectForKey:UIImagePickerControllerEditedImage] copy];
    
        [btnForGroupImage setBackgroundImage:imgForProfilePic forState:UIControlStateNormal];
       [picker dismissModalViewControllerAnimated:NO];
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
