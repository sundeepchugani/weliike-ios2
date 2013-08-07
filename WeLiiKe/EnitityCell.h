//
//  EnitityCell.h
//  WeLiiKe
//
//  Created by techvalens on 01/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"
#import "CustomStarRank.h"

@interface EnitityCell : UITableViewCell{
    AsyncImageViewSmall *image1,*image2,*image3;
    AsyncImageViewSmall *profileImage1,*profileImage2,*profileImage3;
    UILabel *lbl1,*lbl2,*lbl3;
    UIImageView *imgViewForGra1,*imgViewForGra2,*imgViewForGra3;
    CustomStarRank *starRate1,*starRate2,*starRate3;
}
@property(nonatomic,retain)CustomStarRank *starRate1,*starRate2,*starRate3;
@property(nonatomic,retain)UIImageView *imgViewForGra1,*imgViewForGra2,*imgViewForGra3;
@property(nonatomic,retain)AsyncImageViewSmall *image1,*image2,*image3;
@property(nonatomic,retain)AsyncImageViewSmall *profileImage1,*profileImage2,*profileImage3;
@property(nonatomic,retain)UILabel *lbl1,*lbl2,*lbl3;

@end
