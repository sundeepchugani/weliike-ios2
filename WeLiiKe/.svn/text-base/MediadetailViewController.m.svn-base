//
//  MediadetailViewController.m
//  WeLiiKe
//
//  Created by techvalens on 17/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MediadetailViewController.h"
#import "CommentViewController.h"
#import "LikkerViewConotroller.h"
#import "Foursquare2.h"
#import "RespostViewController.h"
#import "EntityDetailViewController.h"
#import "OtherUserProfile.h"
#import "zoomViewController.h"

@implementation MediadetailViewController
@synthesize scrollViewForMain,strForEntity,tableViewForDetail,strUserID;
@synthesize lblForTitle;
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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentPage=0;
    MapViewForLocation=[[MKMapView alloc] init];
    MapViewForLocation.userInteractionEnabled=NO;
    MapViewForLocation.layer.borderWidth=5;
    //[MapViewForLocation setShowsUserLocation:YES];
    MapViewForLocation.layer.borderColor=[UIColor whiteColor].CGColor;
    
    //[self performSelector:@selector(makeScrollView:) withObject:NO];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
 
    [super viewDidAppear:animated];
    [self showHUD];
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
    
}
-(void)callWebService{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(entityInfoHandler:)];
    //int countObj=[arrayForCateSelected count]-countSelectedCategory;
    //labelForName.text=[[arrayForCateSelected objectAtIndex:countObj] valueForKey:@"Name"];
    
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if ([strUserID length]>0) {
        if (![strUserID isEqualToString:strID]) {
            strID=strUserID;
        }
    }
    NSLog(@"valeu of User ID %@",strUserID);
    NSLog(@"valeu of User ID %@",strID);
    NSLog(@"valeu of User  %@",strForEntity);
    [service entityInfo:strID entityID:strForEntity];
}

