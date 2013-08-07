//
//  AggreegatorCell.h
//  WeLiiKe
//
//  Created by techvalens on 07/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"

@interface AggreegatorCell : UITableViewCell{
    
    AsyncImageViewSmall *image1,*image2,*image3;
    UILabel *lbl1,*lbl2,*lbl3;
    //UIImageView *imgViewForGra1,*imgViewForGra2,*imgViewForGra3;
    
}
//@property(nonatomic,retain) UIImageView *imgViewForGra1,*imgViewForGra2,*imgViewForGra3;
@property(nonatomic,retain)AsyncImageViewSmall *image1,*image2,*image3;
@property(nonatomic,retain)UILabel *lbl1,*lbl2,*lbl3;

@end
