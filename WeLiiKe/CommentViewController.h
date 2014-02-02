//
//  CommentViewController.h
//  WeLiiKe
//
//  Created by techvalens on 28/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomStarRank.h"
#import "HudView.h"
#import "WeLiikeWebService.h"
#import "Facebook.h"

@interface CommentViewController : UIViewController<UITextViewDelegate,FBRequestDelegate,FBDialogDelegate>{

    UITextView *txtViewForComment;
    NSString *strForClass;
    CustomStarRank *customRank;
    //NSString *strForID;
    //NSString *strForUserID;
    NSString *strForEntity;
    HudView *aHUD;
    UIButton *btnForFb;
    NSDictionary *dicForDetail;
    BOOL FBSharing,TwitterSharing;
     BOOL checkKeyBoard;
}
@property(nonatomic,retain)NSDictionary *dicForDetail;
@property(nonatomic,retain)IBOutlet UIButton *btnForFb;
@property(nonatomic,retain)NSString *strForEntity;
@property(nonatomic,retain)NSString *strForClass;
@property(nonatomic,retain)IBOutlet UITextView *txtViewForComment;
-(IBAction)actionOnback:(id)sender;
-(IBAction)actionOnDone:(id)sender;
-(IBAction)actionOnFacebook:(id)sender;
-(IBAction)actionOnTwitter:(id)sender;
@end
