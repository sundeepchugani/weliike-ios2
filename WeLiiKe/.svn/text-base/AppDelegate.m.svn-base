//
//  AppDelegate.m
//  WeLiiKe
//
//  Created by techvalens on 12/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <NewRelicAgent/NewRelicAgent.h>

int checkForFB;
static NSString* kAppId = @"483095475079437";
@implementation AppDelegate

@synthesize facebook;
@synthesize window = _window,tabBarController,navControllerApp,btnPost,currentLatitude,currentLongitute;
@synthesize dictionaryForImageCacheing,arrayOfEmailContact,locationManager=_locationManager,arrayOfUserForMessage;
@synthesize strForAddressDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    application.applicationIconBadgeNumber=0;
    
    if (nil==dictionaryForImageCacheing) {
		dictionaryForImageCacheing=[[NSMutableDictionary alloc] init];
	}
    
    // Initialize Facebook
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:nil];
    
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    // *****************************************************************************

    [NewRelicAgent startWithApplicationToken:@"AA3d3066495a4ac64638b419d8db547521e323989b"];
    //NSMutableDictionary *dictionaryForImageCacheing11=[[NSMutableDictionary alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    arrayOfEmailContact = [[NSMutableArray alloc] init];
    arrayOfUserForMessage = [[NSMutableArray alloc] init];
    btnPost=[[UIButton alloc] initWithFrame:CGRectMake(127,431, 65, 49)];
    [btnPost setImage:[UIImage imageNamed:@"post_icon.png"] forState:UIControlStateNormal];
    [btnPost addTarget:self action:@selector(actionOnPost:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.view addSubview:btnPost];
    
    
    if(self.locationManager==nil){
        _locationManager=[[CLLocationManager alloc] init];        
        _locationManager.delegate=self;
        _locationManager.purpose = @"We will try to tell you where you are if you get lost";
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=500;
        self.locationManager=_locationManager;
    }
    if([CLLocationManager locationServicesEnabled]){
        [self.locationManager startUpdatingLocation];
    }
    self.tabBarController.delegate=self;
    [self.window addSubview:navControllerApp.view];
    self.window.rootViewController=navControllerApp;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateOnFb:)
                                                 name:@"FBIdUpdate"
                                               object:nil];
    
    return YES;
}
- (void)updateOnFb:(NSNotification*)note {
    
    //[NSThread detachNewThreadSelector:@selector(callFbIdServerUpdate) toTarget:self withObject:nil];
    [self performSelector:@selector(callFbIdServerUpdate) withObject:nil afterDelay:0.2];
    
}

