//
//  LikkerViewConotroller.h
//  WeLiiKe
//
//  Created by techvalens on 06/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"
#import "HudView.h"
#import "CustomStarRank.h"

@interface LikkerViewConotroller : UIViewController{

    UITableView *tableForLikker;
    NSMutableDictionary *dicForExpand,*dicForData;
    NSString *strForCategoryId;
    HudView *aHUD;
}
@property(nonatomic,retain)NSString *strForCategoryId;
@property(nonatomic,retain)IBOutlet UITableView *tableForLikker;
-(IBAction)actionOnBack:(id)sender;
@end
