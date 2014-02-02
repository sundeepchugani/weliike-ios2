//
//  feedViewController.h
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"
#import "RTLabel.h"
#import "HudView.h"
#import "FeedCell.h"
#import "RespostViewController.h"
#import "WeLiikeWebService.h"
#import "WETouchableView.h"
#import "AppDelegate.h"
#import "EnityUserController.h"

@interface feedViewController : UIViewController<UIScrollViewDelegate,CustomStarRankDelegate,UIGestureRecognizerDelegate>{

    UITableView *tableViewForFeed;
    NSMutableArray *arrayForData;
    HudView *aHUD;
    NSMutableArray *arrayForCell;
    int currentIndex;
    int pageNo;
    IBOutlet UILabel *lbl_TopBar;
    IBOutlet UIImageView *iv_TopBar;
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
    AppDelegate *delegate;
    UITapGestureRecognizer *tapOnce;
    UIImageView *IV_Gradient;
    //NOJUAN
    UIView *viewForBg;
    //end
}
//NOJUAN
@property (nonatomic,retain)UIView *viewForBg;
//end
@property (strong, nonatomic) IBOutlet UIView *V_TopBar;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForFeed;
-(float)calculateHeightOfLabel:(NSString*)text;
@end
