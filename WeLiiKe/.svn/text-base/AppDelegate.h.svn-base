//
//  AppDelegate.h
//  WeLiiKe
//
//  Created by techvalens on 12/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MapKit/MapKit.h>
//#import <FacebookSDK/FacebookSDK.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "FBConnect.h"
#import "WeLiikeWebService.h"
#define kSocialAccountTypeKey @"SOCIAL_ACCOUNT_TYPE"

@class ACAccount;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,MKMapViewDelegate,FBLoginViewDelegate,UITabBarControllerDelegate>{

    UINavigationController *navControllerApp;
    UITabBarController *tabBarController;
    NSMutableDictionary *dictionaryForImageCacheing;
    UIButton *btnPost;
    NSMutableArray *arrayOfEmailContact;
    NSMutableArray *arrayOfUserForMessage;
    
    //*********
    //CLLocationManager *locationManager;
    double currentLatitude;
    double currentLongitute;
    
    Facebook *facebook;
    NSString *strForAddressDelegate;
    int countForAddress;
}
@property (nonatomic, retain)NSString *strForAddressDelegate;
@property (nonatomic, retain) Facebook *facebook;
@property(assign,nonatomic)double currentLatitude;
@property(assign,nonatomic)double currentLongitute;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic,retain)NSMutableArray *arrayOfEmailContact,*arrayOfUserForMessage;
@property(nonatomic,retain)UIButton *btnPost;
@property(nonatomic,retain) NSMutableDictionary *dictionaryForImageCacheing;
@property(nonatomic,retain)IBOutlet UINavigationController *navControllerApp;
@property(nonatomic,retain)IBOutlet UITabBarController *tabBarController;
@property (strong, nonatomic)IBOutlet UIWindow *window;

- (void)getTwitterAccountOnCompletion:(void(^)(ACAccount *))completionHandler;

@end
