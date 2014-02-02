//
//  EnityUserController.h
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnitityCell.h"
#import "HudView.h"
#import "SearchEntityViewController.h"
#import "EntityListCell.h"
#import "WETouchableView.h"
#import "AppDelegate.h"
#import "FollowerViewController.h"
#import "FollowingViewController.h"
#import "FriendCloudViewController.h"
#import "SortingViewController.h"
#import "TJSpinner.h"


@interface EnityUserController :  UIViewController<WETouchableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableViewForCategoty;
    UITableView *tableViewForWeliike;
    NSString *strForCateID,*strForSearchName;
    NSString *strForCateName,*strForMastCateID;
    NSMutableArray *arrayForServerData;
    NSMutableDictionary *dicForCheckEntity;
    UIButton *btnForDone;
    UILabel *labelForName;
    
    HudView *aHUD;
    UIButton *btnForTitle;
    int checkForGridAndList;
    
    WETouchableView *backgroundView;
    WETouchableView *backgroundViewPop;
    UIView *viewForWeliike;
    int selectedItmeFromWeLiike;
    
    UIView *viewForFollowFollowing;
    UIButton *btnForEntity;
    UIButton *btnForFollowing;
    UIButton *btnForFollower,*btnForSort;
    UIImageView *imgViewForHeader;
    NSString *strUserID;
    NSString *strForClass;
    UIView *viewForHeaderBot;
    int page_No;
    NSMutableDictionary *dicForCitySubcate;
    NSMutableArray *arrayForCell;
    TJSpinner  *spinner;
    
 
}
@property(assign)int selectedItmeFromWeLiike;
@property(nonatomic,retain)IBOutlet TJSpinner  *spinner;
@property(nonatomic,retain)NSString *strForClass;
@property(nonatomic,retain)IBOutlet UIView *viewForHeaderBot;
@property(nonatomic,retain)NSString *strUserID,*strForSearchName;
@property(nonatomic,retain)IBOutlet UIImageView *imgViewForHeader;
@property(nonatomic,retain)UIButton *btnForEntity,*btnForFollowing,*btnForFollower;
@property(nonatomic,retain)IBOutlet UIButton *btnForSort;
@property(nonatomic,retain)UIView *viewForFollowFollowing;
@property(nonatomic,retain)NSString *strForCateName,*strForMastCateID;
@property(nonatomic,retain)UIButton *btnForTitle;
@property(nonatomic,retain)IBOutlet  UILabel *labelForName; 
@property(nonatomic,retain)UIButton *btnForDone;
@property(nonatomic,retain)NSString *strForCateID;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategoty;
@property(nonatomic,retain)UITableView *tableViewForWeliike;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnListAndGrid:(id)sender;
-(IBAction)actionOnSearch:(id)sender;
-(IBAction)actionOnGridAndList:(id)sender;
-(IBAction)actionOnFilterSorting:(id)sender;
//-(IBAction)actionOnDone:(id)sender;
@end
