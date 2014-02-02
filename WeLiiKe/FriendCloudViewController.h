//
//  FriendCloudViewController.h
//  WeLiiKe
//
//  Created by techvalens on 28/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowAndFollowingCell.h"
#import "HudView.h"
#import "WeLiikeWebService.h"
#import "EnityUserController.h"
#import "HudView.h"

@interface FriendCloudViewController : UIViewController {
    
    UITableView *tableForFollowing;
    NSMutableArray *arrayForServerData,*arrayForSearchResult,*arrayForSuggestedUser,*arrayForServerDataForSugested;
    HudView *aHUD;
    NSString *strForCategoryId;
    NSString *strForCategoryName;
    UILabel *lblForCate;
    NSString *strForClass;
    NSMutableDictionary *dicForSelectedUser;
    UIButton *btnForNext;
    NSString *strForMasterId;
}
@property(nonatomic,retain) NSString *strForMasterId;
@property(nonatomic,retain)IBOutlet UIButton *btnForNext;
@property(nonatomic,retain)NSString *strForClass;
@property(nonatomic,retain)IBOutlet UILabel *lblForCate;
@property(nonatomic,retain)NSString *strForCategoryId,*strForCategoryName;
@property(nonatomic,retain)IBOutlet UITableView *tableForFollowing;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnAtoZ:(id)sender;
-(IBAction)actionOnList:(id)sender;
-(IBAction)actionOnNext:(id)sender;

-(void)callWebserviceAddFriends;

@end
