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

@interface feedViewController : UIViewController<UIScrollViewDelegate,CustomStarRankDelegate>{

    UITableView *tableViewForFeed;
    NSMutableArray *arrayForData;
    HudView *aHUD;
    NSMutableArray *arrayForCell;
    int currentIndex;
    int pageNo;
}
@property(nonatomic,retain)IBOutlet UITableView *tableViewForFeed;
-(float)calculateHeightOfLabel:(NSString*)text;
@end
