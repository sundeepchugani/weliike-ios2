//
//  HomeViewController.h
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageViewSmall.h"
#import "CellForWelcomeCategory.h"
#import "RTLabel.h"
#import "HudView.h"
#import "UserProfileFeedViewController.h"

@interface HomeViewController : UIViewController<UIGestureRecognizerDelegate>
{
    AsyncImageViewSmall *profileImage;
    IBOutlet AsyncImageViewSmall *coverImg;
    UITableView *tableViewForCategoty;
    NSMutableArray *arrayForServerData,*arrayForGroup;
    UILabel *lblForTitle;
    UIImageView *lblForPopUp;
    HudView *aHUD;
    
}
@property(nonatomic,retain)IBOutlet UILabel *lblForTitle;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategoty;
-(IBAction)actionOnFeed:(id)sender;
-(IBAction)actionOnMessage:(id)sender;
@end
