//
//  ShareSettingViewController.h
//  WeLiiKe
//
//  Created by techvalens on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowAndFollowingCell.h"
#import "EmailContects.h"
#import "WeLiikeWebService.h"

@interface ShareSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    UIButton *btnForDone,*btnForFeedShare;
    UITableView *tableForSearch;
    int checkForHideGroupAndMessage;
    UITextField *txtForGroup,*txtForMessage;
    NSMutableArray *arrayForServerData,*arrayForSearchResult;
    UIButton *btnForFb;
    UIButton *btnForTwitter;
    UIButton *btnForEmail;
    NSMutableDictionary *dicForSelecteGroup;
    IBOutlet UIButton *btn_ForLock;
}
- (IBAction)actionOnLock:(id)sender;
@property(nonatomic,retain)UIButton *btnForFb,*btnForTwitter,*btnForEmail;
@property(nonatomic,retain)UITextField *txtForGroup,*txtForMessage;
@property(nonatomic,retain) UITableView *tableForSearch;
@property(nonatomic,retain)IBOutlet UIButton *btnForDone;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDone:(id)sender;

@end
