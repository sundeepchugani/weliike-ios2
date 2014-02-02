//
//  AddCategoryInUser.h
//  WeLiiKe
//
//  Created by techvalens on 10/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"
#import "CategoryAddCell.h"
#import "FriendCloudViewController.h"
#import "HudView.h"

@interface AddCategoryInUser : UIViewController {

    UITableView *tableViewForAddCate;
    NSMutableArray *arrayForServerData;
    NSMutableArray *arrayForSelectedData;
    HudView *aHUD;
      
}
@property(nonatomic,retain)IBOutlet UITableView *tableViewForAddCate;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnNext:(id)sender;
-(void)callServiceAddcategory:(NSString *)idForCat;

@end
