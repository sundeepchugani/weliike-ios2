//
//  AggregateViewController.h
//  WeLiiKe
//
//  Created by techvalens on 10/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AggreegatorCell.h"
#import "WeLiikeWebService.h"

@interface AggregateViewController :UIViewController{
    
    UISearchBar *searchBarExplore;
    UITableView *tableViewForCategoty;
    NSMutableArray *arrayForServerData;
}

@property(nonatomic,retain)IBOutlet UITableView *tableViewForCategoty;
//@property(nonatomic,retain)IBOutlet UISearchBar *searchBarExplore;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDone:(id)sender;
@end
