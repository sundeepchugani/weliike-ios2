//
//  AddFriendViewController.h
//  WeLiiKe
//
//  Created by techvalens on 09/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBook/ABPerson.h>
#import <MessageUI/MessageUI.h>
#import "HudView.h"
#import "FBConnect.h"

@interface AddFriendViewController : UIViewController<MFMailComposeViewControllerDelegate,FBRequestDelegate,FBDialogDelegate>{

    UITableView *tableForAddFriend;
    UILabel *lblForAddFriend;
    NSMutableArray *arrayForContacts;
    HudView *aHUD;
}
@property(nonatomic,retain)IBOutlet UILabel *lblForAddFriend;
@property(nonatomic,retain)IBOutlet  UITableView *tableForAddFriend;
-(IBAction)actionOnDone:(id)sender;
-(IBAction)actionOnBack:(id)sender;
-(void)getAllfriends;
@end
