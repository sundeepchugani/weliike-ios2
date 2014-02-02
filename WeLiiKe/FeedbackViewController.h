//
//  FeedbackViewController.h
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudView.h"

@interface FeedbackViewController : UIViewController<UITextViewDelegate>{

    HudView *aHUD;
    UITextView *txtViewForSug;
}

@property(nonatomic,retain)IBOutlet UITextView *txtViewForSug;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnSub:(id)sender;

@end
