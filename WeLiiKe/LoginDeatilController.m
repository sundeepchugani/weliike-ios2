//
//  LoginDeatilController.m
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "LoginDeatilController.h"

@implementation LoginDeatilController
@synthesize txtForEmail,txtForPass,txtForNewPass,txtForNewPassAgain;

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
    txtForEmail.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserEmail"];
        
    // Do any additional setup after loading the view from its nib.
    
}

-(void)callService{
    
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(changePasswordHandler:)];

    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    if ([txtForPass.text length]>0 && [txtForNewPass.text isEqualToString:txtForNewPassAgain.text]) {
        [service changePassword:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserEmail"] password:txtForPass.text passwordNew:txtForNewPassAgain.text];
        
        
    }else  if ([txtForPass.text length]==0){
        [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Error"
                                   message: @"Please enter current password."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
    }else if(![txtForNewPass.text isEqualToString:txtForNewPassAgain.text]) {
        [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Error"
                                   message: @"Please enter same new password."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
    }else{
        [self killHUD];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Error"
                                   message: @"Error from server please try again later."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
    }
    
}

-(void)changePasswordHandler:(id)sender{
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
                
                NSString *str=[(NSDictionary*)strForResponce  valueForKey:@"message"];
                NSLog(@"value of str %@",str);
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: str
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


-(IBAction)actionOnSave:(id)sender{
     [self showHUD];
     [self performSelector:@selector(callService) withObject:nil afterDelay:0.2];
}
-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
