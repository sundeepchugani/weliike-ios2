//
//  CustomCellLikeList.m
//  Pictale
//
//  Created by USER on 12/11/12.
//  Copyright (c) 2012 Techvalens Software Systems Pvt Ltd. All rights reserved.
//

#import "CustomCellLikeList.h"

@implementation CustomCellLikeList
@synthesize lblName,imgProfile,imgBg;


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
        [self.contentView addSubview:lblName];
        [self.contentView addSubview:imgProfile];
    }
    return self;
}


-(void)layoutSubviews
{
	lblName.frame=CGRectMake(50, 5, 200, 20 );
    imgProfile.frame=CGRectMake(5, 5, 40, 40);
	[super layoutSubviews];
}


@end
