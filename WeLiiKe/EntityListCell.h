//
//  EntityListCell.h
//  WeLiiKe
//
//  Created by techvalens on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"
#import "CustomStarRank.h"

@interface EntityListCell : UITableViewCell{

    AsyncImageViewSmall *imgForEntity;
    AsyncImageViewSmall *imgForProfile;
    UILabel *lblForEntityName,*lblForEntityType,*lblForEntityAddress;
    CustomStarRank *starRate;
    
}
//@property(assign)int starCount;
@property(nonatomic,retain)CustomStarRank *starRate;
@property(nonatomic,retain)AsyncImageViewSmall *imgForEntity,*imgForProfile;
@property(nonatomic,retain)UILabel *lblForEntityName,*lblForEntityType,*lblForEntityAddress;

-(void)loadStar:(int)coutStar;

@end
