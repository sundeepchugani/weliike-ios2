//
//  EntityDetailViewController.h
//  WeLiiKe
//
//  Created by anoop gupta on 13/04/13.
//
//

#import <UIKit/UIKit.h>
#import "HudView.h"
#import "RTLabel.h"
#import "CommentCell.h"

@interface EntityDetailViewController : UIViewController{

    UITableView *tableViewForEntity;
    NSMutableArray *arrayForServerData;
    HudView *aHUD;
    NSMutableDictionary *dicForDetail;
    NSString *strForEntity;
}
@property(nonatomic,retain)NSString *strForEntity;
@property(nonatomic,retain)NSMutableDictionary *dicForDetail;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForEntity;

-(IBAction)actionOnBack:(id)sender;
-(float)calculateHeightOfLabel:(NSString*)text;
@end
