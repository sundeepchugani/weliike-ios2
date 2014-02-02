//
//  EntityViewController.h
//  WeLiiKe
//
//  Created by techvalens on 01/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnitityCell.h"
#import "HudView.h"

@interface EntityViewController : UIViewController{

    UISearchBar *searchBarExplore;
    UITableView *tableViewForCategoty;
    NSString *strForCateID,*strForCome;
    NSMutableArray *arrayForServerData;
    NSMutableDictionary *dicForCheckEntity;
    UIButton *btnForDone;
    UILabel *labelForName;
    HudView *aHUD;
    int pageNo;
}

@property(nonatomic,retain)IBOutlet  UILabel *labelForName; 
@property(nonatomic,retain)IBOutlet UIButton *btnForDone;
@property(nonatomic,retain)NSString *strForCateID,*strForCome;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategoty;
@property(nonatomic,retain)IBOutlet UISearchBar *searchBarExplore;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDone:(id)sender;
@end
