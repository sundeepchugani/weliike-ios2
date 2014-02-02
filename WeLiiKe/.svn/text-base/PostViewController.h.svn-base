//
//  PostViewController.h
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CameraViewController.h"
#import "CustomStarRank.h"
#import "HudView.h"
#import "WeLiikeWebService.h"
#import "ShareSettingViewController.h"
#import "SearchResultEntity.h"
#import "addEnityViewController.h"
#import "UIImage+Resize.h"
#import "FBConnect.h"


@interface PostViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,FBRequestDelegate,FBDialogDelegate,UIScrollViewDelegate>{

    UIImageView *imgView;
    UITextView *txtView;
    UITextField *txtField;
    UIImageView *btnForTakePicture;
    CustomStarRank *customRank;
    HudView *aHUD;
    UIButton *btnForSelecte;
    UITableView *tableViewForSearchEntity;
    NSString *strForSeletedAppID,*strForSubcategoryName;
    NSString *strForAddress,*strForCity;
    NSMutableArray *arrayForEntitySearch;
    int selectedCategory;
    UILabel *lblForWrite;
    UIScrollView *scrollViewTakePhoto;
    NSString *strForLatFourSqaure,*strForLongFourSqaure;
    BOOL checkKeyBoard;
    UIScrollView *scrollViewForPost;
}
@property(nonatomic,retain)IBOutlet UIScrollView *scrollViewForPost;
@property(nonatomic,retain)IBOutlet UILabel *lblForWrite;
@property(nonatomic,retain)NSString *strForAddress,*strForSubcategoryName,*strForCity;
@property(nonatomic,retain)NSString *strForSeletedAppID;
@property(nonatomic,retain)UITableView *tableViewForSearchEntity;
@property(nonatomic,retain)IBOutlet UIButton *btnForSelecte;
@property(nonatomic,retain)IBOutlet  UITextField *txtField;
@property(nonatomic,retain)IBOutlet UIImageView *imgView;
@property(nonatomic,retain)IBOutlet UITextView *txtView;

@property (strong, nonatomic) FBRequestConnection *requestConnection;

-(IBAction)actionOnSelectCategory:(id)sender;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDone:(id)sender;
-(IBAction)actionOnCaption:(id)sender;
-(IBAction)actionOnShare:(id)sender;
-(NSString *)Base64Encode:(NSData *)theData;
UIImage* imageFromView(UIImage* srcImage, CGRect* rect);
//- (void)showAlert:(NSString *)message result:(id)result error:(NSError *)error;
@end