-(void)callFbIdServerUpdate{

    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(add_facebook_idHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strFbID=[[NSUserDefaults standardUserDefaults] valueForKey:@"facebookIdFB"];
    [service add_facebook_id:strID facebook_id:strFbID];
    
}

-(void)add_facebook_idHandler:(id)sender{
    //[self killHUD];
    
    if([sender isKindOfClass:[NSError class]]) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: @"Error"
                                   message: @"Error from server please try again later."
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        
    }else{
        NSError *error=nil;
        NSString *str=[sender stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        //NSLog(@"value of data %@",str);
        id strForResponce = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (error==nil) {
            
            NSLog(@"value of string %@",strForResponce);

            
        }else{
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Error"
                                       message: @"Error from server please try again later."
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
            
        }
        
    }
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	// Add registration for remote notifications
	[[UIApplication sharedApplication]
	 registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
	
	// Clear application badge when app launches
	application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken{
	
    NSString *deviceToken = [[[[devToken description]
							   stringByReplacingOccurrencesOfString:@"<"withString:@""]
							  stringByReplacingOccurrencesOfString:@">" withString:@""]
							 stringByReplacingOccurrencesOfString: @" " withString: @""];
    [[NSUserDefaults standardUserDefaults] setValue:deviceToken forKey:@"pushtokenMakaMaka"];
    NSLog(@"Device Token %@",deviceToken);
}

/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	
#if !TARGET_IPHONE_SIMULATOR
	
	NSLog(@"Error in registration. Error: %@", error);
	
#endif
}


/**
 * Remote Notification Received while application was open.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
#if !TARGET_IPHONE_SIMULATOR
    
	NSLog(@"remote notification: %@",[userInfo description]);
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];
    
    [[NSUserDefaults standardUserDefaults] setValue:alert forKey:@"pushNotiText"];
    
	NSLog(@"Received Push Alert: %@", alert);
	
	NSString *sound = [apsInfo objectForKey:@"sound"];
	NSLog(@"Received Push Sound: %@", sound);
	//	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	
	NSString *badge = [apsInfo objectForKey:@"badge"];
	NSLog(@"Received Push Badge: %@", badge);
    //checkForPN=YES;
	application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
	
    
    
#endif
	
    //	viewForNotification=[[UIView alloc] initWithFrame:CGRectMake(150, 380,150,45)];
    //	[viewForNotification setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"image_notificationBubble150x45.png"]]];
    //	[[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:viewForNotification];
    //	[self performSelector:@selector(removeSuperViewForNotificationView:) withObject:nil afterDelay:2];
    //	[viewForNotification release];
	
	
	
}


- (void)getTwitterAccountOnCompletion:(void (^)(ACAccount *))completionHandler
{
    ACAccountStore *accountStore1 = [[ACAccountStore alloc] init];
    ACAccountType *twitterType = [accountStore1 accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    ACAccount *account = [[ACAccount alloc] initWithAccountType:twitterType];
    //  this is where you *should* apply the ACAccountCredential, but we're not going to
    [accountStore1 requestAccessToAccountsWithType:twitterType
                            withCompletionHandler:^(BOOL granted, NSError *error) {
                                if(granted) {
                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                        NSLog(@"succeeded new  .");
                                        
                                        NSArray *twitterAccounts = [accountStore1 accountsWithAccountType:twitterType];
                                        if ([twitterAccounts count]>0) {
                                            ACAccount * account=[twitterAccounts objectAtIndex:0];
                                            NSLog(@"twitter user: %@",[account username]);
                                        }
                                        
                                        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kSocialAccountTypeKey];
                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                        
                                        //Call the completion handler so the calling object can retrieve the twitter account.
                                        completionHandler(account);

                                    });
                                }else{
                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                    [self twitterAlert];
                                        });
                                }
        }];
    
}


+ (void)setAlertForSettingPage :(id)delegate
{
    // Set up the built-in twitter composition view controller.
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        [delegate dismissModalViewControllerAnimated:YES];
    }];
    
    // Present the tweet composition view controller modally.
    [delegate presentModalViewController:tweetViewController animated:YES];
    //tweetViewController.view.hidden = YES;
    for (UIView *view in tweetViewController.view.subviews){
        [view removeFromSuperview];
    }
    
}
-(void) twitterAlert
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Twitter Authorisation" message:@"Please log into Twitter in the Settings please, then try again!" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
    [alert show];
}
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSString *str=[alertView buttonTitleAtIndex:buttonIndex];
    
    if ([str isEqualToString:@"Ok"]) {
        
        [self performSelector:@selector(actionOnUrl) withObject:nil afterDelay:1.0];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=TWITTER"]];
    }
}

-(void)actionOnUrl{

    NSURL *twitterURL = [NSURL URLWithString:@"prefs:root=TWITTER"];
    [[UIApplication sharedApplication] openURL:twitterURL];
    
}

-(void)actionOnPost:(id)sender{
    self.tabBarController.selectedIndex=2;

}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	double lat_long_Val = newLocation.coordinate.latitude;	
	currentLatitude = lat_long_Val;
	
	lat_long_Val =newLocation.coordinate.longitude;
	currentLongitute =lat_long_Val;
    NSLog(@"*********************************Sucess");
    countForAddress=countForAddress+1;
    if (countForAddress==20 || [strForAddressDelegate length]==0) {
        countForAddress=0;
        NSLog(@"*********************************");
        [self getAddressLocation];
    }
    
    
}

-(void)getAddressLocation{
    
    //AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:_locationManager.location // You can pass aLocation here instead
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       dispatch_async(dispatch_get_main_queue(),^ {
                           if (placemarks.count == 1) {
                               CLPlacemark *place = [placemarks objectAtIndex:0];
                               //NSString *zipString = [place.addressDictionary valueForKey:@"ZIP"];
                               NSArray *arrayForAddress=[place.addressDictionary valueForKey:@"FormattedAddressLines"];
                               //NSLog(@"value of address %@",place.addressDictionary);
                               //strForCity=[place.addressDictionary valueForKey:@"City"];
                               [self performSelectorInBackground:@selector(showWeatherFor:) withObject:[arrayForAddress componentsJoinedByString:@","]];
                               
                           }
                           
                       });
                       
                   }];
}
-(void)showWeatherFor:(NSString *)zipString{
    strForAddressDelegate=zipString;
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{

}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {


}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Although the SDK attempts to refresh its access tokens when it makes API calls,
    // it's a good practice to refresh the access token also when the app becomes active.
    // This gives apps that seldom make api calls a higher chance of having a non expired
    // access token.
    [[self facebook] extendAccessTokenIfNeeded];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    [self performSelector:@selector(callNoti) withObject:nil afterDelay:0.5];
    return [self.facebook handleOpenURL:url];
}

-(void)callNoti{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    if (checkForFB==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBLogin" object:self userInfo:nil];
    }else if (checkForFB==1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBGetFriend" object:self userInfo:nil];
    }else if (checkForFB==2){
        //FBLoginSetting
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBLoginSetting" object:self userInfo:nil];
    }else if (checkForFB==3){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBLoginSharing" object:self userInfo:nil];
    }else if (checkForFB==4){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBLoginComment" object:self userInfo:nil];
    }else if (checkForFB==5){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBLoginRepost" object:self userInfo:nil];
    }else if (checkForFB==6){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBGetPeople" object:self userInfo:nil];
    }//FBGetPeople
    
}

-(void)callLocation{

//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
//    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
//    _locationManager.delegate=self;
//    [_locationManager startUpdatingLocation];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FBPost"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TWPost"];
    [FBSession.activeSession close];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
