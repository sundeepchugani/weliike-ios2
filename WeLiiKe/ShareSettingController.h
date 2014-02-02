//
//  ShareSettingController.h
//  WeLiiKe
//
//  Created by techvalens on 12/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HudView.h"

@interface ShareSettingController : UIViewController<FBRequestDelegate,FBDialogDelegate>
{
    UILabel *lblForEmail,*lblForFacebook,*lblForTwitter;
    HudView *aHUD;
}
@property(nonatomic,retain)IBOutlet UILabel *lblForEmail,*lblForFacebook,*lblForTwitter;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnFacebook:(id)sender;
-(IBAction)actionOnTwitter:(id)sender;
-(IBAction)actionOnEmail:(id)sender;

@end
