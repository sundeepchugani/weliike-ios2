//
//  FollowAndFollowingCell.m
//  WeLiiKe
//
//  Created by techvalens on 27/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FollowAndFollowingCell.h"

@implementation FollowAndFollowingCell
@synthesize lblName,imgProfile,imgBg,lblForCountEntity,imgForAddSing;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [imgBg setImage:[UIImage imageNamed:@"center_bar.png"]];
        imgBg.hidden=YES;
        [self.contentView addSubview:imgBg];
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 20)];
        [lblName setFont:[UIFont boldSystemFontOfSize:15]];
        [lblName setTextColor:[UIColor grayColor]];
        [lblName setBackgroundColor:[UIColor clearColor]];
        imgProfile=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        imgProfile.layer.cornerRadius=5;
        imgProfile.layer.masksToBounds=YES;
        
        lblForCountEntity=[[UILabel alloc] initWithFrame:CGRectMake(260, 10, 40, 25)];
        [lblForCountEntity setFont:[UIFont systemFontOfSize:14]];
        [lblForCountEntity setTextColor:[UIColor whiteColor]];
        [lblForCountEntity setTextAlignment:UITextAlignmentCenter];
        [lblForCountEntity setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        lblForCountEntity.layer.cornerRadius=5;
        lblForCountEntity.layer.masksToBounds=YES;
 
        imgForAddSing=[[UIButton alloc] initWithFrame:CGRectMake(255, 10, 40, 25)];
        imgForAddSing.hidden=YES;
        [self.contentView addSubview:lblName];
        [self.contentView addSubview:imgProfile];
        [self.contentView addSubview:lblForCountEntity];
        [self.contentView addSubview:imgForAddSing];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
