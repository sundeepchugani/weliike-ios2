//
//  addEnityViewController.m
//  WeLiiKe
//
//  Created by techvalens on 01/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "addEnityViewController.h"

@implementation addEnityViewController
@synthesize txtFieldForName,imgView,strForMasterCate;

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
}

-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)actionOnDone:(id)sender{
    
    if (imgView.image==nil) {
        UIAlertView *arlt=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please set image for entity" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [arlt show];
    }else if ([txtFieldForName.text length]==0) {
        UIAlertView *arlt=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please set image for entity" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [arlt show];
    }else{
        [self showHUD];
        [self performSelector:@selector(callWebServiceForAddEntity) withObject:nil afterDelay:0.2];
    }
    
}

-(void)callWebServiceForAddEntity{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(suggested_entityHandler:)];;
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strBase=[self Base64Encode:UIImageJPEGRepresentation(imgView.image, 0.7)];
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *strForlate=[NSString stringWithFormat:@"%f",delegate.currentLatitude];
    NSString *strForlong=[NSString stringWithFormat:@"%f",delegate.currentLongitute];
    
    [service suggested_entity:strID master_category_id:strForMasterCate entity_name:txtFieldForName.text address:delegate.strForAddressDelegate lat:strForlate longitude:strForlong sub_category:@"" entity_image:strBase comment:@"" rating_count:@"" information:@"" city:@""];
    //[self performSelector:@selector(killHUD) withObject:nil afterDelay:0.0];
    
}
-(void)suggested_entityHandler:(id)sender{
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
        NSLog(@"value of str %@",strForResponce);
        if (error==nil) {
            
            [self killHUD];
            if ([strForResponce count]>0) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
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


-(IBAction)actionOnImage:(id)sender{

    UIActionSheet *aSheet=[[UIActionSheet alloc] initWithTitle:@"How would you like to set  picture?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture",@"Choose Picture",nil ];
    [aSheet showInView:[UIApplication sharedApplication].keyWindow];
    
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
    
    imgView.image=[[info objectForKey:UIImagePickerControllerEditedImage] copy];
    [picker dismissModalViewControllerAnimated:NO];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //if (textField==txtFieldCity){
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
    //if (textField==txtFieldCity){
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
