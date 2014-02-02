//
//  AddGroupViewController.h
//  WeLiiKe
//
//  Created by techvalens on 13/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowAndFollowingCell.h"
#import "UIImage+Resize.h"
#import "AsyncImageViewSmall.h"
#import "HudView.h"

@interface AddGroupViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{

    UITableView *tableForGroupSetting;
    UITextField *txtForGroupName;
    NSMutableArray *arrayForServerData;
    AsyncImageViewSmall *btnForGroupImage;
    UISwitch *swActive;
    NSString *strForCheckEdit;
    NSMutableDictionary *dicForGroupInfo;
    HudView *aHUD;
    int page;
    NSString *strForUserID;
}
@property(nonatomic,retain)NSString *strForUserID;
@property(nonatomic,retain)NSMutableDictionary *dicForGroupInfo;
@property(nonatomic,retain)NSString *strForCheckEdit;
@property(nonatomic,retain) UISwitch *swActive;
@property(nonatomic,retain)IBOutlet UITextField *txtForGroupName;
@property(nonatomic,retain)IBOutlet AsyncImageViewSmall *btnForGroupImage;
@property(nonatomic,retain)IBOutlet UITableView *tableForGroupSetting;

-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnGroupImage:(id)sender;
-(NSString *)Base64Encode:(NSData *)theData;
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType;
@end
