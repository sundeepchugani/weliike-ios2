////
////  ImagePickerControllerClass.m
////  CameraLib
////
////  Created by Gaurav Goyal on 1/5/12.
////  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
////
//
//#import "ImagePickerControllerClass.h"
//#import "UIImage+Crop.h"
//#import "UIImage+Resize.h"
//#import <AVFoundation/AVFoundation.h>
//#import "TVImageFilterController.h"
//#import "ConfigureSNaccount.h"
//#import "AppDelegate.h"
//#import "Reachability.h"
//#import "InAppPurchaseManager.h"
//BOOL isBrightButttonEnabled;
//int isCameraFlashOn;
//
//UIView *indicatorView;
//extern BOOL nextButtonFlag;
//extern UIImage *photo;
//extern BOOL cameraFromProfile;//to check the from where camera is opened
//extern BOOL cameraFromSignUp;//to check the from where camera is opened
//BOOL isPresent;
//extern BOOL isPhotocapureComplited;
//
//#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
//
//#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
//
//#define kInAppPurchaseManagerTransactionCancelNotification @"kInAppPurchaseManagerTransactionCancelNotification"
//
//#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"
//
//
//@implementation ImagePickerControllerClass
//
//
//- (id)init {
//    self = [super init];
//    if (self) {
//        
//        //        if (self.sourceType == UIImagePickerControllerSourceTypeCamera)
//        //            self.sourceType = UIImagePickerControllerSourceTypeCamera;
//        //        else
//        
//        if (TARGET_IPHONE_SIMULATOR) {
//            
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"camera is not Availabel..in IPHONE_SIMULATOR" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//            // self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;         
//        }else
//        {
//            self.sourceType = UIImagePickerControllerSourceTypeCamera;
//            
//            self.delegate = self;
//            
//        }
//        
//        //   self.allowsEditing = YES;
//    }
//    return self;
//    
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.delegate = self;
//    if (filterView == nil) {
//        //----- allocate the view for filters ----
//        CGRect frame = CGRectMake(0, 0, 320, 480);
//        float height=[UIScreen mainScreen].bounds.size.height;
//        
//        if ( height==568) {
//            frame = CGRectMake(0, 0, 320, 568); 
//        }
//        
//        filterView = [[UIView alloc] initWithFrame:frame];
//        filterView.backgroundColor = [UIColor blackColor];
//        filterView.hidden = YES;
//        [self.view addSubview:filterView];
//        
//    }
//    
//    if (imageView == nil) {
//        //----- allocate the image view for preview ----
//        CGRect myImageRect = CGRectMake(10, 20, 300, 300);
//        float height=[UIScreen mainScreen].bounds.size.height;
//        
//        if ( height==568) {
//            myImageRect = CGRectMake(0, 20+32, 320, 320); 
//        }
//        imageView = [[UIImageView alloc] initWithFrame:myImageRect];
//        [filterView addSubview:imageView];
//    }
//    //--------------- Local Notification ---------------
//    
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(receiveTestNotification:) 
////                                                 name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
////    
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(receiveTestNotification:) 
////                                                 name:kInAppPurchaseManagerTransactionFailedNotification
////                                               object:nil];
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(receiveTestNotification:) 
////                                                 name:kInAppPurchaseManagerTransactionCancelNotification
////                                               object:nil];
//    
//    //------------ Local Notification ---------------
//      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(log:) name:nil object:nil];
//    
//    //[[[UIApplication sharedApplication].windows objectAtIndex:0] insertSubview:indicator atIndex:0];
//    
//    
//    originalImageNew=[[UIImage alloc] init];
//    isPresent=NO;
//    if (!TARGET_IPHONE_SIMULATOR ) {   
//        Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
//        
//        if (captureDeviceClass != nil) {
//            device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//            
//            if ([device hasFlash]&& [device hasTorch]){
//                // [device lockForConfiguration:nil];
//                //                 NSLog(@"device.flashMode=%d",device.flashMode);
//                //                 NSLog(@"device.torchMode=%d",device.torchMode);
//                //                 NSLog(@"device.CameraFlashMode=%d",self.cameraFlashMode);
//                if (device.flashMode==0) 
//                {
//                    NSLog(@"AVCaptureTorchModeOff didload");
//                    // [device setFlashMode:0];
//                    deviceFlashMode=0;
//                    //self.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
//                    [self setCameraFlashMode:-1];
//                    //  [device setTorchMode:0];
//                    
//                    
//                    //torchIsOn = YES;
//                }else if(device.flashMode==1){
//                    NSLog(@"AVCaptureTorchModeOn didload");
//                    deviceFlashMode=1;
//                    // [device setFlashMode:1];
//                    //self.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
//                    [self setCameraFlashMode:1];
//                    //  [device setTorchMode:1];
//                    
//                }else {
//                    NSLog(@"AVCaptureTorchModeAuto didload");
//                    deviceFlashMode=2;
//                    //   [device setFlashMode:2];
//                    //self.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
//                    [self setCameraFlashMode:0];
//                    //  [device setTorchMode:2];
//                    
//                    // torchIsOn = NO;            
//                }
//                // [device unlockForConfiguration];
//            } 
//        }
//        
//    }
//    
//}
//// Find the view that contains the camera controls (buttons)
//
//-(void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    UIViewController *top = [self topViewController];
//    UIView *view = top.view;
//    for (UIView *v1 in view.subviews) {
//        
//        //  ////NSLog(@"%@",v);
//    }
//    fiterBtnTag=0;
//   
//    //    //----- Change image of toolBar ImageView ------
//    //    if (toolBarImage) {
//    //        [toolBarImageView setImage:toolBarImage];
//    //    }
//    
//    //    if (!TARGET_IPHONE_SIMULATOR ) {
//    //        Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
//    //        
//    //        if (captureDeviceClass != nil) {
//    //            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    //            if ([device hasFlash]&& [device hasTorch]){
//    ////                UIViewController *top = [self topViewController];
//    ////                UIView *view = top.view;
//    ////                for (UIView *v1 in view.subviews) {
//    ////                    NSLog(@"v1=%@",v1 );
//    ////                    
//    ////                    NSLog(@"v1 sub=%@",[v1 subviews]);
//    ////                    for (UIView *v2 in v1.subviews) {
//    ////                        
//    ////                        // NSLog(@"height=%f",v2.frame.size.height);
//    ////                        
//    ////                        if (v2.frame.origin.x==20) {
//    ////                            UIButton *btn=(UIButton *)v2;
//    ////                            [btn addTarget:self action:@selector(demo:) forControlEvents:UIControlEventTouchUpInside];
//    ////                            break;
//    ////                        }
//    ////                    }
//    ////                }
//    //
//    //                
//    //            
//    //                
//    ////        UIView *topView = [self flashLayerView:[self topViewController].view];
//    ////                NSLog(@"topView=%@",topView);
//    ////        UIView *buttonFlash = [topView.subviews objectAtIndex:0];
//    ////        
//    ////        UIButton *btn1=[buttonFlash.subviews objectAtIndex:0];
//    ////        [btn1 addTarget:self action:@selector(flashBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    //            }
//    if (!TARGET_IPHONE_SIMULATOR ) {
//        Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
//        
//        if (captureDeviceClass != nil) {
//            //            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//            if ([device hasFlash]&& [device hasTorch]){
//                [device lockForConfiguration:nil];
//                NSLog(@"device.flashMode=%d",device.flashMode);
//                NSLog(@"device.torchMode=%d",device.torchMode);
//                if (deviceFlashMode==0) 
//                {
//                    NSLog(@"AVCaptureTorchModeOff");
//                    [device setFlashMode:AVCaptureFlashModeOff];
//                    
//                    //self.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
//                    [self setCameraFlashMode:-1];
//                    [device setTorchMode:0];
//                    
//                    
//                    //torchIsOn = YES;
//                }else if(deviceFlashMode==1){
//                    NSLog(@"AVCaptureTorchModeOn");
//                    [device setFlashMode:1];
//                    //self.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
//                    [self setCameraFlashMode:1];
//                    [device setTorchMode:2];//here set 1 b'cause open camera view without tourch light
//                    
//                }else {
//                    NSLog(@"AVCaptureTorchModeAuto");
//                    [device setFlashMode:2];
//                    //self.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
//                    [self setCameraFlashMode:0];
//                    [device setTorchMode:2];
//                    
//                    // torchIsOn = NO;            
//                }
//                [device unlockForConfiguration];
//            } 
//        }
//    }
//    
//}
//
//-(void) viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    if (self.sourceType == UIImagePickerControllerSourceTypeCamera) {   
//        //  self.allowsEditing=NO;
//        
//        //        UIImageView *overlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 426)];
//        //        float height=[UIScreen mainScreen].bounds.size.height;
//        //        
//        //        if ( height==568) {
//        //            overlay.frame= CGRectMake(0, 0, 320, 426+88) ;
//        //        }
//        //        overlay.image = [UIImage imageNamed:@"bg_photo_crop.png"];
//        //        overlay.hidden = YES;
//        //        self.cameraOverlayView = overlay;
//        //        [overlay release];
//        
//        UIViewController *top = [self topViewController];
//        UIView *view = top.view;
//        for (UIView *v1 in view.subviews) {
//            
//            for (UIView *v2 in v1.subviews) {
//                
//                // NSLog(@"height=%f",v2.frame.size.height);
//                // if (v2.frame.origin.x==20) {
//                NSLog(@"v2 sub=%@",[v2 subviews]);
//                NSLog(@"v2 =%@",v2 );
//                //                UILabel *lbl=[[v2 subviews] objectAtIndex:2];
//                //                    NSLog(@"lbl.text =%@",lbl.text );
//                //                    lbl.text=@"Eric";
//                //                    UIButton *btn=(UIButton *)v2;
//                //                    [btn addTarget:self action:@selector(demo:) forControlEvents:UIControlEventTouchUpInside];
//                
//                //   }
//                
//                
//                if (v2.frame.size.height == 53 || v2.frame.size.height == 96) {
//                    [v2 addSubview:[self customCameraToolbar:cancelBtnImage library:libraryBtnImage takePhoto:takePhotoBtnImage]];
//                    break;
//                }
//            }
//        }
//    }
//    else if(!isPresent){
//        isPresent=YES;
//        [self performSelector:@selector(libraryButtonPressed:) withObject:nil];
//    }
//}
////Local notification callback----------------------------------
//- (void) receiveTestNotification:(NSNotification *)notification
//{
//    if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionSucceededNotification]){
//        
//        if (fiterBtnTag<16) {
//            for (int i=11; i<16; i++) {
//                UIButton *btn1=(UIButton *)[self.view viewWithTag:i];
//                if ([[btn1 subviews] count]>1) {
//                    UIImageView *img=[[btn1 subviews] objectAtIndex:1];
//                    if (img!=nil) {
//                        [img removeFromSuperview];
//                    } 
//                } 
//            }
//            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Key_PurchasedGroup1"];
//            
//        }else{
//            for (int i=16; i<21; i++) {
//                UIButton *btn1=(UIButton *)[self.view viewWithTag:i];
//                if ([[btn1 subviews] count]>1) {
//                    UIImageView *img=[[btn1 subviews] objectAtIndex:1];
//                    if (img!=nil) {
//                        [img removeFromSuperview];
//                    } 
//                } 
//            }
//            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Key_PurchasedGroup2"];  
//            
//        }
//        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//        [backButton setTitle:@"Back" forState:UIControlStateNormal];
//        filterView.userInteractionEnabled=YES;
//        [indicatorView removeFromSuperview];
//        
//        if (indicatorView!=nil) {
//            
//            [indicatorView release];
//            indicatorView=nil;
//        }
//        
//        
//        
//    }else if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionFailedNotification]){
//        
//        
//        filterView.userInteractionEnabled=YES;
//        [indicatorView removeFromSuperview];
//        
//        if (indicatorView!=nil) {
//            
//            [indicatorView release];
//            indicatorView=nil;
//        }
//        
//        
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Transaction failed. Please try after some time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        
//        
//    }else if([[notification name] isEqualToString:kInAppPurchaseManagerTransactionCancelNotification]){
//        filterView.userInteractionEnabled=YES;
//        [indicatorView removeFromSuperview];
//        
//        if (indicatorView!=nil) {
//            
//            [indicatorView release];
//            indicatorView=nil;
//        }
//        
//    }
//}
////---------------------------------------------------
//
//-(UIView *) customCameraToolbar:(UIImage *)image1 library:(UIImage *)image2 takePhoto:(UIImage *)image3 {
//    
//    if (v!=nil) {
//        
//        [v removeFromSuperview];
//        [v release];
//        v=nil;
//    }
//   
//    v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 53)];
//    float height=[UIScreen mainScreen].bounds.size.height;
//    if (height==568) {
//        v.frame=CGRectMake(0, 0, 320, 96);
//    }
//    //---- To change toolbar Background Image ------
//    if (toolbarBackgroundImage)
//        v.image = toolbarBackgroundImage;
//    else
//        v.image = [UIImage imageNamed:@"bg_capture_tabbar"];
//    
//    v.userInteractionEnabled = YES;
//    
//    cancel = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancel.frame = CGRectMake(10, 10, 43, 30);
//    if (height==568) {
//        cancel.frame = CGRectMake(10, 30, 43, 40);
//    }
//    [cancel addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    library = [UIButton buttonWithType:UIButtonTypeCustom];
//    library.frame = CGRectMake(62, 10, 42, 30);
//    if (height==568) {
//        library.frame = CGRectMake(62, 30, 42, 40);
//    }
//    [library addTarget:self action:@selector(libraryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *takePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
//    takePhoto.frame = CGRectMake(110, 3, 100, 46);
//    if (height==568) {
//        takePhoto.frame = CGRectMake(110, 12, 100, 70);
//    }
//    
//    [takePhoto addTarget:self action:@selector(takePictureButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [takePhoto setAccessibilityLabel:@"Take Photo Button"];
//    //---- To change takePhoto Background Image ------------
//    if (takePhotoBackgroundImage)
//        [takePhoto setBackgroundImage:takePhotoBackgroundImage forState:UIControlStateNormal];
//    else
//        [takePhoto setBackgroundImage:[UIImage imageNamed:@"btn_bg_capture_upload_n.png"] forState:UIControlStateNormal];
//    //---- To change cancel button Image ---------------
//    if (image1)
//        [cancel setBackgroundImage:image1 forState:UIControlStateNormal];
//    else
//        [cancel setBackgroundImage:[UIImage imageNamed:@"btn_capture_cancel_n.png"] forState:UIControlStateNormal];
//    
//    //---- To change library button Image ---------------
//    if (image2)
//        [library setBackgroundImage:image2 forState:UIControlStateNormal];
//    else
//        [library setBackgroundImage:[UIImage imageNamed:@"btn_camRoll_n.png"] forState:UIControlStateNormal];
//    
//    //---- To change takePhoto button Image --------------
//    if (image3)
//        [takePhoto setBackgroundImage:image3 forState:UIControlStateNormal];
//    else
//        [takePhoto setImage:[UIImage imageNamed:@"btn_capture_n.png"] forState:UIControlStateNormal];
//    
//    [v addSubview:cancel];
//    [v addSubview:library];
//    [v addSubview:takePhoto];
//    
//    return v;
//}
//
//-(void) takePictureButtonPressed:(id)sendrd {
//    
//    isTakePictureButtonPressed=NO;
//    self.delegate = self;
//    self.allowsEditing = YES;
//    
//    // ipc.cameraViewTransform = YES
//    cancel.userInteractionEnabled=NO;
//    library.userInteractionEnabled=NO;
//    self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//    
//    //  libraryPicker.sourceType = UIImagePickerControllerSourceTypeCamera; 
//    //self.allowsImageEditing=YES;
//    //    self.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
//    //    self.showsCameraControls=YES;
//    [self takePicture];
//    
//    
//}
//-(void)setFirstTabItemOnView{
//    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [delegate.mainNavigationControler setNavigationBarHidden:YES];
//    delegate.mailTabbarController.selectedIndex=0;
//    [delegate hidecustomTabbarView:NO];   
//}
//-(void) cancelButtonPressed:(id)sender {
//    
//    isPhotocapureComplited=NO;
//    // [self dismissModalViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    if (cameraFromProfile||cameraFromSignUp){
//        cameraFromSignUp = NO;
//        cameraFromProfile = NO;
//    }else {
//        [self performSelector:@selector(setFirstTabItemOnView) withObject:nil afterDelay:0.2f];  
//    }
//}
//
//-(void) libraryButtonPressed:(id)sender {
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//    
//    if (!libraryPicker) {
//        libraryPicker = [[UIImagePickerController alloc] init];
//    }
//    libraryPicker.allowsEditing = YES;
//    
//    libraryPicker.view.backgroundColor = [UIColor blackColor];
//    libraryPicker.topViewController.view.backgroundColor = [UIColor blackColor];
//    libraryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; 
//    libraryPicker.delegate = self;
//    //[self presentModalViewController:libraryPicker animated:YES];
//    
//    [self presentViewController:libraryPicker animated:YES completion:nil];
//   
//}
////- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
////    
////    NSLog(@"cancel@@@@@@@@@@@@@@@@@@@@@@@@@@");
////}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    // NSLog(@" info=%@",info);
//    
//    NSLog(@" info=%@",[info valueForKey:UIImagePickerControllerCropRect]);
//    NSLog(@" info=%@",[picker.view subviews]);
//    
//    CGRect rect=[[info valueForKey:UIImagePickerControllerCropRect] CGRectValue];
//    UIImage *image;
//    if (rect.origin.x<=0 && rect.origin.y==320) {
//        image = [[info objectForKey:@"UIImagePickerControllerOriginalImage"] copy];
//        NSLog(@"User not edited!!!!!!!!!!!") ;
//        
//        
//    }else{
//        image = [[info objectForKey:@"UIImagePickerControllerEditedImage"] copy];
//        NSLog(@"User  edited!!!!!!!!!!!") ;
//    }
//    
//    
//    
//    // UIImage *image = [[info objectForKey:@"UIImagePickerControllerOriginalImage"] copy];
//    // UIImage *image = [[info objectForKey:@"UIImagePickerControllerEditedImage"] copy];
//    
//    originalImage = [image thumbnailImage:640 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
//    // originalImage=[self performSelector:@selector(resizeImage::) withObject:image withObject:@"320"];
//    //originalImageNew=[originalImage copy];
//    
//    [image release];
//    imageView.image=originalImage;
//    //if (picker == libraryPicker) {
//    
//    //---- Set image of Filter view for back and next button --------
//    if(backButtonImageOfFilterView && nextButtonImageOfFilterView) {
//        [self setImagesOfBackAndNextButton:backButtonImageOfFilterView nextImage:nextButtonImageOfFilterView];
//    }else{
//        if(backButtonImageOfFilterView && !nextButtonImageOfFilterView) {
//            [self setImagesOfBackAndNextButton:backButtonImageOfFilterView nextImage:nil];
//        }else{
//            if (!backButtonImageOfFilterView && nextButtonImageOfFilterView) {
//                [self setImagesOfBackAndNextButton:nil nextImage:nextButtonImageOfFilterView];
//            }
//        }
//    }
//    
//    //---- Set background image to Filter view for back and next button --------
//    if (backButtonBackgroundImageOfFilterView && nextButtonBackgroundImageOfFilterView) {
//        [self setBackgroundImagesOfBackAndNextButton:backButtonBackgroundImageOfFilterView nextImage:nextButtonBackgroundImageOfFilterView];
//    }else{
//        if(backButtonBackgroundImageOfFilterView && !nextButtonBackgroundImageOfFilterView) {
//            [self setBackgroundImagesOfBackAndNextButton:backButtonBackgroundImageOfFilterView nextImage:nil];
//        }else{
//            if(!backButtonBackgroundImageOfFilterView && nextButtonBackgroundImageOfFilterView){
//                [self setBackgroundImagesOfBackAndNextButton:nil nextImage:nextButtonBackgroundImageOfFilterView];
//            }
//        }
//    } 
//    
//    
//    //---- Set Title to Filter view for back and next button --------
//    if (backButtonTitleForFilterView && nextButtonTitleForFilterView) {
//        [self setTitleOfBackAndNextButton:backButtonTitleForFilterView nextTitle:nextButtonTitleForFilterView];
//    }else{
//        if (backButtonTitleForFilterView && !nextButtonTitleForFilterView) {
//            [self setTitleOfBackAndNextButton:backButtonTitleForFilterView nextTitle:nil];
//        }else{
//            if (!backButtonTitleForFilterView && nextButtonTitleForFilterView) {
//                [self setTitleOfBackAndNextButton:nil nextTitle:nextButtonTitleForFilterView];
//            }
//        }
//    }
//    
//    
//    //---- Set Toolbar background image to Filter view --------
//    if (toolBarImageOfFilterView) {
//        [self setImageForFilterToolbarImageView:toolBarImageOfFilterView];
//    }
//    //---- Set scroll view background image to Filter view -------- 
//    if (scrollViewBackgroundImageForFilterView) {
//        [self setScrollViewBackgroundImage:scrollViewBackgroundImageForFilterView];
//    }
//    
//    //[self dismissModalViewControllerAnimated:YES];
//    //if (picker == libraryPicker) {
//    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//        UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil, nil);  
//    }else{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    
//    [self performSelector:@selector(configureFilterScrollView)];
//    return;
//    // }
//}
//
//- (void)log:(NSNotification *)note {//_UIImagePickerControllerUserDidCaptureItem
//    
//    // NSLog(@"note=%@",note);
//    if ([note.name isEqualToString:@"_UIScrollViewDidEndDraggingNotification"]) {
//        
//        float height=[[[note.object subviews] objectAtIndex:0] size].height;
//        float width=[[[note.object subviews] objectAtIndex:0] size].width;
//        float scrHeight=[UIScreen mainScreen].bounds.size.height;
//        if (scrHeight==568) {
//            [note.object setContentSize:CGSizeMake(width, height+185)];
//        }else{
//            [note.object setContentSize:CGSizeMake(width, height+105)];
//        }
//        
//    }
//    
//    if ([note.name isEqualToString:@"Recorder_PhotoStillImageSampleBufferReady"]&& !isTakePictureButtonPressed) {
//        
//        NSDictionary *userInfo = note.userInfo;
//        
//        CMSampleBufferRef x = ( CMSampleBufferRef)[userInfo objectForKey:@"Recorder_StillImageSampleBuffer"];
//        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:x];
//        
//        
//        UIImage *image = [[UIImage alloc] initWithData:imageData];
//        if (image!=nil ) {
//            //  imageView.image = [image thumbnailImage:320 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh]; 
//            
//        }
//        
//        [image release]; 
//        
//        
//        
//        //---- Set image of Filter view for back and next button --------
//        if(backButtonImageOfFilterView && nextButtonImageOfFilterView) {
//            [self setImagesOfBackAndNextButton:backButtonImageOfFilterView nextImage:nextButtonImageOfFilterView];
//        }else{
//            if(backButtonImageOfFilterView && !nextButtonImageOfFilterView) {
//                [self setImagesOfBackAndNextButton:backButtonImageOfFilterView nextImage:nil];
//            }else{
//                if (!backButtonImageOfFilterView && nextButtonImageOfFilterView) {
//                    [self setImagesOfBackAndNextButton:nil nextImage:nextButtonImageOfFilterView];
//                }
//            }
//        }
//        //---- Set background image to Filter view for back and next button --------
//        if (backButtonBackgroundImageOfFilterView && nextButtonBackgroundImageOfFilterView) {
//            [self setBackgroundImagesOfBackAndNextButton:backButtonBackgroundImageOfFilterView nextImage:nextButtonBackgroundImageOfFilterView];
//        }else{
//            if(backButtonBackgroundImageOfFilterView && !nextButtonBackgroundImageOfFilterView) {
//                [self setBackgroundImagesOfBackAndNextButton:backButtonBackgroundImageOfFilterView nextImage:nil];
//            }else{
//                if(!backButtonBackgroundImageOfFilterView && nextButtonBackgroundImageOfFilterView){
//                    [self setBackgroundImagesOfBackAndNextButton:nil nextImage:nextButtonBackgroundImageOfFilterView];
//                }
//            }
//        } 
//        //---- Set Title to Filter view for back and next button --------
//        if (backButtonTitleForFilterView && nextButtonTitleForFilterView) {
//            [self setTitleOfBackAndNextButton:backButtonTitleForFilterView nextTitle:nextButtonTitleForFilterView];
//        }else{
//            if (backButtonTitleForFilterView && !nextButtonTitleForFilterView) {
//                [self setTitleOfBackAndNextButton:backButtonTitleForFilterView nextTitle:nil];
//            }else{
//                if (!backButtonTitleForFilterView && nextButtonTitleForFilterView) {
//                    [self setTitleOfBackAndNextButton:nil nextTitle:nextButtonTitleForFilterView];
//                }
//            }
//        }
//        //---- Set Toolbar background image to Filter view --------
//        if (toolBarImageOfFilterView) {
//            [self setImageForFilterToolbarImageView:toolBarImageOfFilterView];
//        }
//        //---- Set scroll view background image to Filter view -------- 
//        if (scrollViewBackgroundImageForFilterView) {
//            [self setScrollViewBackgroundImage:scrollViewBackgroundImageForFilterView];
//        }
//        if (!isTakePictureButtonPressed) {
//            if (v!=nil) {
//                [v removeFromSuperview];
//                [v release];
//                v=nil;
//            }
//            
//            UIView *topView = [self findCamControlsLayerView:self.view];
//            
//            UIView *buttonsBar = [topView.subviews objectAtIndex:0];
//            isTakePictureButtonPressed=YES;
//            
//            UIButton *btn=[buttonsBar.subviews objectAtIndex:0];
//            [btn addTarget:self action:@selector(retakeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            
//        }
//    }
//    
//    
//}
//-(void)retakeBtnAction:(id)sender{
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(log:) name:nil object:nil];
//    
//    UIViewController *top = [self topViewController];
//    UIView *view = top.view;
//    for (UIView *v1 in view.subviews) {
//        for (UIView *v2 in v1.subviews) {
//            NSLog(@"height=%f",v2.frame.size.height);
//            
//            
//            if (v2.frame.size.height == 53 || v2.frame.size.height == 96) {
//                [v2 addSubview:[self customCameraToolbar:cancelBtnImage library:libraryBtnImage takePhoto:takePhotoBtnImage]];
//                break;
//            }
//        }
//    }
//}
//
//
//- (UIView*)findCamControlsLayerView:(UIView*)view {
//    
//    Class cl = [view class];
//    NSString *desc = [cl description];
//    if ([desc compare:@"PLCropOverlayBottomBar"] == NSOrderedSame)
//        return view;
//    
//    for (NSUInteger i = 0; i < [view.subviews count]; i++)
//    {
//        UIView *subView = [view.subviews objectAtIndex:i];
//        subView = [self findCamControlsLayerView:subView];
//        if (subView)
//            return subView;
//    }
//    
//    return nil;
//}
//-(void) setCameraControlsButtonsImage:(UIImage *)cancelImage library:(UIImage *)libraryImage takePhoto:(UIImage *)takePhotoImage {
//    cancelBtnImage    = cancelImage;
//    libraryBtnImage   = libraryImage;
//    takePhotoBtnImage = takePhotoImage;
//}
//
//-(void) setCameraToolbarBackgroundImage:(UIImage *)backgroundImage{
//    
//    toolbarBackgroundImage = backgroundImage;
//}
//
//-(void) setTakePhotoBackgroundImage:(UIImage *)image{
//    
//    takePhotoBackgroundImage = image;
//}
//-(void) setImagesBackAndNextButtonOfFilterView:(UIImage *)back nextImage:(UIImage *)next{
//    
//    backButtonImageOfFilterView = back;
//    nextButtonImageOfFilterView = next;
//}
//-(void) setBackgroundImagesBackAndNextButtonOfFilterClass:(UIImage *)back nextImage:(UIImage *)next{
//    
//    backButtonBackgroundImageOfFilterView = back;
//    nextButtonBackgroundImageOfFilterView = next;
//}
//
//-(void) setTitleOfBackAndNextButtonOfFilterClass:(NSString *)back nextTitle:(NSString *)next{
//    
//    backButtonTitleForFilterView = back;
//    nextButtonTitleForFilterView = next;
//}
//-(void) setImageOfToolbarImageViewOfFilterClass:(UIImage *)image{
//    
//    toolBarImageOfFilterView = image;
//}
//-(void) setScrollViewBackgroundImageOfFilterClass:(UIImage *)image{
//    
//    scrollViewBackgroundImageForFilterView = image;
//}
//
//-(void) setImagesOfBackAndNextButton:(UIImage *)back nextImage:(UIImage *)next{
//    
//    backButtonImage = back;
//    nextButtonImage = next;
//}
//-(void) setBackgroundImagesOfBackAndNextButton:(UIImage *)back nextImage:(UIImage *)next{
//    
//    backButtonBackgroundImage = back;
//    nextButtonBackgroundImage = next;
//}
//-(void) setTitleOfBackAndNextButton:(NSString *)back nextTitle:(NSString *)next{
//    
//    backButtonTitle = back;
//    nextButtonTitle = next;
//}
//
//-(void) setImageForFilterToolbarImageView:(UIImage *)image{
//    toolBarImage = image;
//}
//
//-(void) setScrollViewBackgroundImage:(UIImage *)image{
//    scrollViewBackgroundImage = image;
//}
//
//-(void) configureFilterScrollView {
//    
//    //---- Check filter view when back from filter view --------
//    if (filterView.hidden == YES) {
//        filterView.hidden = NO;
//    }
//    if (filterScrollView!=nil) {
//        for(UIView *filterSubView in [filterScrollView subviews]) {
//            [filterSubView removeFromSuperview];
//        } 
//        [filterScrollView removeFromSuperview];
//        filterScrollView=nil;
//    }
//    
//    
//    //    cancel.userInteractionEnabled=YES;
//    //    library.userInteractionEnabled=YES;
//    
//    NSUInteger numberOfFilters = 20;
//    NSUInteger margin = 11; 
//    
//    // NSArray *lableTitles = [[NSArray alloc] initWithObjects:@"Lomo-fi",@"Amaro",@"Inkwell",@"Valencia",@"X-pro ll",@"Rise",@"Walden",@"Nashville",@"Hudson",@"Sutro",@"Earlybird",@"Brannan",@"Toaster",@"Kelvin",@"Hefe",@"Lo-fi",@"1977", @"Sexy Carrie",@"lien",@"sa9ra",@"Recontre",@"Aidol Simon",@"Juillet",@"Nina Ruby",@"634",@"rbv",@"雅",@"Oscar",@"Sausalito83",@"1978",@"Sunset 19",nil];
//    // NSArray *lableTitles = [[NSArray alloc] initWithObjects:@"Lomo-fi",@"Amaro",@"Valencia",@"X-pro ll",@"Rise",@"Walden",@"Hudson",@"Brannan",@"Kelvin",@"Hefe", @"Sexy Carrie",@"lien",@"sa9ra",@"Recontre",@"Aidol Simon",@"Juillet",@"Nina Ruby",@"634",@"rbv",@"雅",@"Oscar",@"Sausalito83",@"1978",@"Sunset 19",nil];
//    NSArray *lableTitles = [[NSArray alloc] initWithObjects:@"Lomo-fi",@"Amaro",@"Valencia",@"X-pro ll",@"Rise",@"Walden",@"Hudson",@"Brannan",@"Kelvin",@"Hefe", @"Sexy Carrie",@"Lien",@"Aidol Simon",@"Juillet",@"Nina Ruby",@"Sara",@"Oscar",@"Sausalito",@"RBV",@"Sunset",nil];
//    
//    CGRect myImageRectForfilterScrollView = CGRectMake( 0, 332, 321, 94);//0, 342, 321, 84
//    float height=[UIScreen mainScreen].bounds.size.height;
//    
//    if ( height==568) {
//        myImageRectForfilterScrollView = CGRectMake( 0, 420, 321, 94); 
//    }
//    UIImageView *imageViewForfilterScrollView = [[UIImageView alloc] initWithFrame:myImageRectForfilterScrollView];
//    imageViewForfilterScrollView.userInteractionEnabled = YES;
//    //----- Change image of background of scroll view ------
//    if (scrollViewBackgroundImage)
//        [scrollViewBackgroundView setImage:scrollViewBackgroundImage];
//    else
//        [imageViewForfilterScrollView setImage:[UIImage imageNamed:@"bg_filters.png"]];
//    [filterView addSubview:imageViewForfilterScrollView];
//    
//    filterScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 5.0, 320.0, 72.0)];
//    filterScrollView.scrollEnabled = YES;
//    filterScrollView.scrollsToTop = NO;
//    filterScrollView.showsVerticalScrollIndicator = NO;
//    filterScrollView.showsHorizontalScrollIndicator = YES;
//    filterScrollView.alwaysBounceHorizontal = YES;
//    filterScrollView.alwaysBounceVertical = NO;
//    filterScrollView.pagingEnabled = NO;
//    filterScrollView.delaysContentTouches = YES;
//    filterScrollView.canCancelContentTouches = YES;
//    filterScrollView.bouncesZoom = YES;
//    filterScrollView.bounces = YES;
//    filterScrollView.multipleTouchEnabled = YES;
//    filterScrollView.userInteractionEnabled = YES;
//    filterScrollView.backgroundColor = [UIColor clearColor];
//    filterScrollView.contentSize = CGSizeMake((80*numberOfFilters) + 70
//                                              + (margin*2), 72);
//    filterScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 64, 0);
//    
//    [imageViewForfilterScrollView addSubview:filterScrollView];
//    
//    
//    CGRect imageViewFrameForBtn = CGRectMake(0, 415, 320, 65);
//    if (height==568) {
//        imageViewFrameForBtn = CGRectMake(0, 503, 320, 65); 
//    }
//    
//    UIImageView *imageViewForBtn = [[UIImageView alloc]initWithFrame:imageViewFrameForBtn];
//    [imageViewForBtn setImage:[UIImage imageNamed:@"bg_capture_tabbar.png"]];
//    imageViewForBtn.userInteractionEnabled=YES;
//    imageViewForBtn.layer.borderWidth=3.0;
//    imageViewForBtn.layer.borderColor=[UIColor darkGrayColor].CGColor;
//    
//    [filterView addSubview:imageViewForBtn];
//    
//    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    //----- Change background image of back button ------
//    if (backButtonBackgroundImage) 
//        [backButton setBackgroundImage:backButtonBackgroundImage forState:UIControlStateNormal];
//    else
//        [backButton setBackgroundImage:[UIImage imageNamed:@"btn_navbar_item_n@2x.png"] forState:UIControlStateNormal];
//    //----- Change image of back button ------
//    if (backButtonImage) {
//        [backButton setImage:backButtonImage forState:UIControlStateNormal];
//    }
//    
//    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0] ];
//    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];   
//    backButton.userInteractionEnabled=YES;
//    //----- Change title of back button ------
//    if (backButtonTitle)
//        [backButton setTitle:backButtonTitle forState:UIControlStateNormal];
//    else
//        [backButton setTitle:@"Back" forState:UIControlStateNormal];
//    backButton.frame = CGRectMake(5, 11, 63, 33);
//    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [imageViewForBtn addSubview:backButton];
//    
//    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    //----- Change image of next button ------
//    if (nextButtonImage) {
//        [nextButton setImage:nextButtonImage forState:UIControlStateNormal];
//    }
//    
//    //----- Change background image of next button -------
//    if (nextButtonBackgroundImage) {
//        [nextButton setBackgroundImage:nextButtonBackgroundImage forState:UIControlStateNormal];
//    }else
//        [nextButton setBackgroundImage:[UIImage imageNamed:@"btn_navbar_item_n@2x.png"] forState:UIControlStateNormal];
//    
//    [nextButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0]];
//    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];   
//    nextButton.userInteractionEnabled=YES;
//    //----- Change title of next button ------
//    if (nextButtonTitle)
//        [nextButton setTitle:nextButtonTitle forState:UIControlStateNormal];
//    else
//        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//    nextButton.frame = CGRectMake(250, 11, 65, 33);
//    [nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [imageViewForBtn addSubview:nextButton];
//    
//    
//    //************************ button for brightness ********************
//    
//    btnBrightness=[[UIButton alloc] initWithFrame:CGRectMake(85, 11, 33, 33)];
//    // [btnBrightness setBackgroundColor:[UIColor yellowColor]];
//    
//    [btnBrightness setImage:[UIImage imageNamed:@"contrast_grey.png"] forState:UIControlStateNormal];
//    [btnBrightness setTitle:@"contrast_grey.png" forState:UIControlStateNormal];
//    
//    btnBrightness.tag=21;
//    [btnBrightness addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [imageViewForBtn addSubview:btnBrightness];
//    
//    UILabel *filterTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 15, 47, 21)];
//    filterTitle.text = @"Filters";
//    filterTitle.textColor = [UIColor whiteColor];
//    filterTitle.backgroundColor = [UIColor clearColor];
//    [filterTitle setFont:[UIFont fontWithName:@"Helvetica" size:17.0]];
//    [imageViewForBtn addSubview:filterTitle];
//    for (int c=0; c<(numberOfFilters + 1); c++) {
//        
//        if (c==0|| c==10 || c==15) {
//            
//            if(c==10) {
//                UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(888, 3.0, 395, 80)];
//                lbl.layer.cornerRadius=3.0f;
//                
//                lbl.backgroundColor=[UIColor lightGrayColor];
//                [filterScrollView addSubview:lbl]; 
//            }else if(c==15){
//                UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(1287, 3.0, 398, 80)];
//                lbl.backgroundColor=[UIColor lightGrayColor];
//                lbl.layer.cornerRadius=3.0f;
//                [filterScrollView addSubview:lbl]; 
//            }
//        }
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = c;
//        button.frame = CGRectMake(80*c + margin, 5, 70, 55);
//        [button.layer setBorderWidth:5];
//        [button.layer setCornerRadius:2];
//        button.layer.borderColor=[UIColor darkGrayColor].CGColor;
//        
//        [button addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [filterScrollView addSubview:button];
//        
//        // [button setBackgroundColor:[UIColor redColor]];
//        if (c == 0) {
//            UIImageView *btnImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 55)];
//            btnImageView.image=[UIImage imageNamed:@"filter0.png"];
//            // Create the path (with only the all corner rounded)
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btnImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(12.0, 5.0)];
//            // Create the shape layer and set its path
//            CAShapeLayer *maskLayer = [CAShapeLayer layer];
//            maskLayer.frame = btnImageView.bounds;
//            maskLayer.path = maskPath.CGPath;
//            
//            // Set the newly created shape layer as the mask for the image view's layer
//            btnImageView.layer.mask = maskLayer;   
//            
//            [button addSubview:btnImageView];
//            // [button setBackgroundImage:thumb forState:UIControlStateNormal];
//        }else {
//            UIImageView *btnImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 55)];
//            NSString *strFilterName=[NSString stringWithFormat:@"filter%d.png",c];
//            btnImageView.image=[UIImage imageNamed:strFilterName];
//            // Create the path (with only the all corner rounded)
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btnImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(12.0, 5.0)];
//            // Create the shape layer and set its path
//            CAShapeLayer *maskLayer = [CAShapeLayer layer];
//            maskLayer.frame = btnImageView.bounds;
//            maskLayer.path = maskPath.CGPath;
//            
//            // Set the newly created shape layer as the mask for the image view's layer
//            btnImageView.layer.mask = maskLayer;   
//            
//            [button addSubview:btnImageView];
//            
//        }
//        
//        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(80*c + margin, 13+45, 70, 15)];
//        l.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
//        l.textColor = [UIColor whiteColor];
//        l.textColor = [UIColor colorWithRed:177.0 green:173.0 blue:176.0 alpha:255.0];
//        l.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:255.0];
//        l.shadowOffset = CGSizeMake(0, -1);
//        l.backgroundColor = [UIColor clearColor];
//        
//        if (c > 0 && c < numberOfFilters+1) {
//            l.text = [lableTitles objectAtIndex:c-1];
//        }else{ 
//            l.text = @"Original";
//        }
//        l.textAlignment = UITextAlignmentCenter;
//        [filterScrollView addSubview:l];
//        
//        // show lock image with button image
//        if (c>10) {
//            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"Key_PurchasedGroup1"]==nil && c<16){
//                UIImageView *imgViewDollar=[[UIImageView alloc] initWithFrame:CGRectMake(52, 35, 20, 20)];
//                //imgViewDollar.tag=c;
//                [imgViewDollar setImage:[UIImage imageNamed:@"lock_filter.png"]];
//                [button addSubview:imgViewDollar];
//                
//            }else if([[NSUserDefaults standardUserDefaults] valueForKey:@"Key_PurchasedGroup2"]==nil){
//                UIImageView *imgViewDollar=[[UIImageView alloc] initWithFrame:CGRectMake(52, 35, 20, 20)];
//                //imgViewDollar.tag=c;
//                [imgViewDollar setImage:[UIImage imageNamed:@"lock_filter.png"]];
//                [button addSubview:imgViewDollar]; 
//            }
//        }
//        
//        
//    } 
//}
//
//- (IBAction)backButtonPressed:(id)sender {
//    UIButton *btn1=(UIButton *)sender;
//    if ([btn1.titleLabel.text isEqualToString:@"Cancel"]) {
//        //        if ([btnBrightness.titleLabel.text isEqualToString:@"contrast.png"]) {
//        //            if ([originalImageNew retainCount]>1) {
//        //                [originalImageNew release];
//        //            }
//        //            originalImageNew=[imageView.image copy];
//        //            [self setBrightness];
//        //        }else{
//        //            imageView.image=oringialImage;
//        //
//        //        }
//        imageView.image=oringialImage;
//        [btn1 setTitle:@"Back" forState:UIControlStateNormal];
//        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//        return;
//    }
//    
//    //---- Set filter view hidden when open camera again ----------
//    if (filterView.hidden == NO) 
//        filterView.hidden = YES;
//    else
//        filterView.hidden = NO;
//    //------ Call these methods for when come back from filter view to camera view --------
//    oringialImage = nil;
//    isBrightButttonEnabled=NO;
//    [self init];
//    [self viewDidLoad];
//    [self performSelector:@selector(callViewWillAppear) withObject:nil afterDelay:0.1f];
//    //    [self viewWillAppear:YES];
//    //    [self viewDidAppear:YES];
//}
//-(void)callViewWillAppear{
//    
//    [self viewWillAppear:YES];
//    [self viewDidAppear:YES];
//    
//}
//- (void) filterButtonPressed:(UIButton *)sender {
//    //[self performSelector:@selector(showHUD)];
//    if (!oringialImage) {
//        //  oringialImage= [[imageView.image thumbnailImage:640 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationMedium] copy];//[imageView.image copy];
//        
//        oringialImage=[imageView.image copy];
//        
//    }
//    if (sender.tag == 0) {
//        imageView.image = oringialImage;
//        if ([btnBrightness.titleLabel.text isEqualToString:@"contrast.png"]) {
//            if ([originalImageNew retainCount]>1) {
//                [originalImageNew release];
//            }
//            originalImageNew=[imageView.image copy];
//            [self setBrightness];
//        }
//        
//        
//        //        [btnBrightness setImage:[UIImage imageNamed:@"contrast_grey.png"] forState:UIControlStateNormal];
//        //        [btnBrightness setTitle:@"contrast_grey.png" forState:UIControlStateNormal];
//        isBrightButttonEnabled=NO;
//        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//        [backButton setTitle:@"Back" forState:UIControlStateNormal];
//        // [self.imageView setImage:originalImage];
//    }else if(sender.tag==21){
//        [self performSelector:@selector(callFilter:) withObject:sender afterDelay:0.1];
//    }else {
//        
//        //        [btnBrightness setImage:[UIImage imageNamed:@"contrast_grey.png"] forState:UIControlStateNormal];
//        //        [btnBrightness setTitle:@"contrast_grey.png" forState:UIControlStateNormal];
//        
//        if (indicatorView==nil) {
//            indicatorView=[[UIView alloc] initWithFrame:CGRectMake(130, 160, 60, 60)];
//            indicatorView.layer.cornerRadius=5;
//            indicatorView.alpha=0.8;
//            [indicatorView setBackgroundColor:[UIColor blackColor]];
//            UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            [indicator setFrame:CGRectMake(15, 15, 30, 30)];
//            [indicator startAnimating];
//            [indicatorView addSubview:indicator];
//            [indicator release];
//            [filterView addSubview:indicatorView];  
//        }
//        
//        filterView.userInteractionEnabled=NO;
//        fiterBtnTag=sender.tag;
//        if (sender.tag>10){
//            
//            if ([[Reachability sharedReachability] internetConnectionStatus]==NotReachable) {
//                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Internet connection not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alertView show];
//                [alertView release];
//                return;
//            }
//            
//            if (sender.tag>15) {
//                if ([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Key_PurchasedGroup2"]] isEqualToString:@"(null)"] || [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Key_PurchasedGroup2"]] ==nil) {
//                    
//                    [nextButton setTitle:@"Purchase" forState:UIControlStateNormal];
//                    [backButton setTitle:@"Cancel" forState:UIControlStateNormal];
//                    [self performSelector:@selector(callFilter:) withObject:sender afterDelay:0.1];
//                    
//                }else{
//                    [self performSelector:@selector(callFilter:) withObject:sender afterDelay:0.1];
//                }
//                
//            }else{
//                if ([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Key_PurchasedGroup1"]] isEqualToString:@"(null)"] || [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Key_PurchasedGroup1"]] ==nil){
//                    [nextButton setTitle:@"Purchase" forState:UIControlStateNormal];
//                    [backButton setTitle:@"Cancel" forState:UIControlStateNormal];
//                    [self performSelector:@selector(callFilter:) withObject:sender afterDelay:0.1];
//                    
//                }else{
//                    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//                    [backButton setTitle:@"Back" forState:UIControlStateNormal];
//                    [self performSelector:@selector(callFilter:) withObject:sender afterDelay:0.1];
//                }
//            }
//            
//        }else{
//            [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//            [backButton setTitle:@"Back" forState:UIControlStateNormal];
//            [self performSelector:@selector(callFilter:) withObject:sender afterDelay:0.1];
//        }
//    }
//    
//}
//
//-(void)callFilter:(UIButton *)sender{
//    
//    if (sender==nil) {
//        if ([nextButton.titleLabel.text isEqualToString:@"Purchase"]) {
//            
//            imageView.image=[TVImageFilterController filteredImageWithImage:oringialImage filter:sender.tag - 1];
//            
//            if ([btnBrightness.titleLabel.text isEqualToString:@"contrast.png"]) {
//                if ([originalImageNew retainCount]>1) {
//                    [originalImageNew release];
//                }
//                originalImageNew=[imageView.image copy];
//                [self setBrightness];
//            }
//            
//            
//            
//            
//        }else{
//            imageView.image = [TVImageFilterController filteredImageWithImage:originalImage filter:fiterBtnTag- 1]; 
//            if ([btnBrightness.titleLabel.text isEqualToString:@"contrast.png"]) {
//                if ([originalImageNew retainCount]>1) {
//                    [originalImageNew release];
//                }
//                originalImageNew=[imageView.image copy];
//                [self setBrightness];
//            }
//            
//        }
//        isBrightButttonEnabled=NO;
//    }else{
//        
//        if (sender.tag==21 ) {
//            
//            //   if (!isBrightButttonEnabled) {
//            if([sender.titleLabel.text isEqualToString:@"contrast.png"]){
//                [sender setImage:[UIImage imageNamed:@"contrast_grey.png"] forState:UIControlStateNormal];
//                [sender setTitle:@"contrast_grey.png" forState:UIControlStateNormal];
//                imageView.image = originalImageNew;
//            }else{
//                [sender setImage:[UIImage imageNamed:@"contrast.png"] forState:UIControlStateNormal];  
//                [sender setTitle:@"contrast.png" forState:UIControlStateNormal];
//                if ([originalImageNew retainCount]>1) {
//                    [originalImageNew release];
//                }
//                originalImageNew=[imageView.image copy];
//                [self setBrightness];
//            }
//            isBrightButttonEnabled=YES;
//            
//            
//            // imageView.image = [TVImageFilterController filteredImageWithImage:imageView.image filter:sender.tag - 1];
//            
//            //[imageView setImage:[self imageWithBrightness]];
//            //            }else{
//            //                
//            //                if([sender.titleLabel.text isEqualToString:@"contrast.png"]){
//            //                    [sender setImage:[UIImage imageNamed:@"contrast_grey.png"] forState:UIControlStateNormal];
//            //                    [sender setTitle:@"contrast_grey.png" forState:UIControlStateNormal];
//            //                }else{
//            //                    [sender setImage:[UIImage imageNamed:@"contrast.png"] forState:UIControlStateNormal];  
//            //                    [sender setTitle:@"contrast.png" forState:UIControlStateNormal];
//            //                }
//            //                
//            //                isBrightButttonEnabled=NO;
//            //                imageView.image = originalImageNew;
//            //                
//            //            }
//        }else{
//            if ([nextButton.titleLabel.text isEqualToString:@"Purchase"]) {
//                
//                
//                imageView.image=[TVImageFilterController filteredImageWithImage:oringialImage filter:sender.tag - 1];
//                
//                if ([btnBrightness.titleLabel.text isEqualToString:@"contrast.png"]) {
//                    if ([originalImageNew retainCount]>1) {
//                        [originalImageNew release];
//                    }
//                    originalImageNew=[imageView.image copy];
//                    [self setBrightness];
//                }
//                
//            }else{
//                imageView.image = [TVImageFilterController filteredImageWithImage:oringialImage filter:sender.tag - 1]; 
//                if ([btnBrightness.titleLabel.text isEqualToString:@"contrast.png"]) {
//                    if ([originalImageNew retainCount]>1) {
//                        [originalImageNew release];
//                    }
//                    originalImageNew=[imageView.image copy];
//                    [self setBrightness];
//                }
//            }
//            
//            isBrightButttonEnabled=NO;
//        }
//    }
//    
//    filterView.userInteractionEnabled=YES;
//    [indicatorView removeFromSuperview];
//    
//    if (indicatorView!=nil){
//        
//        [indicatorView release];
//        indicatorView=nil;
//    }
//}
//
//- (void)nextButtonPressed:(id)sender {
//    
//    UIButton *btn=(UIButton *)sender;
//    if ([btn.titleLabel.text isEqualToString:@"Purchase"]) {
//        
//        if (indicatorView==nil) {
//            indicatorView=[[UIView alloc] initWithFrame:CGRectMake(130, 160, 60, 60)];
//            indicatorView.layer.cornerRadius=5;
//            indicatorView.alpha=0.8;
//            [indicatorView setBackgroundColor:[UIColor blackColor]];
//            UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            [indicator setFrame:CGRectMake(15, 15, 30, 30)];
//            [indicator startAnimating];
//            [indicatorView addSubview:indicator];
//            [indicator release];
//            [filterView addSubview:indicatorView];  
//        }
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(receiveTestNotification:) 
//                                                     name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(receiveTestNotification:) 
//                                                     name:kInAppPurchaseManagerTransactionFailedNotification
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(receiveTestNotification:) 
//                                                     name:kInAppPurchaseManagerTransactionCancelNotification
//                                                   object:nil];
//        
//        
//        filterView.userInteractionEnabled=NO;
//        
//        if (fiterBtnTag>15) {
//            
//            [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.foodiedomain.foodie.ProductGroup2"];   
//        }else{
//            [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.foodiedomain.foodie.ProductGroup1"];    
//        }
//        
////        if (fiterBtnTag>15) {
////            
////            [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.GrubfulDomain.GrubfulFilterGroup2"];   
////        }else{
////            [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.GrubfulDomain.GrubfulFilterGroup1"];    
////        }
//
//        
//        return;
//    }
//    if (cameraFromSignUp || cameraFromProfile) {
//        cameraFromProfile = NO;
//        cameraFromSignUp = NO;
//    }else if (nextButtonFlag == NO) {
//        nextButtonFlag = YES;
//    }
//    photo =[imageView.image thumbnailImage:640 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh]; 
//    //[self performSelector:@selector(resizeImage::) withObject:imageView.image withObject:@"640"];
//    isBrightButttonEnabled=NO;
//    //[self dismissModalViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
//-(void)setBrightness{
//    //    UIImage *sourceImage = imageView.image;
//    //    
//    //    CIContext *context = [CIContext contextWithOptions:nil];
//    //    CIFilter *filter= [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
//    //    
//    //    CIImage *inputImage = [[[CIImage alloc] initWithImage:sourceImage] autorelease];
//    //    
//    //    [filter setValue:inputImage forKey:@"inputImage"];
//    //    [filter setValue:[NSNumber numberWithFloat:0.5f] forKey:@"inputShadowAmount"];
//    //    
//    //    return [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
//    
//    
//    CIImage *inputImage = [[CIImage alloc] initWithImage:imageView.image];
//    
//    CIFilter *brightnesContrastFilter = [CIFilter filterWithName:@"CIColorControls"];
//    NSLog(@"brightnesContrastFilter=%@",brightnesContrastFilter );
//    NSString *strInputContrast=[NSString stringWithFormat:@"%@",[brightnesContrastFilter valueForKey:@"inputContrast"]];
//    NSString *strInputBrightness=[NSString stringWithFormat:@"%@",[brightnesContrastFilter valueForKey:@"inputBrightness"]];
//    
//    [brightnesContrastFilter setDefaults];
//    [brightnesContrastFilter setValue: inputImage forKey: @"inputImage"];
//    
//    float brightness=0.5-[strInputBrightness floatValue];
//    float contrast=3.0-[strInputContrast floatValue];
//    
//    NSLog(@"brightness=%f  contrast=%f ",brightness ,contrast);
//    //[brightnesContrastFilter setValue: [NSNumber numberWithFloat:1.5f] 
//    //          forKey:@"inputSaturation"];
//    [brightnesContrastFilter setValue: [NSNumber numberWithFloat:brightness]
//                               forKey:@"inputBrightness"];
//    
//    [brightnesContrastFilter setValue: [NSNumber numberWithFloat:contrast] 
//                               forKey:@"inputContrast"];
//    
//    CIImage *outputImage = [brightnesContrastFilter valueForKey: @"outputImage"];
//    
//    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    UIImage *finalImage=[UIImage imageWithCGImage:[context 
//                                                   createCGImage:outputImage 
//                                                   fromRect:outputImage.extent]];
//    
//    if (finalImage!=nil) {
//        imageView.image=finalImage;  
//    }else{
//        imageView.image=originalImage;
//        [btnBrightness setImage:[UIImage imageNamed:@"contrast_grey.png"] forState:UIControlStateNormal];
//        [btnBrightness setTitle:@"contrast_grey.png" forState:UIControlStateNormal];
//        isBrightButttonEnabled=NO; 
//    }
//    
//    
//    [inputImage release];
//    
//}
//- (UIImage*) imageWithBrightness {
//    
//    float brightnessFactor=0.5f;
//    
//    CGImageRef imgRef = [imageView.image CGImage];
//    
//    size_t width = CGImageGetWidth(imgRef);
//    size_t height = CGImageGetHeight(imgRef);
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    size_t bitsPerComponent = 8;
//    size_t bytesPerPixel = 4;
//    size_t bytesPerRow = bytesPerPixel * width;
//    size_t totalBytes = bytesPerRow * height;
//    
//    //Allocate Image space
//    uint8_t* rawData = malloc(totalBytes);
//    
//    //Create Bitmap of same size
//    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//    
//    //Draw our image to the context
//    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
//    
//    //Perform Brightness Manipulation
//    for ( int i = 0; i < totalBytes; i += 4 ) {
//        
//        uint8_t* red = rawData + i; 
//        uint8_t* green = rawData + (i + 1); 
//        uint8_t* blue = rawData + (i + 2); 
//        
//        *red = MIN(255,MAX(0,roundf(*red + (*red * brightnessFactor))));
//        *green = MIN(255,MAX(0,roundf(*green + (*green * brightnessFactor))));
//        *blue = MIN(255,MAX(0,roundf(*blue + (*blue * brightnessFactor))));
//        
//    }
//    
//    //Create Image
//    CGImageRef newImg = CGBitmapContextCreateImage(context);
//    
//    //Release Created Data Structs
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//    free(rawData);
//    
//    //Create UIImage struct around image
//    UIImage* image = [UIImage imageWithCGImage:newImg];
//    if (image==nil) {
//        NSLog(@"image nil!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    }
//    //Release our hold on the image
//    CGImageRelease(newImg);
//    
//    //return new image!
//    return image;
//    
//}
//
//@end
