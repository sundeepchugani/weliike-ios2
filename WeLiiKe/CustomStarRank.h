//
//  CustomStarRank.h
//  IftekharCustomClasses
//
//  Created by Gaurav Goyal on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomStarRankDelegate;

@interface CustomStarRank : UIView
{
    float getValue;
    NSInteger getNumberOfStar;
    BOOL isDesable;
    NSString *strImage,*strStarActImage;
}
@property(nonatomic,retain)NSString *strImage,*strStarActImage;
@property(unsafe_unretained) id <CustomStarRankDelegate> delegate;

-(float)value;
-(void)setValue:(float)value;

-(NSInteger)NumberOfStar;
-(void) setNumberOfStar:(NSInteger)NumberOfStar;

-(void)setDesable:(BOOL)desable;

@end

@protocol CustomStarRankDelegate <NSObject>

@optional
-(void)CustomStarRank:(CustomStarRank*)customStarRank DidChangedValue:(float)value;
-(void)CustomStarRank:(CustomStarRank*)customStarRank Desabled:(BOOL)desable;
-(void)tapOnSliderView:(CustomStarRank*)customStarRank;
@end