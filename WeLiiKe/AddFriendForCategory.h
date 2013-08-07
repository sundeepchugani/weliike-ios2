//
//  AddFriendForCategory.h
//  WeLiiKe
//
//  Created by techvalens on 06/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellLikeList.h"
#import "WeLiikeWebService.h"
#import "HudView.h"
#import "AppDelegate.h"

@interface AddFriendForCategory : UIViewController<UITextFieldDelegate>{

    UITextField *txtFieldForSearch;
    UIButton *btnForList,*btnForAtoZ;
    NSMutableArray *arrayForServerData,*arrayForServerCategory,*arrayForSearchResult;
    UITableView *tableForFriends;
    UILabel *labelForName;
    HudView *aHUD;
    BOOL checkForUpdate;
    NSMutableDictionary *dicForSelectFriend;
    //NSMutableDictionary *dicForAddFriend;
}

@property(nonatomic,retain)IBOutlet UIButton *btnForList,*btnForAtoZ;
@property(nonatomic,retain)IBOutlet  UILabel *labelForName;
@property(nonatomic,retain)IBOutlet UITextField *txtFieldForSearch;
@property(nonatomic,retain)IBOutlet UITableView *tableForFriends;

-(IBAction)actionForBack:(id)sender;
-(IBAction)actionOnList:(id)sender;
-(IBAction)actionOnAtoZ:(id)sender;
-(IBAction)actionOnNext:(id)sender;
-(void)callWebserviceFor:(NSString *)index;
@end
