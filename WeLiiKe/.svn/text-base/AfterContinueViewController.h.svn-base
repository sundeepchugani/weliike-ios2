//
//  AfterContinueViewController.h
//  WeLiiKe
//
//  Created by techvalens on 12/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudView.h"
#import <Accounts/Accounts.h>
//#import <FacebookSDK/FacebookSDK.h>
#import "FBConnect.h"
#import <Twitter/Twitter.h>
#import <Accounts/ACAccountType.h>
#import <Accounts/ACAccountStore.h>
#import "AppDelegate.h"

@interface AfterContinueViewController : UIViewController<FBRequestDelegate,FBDialogDelegate,FBSessionDelegate>{

    UIButton *signUpBtn;
    HudView *aHUD;
    ACAccountStore *accountStore;
    NSArray *permissions;
}

//@property (nonatomic, retain) NSArray *permissions;
@property(nonatomic,retain)IBOutlet UIButton *signUpBtn;
@property (nonatomic,nonatomic)ACAccountStore *accountStore;
@property (strong, nonatomic) NSArray *accounts;

-(IBAction)actionOnCreateAccount:(id)sender;
-(IBAction)actionOnLoginWithFB:(id)sender;
-(IBAction)actionOnLoginWithTwitter:(id)sender;
-(IBAction)actionOnLoginWithEmail:(id)sender;
-(NSString *)Base64Encode:(NSData *)theData;
-(void)getTwitterFriendsDetail:(NSString*)ids;
- (void)apiFQLIMe;
@end
