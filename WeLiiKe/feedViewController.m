//
//  feedViewController.m
//  WeLiiKe
//
//  Created by techvalens on 16/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "feedViewController.h"
#import "CommentViewController.h"
#import "UserProfileViewController.h"
#import "OtherUserProfile.h"

@implementation feedViewController

@synthesize tableViewForFeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) killHUD
{
	if(aHUD != nil ){
		[aHUD.loadingView removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        aHUD = nil;
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

//Initialize and display the progress view
- (void) showHUD
{
	if(aHUD == nil)
	{
		aHUD = [[HudView alloc]init];
        [aHUD loadingViewInView:self.view text:@"Please Wait..."];
		[aHUD setUserInteractionEnabledForSuperview:self.view.superview];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}


-(IBAction)actionOnback:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageNo=1;
    arrayForCell=[[NSMutableArray alloc] init];
    arrayForData=[[NSMutableArray alloc] init];
       // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self performSelector:@selector(callServiceFeed) withObject:nil afterDelay:0.2];
    
}

-(void)actionOnSeeMore:(UIButton*)sender{
    
    pageNo=pageNo+1;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self performSelector:@selector(callServiceFeed) withObject:nil afterDelay:0.2];
    
}


-(void)callServiceFeed{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(news_feed1Handler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    //NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service news_feed1:[NSString stringWithFormat:@"%d",pageNo]];
   
        
}


-(void)news_feed1Handler:(id)sender{
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
        [self showHUD];
        NSError *error=nil;
        NSString *str=[sender stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        //NSLog(@"value of data %@",str);
        id strForResponce = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
        
        if (error==nil) {
            
            //[self killHUD];
            if ([strForResponce count]>0) {
                for (int i=0; i<[strForResponce count]; i++) {
                    
                    [arrayForData addObject:[strForResponce objectAtIndex:i]];
                    
                }
                [self performSelector:@selector(makeCell)];
                //
                //[self performSelector:@selector(killHUD) withObject:nil afterDelay:0.5];
                
            }else{
                [self killHUD];
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Error"
                                           message: @"Error from server please try again later."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                
            }
            

            
        }else{
            [self killHUD];
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

-(void)makeCell{
    
    if ([arrayForCell count]>0) {
        [arrayForCell removeAllObjects];
    }
    
    for (int i=0; i<[arrayForData count]; i++) {
        
        
        NSDictionary *dicTemp=[[arrayForData objectAtIndex:i] valueForKey:@"entity_info"];
        
        FeedCell *cell=[[FeedCell alloc] init];
        
        [cell.viewForback setBackgroundColor:[UIColor whiteColor]];
        
        [cell.btnForUserName setTitle:[dicTemp valueForKey:@"user_name"] forState:UIControlStateNormal];
        
        [cell.btnForCategory setTitle:[dicTemp valueForKey:@"mastet_category_name"] forState:UIControlStateNormal];
        
        int widthForScrollView=0;
        NSArray *arrayPost=[dicTemp valueForKey:@"post"];
        
        for (int j=0; j<[arrayPost count]+1; j++) {
            
            NSString *strProfile=@"";
            NSString *strImage=@"";
            NSString *strUserName=@"";
            NSString *strAddress=@"";
            NSString *strUserId=@"";
            int starRating=0;
            if (j==0) {
                strProfile=[dicTemp valueForKey:@"profile_picture"];
                strImage=[dicTemp valueForKey:@"entity_image"];
                strUserName=[dicTemp valueForKey:@"user_name"];
                strAddress=[dicTemp valueForKey:@"address"];
                if (![[dicTemp valueForKey:@"rating_count"] isEqual:[NSNull null]]) {
                    starRating=[[dicTemp valueForKey:@"rating_count"] intValue];
                }else{
                    starRating=0;
                }
                
                strUserId=[dicTemp valueForKey:@"user_id"];
            }else {
                strProfile=[[arrayPost objectAtIndex:j-1] valueForKey:@"profile_picture"];
                strImage=[[arrayPost objectAtIndex:j-1] valueForKey:@"post_image"];
                strUserName=[[arrayPost objectAtIndex:j-1] valueForKey:@"user_name"];
                strAddress=[[arrayPost objectAtIndex:j-1] valueForKey:@"address"];                
                
                if (![[[arrayPost objectAtIndex:j-1] valueForKey:@"rating_count"] isEqual:[NSNull null]]) {
                    starRating=[[[arrayPost objectAtIndex:j-1] valueForKey:@"rating_count"] intValue];
                }else{
                    starRating=0;
                }
                
                strUserId=[[arrayPost objectAtIndex:j-1] valueForKey:@"user_id"];
            }
            
            AsyncImageViewSmall *imageProfile=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(widthForScrollView, 0, 80, 140)];
            [imageProfile setTitle:strUserId forState:UIControlStateNormal];
            [imageProfile setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [imageProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
            [imageProfile loadImage:strProfile];
            [cell.scrollViewCell addSubview:imageProfile];
            
            
            AsyncImageViewSmall *image=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(widthForScrollView+85, 0, 235, 140)];
            //[image setBackgroundImage:[UIImage imageNamed:[[arrayForData objectAtIndex:j] valueForKey:@"mediaImages"]] forState:UIControlStateNormal];
            //[image setBackgroundImage:[UIImage imageNamed:[[arrayForData objectAtIndex:j] valueForKey:@"mediaImages"]] forState:UIControlStateHighlighted];
            [image addTarget:self action:@selector(multipleTap:withEvent:)
             forControlEvents:UIControlEventTouchDownRepeat];
            image.tag=i;
            
            [image loadImage:strImage];
            [cell.scrollViewCell addSubview:image];
            
            UIButton *btnForUser=[[UIButton alloc] initWithFrame:CGRectMake(5, 100, 150, 30)];
            [btnForUser setTitle:strUserName forState:UIControlStateNormal];
            [btnForUser.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [btnForUser setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btnForUser setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [btnForUser setBackgroundColor:[UIColor clearColor]];
            [image addSubview:btnForUser];
            
            UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(5, 115, 200, 30)];
            if (![strAddress isEqual:[NSNull null]]) {
                [lblForAddress setText:strAddress];
            }
            [lblForAddress setFont:[UIFont boldSystemFontOfSize:12]];
            [lblForAddress setTextAlignment:UITextAlignmentLeft];
            [lblForAddress setBackgroundColor:[UIColor clearColor]];
            [lblForAddress setTextColor:[UIColor grayColor]];
            [image addSubview:lblForAddress];
            
            
            CustomStarRank  *starRate=[[CustomStarRank alloc] initWithFrame:CGRectMake(170, 114,60, 12)];
            [starRate setValue:starRating];
            [starRate setUserInteractionEnabled:NO];
            [image addSubview:starRate];
            
            UIButton *btnForRate=[[UIButton alloc] initWithFrame:CGRectMake(170, 114,60, 12)];
            [btnForRate setBackgroundColor:[UIColor clearColor]];
            [btnForRate addTarget:self action:@selector(actionOnRate:) forControlEvents:UIControlEventTouchUpInside];
            btnForRate.tag=i;
            [image addSubview:btnForRate];
            
            widthForScrollView=widthForScrollView+320;
        }
        [cell.scrollViewCell setContentSize:CGSizeMake(widthForScrollView, 140)];
        
        
        NSString *strForCaption=[dicTemp valueForKey:@"comment"];
        
        float heightForLbl=0.0;
        if (![strForCaption isEqual:[NSNull null]]) {
            heightForLbl=[self calculateHeightOfLabel:strForCaption];
            if ([strForCaption length]>0) {
                if (heightForLbl<30) {
                    heightForLbl=30;
                }
                
                [cell.lblForName setFrame:CGRectMake(5, 175, 296, heightForLbl)];
                [cell.lblForName setText:strForCaption];
            }
        }
        int heighForCell=175+heightForLbl+5;
        
        cell.btnForComment.tag=i;
        [cell.btnForComment addTarget:self action:@selector(actionOnComment:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnForComment setFrame:CGRectMake(5,heighForCell, 60, 25)];
        
        cell.btnForShare.tag=i;
        [cell.btnForShare addTarget:self action:@selector(actionOnShare:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnForShare setFrame:CGRectMake(65,heighForCell, 45, 25)];
        
        [cell.lblForDate setFrame:CGRectMake(120, heighForCell, 50, 25)];
        [cell.lblForDate setText:@"15 july"];
        
        
        [cell.lblForCommentCount setFrame:CGRectMake(175, heighForCell, 45, 25)];
        [cell.lblForCommentCount setText:@"10"];
        
        [cell.imgViewCommentCount setFrame:CGRectMake(225, heighForCell+5, 15, 15)];
        
        [cell.lblForLikeCount setFrame:CGRectMake(240, heighForCell, 45, 25)];
        [cell.lblForLikeCount setText:@"5"];
        
        [cell.imgViewLikeCount setFrame:CGRectMake(287, heighForCell+5, 15, 15)];
        
        heighForCell=heighForCell+30;
        
        [cell.viewForback setFrame:CGRectMake(7, 8, 306, heighForCell)];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        NSMutableDictionary *dicForData=[[NSMutableDictionary alloc] init];
        [dicForData setValue:cell forKey:@"cell"];
        [dicForData setValue:[NSString stringWithFormat:@"%d",heighForCell] forKey:@"height"];
        [arrayForCell addObject:dicForData];
        //[[arrayForCell objectAtIndex:i] setObject:cell forKey:@"cell"];
        //[[arrayForCell objectAtIndex:i] setObject:[NSString stringWithFormat:@"%d",heighForCell] forKey:@"height"];
        
    }
    
    if ([arrayForCell count]>=10) {
        
        UITableViewCell *cell1= [[UITableViewCell alloc] init];
        
        
        UIButton *btnForSeemore=[[UIButton alloc] init];
        [btnForSeemore setFrame:CGRectMake(112, 20, 75, 30)];
        btnForSeemore.userInteractionEnabled=YES;
        [btnForSeemore addTarget:self action:@selector(actionOnSeeMore:) forControlEvents:UIControlEventTouchUpInside];
        [btnForSeemore setBackgroundImage:[UIImage imageNamed:@"see_more.png"] forState:UIControlStateNormal];
        [cell1 addSubview:btnForSeemore];
        cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        NSMutableDictionary *dicForData=[[NSMutableDictionary alloc] init];
        [dicForData setValue:cell1 forKey:@"cell"];
        [dicForData setValue:[NSString stringWithFormat:@"%d",70] forKey:@"height"];
        [arrayForCell addObject:dicForData];
        //[cell1 addSubview:btnForSeemore];
    }
    
    NSLog(@"value of array %d",[arrayForCell count]);
    [tableViewForFeed reloadData];
    [self killHUD];
}

-(void)multipleTap:(id)sender withEvent:(UIEvent*)event {
    UITouch* touch = [[event allTouches] anyObject];
    if (touch.tapCount == 2) {
        // do action.
        NSLog(@"Action on Double Touch ");
        UIButton *btn=(UIButton*)sender;
        NSDictionary *dicTemp=[[arrayForData objectAtIndex:btn.tag] valueForKey:@"entity_info"];
        NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        if (![strID isEqualToString:[dicTemp valueForKey:@"user_id"]]) {

            [self showHUD];
            [self performSelector:@selector(callWebserviceFor:) withObject:sender afterDelay:0.2];
            
        }else{
        
        }
    }
}

-(void)callWebserviceFor:(UIButton*)sender{
    
    NSDictionary *dicTemp=[[arrayForData objectAtIndex:sender.tag] valueForKey:@"entity_info"];
    NSLog(@"vale of dic ********** %@",dicTemp);
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(follow_categoryHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    currentIndex=sender.tag;
    [service follow_category:strID friend_user_id:[dicTemp valueForKey:@"user_id"] user_category_id:[dicTemp valueForKey:@"user_category_id"] master_category_id:[dicTemp valueForKey:@"master_category_id"]];
    
        
    
}

-(void)follow_categoryHandler:(id)sender{
    [self killHUD];
    
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
            
            [self killHUD];
            NSLog(@"value of responce %@",strForResponce);
            if ([strForResponce count]>0) {
                
                NSDictionary *dicTemp=[[arrayForData objectAtIndex:currentIndex] valueForKey:@"entity_info"];
                
                UITableViewCell *cell;
                if ([arrayForCell count]>currentIndex) {
                    cell=[[arrayForCell objectAtIndex:currentIndex] valueForKey:@"cell"];
                    
                    UIImageView *imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(85, 55, 220, 85)];
                    [imgBg setImage:[UIImage imageNamed:@"popupFollow.png"]];
                    
                    
                    UILabel *lblForShow=[[UILabel alloc] initWithFrame:CGRectMake(80, 15, 120, 60)];
                    [lblForShow setText:[NSString stringWithFormat:@"Now following %@ %@",[dicTemp valueForKey:@"user_name"],[dicTemp valueForKey:@"mastet_category_name"]]];
                    [lblForShow setTextColor:[UIColor whiteColor]];
                    lblForShow.numberOfLines=4;
                    [lblForShow setFont:[UIFont boldSystemFontOfSize:13]];
                    [lblForShow setBackgroundColor:[UIColor clearColor]];
                    [imgBg addSubview:lblForShow];
                    
                    [imgBg setAlpha:0.0];
                    [cell addSubview:imgBg];
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1.0];
                    [imgBg setAlpha:1.0];
                    [UIView commitAnimations];
                    
                    //[UIView setAnimationDelegate:imgBg];
                    //[UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
                    [self performSelector:@selector(removeImageView:) withObject:imgBg afterDelay:0.2];
                }
                
                
            }else{
                //[arrayForServerData removeAllObjects];
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Error"
                                           message: @"Error from server please try again later."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                
            }

            
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


-(void)actionOnRate:(UIButton*)sender{
    
    UITableViewCell *cell;
    if ([arrayForCell count]>sender.tag) {
        cell=[[arrayForCell objectAtIndex:sender.tag] valueForKey:@"cell"];
    }
    
    currentIndex=sender.tag;
    
    UIView *viewForBack=[[UIView alloc] initWithFrame:CGRectMake(85, 135, 235, 40)];
    [viewForBack setBackgroundColor:[UIColor blackColor]];
    viewForBack.alpha=0.5;
    viewForBack.tag=1002;
    [cell addSubview:viewForBack];
    
    CustomStarRank  *starRate=[[CustomStarRank alloc] initWithFrame:CGRectMake(85, 135, 200, 40)];
    [starRate setValue:2];
    starRate.delegate=self;
    starRate.tag=1003;
    [starRate setUserInteractionEnabled:YES];
    [cell addSubview:starRate];

    
}

-(void)tapOnSliderView:(CustomStarRank*)customStarRank {

    UITableViewCell *cell;
    if ([arrayForCell count]>currentIndex) {
        cell=[[arrayForCell objectAtIndex:currentIndex] valueForKey:@"cell"];
    }
    id view=[cell viewWithTag:1002];
    id view1=[cell viewWithTag:1003];

    if(view!=nil){
        [view removeFromSuperview];
    }

    if(view1!=nil){
    [view1 removeFromSuperview];
    }
    [self showHUD];
    [self performSelector:@selector(callStarRating:) withObject:customStarRank afterDelay:0.2];
}

-(void)callStarRating:(CustomStarRank*)customStarRank{

    NSDictionary *dicTemp=[[arrayForData objectAtIndex:currentIndex] valueForKey:@"entity_info"];
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(ratingEntityHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    
    [service ratingEntity:[dicTemp valueForKey:@"user_id"] user_entity_id:[dicTemp valueForKey:@"user_entity_id"] rating_count:[NSString stringWithFormat:@"%d",(int)customStarRank.value] self_user_id:strID];
    
        
    
}


-(void)ratingEntityHandler:(id)sender{
    [self killHUD];
    
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
            
            [self killHUD];
            NSLog(@"value of responce %@",strForResponce);
            if ([strForResponce count]>0) {
                UITableViewCell *cell;
                if ([arrayForCell count]>currentIndex) {
                    cell=[[arrayForCell objectAtIndex:currentIndex] valueForKey:@"cell"];
                }
                UIImageView *imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(140, 55, 100, 75)];
                [imgBg setImage:[UIImage imageNamed:@"iconWeliike.png"]];
                //[cell addSubview:imgBg];
                
                [imgBg setAlpha:0.0];
                [cell addSubview:imgBg];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [imgBg setAlpha:1.0];
                [UIView commitAnimations];
                
                
                [self performSelector:@selector(removeImageView:) withObject:imgBg afterDelay:0.2];
            }else{
                //[arrayForServerData removeAllObjects];
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Error"
                                           message: @"Error from server please try again later."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                
            }
            

            
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


-(void)removeImageView:(UIImageView *)imgView{

    if (imgView!=nil) {
        
//        [imgView setAlpha:1.0];
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:1.0];
//        [imgView setAlpha:0.0];
//        [imgView removeFromSuperview];
//        [UIView commitAnimations];
        
        [UIView animateWithDuration:0.5
                              delay:1.0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             imgView.alpha = 0;
                         }completion:^(BOOL finished){
                             [imgView removeFromSuperview];
                         }];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self performSelector:@selector(removeViewFromCell)];
}
-(void)removeViewFromCell{
    
//    UITableViewCell *cell;
//    if ([arrayForCell count]>CurrentLikeIndex) {
//        cell=[[arrayForCell objectAtIndex:CurrentLikeIndex] valueForKey:@"cell"];
//    }
//    
//    id view2=[cell viewWithTag:1001];
//    if (view2!=nil) {
//        [[cell viewWithTag:1001] removeFromSuperview];
//    }
//    
//    id view=[cell viewWithTag:1002];
//    if (view!=nil) {
//        [[cell viewWithTag:1002] removeFromSuperview];
//        [[cell viewWithTag:1003] removeFromSuperview];
//    }
//    
//    id view1=[cell viewWithTag:1003];
//    if (view1!=nil) {
//        [[cell viewWithTag:1003] removeFromSuperview];
//    }
//    
//    id view3=[cell viewWithTag:1004];
//    if (view3!=nil) {
//        [[cell viewWithTag:1004] removeFromSuperview];
//    }
}
-(void)actionOnComment:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    CommentViewController *obj=[[CommentViewController alloc] init];
    NSDictionary *dicTemp=[[arrayForData objectAtIndex:btn.tag] valueForKey:@"entity_info"];
    obj.dicForDetail=dicTemp;
    obj.strForEntity=@"entity";

    [self.navigationController pushViewController:obj animated:YES];
    
}
-(void)actionOnShare:(id)sender{

    UIButton *btn=(UIButton *)sender;
    
    
    NSDictionary *dicTemp=[[arrayForData objectAtIndex:btn.tag] valueForKey:@"entity_info"];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if (![strID isEqualToString:[dicTemp valueForKey:@"user_id"]]) {
        
        RespostViewController *obj=[[RespostViewController alloc] init];
        //NSDictionary *dicTemp=[[arrayForData objectAtIndex:btn.tag] valueForKey:@"entity_info"];
        obj.dicForDetail=dicTemp;
        obj.strForEntity=@"entity";
        [self.navigationController pushViewController:obj animated:YES];
        
    }else{
        
    }
    
    
    
}

-(void)actionOnProfile:(id)sender{
    
    UserProfileViewController *obj=[[UserProfileViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}
-(void)actionOnUserProfile:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    NSString *str=[btn currentTitle];
    if ([str length]>0) {
        
        OtherUserProfile *obj=[[OtherUserProfile alloc] init];
        obj.strForUserID=str;
        [self.navigationController pushViewController:obj animated:YES];
    }
}

-(float)calculateHeightOfLabel:(NSString*)text{
    RTLabel *lblForHeight=[[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 296, 1000)];
    [lblForHeight setText:text];
    CGSize optimumSize = [lblForHeight optimumSize];
    return optimumSize.height;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([arrayForCell count]>0) {
        return [[[arrayForCell objectAtIndex:indexPath.row] valueForKey:@"height"] floatValue]+10;
    }
    return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return  [arrayForCell count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    if ([arrayForCell count]>0) {
        return  [[arrayForCell objectAtIndex:indexPath.row] objectForKey:@"cell"];
    }
    
	return cell;
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