//
//  UserProfileFeedViewController.h
//  WeLiiKe
//
//  Created by techvalens on 30/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"
#import "RTLabel.h"
#import "CustomStarRank.h"
#import "CommentViewController.h"
#import "HudView.h"
#import "FeedCell.h"
#import "RespostViewController.h"

@interface UserProfileFeedViewController : UIViewController<CustomStarRankDelegate>{
    
    UITableView *tableViewForFeed;
    NSMutableArray *arrayForData;
    HudView *aHUD;
    NSMutableArray *arrayForCell;
    NSString *strForUserId;
    int currentIndex;
}
@property(nonatomic,retain)NSString *strForUserId;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForFeed;
-(float)calculateHeightOfLabel:(NSString*)text;
-(IBAction)actionOnback:(id)sender;

@end
