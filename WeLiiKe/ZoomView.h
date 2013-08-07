//
//  ZoomView.h
//  MakaMaka
//
//  Created by techvalens on 13/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "EGOPhotoScrollView.h"
@class EGOPhotoScrollView;

@interface ZoomView : UIView <UIScrollViewDelegate>{
@private
	EGOPhotoScrollView *_scrollView;
    UIImageView *_imageView;
    CGFloat _beginRadians;
} 
@property(nonatomic,readonly) UIImageView *imageView;
@property(nonatomic,readonly) EGOPhotoScrollView *scrollView;

- (void)killScrollViewZoom;
- (void)layoutScrollViewAnimated:(BOOL)animated;
- (void)prepareForReusue;
- (void)rotateToOrientation:(UIInterfaceOrientation)orientation;
-(void)setImageOn:(UIImage *)image;

@end
