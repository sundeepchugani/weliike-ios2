//
//  SearchResultEntity.m
//  WeLiiKe
//
//  Created by techvalens on 25/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SearchResultEntity.h"

@implementation SearchResultEntity
@synthesize imgForEntity,lblForEntityName,lblForEntityDisc;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        imgForEntity=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [imgForEntity setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:imgForEntity];
        
        lblForEntityName=[[UILabel alloc] initWithFrame:CGRectMake(70, 0, 220, 50)];
        [lblForEntityName setFont:[UIFont boldSystemFontOfSize:16]];
        [lblForEntityName setNumberOfLines:3];
        [lblForEntityName setTextColor:[UIColor darkGrayColor]];
        [lblForEntityName setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:lblForEntityName];
        
        lblForEntityDisc=[[UILabel alloc] initWithFrame:CGRectMake(70, 45, 220, 25)];
        [lblForEntityDisc setFont:[UIFont systemFontOfSize:12]];
        [lblForEntityDisc setTextColor:[UIColor lightGrayColor]];
        [lblForEntityDisc setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:lblForEntityDisc];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