-(void)entityInfoHandler:(id)sender{
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
            NSLog(@"value of %@",strForResponce);
            if ([strForResponce count]>0) {
                //NSLog(@"value of %@",strForResponce);
                
                dicForServerData=[[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)strForResponce copyItems:YES];
                arrayForData=[[NSMutableArray alloc] init];
                NSArray *array=[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"comment"];
                lblForTitle.text=[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"user_entity_name"];
                [arrayForData addObject:array];
                if ([dicForServerData valueForKey:@"post_info"] !=nil) {
                    NSArray *array=[dicForServerData valueForKey:@"post_info"];
                    NSArray *arrayForComment=[dicForServerData valueForKey:@"commentss"];
                    for (int i=0; i<[array count]; i++) {
                        NSMutableArray *arrayForFinalComment=[[NSMutableArray alloc] init];
                        for (int j=0; j<[arrayForComment count]; j++) {
                            if ([[[arrayForComment objectAtIndex:j] valueForKey:@"post_id"] isEqualToString:[[array objectAtIndex:i] valueForKey:@"post_id"]]) {
                                [arrayForFinalComment addObject:[arrayForComment objectAtIndex:j]];
                            }
                        }
                        [arrayForData addObject:arrayForFinalComment];
                    }
                    
                }
                NSLog(@"value of array %@",dicForServerData);
                
                cellScrolling=[[UITableViewCell alloc] init];
                cellScrolling.selectionStyle=UITableViewCellSelectionStyleNone;
                
                // NSArray *arrayForImage=[str componentsSeparatedByString:@" "];
                if (scrollviewForAllImages==nil) {
                    scrollviewForAllImages=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
                }
                
                int xForScrollView=0;
                NSArray *viewsToRemove = [scrollviewForAllImages subviews];
                for (UIView *v in viewsToRemove)
                    [v removeFromSuperview];
                
                scrollviewForAllImages.pagingEnabled=YES;
                scrollviewForAllImages.delegate=self;
                NSMutableArray *arrayForLatLong=[[NSMutableArray alloc] init];
                for (int i=0; i<[arrayForData count]; i++) {
                    AsyncImageViewSmall *image=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(xForScrollView, 0, 320, 250)];
                    //[image setBackgroundImage:[UIImage imageNamed:[arrayForImage objectAtIndex:i]] forState:UIControlStateNormal];
                    
                    NSString *str=@"";
                    NSString *strcaption=@"";
                    //NSString *strLocation=@"";
                    
                    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
                    NSDictionary *dicFordata;
                    
                    image.tag=i;
                    if (i==0) {
                        dicFordata=[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0];
                        str=[NSString stringWithFormat:@"%@",[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"user_entity_image"]];
                        strcaption=[NSString stringWithFormat:@"%@",[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"comment_text"]];
                        if (![[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"latitute"] isEqual:[NSNull null]]) {
                            [dic setValue:[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"latitute"] forKey:@"lat"];
                            [dic setValue:[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"longitude"] forKey:@"lng"];
                        }
                        
                    }else{
                        dicFordata=[[dicForServerData valueForKey:@"post_info"] objectAtIndex:i-1];
                        str=[NSString stringWithFormat:@"%@",[[[dicForServerData valueForKey:@"post_info"] objectAtIndex:i-1] valueForKey:@"post_image"]];
                        //comment_text
                        strcaption=[NSString stringWithFormat:@"%@",[[[dicForServerData valueForKey:@"post_info"] objectAtIndex:i-1] valueForKey:@"comment_text"]];
                        
                        if (![[[[dicForServerData valueForKey:@"post_info"] objectAtIndex:i-1] valueForKey:@"latitute"] isEqual:[NSNull null]]) {
                            [dic setValue:[[[dicForServerData valueForKey:@"post_info"] objectAtIndex:i-1] valueForKey:@"latitute"] forKey:@"lat"];
                            [dic setValue:[[[dicForServerData valueForKey:@"post_info"] objectAtIndex:i-1] valueForKey:@"longitude"] forKey:@"lng"];
                        }
                        
                    }
                    [arrayForLatLong addObject:dic];
                    [image loadImage:str];
                    //[image addTarget:self action:@selector(actionOnZoom:withEvent:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doSingleTap:)];
                    singleTap.numberOfTapsRequired = 1;
                    [image addGestureRecognizer:singleTap];
                    
                    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doDoubleTap:)];
                    doubleTap.numberOfTapsRequired = 2;
                    [image addGestureRecognizer:doubleTap];
                    
                    [singleTap requireGestureRecognizerToFail:doubleTap];
                    
                    [scrollviewForAllImages addSubview:image];
                    
                    
                    
                    CustomStarRank  *starRate=[[CustomStarRank alloc] initWithFrame:CGRectMake(xForScrollView+255, 235,60, 12)];
                    [starRate setValue:[[dicFordata valueForKey:@"rating_count"] intValue]];
                    [starRate setUserInteractionEnabled:NO];
                    [scrollviewForAllImages addSubview:starRate];
                    
                    UIButton *btnForRate=[[UIButton alloc] initWithFrame:CGRectMake(xForScrollView+255, 232,60, 18)];
                    [btnForRate setBackgroundColor:[UIColor clearColor]];
                    [btnForRate addTarget:self action:@selector(actionOnRate:) forControlEvents:UIControlEventTouchUpInside];
                    btnForRate.tag=i;
                    [scrollviewForAllImages addSubview:btnForRate];
                    
                    UIButton *lblForcaption=[[UIButton alloc] initWithFrame:CGRectMake(xForScrollView+10, 250, 300, 40)];
                    //lblForcaption.numberOfLines=2;
                    [lblForcaption setBackgroundColor:[UIColor clearColor]];
                    [lblForcaption.titleLabel setTextColor:[UIColor darkGrayColor]];
                    [lblForcaption setTitle:strcaption forState:UIControlStateNormal];
                    [lblForcaption setFont:[UIFont systemFontOfSize:15]];
                    [lblForcaption setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                    [lblForcaption setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    if ([strcaption length]>0) {
                        //[lblForcaption addTarget:self action:@selector(callCaptionView:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    [scrollviewForAllImages addSubview:lblForcaption];
                    
                    xForScrollView=xForScrollView+320;
                }
                //[scrollviewForAllImages setContentOffset:CGPointMake(currentPage*320, 220)];
                [scrollviewForAllImages setContentSize:CGSizeMake(xForScrollView, 250)];
                [cellScrolling addSubview:scrollviewForAllImages];
                
                
                static NSString *CellIdentifierMap = @"CellMap";
                cellMap= [[MapCell alloc] init];
                if (cellMap == nil) {
                    cellMap = [[MapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierMap];
                }
                cellMap.selectionStyle=UITableViewCellSelectionStyleNone;
                cellMap.MapViewForLocation.frame=CGRectMake(0, 40, 320, 260);
                //cellMap.btnForZoom.frame=CGRectMake(274, 260, 36, 30);
                //[cellMap.btnForZoom setImage:[UIImage imageNamed:@"zoom_out.png"] forState:UIControlStateNormal];
                [cellMap showpin:(NSArray*)arrayForLatLong];
                UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 250, 35)];
                
                if ([[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"address"] !=[NSNull null]) {
                    [lblForAddress setText:[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"address"]];
                }
                
                [lblForAddress setFont:[UIFont systemFontOfSize:12]];
                [lblForAddress setTextAlignment:UITextAlignmentLeft];
                [lblForAddress setBackgroundColor:[UIColor clearColor]];
                [lblForAddress setTextColor:[UIColor grayColor]];
                [lblForAddress setNumberOfLines:2];
                [cellMap addSubview:lblForAddress];
                //[cellMap.btnForZoom addTarget:self action:@selector(actionOnZoom:event:) forControlEvents:UIControlEventTouchUpInside];
                [cellMap.btnForZoom setHidden:YES];
                
                
                
                [tableViewForDetail reloadData];
            }else{
                //[arrayForServerData removeAllObjects];
                //[tableViewForCategoty reloadData];
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

-(void)callCaptionView:(UIButton*)sender{

    CaptionPopViewController *obj=[[CaptionPopViewController alloc] init];
    obj.strForCaption=[sender currentTitle];
    obj.title=@"Caption";
    popover = [[FPPopoverController alloc] initWithViewController:obj];
    popover.tint = FPPopoverDefaultTint;
    popover.contentSize = CGSizeMake(200, 300);
    popover.alpha = 1.0;
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:sender];
    
    
//    alertForCaption=[[UIAlertView alloc] init];
//    [alertForCaption setMessage:@" \n\n\n\n\n\n\n\n\n\n\n\n " ];
//    UIView *myView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280,345)] ;
//    [myView setBackgroundColor:[UIColor redColor]];
//    [myView setBackgroundColor:[UIColor yellowColor]];
//    myView.layer.cornerRadius= 10.0f;
//    myView.layer.masksToBounds=YES;
//
//    [alertForCaption addSubview:myView];
//    
//    UITextView *textView =[[UITextView alloc]init];
//    textView.frame=CGRectMake(10,10,260,270);
//    textView.backgroundColor=[UIColor  orangeColor];
//    textView.text = [sender currentTitle];
//    [alertForCaption addSubview:textView];
//    
//    UIButton *back=[[UIButton alloc] initWithFrame:CGRectMake(100, 250, 60, 40)];
//    [back setBackgroundColor:[UIColor greenColor]];
//    [back addTarget:self action:@selector(actiononAlertback:) forControlEvents:UIControlEventTouchUpInside];
//    [back setTitle:@"back" forState:UIControlStateNormal];
//    [myView addSubview:back];
//    
//    [alertForCaption show];
    
    
}

- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}


