//
//  EnitityCell.m
//  WeLiiKe
//
//  Created by techvalens on 01/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EnitityCell.h"

@implementation EnitityCell
@synthesize image1,image2,image3,lbl1,lbl2,lbl3,profileImage1,profileImage2,profileImage3,imgViewForGra1,imgViewForGra2,imgViewForGra3,starRate1,starRate2,starRate3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
                
        
                
        image1=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
        [image1 setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:image1];
        
        imgViewForGra1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imgViewForGra1 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
        imgViewForGra1.hidden=YES;
        [image1 addSubview:imgViewForGra1];

        
        profileImage1=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(5, 0, 35, 35)];
        [self addSubview:profileImage1];
        
        starRate1=[[CustomStarRank alloc] initWithFrame:CGRectMake(40, 107,60, 12)];
        [starRate1 setUserInteractionEnabled:NO];
        [self addSubview:starRate1];
        
        
        lbl1=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
        [lbl1 setFont:[UIFont boldSystemFontOfSize:10]];
        [lbl1 setTextAlignment:UITextAlignmentCenter];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [lbl1 setTextColor:[UIColor whiteColor]];
        [image1 addSubview:lbl1];
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:profileImage1.bounds];
        profileImage1.layer.masksToBounds = NO;
        profileImage1.layer.shadowColor = [UIColor blackColor].CGColor;
        profileImage1.layer.shadowOffset = CGSizeZero;
        profileImage1.layer.shadowOpacity = 0.5f;
        profileImage1.layer.shadowPath = shadowPath.CGPath;
        
        profileImage1.layer.borderWidth=1.50;
        profileImage1.layer.borderColor=[UIColor whiteColor].CGColor;
        
        image2=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(10+100, 5, 100, 100)];
        [image2 setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:image2];
        imgViewForGra2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imgViewForGra2 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
        imgViewForGra2.hidden=YES;
        [image2 addSubview:imgViewForGra2];
        
        profileImage2=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(115, 0, 35, 35)];
        [self addSubview:profileImage2];
        
        
        starRate2=[[CustomStarRank alloc] initWithFrame:CGRectMake(150, 107,60, 12)];
        [starRate2 setUserInteractionEnabled:NO];
        [self addSubview:starRate2];
        
        profileImage2.layer.masksToBounds = NO;
        profileImage2.layer.shadowColor = [UIColor blackColor].CGColor;
        profileImage2.layer.shadowOffset = CGSizeZero;
        profileImage2.layer.shadowOpacity = 0.5f;
        profileImage2.layer.shadowPath = shadowPath.CGPath;
        
        profileImage2.layer.borderWidth=1.50;
        profileImage2.layer.borderColor=[UIColor whiteColor].CGColor;
        
        lbl2=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
        [lbl2 setFont:[UIFont boldSystemFontOfSize:10]];
        [lbl2 setTextAlignment:UITextAlignmentCenter];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [lbl2 setTextColor:[UIColor whiteColor]];
        [image2 addSubview:lbl2];
        
        image3=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(15+200, 5, 100, 100)];
        [image3 setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:image3];
        imgViewForGra3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imgViewForGra3 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
        imgViewForGra3.hidden=YES;
        [image3 addSubview:imgViewForGra3];
        
        profileImage3=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(220, 0, 35, 35)];
        [self addSubview:profileImage3];

        starRate3=[[CustomStarRank alloc] initWithFrame:CGRectMake(250, 107,60, 12)];
        [starRate3 setUserInteractionEnabled:NO];
        [self addSubview:starRate3];

        
        profileImage3.layer.masksToBounds = NO;
        profileImage3.layer.shadowColor = [UIColor blackColor].CGColor;
        profileImage3.layer.shadowOffset = CGSizeZero;
        profileImage3.layer.shadowOpacity = 0.5f;
        profileImage3.layer.shadowPath = shadowPath.CGPath;
        profileImage3.layer.borderWidth=1.50;
        profileImage3.layer.borderColor=[UIColor whiteColor].CGColor;
        
        
        lbl3=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
        [lbl3 setFont:[UIFont boldSystemFontOfSize:10]];
        [lbl3 setTextAlignment:UITextAlignmentCenter];
        [lbl3 setBackgroundColor:[UIColor clearColor]];
        [lbl3 setTextColor:[UIColor whiteColor]];
        [image3 addSubview:lbl3];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
