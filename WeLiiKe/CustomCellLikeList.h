//
//  CustomCellLikeList.h
//  Pictale
//
//  Created by USER on 12/11/12.
//  Copyright (c) 2012 Techvalens Software Systems Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageViewSmall.h"

@interface CustomCellLikeList : UITableViewCell
{

    UILabel *lblName;
    AsyncImageViewSmall *imgProfile;
    UIImageView *imgBg;
    
}
@property(nonatomic,retain)UIImageView *imgBg;
@property(nonatomic,retain)UILabel *lblName;
@property(nonatomic,retain) AsyncImageViewSmall *imgProfile;
@end
