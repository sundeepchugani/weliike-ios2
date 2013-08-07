//
//  FollowAndFollowingCell.h
//  WeLiiKe
//
//  Created by techvalens on 27/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"

@interface FollowAndFollowingCell : UITableViewCell
{
    
    UILabel *lblName;
    AsyncImageViewSmall *imgProfile;
    UIImageView *imgBg;
    UILabel *lblForCountEntity;
    UIButton *imgForAddSing;
}
@property(nonatomic,retain)UIButton *imgForAddSing;
@property(nonatomic,retain)UILabel *lblForCountEntity; 
@property(nonatomic,retain)UIImageView *imgBg;
@property(nonatomic,retain)UILabel *lblName;
@property(nonatomic,retain) AsyncImageViewSmall *imgProfile;
@end
