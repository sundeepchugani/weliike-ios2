//
//  OtherUserProfile.h
//  WeLiiKe
//
//  Created by techvalens on 02/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageViewSmall.h"
#import "CellForWelcomeCategory.h"
#import "RTLabel.h"
#import "HudView.h"
#import "UserProfileFeedViewController.h"
#import "zoomViewController.h"

@interface OtherUserProfile : UIViewController<UIGestureRecognizerDelegate>
{
    AsyncImageViewSmall *profileImage;
    IBOutlet AsyncImageViewSmall *coverImg;
    UITableView *tableViewForCategoty;
    NSMutableArray *arrayForServerData,*arrayForGroup;
    NSDictionary *dicForServerData;
    UILabel *lblForTitle;
    UIImageView *lblForPopUp;
    HudView *aHUD;
    NSString *strForUserID;
    BOOL checkForFriend;
}
@property(nonatomic,retain)NSString *strForUserID;
@property(nonatomic,retain)IBOutlet UILabel *lblForTitle;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategoty;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnFeed:(id)sender;
-(IBAction)actionOnFeed:(id)sender;
@end