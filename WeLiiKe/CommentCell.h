//
//  CommentCell.h
//  WeLiiKe
//
//  Created by techvalens on 08/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "AsyncImageViewSmall.h"
#import "CustomStarRank.h"

@interface CommentCell : UITableViewCell{

    AsyncImageViewSmall *imgForProfile;
    RTLabel *lblForComment;
    UIButton *btnForName,*btnForSeemore;
    UILabel *lblForDate;
    CustomStarRank *starRate;
    
}
@property(nonatomic,retain)AsyncImageViewSmall *imgForProfile;
@property(nonatomic,retain)RTLabel *lblForComment;
@property(nonatomic,retain)UIButton *btnForName,*btnForSeemore;
@property(nonatomic,retain)UILabel *lblForDate;
@property(nonatomic,retain)CustomStarRank *starRate;

@end
