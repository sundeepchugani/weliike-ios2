////
////  ImagePickerControllerClass.h
////  CameraLib
////
////  Created by Gaurav Goyal on 1/5/12.
////  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//#import <AVFoundation/AVFoundation.h>
//#import <MobileCoreServices/MobileCoreServices.h>
//@interface NSArray(RandomObjects)
//-(id)randomObject;
//@end
//
//@interface ImagePickerControllerClass : UIImagePickerController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIGestureRecognizerDelegate>{
//    
//    UIImage *oringialImage;
//    
//    UIImageView *imageView;
//    UIScrollView *filterScrollView;
//    
//    UIButton *backButton;
//    UIButton *nextButton;
//    
//    UIView *toolBar;
//    UIImagePickerController *libraryPicker;
//    
//    //--- Use for change camera controls button images---- 
//    UIImage *cancelBtnImage;
//    UIImage *libraryBtnImage;
//    UIImage *takePhotoBtnImage;
//    
//    //--- Use for change camera toolbar background image-----
//    UIImage *toolbarBackgroundImage;
//    //--- Use for change takePhoto button background image-----
//    UIImage *takePhotoBackgroundImage;
//    
//    //--- UIImages for Filter class back and next button -----
//    UIImage *backButtonImageOfFilterView;
//    UIImage *nextButtonImageOfFilterView;
//    
//    //--- UIImages for background of back and next button of Filter view --- 
//    UIImage *backButtonBackgroundImageOfFilterView;
//    UIImage *nextButtonBackgroundImageOfFilterView;
//    
//    //--- Title for back and next button of Filter class --- 
//    NSString *backButtonTitleForFilterView;
//    NSString *nextButtonTitleForFilterView;
//    
//    //---- Image for toolbar of Filter view -----
//    UIImage *toolBarImageOfFilterView;
//    //---- Image for background of scroll view For Filter view-----
//    UIImage *scrollViewBackgroundImageForFilterView;
//    
//    // PBFilterManager *filterManager;
//    UIImage *originalImage;
//    
//    //---- Image view for toolbar -----
//    UIImageView *toolBarImageView;
//    
//    //--- UIImages for back and next button --- 
//    UIImage *backButtonImage;
//    UIImage *nextButtonImage;
//    
//    //--- UIImages for background of back and next button --- 
//    UIImage *backButtonBackgroundImage;
//    UIImage *nextButtonBackgroundImage;
//    
//    //--- Title for back and next button --- 
//    NSString *backButtonTitle;
//    NSString *nextButtonTitle;
//    
//    //---- Image for toolbar -----
//    UIImage *toolBarImage;
//    
//    //---- Image view for background of scroll view -----
//    UIImageView *scrollViewBackgroundView;
//    //---- Image for background of scroll view -----
//    UIImage *scrollViewBackgroundImage;
//    //---- View for filter --------
//    UIView *filterView;
//    //to hold in-purchase filter btn tag 
//    int fiterBtnTag;
//    //----image for contrast
//    UIImage *originalImageNew;
//    UIButton *btnBrightness;
//    
//    BOOL isTakePictureButtonPressed;
//    UIButton *cancel;
//    UIButton *library;
//    UIImageView *v;
//    AVCaptureSession *avSession; 
//    NSString *strAuto;
//    
//    int deviceFlashMode;
//    AVCaptureDevice *device;
// 
//}
//
////@property (retain, nonatomic) IBOutlet UIImageView *imageView;
//
//-(UIView *) customCameraToolbar:(UIImage *)cancelBtnImage library:(UIImage *)libraryBtnImage takePhoto:(UIImage *) takePhotoBtnImage;
//-(void) setCameraControlsButtonsImage:(UIImage *)Image1 library:(UIImage *)Image2 takePhoto:(UIImage *)Image3;
//-(void) setCameraToolbarBackgroundImage:(UIImage *)Image;
//-(void) setTakePhotoBackgroundImage:(UIImage *)image;
//-(void) setImagesBackAndNextButtonOfFilterView:(UIImage *)back nextImage:(UIImage *)next;
////-(void) setBackgroundImagesBackAndNextButtonOfFilterView:(UIImage *)back nextImage:(UIImage *)next;
////-(void) setTitleOfBackAndNextButtonOfFilterView:(NSString *)back nextTitle:(NSString *)next;
////-(void) setImageOfToolbarImageViewOfFilterView:(UIImage *)image;
////-(void) setScrollViewBackgroundImageOfFilterView:(UIImage *)image;
//
//-(void) setImagesOfBackAndNextButton:(UIImage *)back nextImage:(UIImage *)next;
//-(void) setBackgroundImagesOfBackAndNextButton:(UIImage *)back nextImage:(UIImage *)next;
//-(void) setTitleOfBackAndNextButton:(NSString *)back nextTitle:(NSString *)next;
//-(void) setImageForFilterToolbarImageView:(UIImage *)image;
//-(void) setScrollViewBackgroundImage:(UIImage *)image;
//-(void)setBrightness;
//- (UIView*)findCamControlsLayerView:(UIView*)view;
//- (UIImage*) imageWithBrightness;
//
//@end
