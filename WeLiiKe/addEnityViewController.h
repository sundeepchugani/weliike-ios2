//
//  addEnityViewController.h
//  WeLiiKe
//
//  Created by techvalens on 01/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudView.h"

@interface addEnityViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    UITextField *txtFieldForName;
    UIImageView *imgView;
    HudView *aHUD;
    NSString *strForMasterCate;
    
}
@property(nonatomic,retain)NSString *strForMasterCate;
@property(nonatomic,retain)IBOutlet UITextField *txtFieldForName;
@property(nonatomic,retain)IBOutlet UIImageView *imgView;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDone:(id)sender;
-(IBAction)actionOnImage:(id)sender;
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType;
-(NSString *)Base64Encode:(NSData *)theData;

@end
