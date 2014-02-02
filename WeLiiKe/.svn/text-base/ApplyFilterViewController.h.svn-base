//
//  ApplyFilterViewController.h
//  MakaMaka
//
//  Created by techvalens on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudView.h"
//#import "WETouchableView.h"

@interface ApplyFilterViewController : UIViewController{

    UIImageView *imgView;
    UIImage *imageOrg;
    
    UIScrollView *scrollViewForFilter;
    UIView *indicatorView;
    HudView *aHUD;
    UIButton *btnForNext;
    UIButton *btnForCancel;
    
   // WETouchableView *backgroundView;
    UIView *viewForCell;
    UIImage *image;
}
@property(nonatomic,retain)IBOutlet UIImage *image;
@property(nonatomic,retain)IBOutlet UIButton *btnForNext,*btnForCancel;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollViewForFilter;
@property(nonatomic,retain)IBOutlet UIImageView *imgView;
@property(nonatomic,retain)UIImage *imageOrg;

-(IBAction)actionOnCancel:(id)sender;
-(IBAction)actionOnNext:(id)sender;
-(void)makeTabBarHidden:(BOOL)hide;

@end
