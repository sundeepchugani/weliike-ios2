//
//  ApplyFilterViewController.m
//  MakaMaka
//
//  Created by techvalens on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplyFilterViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "CameraViewController.h"
#import "TVImageFilterController.h"
#import "UIImage+Resize.h"
#import "AppDelegate.h"

BOOL openPicker;
int productID;

extern UIImage *imageFinal;
//extern BOOL saveButtonPressed;
extern int selectedIndex;
#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"

@implementation ApplyFilterViewController
@synthesize imgView,imageOrg,scrollViewForFilter,btnForCancel,btnForNext,image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) killHUD
{
	if(aHUD != nil ){
		
		[aHUD.loadingView removeFromSuperview];
		[aHUD setUserInteractionEnabledForSuperview:self.view.superview];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		//[aHUD release];
        aHUD = nil;
		[self.view setUserInteractionEnabled:YES];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		
	}
}

- (void) showHUD
{
	if(aHUD == nil)
	{
		aHUD = [[HudView alloc]init];
		[aHUD setUserInteractionEnabledForSuperview:self.view.superview];
		//[aHUD loadingViewInView:self.view.superview text:@"Updating..."];
		[self.view setUserInteractionEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)makeScrollView{

    NSUInteger numberOfFilters = 17;
    NSUInteger margin = 11; 

    scrollViewForFilter.contentSize = CGSizeMake((60*numberOfFilters) + 45 + (margin*2), scrollViewForFilter.bounds.size.height);
    //[scrollViewForFilter setContentSize:CGSizeMake(1220, 90)];
    scrollViewForFilter.showsHorizontalScrollIndicator=NO;
    imgView.image = imageOrg;
    //NSArray *array = [[NSArray alloc] initWithObjects:@"Normal",@"Sexy Carrie",@"lien",@"sa9ra",@"Recontre",@"Aidol Simon",@"Juillet",@"Nina Ruby",@"634",@"rbv",@"雅",@"Oscar",@"Sausalito83",@"1978",@"Sunset 19", nil];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Lamo-fi",@"Amaro",@"Inkwell",@"Valencia",@"X-pro ll",@"Rise",@"Walden",@"Nashville",@"Hudson",@"Sutro",@"Earlybird",@"Brannan",@"Toaster",@"Kelvin",@"Hefe",@"Lo-fi",@"1977", nil];
    
    UIImage *thumb = [imageOrg thumbnailImage:45 transparentBorder:0 cornerRadius:5 interpolationQuality:kCGInterpolationMedium];
    // [imageOrg thumbnailImage:45 transparentBorder:0 cornerRadius:5 interpolationQuality:kCGInterpolationMedium];
    
    int width=5;
    for (int i=0; i<[array count]; i++) {
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(width, 5, 70, 70)];
        if (i == 0) {
            [btn setImage:thumb forState:UIControlStateNormal];
        }
        else {
            [btn setImage:[TVImageFilterController filteredImageWithImage:thumb filter:i-1] forState:UIControlStateNormal];
        }

        [btn addTarget:self action:@selector(callFilter:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [scrollViewForFilter addSubview:btn];
        
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(width, 55, 70, 30)];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [lbl setTextAlignment:UITextAlignmentCenter];
        [lbl setTextColor:[UIColor darkGrayColor]];
        [lbl setText:[array objectAtIndex:i]];
        
        lbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
        lbl.textColor = [UIColor whiteColor];
        lbl.textColor = [UIColor colorWithRed:177.0 green:173.0 blue:176.0 alpha:255.0];
        lbl.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:255.0];
        lbl.shadowOffset = CGSizeMake(0, -1);
        lbl.backgroundColor = [UIColor clearColor];
        
        [scrollViewForFilter addSubview:lbl];
        width=width+63;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self makeTabBarHidden:YES];
    
    

//    if (saveButtonPressed==YES) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self makeTabBarHidden:NO];

}
-(void)callFilter:(UIButton *)sender{
    
    if (sender.tag == 0) {
        imgView.image = imageOrg;
    }
    else {
        
        indicatorView=[[UIView alloc] initWithFrame:CGRectMake(130, 160, 60, 60)];
        indicatorView.layer.cornerRadius=5;
        indicatorView.alpha=0.8;
        [indicatorView setBackgroundColor:[UIColor blackColor]];
        UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setFrame:CGRectMake(15, 15, 30, 30)];
        [indicator startAnimating];
        [indicatorView addSubview:indicator];
        [self.view addSubview:indicatorView];
        self.view.userInteractionEnabled=NO;
        scrollViewForFilter.userInteractionEnabled=NO;
        btnForCancel.userInteractionEnabled=NO;
        btnForNext.userInteractionEnabled=NO;
        [self performSelector:@selector(callFilterFrom:) withObject:sender afterDelay:0.5];

        }
}
-(void)callFilterFrom:(UIButton *)tag{
    
    imgView.image=[TVImageFilterController filteredImageWithImage:imageOrg filter:tag.tag-1];
    [indicatorView removeFromSuperview];
    [self performSelector:@selector(enable) withObject:nil afterDelay:0.5];

}
//-(void)viewWasTouched:(WETouchableView *)view{
//
//    [self performSelector:@selector(enable) withObject:nil afterDelay:0.5];
//     imgView.image = imageOrg;
//    if (viewForCell != nil) {
//        
//        
//        for (NSInteger ko=0; ko<[[viewForCell subviews] count]; ko++){
//            id l=[[viewForCell subviews] objectAtIndex:ko];
//            [l removeFromSuperview];
//        }
//        [viewForCell removeFromSuperview];
//        [backgroundView removeFromSuperview];
//        backgroundView = nil;
//    }
//    
//    
//}
//-(void)actionOnPurchase:(id)sender{
//    
//    UIButton *btn=(UIButton *)sender;
//    int index=btn.tag;
//    
//    if (index==9) {
//        productID=9;
//        [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.Makamaka.MakaMaka.ProductConsumableOne"];
//    }else if(index==10){
//        productID=10;
//        [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.Makamaka.MakaMaka.ProductConsumableTwo"];
//    }else if(index==11){
//        productID=11;
//        [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.Makamaka.MakaMaka.ProductConsumableThreeee"];
//    }else if(index==12){
//        productID=12;
//        [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.Makamaka.MakaMaka.ProductConsumableFour"];
//    }else if(index==13){
//        productID=13;
//        [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"com.Makamaka.MakaMaka.ProductConsumableFive"];
//    }
//}

