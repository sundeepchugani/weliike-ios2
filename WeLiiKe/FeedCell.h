//
//  FeedCell.h
//  WeLiiKe
//
//  Created by anoop gupta on 26/04/13.
//
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"
#import "RTLabel.h"
#import "CustomStarRank.h"


@interface FeedCell : UITableViewCell{

    UIView *viewForback;
    UIButton *btnForUserName;
    UIButton *btnForCategory;
    UIScrollView *scrollViewCell;
    RTLabel *lblForName;
    UIButton *btnForComment;
    UIButton *btnForShare;
    UILabel *lblForDate;
    UILabel *lblForCommentCount;
    UIImageView *imgViewCommentCount;
    UILabel *lblForLikeCount;
    UIImageView *imgViewLikeCount;
}
@property(nonatomic,retain)UIScrollView *scrollViewCell;
@property(nonatomic,retain)UIView *viewForback;
@property(nonatomic,retain)UIButton *btnForUserName,*btnForCategory,*btnForComment,*btnForShare;
@property(nonatomic,retain)RTLabel *lblForName;
@property(nonatomic,retain)UILabel *lblForDate,*lblForCommentCount,*lblForLikeCount;
@property(nonatomic,retain)UIImageView *imgViewCommentCount,*imgViewLikeCount;
@end
