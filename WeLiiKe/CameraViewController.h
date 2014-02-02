//
//  CameraViewController.h
//  MakaMaka
//
//  Created by Ashish on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CropViewController.h"

@interface CameraViewController : UIImagePickerController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UIImagePickerController *libraryPicker;
    UIView *viewOverlay;
    BOOL isTakePictureButtonPressed;
    NSMutableDictionary *dicForAllMasterCategory;

}
@property (nonatomic, retain) IBOutlet NSMutableDictionary *dicForAllMasterCategory;
@property(nonatomic,retain) UIView *viewOverlay;
@property(nonatomic,retain) UIImagePickerController *libraryPicker;
- (UIView*)findCamControlsLayerView:(UIView*)view;
-(void)addOverlay;
@end
