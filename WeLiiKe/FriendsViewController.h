//
//  FriendsViewController.h
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"
#import "HudView.h"
#import "FBConnect.h"
#import "FollowAndFollowingCell.h"

@interface FriendsViewController : UIViewController<UISearchBarDelegate,FBRequestDelegate,FBDialogDelegate>{
    
    AsyncImageViewSmall *profileImage;
    IBOutlet AsyncImageViewSmall *coverImg;
    UILabel *lblForUserName;
    UISearchBar *searchBarExplore;
    UITableView *tableForSearch;
    NSMutableArray *arrayForAfterSearch,*arrayAllServerData;
    HudView *aHUD;
    UIActivityIndicatorView *activityIndicatorView;
}
@property (strong, nonatomic) IBOutlet UIButton *btn_Edit;
- (IBAction)actionOnEdit:(id)sender;
-(IBAction)actionOnBack:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *tableForSearch;
@property(nonatomic,retain)IBOutlet UILabel *lblForUserName;
@property(nonatomic,retain)IBOutlet UISearchBar *searchBarExplore;

-(IBAction)actionOnFb:(id)sender;
-(IBAction)actionOnEmail:(id)sender;

@end
