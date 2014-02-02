//
//  PrivacyAndTerm.h
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyAndTerm : UIViewController{

    UIButton *btnForVersion;
    UIScrollView *scrollViewForPrivacy;
}
@property(nonatomic,retain)IBOutlet UIScrollView *scrollViewForPrivacy;
@property(nonatomic,retain)IBOutlet UIButton *btnForVersion;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnAboutWeLiike:(id)sender;
-(IBAction)actionOnSupport:(id)sender;
-(IBAction)actionOnTermsOfservice:(id)sender;
-(IBAction)actionOnPrivatePolicy:(id)sender;
@end
