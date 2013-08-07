//
//  CategoryAddCell.m
//  WeLiiKe
//
//  Created by techvalens on 10/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CategoryAddCell.h"

@implementation CategoryAddCell

@synthesize lblName,imgAdd;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
        [lblName setFont:[UIFont boldSystemFontOfSize:15]];
        [lblName setTextColor:[UIColor grayColor]];
        imgAdd=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 23)];
        //imgAdd.layer.cornerRadius=5;
        //imgAdd.layer.masksToBounds=YES;
        [self.contentView addSubview:lblName];
        self.accessoryView =imgAdd;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
