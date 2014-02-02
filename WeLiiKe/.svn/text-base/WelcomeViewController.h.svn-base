//
//  WelcomeViewController.h
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellForWelcomeCategory.h"
#import "AppDelegate.h"
#import "WeLiikeWebService.h"
#import "HudView.h"
@interface WelcomeViewController : UIViewController{

    UIButton *btnForDone;
    UITableView *tableViewForCategoty;
    NSMutableArray *arrayForServerData;
    NSMutableDictionary *dicForCheckCate;
    HudView *aHUD;
}
@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategoty;
@property(nonatomic,retain)IBOutlet UIButton *btnForDone;

-(IBAction)actionOnDone:(id)sender;
-(IBAction)actionOnBack:(id)sender;
-(UIColor *)colorWithHexString:(NSString *)hex ;
@end
