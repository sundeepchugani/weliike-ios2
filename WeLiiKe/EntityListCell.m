//
//  EntityListCell.m
//  WeLiiKe
//
//  Created by techvalens on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EntityListCell.h"

@implementation EntityListCell
@synthesize lblForEntityName,lblForEntityType,lblForEntityAddress,imgForEntity,imgForProfile,starRate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imgForEntity=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
        [imgForEntity setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:imgForEntity];
        
        lblForEntityName=[[UILabel alloc] initWithFrame:CGRectMake(80, 0, 150, 25)];
        [lblForEntityName setFont:[UIFont boldSystemFontOfSize:14]];
        [lblForEntityName setTextAlignment:UITextAlignmentLeft];
        [lblForEntityName setBackgroundColor:[UIColor clearColor]];
        [lblForEntityName setTextColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [self addSubview:lblForEntityName];
        
        lblForEntityType=[[UILabel alloc] initWithFrame:CGRectMake(80, 25, 150, 25)];
        [lblForEntityType setFont:[UIFont systemFontOfSize:12]];
        [lblForEntityType setTextAlignment:UITextAlignmentLeft];
        [lblForEntityType setBackgroundColor:[UIColor clearColor]];
        [lblForEntityType setTextColor:[UIColor darkGrayColor]];
        [self addSubview:lblForEntityType];
        
        lblForEntityAddress=[[UILabel alloc] initWithFrame:CGRectMake(80, 50, 150, 25)];
        [lblForEntityAddress setFont:[UIFont systemFontOfSize:11]];
        [lblForEntityAddress setTextAlignment:UITextAlignmentLeft];
        [lblForEntityAddress setBackgroundColor:[UIColor clearColor]];
        [lblForEntityAddress setTextColor:[UIColor lightGrayColor]];
        [self addSubview:lblForEntityAddress];
        
        imgForProfile=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(280, 0, 40, 75)];
        [imgForProfile setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:imgForProfile];
        
        starRate=[[CustomStarRank alloc] initWithFrame:CGRectMake(220, 18,60, 12)];
        [starRate setUserInteractionEnabled:NO];
         [self addSubview:starRate];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
