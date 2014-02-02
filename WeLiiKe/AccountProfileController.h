//
//  AccountProfileController.h
//  WeLiiKe
//
//  Created by techvalens on 09/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeLiikeWebService.h"
#import "AsyncImageViewSmall.h"
#import "HudView.h"
#import "WeliikeCropViewController.h"

@interface AccountProfileController : UIViewController<UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,croppedImageDelegate>{
    
    UIButton *lblForGender,*lblForBirthday;
    UIScrollView *scrollViewForAccountDetail;
    UIDatePicker *datePicker;
    UIToolbar *toolBarForPicker;
    UIPickerView *pickerForGender;
    NSArray *arrayForGender;
    UIImage *imgForProfilePic;
    AsyncImageViewSmall *coverImg;
    AsyncImageViewSmall *profileImage;
    int checkForPicture;
    UITextField *txtForName,*txtForWebSite,*txtForBio,*txtForEmail,*txtForPhone;
    UISwitch *switchForSave,*switchForPrivate,*switchForSaveGeo;
    HudView *aHUD;
}

@property(nonatomic,retain)IBOutlet UISwitch *switchForSave,*switchForPrivate,*switchForSaveGeo;
@property(nonatomic,retain)IBOutlet UITextField *txtForName,*txtForWebSite,*txtForBio,*txtForEmail,*txtForPhone;
@property(nonatomic,retain)IBOutlet UIToolbar *toolBarForPicker;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollViewForAccountDetail;
@property(nonatomic,retain)IBOutlet UIButton *lblForGender,*lblForBirthday;
- (IBAction)switchOnOff:(id)sender;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDonePicker:(id)sender;
-(IBAction)actionOnDate:(id)sender;
-(IBAction)actionOnGender:(id)sender;
-(IBAction)actionOnSwitch:(id)sender;
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType;
//-(IBAction)actionOnCamera:(id)sender;
-(IBAction)actionOnSubmit:(id)sender;
-(NSString *)Base64Encode:(NSData *)theData;
@end