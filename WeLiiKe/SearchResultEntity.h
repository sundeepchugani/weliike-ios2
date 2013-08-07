//
//  SearchResultEntity.h
//  WeLiiKe
//
//  Created by techvalens on 25/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageViewSmall.h"

@interface SearchResultEntity : UITableViewCell{

    AsyncImageViewSmall *imgForEntity;
    UILabel *lblForEntityName,*lblForEntityDisc;
    
}
@property(nonatomic,retain)AsyncImageViewSmall *imgForEntity; 
@property(nonatomic,retain)UILabel *lblForEntityName,*lblForEntityDisc;

@end
