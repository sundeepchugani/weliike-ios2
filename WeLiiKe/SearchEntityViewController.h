//
//  SearchEntityViewController.h
//  WeLiiKe
//
//  Created by techvalens on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"
#import "HudView.h"
#import "EnitityCell.h"
#import "EntityListCell.h"
#import "MapCell.h"
#import "HudView.h"
#import "AppDelegate.h"

@interface SearchEntityViewController : UIViewController<UITextFieldDelegate>{
   
    NSString *strForEnityName;
    NSString *strForCateID;
    UITableView *tableViewForSearchEntity;
    UITextField *txtFieldForSearch;
    UILabel *lblForTitle;
    NSMutableArray *arrayForServerData,*arrayForLatLng;
    HudView *aHUD;
    int checkForGridAndList;
    int checkForMap;
    MapCell *cellMap;
    NSMutableDictionary *dicForCitySubcate;
}
@property(nonatomic,retain)IBOutlet UILabel *lblForTitle;
@property(nonatomic,retain)IBOutlet UITextField *txtFieldForSearch;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForSearchEntity;
@property(nonatomic,retain)NSString *strForEnityName,*strForCateID,*strForMasterID,*strFoSearchName;

-(IBAction)actionOnback:(id)sender;
-(IBAction)actionOnSort:(id)sender;
-(IBAction)actionOnGridAndList:(id)sender;
-(IBAction)actionOnLocation:(id)sender;

@end
