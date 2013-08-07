//
//  FollowerViewController.h
//  WeLiiKe
//
//  Created by techvalens on 27/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowAndFollowingCell.h"
#import "HudView.h"
#import "WeLiikeWebService.h"

@interface FollowerViewController : UIViewController{
    UITableView *tableForFollowing;
    NSMutableArray *arrayForServerData;
    HudView *aHUD;
    NSString *strForCategoryId,*strForMasterCategoryId;
    
}
@property(nonatomic,retain)NSString *strForCategoryId,*strForMasterCategoryId;
@property(nonatomic,retain)IBOutlet UITableView *tableForFollowing;

-(IBAction)actionOnBack:(id)sender;
-(void)callWebserviceFor:(int)index;

@end
