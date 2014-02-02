//
//  AggreegatorCell.m
//  WeLiiKe
//
//  Created by techvalens on 07/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AggreegatorCell.h"

@implementation AggreegatorCell

@synthesize image1,image2,image3,lbl1,lbl2,lbl3;//,imgViewForGra1,imgViewForGra2,imgViewForGra3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        imgViewForGra1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        [imgViewForGra1 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
//        imgViewForGra1.hidden=YES;
        
       
        image1=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(5, 20, 100, 100)];
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:image1.bounds];
        image1.layer.shadowColor = [UIColor blackColor].CGColor;
        image1.layer.shadowOffset = CGSizeZero;
        image1.layer.shadowOpacity = 0.5f;
        image1.layer.shadowPath = shadowPath.CGPath;

        [self addSubview:image1];
       // [image1 addSubview:imgViewForGra1];
        
        lbl1=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 20)];
         UIBezierPath *shadowPath1 = [UIBezierPath bezierPathWithRect:lbl1.bounds];
        [lbl1 setFont:[UIFont boldSystemFontOfSize:12]];
        [lbl1 setTextAlignment:UITextAlignmentCenter];
        [lbl1 setBackgroundColor:[UIColor whiteColor]];
        [lbl1 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];
        lbl1.layer.shadowColor = [UIColor blackColor].CGColor;
        lbl1.layer.shadowOffset = CGSizeZero;
        lbl1.layer.shadowOpacity = 0.5f;
        lbl1.layer.shadowPath = shadowPath1.CGPath;

        [self addSubview:lbl1];
        
//        imgViewForGra2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        [imgViewForGra2 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
//        imgViewForGra2.hidden=YES;
        image2=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(10+100, 20, 100, 100)];
        image2.layer.shadowColor = [UIColor blackColor].CGColor;
        image2.layer.shadowOffset = CGSizeZero;
        image2.layer.shadowOpacity = 0.5f;
        image2.layer.shadowPath = shadowPath.CGPath;
        [self addSubview:image2];
//        [image2 addSubview:imgViewForGra2];
        
        lbl2=[[UILabel alloc] initWithFrame:CGRectMake(10+100, 0, 100, 20)];
        [lbl2 setFont:[UIFont boldSystemFontOfSize:12]];
        [lbl2 setTextAlignment:UITextAlignmentCenter];
        [lbl2 setBackgroundColor:[UIColor whiteColor]];
        [lbl2 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];
        lbl2.layer.shadowColor = [UIColor blackColor].CGColor;
        lbl2.layer.shadowOffset = CGSizeZero;
        lbl2.layer.shadowOpacity = 0.5f;
        lbl2.layer.shadowPath = shadowPath1.CGPath;

        [self addSubview:lbl2];
        
//        imgViewForGra3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        [imgViewForGra3 setImage:[UIImage imageNamed:@"gradient_filter.png"]];
//        imgViewForGra3.hidden=YES;
        image3=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(15+200, 20, 100, 100)];
        image3.layer.shadowColor = [UIColor blackColor].CGColor;
        image3.layer.shadowOffset = CGSizeZero;
        image3.layer.shadowOpacity = 0.5f;
        image3.layer.shadowPath = shadowPath.CGPath;

        [self addSubview:image3];
//        [image3 addSubview:imgViewForGra3];
        
        lbl3=[[UILabel alloc] initWithFrame:CGRectMake(15+200, 0, 100, 20)];
        [lbl3 setFont:[UIFont boldSystemFontOfSize:12]];
        [lbl3 setTextAlignment:UITextAlignmentCenter];
        [lbl3 setBackgroundColor:[UIColor whiteColor]];
        [lbl3 setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255 blue:255.0/255.0 alpha:1.0]];
        lbl3.layer.shadowColor = [UIColor blackColor].CGColor;
        lbl3.layer.shadowOffset = CGSizeZero;
        lbl3.layer.shadowOpacity = 0.5f;
        lbl3.layer.shadowPath = shadowPath1.CGPath;

        [self addSubview:lbl3];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
