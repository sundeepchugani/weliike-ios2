//
//  FriendEmailFbViewController.h
//  WeLiiKe
//
//  Created by anoop gupta on 20/04/13.
//
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"
#import <AddressBookUI/AddressBookUI.h>
//#import <AddressBook/AddressBook.h>
//#import <AddressBook/ABAddressBook.h>
//#import <AddressBook/ABPerson.h>
//#import <MessageUI/MessageUI.h>
#import "HudView.h"
#import "FollowAndFollowingCell.h"
#import "RTLabel.h"


@interface FriendEmailFbViewController : UIViewController<FBRequestDelegate,FBDialogDelegate,UISearchBarDelegate>{

    IBOutlet UIButton *btnBack;
    UITableView *tableForAddFriend;
    NSMutableArray *arrayForContacts;
    HudView *aHUD;
    NSString *strCheckFBandEmail;
    NSMutableArray *arrayForAfterSearch,*arrayAllServerData;
    NSDictionary *dicForFriendFB;
    RTLabel *lblForCountFriend;
    UIButton *btnAllFriendFollow;
    UISearchBar *searchBarExplore;
    int countForUserFound;
    NSMutableArray *arrayForAddedFriendCount;
    NSMutableDictionary *dicForFbID;
    NSMutableArray *arrayForFBID;
    NSMutableArray *arrayForEmailFriendName;
 
}
- (IBAction)actionOnDone:(id)sender;
@property(nonatomic,retain)IBOutlet UISearchBar *searchBarExplore;
@property(nonatomic,retain)UIButton *btnAllFriendFollow;
@property(nonatomic,retain)RTLabel *lblForCountFriend;
@property(nonatomic,retain)NSString *strCheckFBandEmail;
@property(nonatomic,retain)NSDictionary *dicForFriendFB;
@property(nonatomic,retain)IBOutlet  UITableView *tableForAddFriend;
-(IBAction)actionOnBack:(id)sender;

//-(void)getAllfriends;
@end