-(void)actionOnCancelPurchase:(id)sender{
    
    self.navigationController.navigationBar.hidden=NO;
    [self performSelector:@selector(enable) withObject:nil afterDelay:0.5];
      imgView.image = imageOrg;
    if (viewForCell != nil) {
        
        for (NSInteger ko=0; ko<[[viewForCell subviews] count]; ko++){
            id l=[[viewForCell subviews] objectAtIndex:ko];
            [l removeFromSuperview];
        }
        [viewForCell removeFromSuperview];
//        [backgroundView removeFromSuperview];
//        backgroundView = nil;
    }
    
}
-(void)makeTabBarHidden:(BOOL)hide {
    // Custom code to hide TabBar
    
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    // appdelegate.tabBarController;
    
    if ([appdelegate.tabBarController.view.subviews count] < 2 ) {
        return;
    }
    
    UIView *contentView;
    
    if ([[appdelegate.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        contentView = [appdelegate.tabBarController.view.subviews objectAtIndex:1];
    } else {
        contentView = [appdelegate.tabBarController.view.subviews objectAtIndex:0];
    }
    if (hide) {
        contentView.frame = appdelegate.tabBarController.view.bounds;
    }
    else {
        contentView.frame = CGRectMake(appdelegate.tabBarController.view.bounds.origin.x,
                                       appdelegate.tabBarController.view.bounds.origin.y,
                                       appdelegate.tabBarController.view.bounds.size.width,
                                       appdelegate.tabBarController.view.bounds.size.height - appdelegate.tabBarController.tabBar.frame.size.height);
        
    }
    appdelegate.tabBarController.tabBar.hidden = hide;
}

-(void)enable{

    self.view.userInteractionEnabled=YES;
    scrollViewForFilter.userInteractionEnabled=YES;
    btnForCancel.userInteractionEnabled=YES;
    btnForNext.userInteractionEnabled=YES;
    [self killHUD];
}
-(IBAction)actionOnCancel:(id)sender{
    openPicker=YES;
    imageFinal=[imageOrg copy];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)actionOnNext:(id)sender{
  
    imageOrg=imgView.image;
    imageFinal=[imageOrg copy];
    [self.navigationController popViewControllerAnimated:YES];
    
    

    NSData* imageData = UIImagePNGRepresentation(imageOrg);
//    NSData* myEncodedImageData = [NSKeyedArchiver archivedDataWithRootObject:imageData];
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"filterImage"];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    imgView.image=imageOrg;
    viewForCell=[[UIView alloc] initWithFrame:CGRectMake(0, 320, 320, 90)];
    [viewForCell setBackgroundColor:[UIColor blackColor]];
    
    //--------------- Local Notification ---------------
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:kInAppPurchaseManagerTransactionSucceededNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:kInAppPurchaseManagerTransactionFailedNotification
                                               object:nil];
    //------------ Local Notification ---------------
    [self performSelector:@selector(makeScrollView)];
    // Do any additional setup after loading the view from its nib.
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionSucceededNotification]){
            if (productID==9) {
                [[NSUserDefaults standardUserDefaults] setValue:@"Done" forKey:[NSString stringWithFormat:@"rbv"]];
            }else if (productID==10){
                [[NSUserDefaults standardUserDefaults] setValue:@"Done" forKey:[NSString stringWithFormat:@"chanies"]];
            
            }else if (productID==11){
                [[NSUserDefaults standardUserDefaults] setValue:@"Done" forKey:[NSString stringWithFormat:@"Oscar"]];

                
            }else if (productID==12){
                [[NSUserDefaults standardUserDefaults] setValue:@"Done" forKey:[NSString stringWithFormat:@"Sausalito"]];
                
            }else if (productID==13){
                
                [[NSUserDefaults standardUserDefaults] setValue:@"Done" forKey:[NSString stringWithFormat:@"1978"]];
            }
            
            [self performSelector:@selector(enable) withObject:nil afterDelay:0.5];
            
        
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"languageMakaMaka"] isEqualToString:@"english"]) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Transaction Successfully Completed." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                [alert show];
            }else {
               UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"メッセージ" message:@"トランザクションが正常に完了しました。" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
               [alert show];
            }
        }
        if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionFailedNotification]){
            [self performSelector:@selector(enable) withObject:nil afterDelay:0.5];
            
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"languageMakaMaka"] isEqualToString:@"english"]) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Transaction failed. Please try after some time." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                [alert show];
            }else {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"メッセージ" message:@"トランザクションが失敗しました。しばらくしてからやり直してください。" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                [alert show];
            }
            
        }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
