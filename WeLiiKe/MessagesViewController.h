//
//  MessagesViewController.h
//  WeLiiKe
//
//  Created by anoop gupta on 02/05/13.
//
//

#import <UIKit/UIKit.h>
#import "HudView.h"
#import "RTLabel.h"
#import "WeLiikeWebService.h"
#import "CommentCell.h"

@interface MessagesViewController : UIViewController{

    UITableView *tableViewForGroup;
    NSMutableDictionary *dicForServerData;
    NSMutableArray *arrayForMessage;
    NSMutableArray *arrayForFriendReq;
    NSMutableArray *arrayForActivity;
    int indexForSelection;
    HudView *aHUD;
    UIButton *btnForAll,*btnForMessage,*btnForReq,*btnForActi;
}
@property(nonatomic,retain)IBOutlet UITableView *tableViewForGroup;
@property(nonatomic,retain)IBOutlet UIButton *btnForAll,*btnForMessage,*btnForReq,*btnForActi;

-(IBAction)actionOnAll:(id)sender;
-(IBAction)actionOnMessage:(id)sender;
-(IBAction)actionOnReq:(id)sender;
-(IBAction)actionOnActivity:(id)sender;

-(IBAction)actionOnBack:(id)sender;

@end
