//
//  CommentCell.m
//  WeLiiKe
//
//  Created by techvalens on 08/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell
@synthesize imgForProfile,lblForComment,lblForDate,btnForName,starRate,btnForSeemore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        imgForProfile=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        imgForProfile.layer.cornerRadius=5;
        imgForProfile.layer.masksToBounds=YES;
        
        btnForName=[[UIButton alloc] initWithFrame:CGRectMake(50, 0, 200, 25)];
        [btnForName.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [btnForName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnForName setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        starRate=[[CustomStarRank alloc] initWithFrame:CGRectMake(260, 2,60, 12)];
        //[starRate setValue:2];
        [starRate setUserInteractionEnabled:NO];
        //[self.view addSubview:customRank];
        
        lblForComment=[[RTLabel alloc] initWithFrame:CGRectMake(50, 25, 250, 20)];
        [lblForComment setBackgroundColor:[UIColor clearColor]];
        
        
        lblForDate=[[UILabel alloc] initWithFrame:CGRectMake(260, 45, 45, 20)];
        [lblForDate setFont:[UIFont systemFontOfSize:12]];
        [lblForDate setTextColor:[UIColor grayColor]];
        [lblForDate setTextAlignment:UITextAlignmentRight];
        [lblForDate setBackgroundColor:[UIColor clearColor]];
        
        btnForSeemore=[[UIButton alloc] initWithFrame:CGRectMake(112, 0, 75, 30)];
        btnForSeemore.hidden=YES;
        [btnForSeemore setBackgroundImage:[UIImage imageNamed:@"see_more.png"] forState:UIControlStateNormal];
        //[btnForSeemore.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        //[btnForSeemore setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        //[btnForSeemore setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.contentView addSubview:imgForProfile];
        [self.contentView addSubview:btnForName];
        [self.contentView addSubview:starRate];
        [self.contentView addSubview:lblForComment];
        [self.contentView addSubview:lblForDate];
        [self.contentView addSubview:btnForSeemore];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
