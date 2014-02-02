//
//  CellForWelcomeCategory.m
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CellForWelcomeCategory.h"

@implementation CellForWelcomeCategory
@synthesize image1,image2,image3,lbl1,lbl2,lbl3,imgViewForGra1,imgViewForGra2,imgViewForGra3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:image1.bounds];
        image1.layer.shadowColor = [UIColor blackColor].CGColor;
        image1.layer.shadowOffset = CGSizeZero;
        image1.layer.shadowOpacity = 0.5f;
        image1.layer.shadowPath = shadowPath.CGPath;
        
        imgViewForGra1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imgViewForGra1 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
        imgViewForGra1.hidden=YES;
        image1=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
        [image1.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [image1.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [image1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:image1];
        [image1 addSubview:imgViewForGra1];
        
        lbl1=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
        [lbl1 setFont:[UIFont boldSystemFontOfSize:10]];
        [lbl1 setTextAlignment:UITextAlignmentCenter];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [lbl1 setTextColor:[UIColor whiteColor]];
        [image1 addSubview:lbl1];
        
        imgViewForGra2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imgViewForGra2 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
        imgViewForGra2.hidden=YES;
        image2=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(10+100, 5, 100, 100)];
        image2.layer.shadowColor = [UIColor blackColor].CGColor;
        image2.layer.shadowOffset = CGSizeZero;
        image2.layer.shadowOpacity = 0.5f;
        image2.layer.shadowPath = shadowPath.CGPath;
        [image2.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [image2.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [image2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:image2];
        [image2 addSubview:imgViewForGra2];
        
        lbl2=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
        [lbl2 setFont:[UIFont boldSystemFontOfSize:10]];
        [lbl2 setTextAlignment:UITextAlignmentCenter];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [lbl2 setTextColor:[UIColor whiteColor]];
        [image2 addSubview:lbl2];
        
        imgViewForGra3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imgViewForGra3 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
        imgViewForGra3.hidden=YES;
        image3=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(15+200, 5, 100, 100)];
        image3.layer.shadowColor = [UIColor blackColor].CGColor;
        image3.layer.shadowOffset = CGSizeZero;
        image3.layer.shadowOpacity = 0.5f;
        image3.layer.shadowPath = shadowPath.CGPath;
        [image3.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [image3.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [image3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:image3];
        [image3 addSubview:imgViewForGra3];
    
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
