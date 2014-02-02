//
//  EmailContects.h
//  HFH
//
//  Created by mini on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewEmailAdress.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
//#import "ProfileScreen.h"
@interface EmailContects : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,ABPeoplePickerNavigationControllerDelegate,
ABPersonViewControllerDelegate,
ABNewPersonViewControllerDelegate,
ABUnknownPersonViewControllerDelegate> {
    
    IBOutlet UITableView *tableEmailContect;
    IBOutlet UIButton *btnEdit;
    IBOutlet UIButton *btnback;
    NSString *Emailproperty;
    NSString *personnameProperty;
    
}
@property(nonatomic,retain)IBOutlet UIButton *btnEdit; 
@property(nonatomic,retain)  IBOutlet UITableView *tableEmailContect;
@property(nonatomic,retain)  IBOutlet UIButton *btnback;
-(IBAction)backToshareScreen:(id)sender; 
-(void)showPeoplePickerController;
- (IBAction) EditTable:(UIButton *)sender;
@end
