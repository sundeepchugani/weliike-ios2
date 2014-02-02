//
//  RespostViewController.h
//  WeLiiKe
//
//  Created by anoop gupta on 13/04/13.
//
//

#import <UIKit/UIKit.h>
#import "FollowAndFollowingCell.h"
#import "EmailContects.h"
#import "WeLiikeWebService.h"
#import "GCPlaceholderTextView.h"
#import "HudView.h"

@interface RespostViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,FBRequestDelegate,FBDialogDelegate>{
    
    UIButton *btnForDone,*btnForFeedShare;
    UITableView *tableForSearch;
    int checkForHideGroupAndMessage;
    UITextField *txtForGroup,*txtForMessage;
    NSMutableArray *arrayForServerData,*arrayForSearchResult;
    UIButton *btnForFb;
    UIButton *btnForTwitter;
    UIButton *btnForEmail;
    UIScrollView *scrollViewForRepost;
    GCPlaceholderTextView *txtViewForCaption;
    NSString *strForAddress;
    HudView *aHUD;
    NSString *strForEntity;
    NSDictionary *dicForDetail;
    NSMutableDictionary *dicForSelecteGroup;
    
    
}
@property(nonatomic,retain)NSDictionary *dicForDetail;
@property(nonatomic,retain)NSString *strForAddress,*strForEntity;
@property(nonatomic,retain)GCPlaceholderTextView *txtViewForCaption;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollViewForRepost;
@property(nonatomic,retain)UIButton *btnForFb,*btnForTwitter,*btnForEmail;
@property(nonatomic,retain)UITextField *txtForGroup,*txtForMessage;
@property(nonatomic,retain) UITableView *tableForSearch;
@property(nonatomic,retain)IBOutlet UIButton *btnForDone;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDone:(id)sender;

@end
