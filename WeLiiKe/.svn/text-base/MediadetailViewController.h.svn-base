//
//  MediadetailViewController.h
//  WeLiiKe
//
//  Created by techvalens on 17/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageViewSmall.h"
#import "RTLabel.h"
#import<MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "HudView.h"
#import "WeLiikeWebService.h"
#import "MapCell.h"
#import "CommentCell.h"
#import "FPPopoverController.h"
#import "ARCMacros.h"
#import "CaptionPopViewController.h"

@interface MediadetailViewController : UIViewController<MKMapViewDelegate,UIScrollViewDelegate,CustomStarRankDelegate>{

    UIScrollView *scrollViewForMain;    
    NSMutableArray *arrayForData;
    NSMutableDictionary *dicForServerData;
    UIScrollView *scrollviewForAllImages;
    MKMapView *MapViewForLocation;
    HudView *aHUD;
    NSString *strForEntity;
   
    //*******************
    UITableView *tableViewForDetail;
    BOOL checkForMapShow;
    int currentPage,currentIndex;
    UITableViewCell *cellScrolling;
    NSString *strUserID;
    MapCell *cellMap;
    UIAlertView *alertForCaption;
    FPPopoverController *popover;
    UILabel *lblForTitle;
}
@property(nonatomic,retain)NSString *strUserID;
@property(nonatomic,retain)IBOutlet UITableView *tableViewForDetail;
@property(nonatomic,retain)NSString *strForEntity;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollViewForMain;
@property(nonatomic,retain)IBOutlet UILabel *lblForTitle;
-(IBAction)actionOnBack:(id)sender;
-(void)makeScrollView:(BOOL)showMap;
-(float)calculateHeightOfLabel:(NSString*)text;
@end