- (void)willPresentAlertView:(UIAlertView *)alertView {
	
	
	if ([alertForCaption isEqual:alertView]) {
		
		[alertView setFrame:CGRectMake(0, 50, 290, 400)];
		alertView.center = CGPointMake(320 / 2, 480 / 2);
		
	}
	
}

-(void)actiononAlertback:(id)sender{

    [alertForCaption dismissWithClickedButtonIndex:0 animated:YES];
    [alertForCaption removeFromSuperview];
}

-(void)actionOnRate:(UIButton*)sender{
    
    
    currentIndex=sender.tag;
    UIView *viewForBack=[[UIView alloc] initWithFrame:CGRectMake(0, 210, 320, 40)];
    [viewForBack setBackgroundColor:[UIColor blackColor]];
    viewForBack.alpha=0.5;
    viewForBack.tag=1002;
    [cellScrolling addSubview:viewForBack];
    
    CustomStarRank  *starRate=[[CustomStarRank alloc] initWithFrame:CGRectMake(60, 210, 200, 40)];
    [starRate setValue:2];
    starRate.delegate=self;
    starRate.tag=1003;
    [starRate setUserInteractionEnabled:YES];
    [cellScrolling addSubview:starRate];
    
    
}

-(void)tapOnSliderView:(CustomStarRank*)customStarRank {
    
    
    id view=[cellScrolling viewWithTag:1002];
    id view1=[cellScrolling viewWithTag:1003];
    
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
    
    NSDictionary *dicTemp;
    if (currentIndex==0) {
        dicTemp=[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0];
    }else{
        dicTemp=[[dicForServerData valueForKey:@"post_info"] objectAtIndex:currentIndex-1];
    }
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
                
                UIImageView *imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(110, 85, 100, 75)];
                [imgBg setImage:[UIImage imageNamed:@"iconWeliike.png"]];
                //[cell addSubview:imgBg];
                
                [imgBg setAlpha:0.0];
                [cellScrolling addSubview:imgBg];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [imgBg setAlpha:1.0];
                [UIView commitAnimations];
                [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.2];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	if ([arrayForData count]>0 && checkForMapShow==NO) {
        NSLog(@"value of array data %d",1+[arrayForData count]);
        return 1+[arrayForData count];
    }else if ([arrayForData count]>0 && checkForMapShow==YES) {
        NSLog(@"value of array data %d",2+[arrayForData count]);
        return 2+[arrayForData count];
    } 
    
    return  0;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
    if ([arrayForData count]>0 && checkForMapShow==NO) {
        if (section==0) {
            return 1;
        }
       
        NSArray *arrayTemp=[arrayForData objectAtIndex:section-1];
        //NSLog(@"Section value %d and value of array count %d",section-1,[arrayTemp count]);
        
        return [arrayTemp count];
    }else if ([arrayForData count]>0 && checkForMapShow==YES) {
        
        if (section==0) {
            return 1;
        }else if (section==1){
            return 1;
        }
        NSArray *arrayTemp=[arrayForData objectAtIndex:section-2];
        
        return [arrayTemp count];
    } 
        
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    int index=indexPath.section;
    if (checkForMapShow==YES){
        index=index-2;
    }else{
        index=index-1;
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
        return cellScrolling;
        }
    }else if (indexPath.section==1 && checkForMapShow==YES){
        if (indexPath.row==0) {
                return cellMap;
        }
    }
    else if(index<[arrayForData count]){
        //static NSString *CellIdentifierComment = @"CellComment";
        NSArray *arrayTempComment=[arrayForData objectAtIndex:index];
        CommentCell *cellComment= (CommentCell*)[tableView dequeueReusableCellWithIdentifier:nil];
        
        if (cellComment == nil) {
            cellComment = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        cellComment.selectionStyle=UITableViewCellSelectionStyleNone;
        NSString *str=[NSString stringWithFormat:@"%@",[[arrayTempComment objectAtIndex:indexPath.row] valueForKey:@"profile_picture"]];
        [cellComment.imgForProfile loadImage:str];
        [cellComment.imgForProfile setTitle:[[arrayTempComment objectAtIndex:indexPath.row] valueForKey:@"user_id"] forState:UIControlStateNormal];
        [cellComment.imgForProfile setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [cellComment.imgForProfile addTarget:self action:@selector(actionOnUserProfile:) forControlEvents:UIControlEventTouchUpInside];
        [cellComment.btnForName setTitle:[[arrayTempComment objectAtIndex:indexPath.row] valueForKey:@"user_name"] forState:UIControlStateNormal];
        int height=0;
        if ([[[arrayTempComment objectAtIndex:indexPath.row] valueForKey:@"comment_text"] length]>0) {
            NSString *strForComment=[NSString stringWithFormat:@"%@",[[arrayTempComment objectAtIndex:indexPath.row] valueForKey:@"comment_text"]];
            cellComment.lblForComment.text=strForComment;
            height=[self calculateHeightOfLabel:[[arrayTempComment objectAtIndex:indexPath.row] valueForKey:@"comment_text"]];
            [cellComment.lblForComment setFrame:CGRectMake(50, 25, 250, height)];
        }
       
        [cellComment.starRate setStrImage:@"star_small.png"];
        [cellComment.starRate setStrStarActImage:@"star_active_small.png"];
 
        
        if ([[arrayTempComment objectAtIndex:indexPath.row]
             valueForKey:@"comment_rating"]!=[NSNull null]) {
            [cellComment.starRate setValue:[[[arrayTempComment objectAtIndex:indexPath.row] valueForKey:@"comment_rating"] intValue]];
        }else{
            [cellComment.starRate setValue:0];
        }
        
        [cellComment.lblForDate setText:@"20 Hr"];
        [cellComment.lblForDate setFrame:CGRectMake(260, height-25, 45, 20)];
        
        if ([arrayTempComment count]>0 && indexPath.row==([arrayTempComment count]-1)) {
            if ([[[arrayTempComment objectAtIndex:0] valueForKey:@"comment_count"] intValue]>2) {
                [cellComment.btnForSeemore setFrame:CGRectMake(112, height, 75, 30)];
                 cellComment.btnForSeemore.tag=index;
                 cellComment.btnForSeemore.hidden=NO;
                cellComment.btnForSeemore.userInteractionEnabled=YES;
                [cellComment.btnForSeemore addTarget:self action:@selector(actionOnSeeMore:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        return cellComment;
    }else {
        cell.textLabel.text=@"See more";
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
	return cell;
}

-(void)actionOnZoom:(UIButton*)sender withEvent:(UIEvent*)event{
    UITouch* touch = [[event allTouches] anyObject];
    
    if (touch.tapCount == 2) {
        
        
    }else if (touch.tapCount == 1){
        

    
    }
        
}

- (void) doSingleTap: (UITapGestureRecognizer *)recognizer{

    UIButton *btn=(UIButton*)recognizer.view;
    UIImage *img=[btn.imageView image];
    if (img!=nil) {
        zoomViewController *obj=[[zoomViewController alloc] init];
        obj.imgOnZoom=img;
        obj.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:obj animated:YES];
    }
    
}

- (void) doDoubleTap: (UITapGestureRecognizer *)recognizer{
    
    UIButton *btn=(UIButton*)recognizer.view;
    NSDictionary *dicTemp;
    if (btn.tag==0) {
        dicTemp=[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0];
    }else{
        dicTemp=[[dicForServerData valueForKey:@"post_info"] objectAtIndex:btn.tag-1];
    }
    
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if (![strID isEqualToString:[dicTemp valueForKey:@"user_id"]]) {
        
        [self showHUD];
        [self performSelector:@selector(callWebserviceFor:) withObject:btn afterDelay:0.2];
        
    }else{
        
    }

    
}

-(void)callWebserviceFor:(UIButton*)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    NSDictionary *dicTemp;
    if (btn.tag==0) {
        dicTemp=[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0];
    }else{
        dicTemp=[[dicForServerData valueForKey:@"post_info"] objectAtIndex:btn.tag-1];
    }
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(follow_categoryHandler:)];
    NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
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
                
                
                UIImageView *imgBg=[[UIImageView alloc] initWithFrame:CGRectMake(85, 55, 220, 85)];
                [imgBg setImage:[UIImage imageNamed:@"popupFollow.png"]];
                
                
                UILabel *lblForShow=[[UILabel alloc] initWithFrame:CGRectMake(80, 15, 120, 60)];
                [lblForShow setText:[NSString stringWithFormat:@"Now following %@ %@",[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"user_name"],[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"master_category_name"]]];
                [lblForShow setTextColor:[UIColor whiteColor]];
                lblForShow.numberOfLines=4;
                [lblForShow setFont:[UIFont boldSystemFontOfSize:13]];
                [lblForShow setBackgroundColor:[UIColor clearColor]];
                [imgBg addSubview:lblForShow];
                
                [imgBg setAlpha:0.0];
                [scrollviewForAllImages addSubview:imgBg];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [imgBg setAlpha:1.0];
                [UIView commitAnimations];
                
                //[UIView setAnimationDelegate:imgBg];
                //[UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
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


-(void)actionOnSeeMore:(id)sender{

    UIButton *btn=(UIButton*)sender;
    NSLog(@"value of Tag SeeMore button******* %d",btn.tag);
    EntityDetailViewController *obj=[[EntityDetailViewController alloc] init];
    
    int index =btn.tag;
    
    if (index==0) {
    }else if (btn.tag>0 && checkForMapShow==YES){
        index=index-2;
    }else{
        index=index-1;
    }
    
    if (index==0) {
        obj.strForEntity=@"entity";
        obj.dicForDetail=[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0];
    }else if (index>0){
        obj.strForEntity=@"post";
        NSArray *array=[dicForServerData valueForKey:@"post_info"];
        if (index-1<[array count]) {
            obj.dicForDetail=[array objectAtIndex:index-1];
        }
    }
    
    [self.navigationController pushViewController:obj animated:YES];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
//    if (!pageControlBeingUsed) {
//        // Switch the indicator when more than 50% of the previous/next page is visible
//        NSLog(@"value scrollViewDidScroll");
//    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView==scrollviewForAllImages) {
        NSLog(@"value of scrolling %f",scrollviewForAllImages.contentOffset.x);
        currentPage = scrollviewForAllImages.contentOffset.x / 320;
        if ([arrayForData count]>currentPage) {        
            //arrayForComment=[[NSMutableArray alloc] initWithArray:[[arrayForData objectAtIndex:currentPage] valueForKey:@"comment"]  copyItems:YES];
        }    
        //[self.tableViewForDetail reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableViewForDetail reloadData];
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index=indexPath.section;
    if (checkForMapShow==YES){
        index=index-2;
    }else{
        index=index-1;
    }
        if (indexPath.section==0) {
            return 290;
        }else if (indexPath.section==1 && checkForMapShow==YES){
            return 300;
        }else if(index<[arrayForData count]){
            NSArray *arrayTemp=[arrayForData objectAtIndex:index];
            NSString *strComment= [[arrayTemp objectAtIndex:indexPath.row] valueForKey:@"comment_text"];
            int height=(int)[self calculateHeightOfLabel:strComment];
            
            if ([arrayTemp count]>0 && indexPath.row==([arrayTemp count]-1)) {
                if ([[[arrayTemp objectAtIndex:0] valueForKey:@"comment_count"] intValue]>2) {
                    return height+50;
                }
            }
            
            return height;
        }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if (section==1 && checkForMapShow==YES){
        return 0;
    }else{
        return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   UIView *viewForHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    if (section==0) {
       return viewForHeader;
   }else if (section==1 && checkForMapShow==YES){
       return viewForHeader;
    }else{        
        
        UIImageView *viewForCommentAndLike=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        viewForCommentAndLike.userInteractionEnabled=YES;
        [viewForCommentAndLike setImage:[UIImage imageNamed:@"nav_bottom_bar.png"]];
        [viewForCommentAndLike setBackgroundColor:[UIColor clearColor]];
        [viewForHeader addSubview:viewForCommentAndLike];
        
        UIButton *btnForComment=[[UIButton alloc] initWithFrame:CGRectMake(5, 2, 70, 25)];
        [btnForComment setImage:[UIImage imageNamed:@"commentbtn.png"] forState:UIControlStateNormal];
        [btnForComment.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [btnForComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnForComment setBackgroundColor:[UIColor clearColor]];
        btnForComment.layer.cornerRadius=5;
        btnForComment.layer.masksToBounds=YES;
        btnForComment.tag=section;
        [btnForComment addTarget:self action:@selector(actionOnComment:) forControlEvents:UIControlEventTouchUpInside];
        [viewForCommentAndLike addSubview:btnForComment];
        
        UIButton *btnForShare=[[UIButton alloc] initWithFrame:CGRectMake(85, 2, 70, 25)];
        [btnForShare setImage:[UIImage imageNamed:@"sharebtn.png"] forState:UIControlStateNormal];
        [btnForShare.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [btnForShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnForShare setBackgroundColor:[UIColor clearColor]];
        btnForShare.layer.cornerRadius=5;
        btnForShare.tag=section;
        btnForShare.layer.masksToBounds=YES;
        [btnForShare addTarget:self action:@selector(actionOnShare:) forControlEvents:UIControlEventTouchUpInside];
        [viewForCommentAndLike addSubview:btnForShare];
        
        
        UIButton *btnForLocation=[[UIButton alloc] initWithFrame:CGRectMake(250, 2, 30, 25)];
        [btnForLocation setImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
        [btnForLocation.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [btnForLocation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnForLocation setBackgroundColor:[UIColor clearColor]];
        btnForLocation.layer.cornerRadius=5;
        btnForComment.tag=section;
        btnForLocation.layer.masksToBounds=YES;
        [btnForLocation addTarget:self action:@selector(actionOnlat:event:) forControlEvents:UIControlEventTouchUpInside];
        [viewForCommentAndLike addSubview:btnForLocation];
        
        
        UIButton *btnForLiik=[[UIButton alloc] initWithFrame:CGRectMake(285, 2, 30, 25)];
        [btnForLiik setImage:[UIImage imageNamed:@"smiley.png"] forState:UIControlStateNormal];
        [btnForLiik.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [btnForLiik setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnForLiik setBackgroundColor:[UIColor clearColor]];
        btnForLiik.layer.cornerRadius=5;
        btnForLiik.tag=section;
        btnForLiik.layer.masksToBounds=YES;
        [btnForLiik addTarget:self action:@selector(actionOnlikker:) forControlEvents:UIControlEventTouchUpInside];
        [viewForCommentAndLike addSubview:btnForLiik];
        
        return viewForHeader;

    }
    return viewForHeader;
}
-(void)actionOnComment:(id)sender{

    UIButton *btn=(UIButton*)sender;
    CommentViewController *obj=[[CommentViewController alloc] init];
    NSLog(@"btn tag in section %d",btn.tag);
    int index =btn.tag;
    
    if (index==0) {
    }else if (btn.tag>0 && checkForMapShow==YES){
        index=index-2;
    }else{
        index=index-1;
    }
    
    if (index==0) {

            obj.dicForDetail=[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0];
            obj.strForEntity=@"entity";           

    }else if (index>0){
            
            NSArray *array=[dicForServerData valueForKey:@"post_info"];
            if (index-1<[array count]) {
            obj.dicForDetail=[array objectAtIndex:index-1];
            }        
    }
    [self.navigationController pushViewController:obj animated:YES];
}

-(void)actionOnlikker:(id)sender{

    LikkerViewConotroller *obj=[[LikkerViewConotroller alloc] init];
    UIButton *btn=(UIButton*)sender;
    NSLog(@"btn tag in section %d",btn.tag);
    int index =btn.tag;
    
    if (index==0) {
        
    }else if (btn.tag>0 && checkForMapShow==YES){
        index=index-2;
    }else{
        index=index-1;
    }
    
    if (index==0) {
        
        obj.strForCategoryId=[[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"user_entity_id"];
                
    }else if (index>0){
        
        NSArray *array=[dicForServerData valueForKey:@"post_info"];
        if (index-1<[array count]) {
            obj.strForCategoryId=[[array objectAtIndex:index-1] valueForKey:@"post_id"];
            //obj.strForUserID=[[array objectAtIndex:index-1] valueForKey:@"user_id"];
        }
    }

    
    [self.navigationController pushViewController:obj animated:YES];
    
}
-(void)actionOnShare:(id)sender{

    UIButton *btn=(UIButton*)sender;
    
    int index =btn.tag;
    
    if (index==0) {
    }else if (btn.tag>0 && checkForMapShow==YES){
        index=index-2;
    }else{
        index=index-1;
    }
    
    RespostViewController *obj=[[RespostViewController alloc] init];
    if (index==0) {
        obj.strForEntity=@"entity";
        obj.dicForDetail=[[dicForServerData valueForKey:@"entity_info"] objectAtIndex:0];
    }else if (index>0){
        obj.strForEntity=@"post";
        NSArray *array=[dicForServerData valueForKey:@"post_info"];
        if (index-1<[array count]) {
        obj.dicForDetail=[array objectAtIndex:index-1];
        }
    }

    [self.navigationController pushViewController:obj animated:YES];
    
}
-(void)actionOnlat:(id)sender event:(id)event{
    
    if (checkForMapShow==YES) {
        checkForMapShow=NO;
    }else{
        checkForMapShow=YES;
    }    
//    NSSet *touches = [event allTouches];
//    UITouch *touch = [touches anyObject];
//    CGPoint currentTouchPosition = [touch locationInView:self.tableViewForDetail];
//    NSIndexPath *indexPath = [self.tableViewForDetail indexPathForRowAtPoint: currentTouchPosition];
//    if (indexPath != nil)
//    {
//        [self.tableViewForDetail reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
    [tableViewForDetail reloadData];
}

-(void)showpin:(NSArray *)arrayForLocation{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.longitudeDelta= 00.0005000;
    span.latitudeDelta=00.0050000;
    CLLocationCoordinate2D center;
    if ([arrayForLocation count]>0) {
        center.latitude=[[arrayForLocation valueForKey:@"lat"] doubleValue];
        center.longitude=[[arrayForLocation valueForKey:@"lng"] doubleValue];
    } else{
    }
    
    
    region.span=span;
    region.center=center;
    [MapViewForLocation setRegion:region animated:YES];
    
    for (int i = 0; i<1;i++) {
        MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
        
        CLLocationCoordinate2D theCoordinate1;////22.717911//75.889332
        theCoordinate1.latitude = [[arrayForLocation valueForKey:@"lat"] doubleValue];
        theCoordinate1.longitude = [[arrayForLocation valueForKey:@"lng"] doubleValue];
        myAnnotation1.coordinate=theCoordinate1;
        [MapViewForLocation addAnnotation:myAnnotation1];
    }
    [MapViewForLocation setDelegate:self];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // Boilerplate pin annotation code
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;                
    }
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [MapViewForLocation dequeueReusableAnnotationViewWithIdentifier: @"restMap"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"restMap"] ;
    } else {
        pin.annotation = annotation;
    }
    pin.pinColor = MKPinAnnotationColorRed;
    pin.canShowCallout = YES;
    pin.animatesDrop = YES;
	
    return pin;
}


-(float)calculateHeightOfLabel:(NSString*)text{
    RTLabel *lblForHeight=[[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 250, 1000)];
    [lblForHeight setText:text];
    CGSize optimumSize = [lblForHeight optimumSize];
    if (optimumSize.height<20) {
        return 20+55;
    }
    return optimumSize.height+55;
}

-(IBAction)actionOnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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


- (void)viewDidUnload
{
    [super viewDidUnload];
    MapViewForLocation.delegate=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
