//
//  SelectCategoryViewController.h
//  WeLiiKe
//
//  Created by techvalens on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"
#import "CategoryAddCell.h"
#import "HudView.h"


@interface SelectCategoryViewController : UIViewController
{
    UITableView *tableViewForCategory;
    NSMutableArray *arrayForCategory;
    BOOL checkSeeMore;
    HudView *aHUD;
}
@property (strong, nonatomic) IBOutlet UIButton *can;

@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategory;
- (void) dataDownloadComplete:(NSNotification *)notif;
-(IBAction)actionOnCancel:(id)sender;
@end
