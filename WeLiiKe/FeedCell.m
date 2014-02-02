//
//  FeedCell.m
//  WeLiiKe
//
//  Created by anoop gupta on 26/04/13.
//
//

#import "FeedCell.h"

@implementation FeedCell
@synthesize viewForback;
@synthesize btnForCategory,btnForComment,btnForShare,btnForUserName;
@synthesize lblForName;
@synthesize lblForCommentCount,lblForDate,lblForLikeCount;
@synthesize scrollViewCell;
@synthesize imgViewCommentCount,imgViewLikeCount;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        viewForback=[[UIView alloc] init];
        [viewForback setBackgroundColor:[UIColor whiteColor]];
        
        btnForUserName=[[UIButton alloc] initWithFrame:CGRectMake(-23, -2, 100, 30)];
        //[btnForUserName setTitle:[[arrayForData objectAtIndex:i] valueForKey:@"UserName"] forState:UIControlStateNormal];
        [btnForUserName.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [btnForUserName setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnForUserName setBackgroundColor:[UIColor clearColor]];
        [viewForback addSubview:btnForUserName];
        
        
        btnForCategory=[[UIButton alloc] initWithFrame:CGRectMake(175, -2, 175, 30)];
        btnForCategory.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        //[btnForCategory setTitle:[[arrayForData objectAtIndex:i] valueForKey:@"category"] forState:UIControlStateNormal];
        //SUNDEEP: REPLACE "NIL" BELOW FOR @"button_bgFeed.png"
        [btnForCategory setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        //2 lines below added by SUNDEEP
        [btnForCategory.titleLabel setTextAlignment: UITextAlignmentRight];
        //[btnForCategory setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnForCategory.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        //UNCOMMENTED AND EDITED BY SUNDEEP
        [btnForCategory setTitleColor:[UIColor colorWithRed:0.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnForCategory setBackgroundColor:[UIColor clearColor]];
        [viewForback addSubview:btnForCategory];
        //END OF SUNDEEP
        
        scrollViewCell=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, 320, 140)];
        scrollViewCell.pagingEnabled=YES;

        
        lblForName=[[RTLabel alloc] initWithFrame:CGRectMake(5, 175, 296, 40)];
        [lblForName setTextColor:[UIColor blackColor]];
        //[lblForName setText:strForCaption];
        [viewForback addSubview:lblForName];;
        
        
        btnForComment=[[UIButton alloc] initWithFrame:CGRectMake(5,170, 60, 25)];
        [btnForComment setTitle:@"Comment" forState:UIControlStateNormal];
        [btnForComment.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        btnForComment.layer.cornerRadius=5.0;
        btnForComment.layer.masksToBounds=YES;
        [btnForComment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnForComment setBackgroundColor:[UIColor clearColor]];
        //[btnForComment addTarget:self action:@selector(actionOnComment:) forControlEvents:UIControlEventTouchUpInside];
        [viewForback addSubview:btnForComment];
        
        btnForShare=[[UIButton alloc] initWithFrame:CGRectMake(65,170, 45, 25)];
        [btnForShare setTitle:@"Share" forState:UIControlStateNormal];
        btnForShare.layer.cornerRadius=5.0;
        btnForShare.layer.masksToBounds=YES;
        [btnForShare.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [btnForShare setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnForShare setBackgroundColor:[UIColor clearColor]];
        [viewForback addSubview:btnForShare];
        
        lblForDate=[[UILabel alloc] initWithFrame:CGRectMake(120, 170, 50, 25)];
        //[lblForDate setText:[[arrayForData objectAtIndex:i] valueForKey:@"Date"]];
        [lblForDate setFont:[UIFont boldSystemFontOfSize:12]];
        [lblForDate setTextAlignment:UITextAlignmentLeft];
        [lblForDate setBackgroundColor:[UIColor clearColor]];
        [lblForDate setTextColor:[UIColor grayColor]];
        [viewForback addSubview:lblForDate];
        
        lblForCommentCount=[[UILabel alloc] initWithFrame:CGRectMake(175, 170, 45, 25)];
        //[lblForCommentCount setText:[[arrayForData objectAtIndex:i] valueForKey:@"CommentCount"]];
        [lblForCommentCount setFont:[UIFont boldSystemFontOfSize:12]];
        [lblForCommentCount setTextAlignment:UITextAlignmentRight];
        [lblForCommentCount setBackgroundColor:[UIColor clearColor]];
        [lblForCommentCount setTextColor:[UIColor grayColor]];
        [viewForback addSubview:lblForCommentCount];
        
        imgViewCommentCount=[[UIImageView alloc] initWithFrame:CGRectMake(225, 170+5, 15, 15)];
        [imgViewCommentCount setImage:[UIImage imageNamed:@"commentFeed.png"]];//Comment.png
        [viewForback addSubview:imgViewCommentCount];
        
        lblForLikeCount=[[UILabel alloc] initWithFrame:CGRectMake(240, 170, 45, 25)];
        //[lblForLikeCount setText:[[arrayForData objectAtIndex:i] valueForKey:@"LikeCount"]];
        [lblForLikeCount setFont:[UIFont boldSystemFontOfSize:12]];
        [lblForLikeCount setTextAlignment:UITextAlignmentRight];
        [lblForLikeCount setBackgroundColor:[UIColor clearColor]];
        [lblForLikeCount setTextColor:[UIColor grayColor]];
        [viewForback addSubview:lblForLikeCount];
        
        imgViewLikeCount=[[UIImageView alloc] initWithFrame:CGRectMake(287, 170+5, 15, 15)];
        [imgViewLikeCount setImage:[UIImage imageNamed:@"smileyFeed.png"]];
        [viewForback addSubview:imgViewLikeCount];
        
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:viewForback.bounds];
        viewForback.layer.masksToBounds = NO;
        viewForback.layer.shadowColor = [UIColor blackColor].CGColor;
        viewForback.layer.shadowOffset = CGSizeZero;
        viewForback.layer.shadowOpacity = 0.5f;
        viewForback.layer.shadowPath = shadowPath.CGPath;
        
        [self addSubview:viewForback];
        [self addSubview:scrollViewCell];
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
