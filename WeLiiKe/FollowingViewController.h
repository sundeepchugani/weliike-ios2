//
//  FollowingViewController.h
//  WeLiiKe
//
//  Created by techvalens on 27/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowAndFollowingCell.h"
#import "HudView.h"
#import "WeLiikeWebService.h"

@interface FollowingViewController : UIViewController {

    UITableView *tableForFollowing;
    NSMutableArray *arrayForServerData,*arrayForSearchResult,*arrayForSuggestedUser,*arrayForServerDataForSugested;
    HudView *aHUD;
    NSString *strForCategoryId;
    NSString *strForMasterID;
}
@property(nonatomic,retain)NSString *strForCategoryId,*strForMasterID;
@property(nonatomic,retain)IBOutlet UITableView *tableForFollowing;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnAtoZ:(id)sender;
-(IBAction)actionOnList:(id)sender;
-(void)callWebserviceFor:(int)index;

@end
