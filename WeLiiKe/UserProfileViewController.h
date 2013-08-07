//
//  UserProfileViewController.h
//  WeLiiKe
//
//  Created by techvalens on 30/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"
#import "CellForWelcomeCategory.h"


@interface UserProfileViewController : UIViewController<UIGestureRecognizerDelegate>
{
    AsyncImageViewSmall *profileImage;
    UITableView *tableViewForCategoty;
}
@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategoty;

-(IBAction)actionOnUserProfileFeed:(id)sender;
-(IBAction)actionOnBack:(id)sender;
@end