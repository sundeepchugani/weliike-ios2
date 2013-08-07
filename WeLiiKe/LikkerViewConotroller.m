//
//  LikkerViewConotroller.m
//  WeLiiKe
//
//  Created by techvalens on 06/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "LikkerViewConotroller.h"
#import "AsyncImageViewSmall.h"

@implementation LikkerViewConotroller
@synthesize tableForLikker,strForCategoryId;
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
    dicForData=[[NSMutableDictionary alloc] init];
    dicForExpand=[[NSMutableDictionary alloc] init];
    [dicForExpand setValue:@"NO" forKey:@"1"];
    [dicForExpand setValue:@"NO" forKey:@"2"];
    [dicForExpand setValue:@"NO" forKey:@"3"];
    [dicForExpand setValue:@"NO" forKey:@"4"];
    [dicForExpand setValue:@"NO" forKey:@"5"];
    // Do any additional setup after loading the view from its nib.
    //[self performSelector:@selector(callServiceLiker)];
   
}


-(void)viewDidAppear:(BOOL)animated{

    [self showHUD];
    [self performSelector:@selector(callServiceLiker) withObject:nil afterDelay:0.2];
}

-(void)callServiceLiker{
    
    WeLiikeWebService *service=[[WeLiikeWebService alloc] initWithDelegate:self callback:@selector(getLikerHandler:)];
    //service.delegateService=self;
    //NSString *strForImageData=[self Base64Encode:imageData];
    //NSString *strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    [service getLiker:strForCategoryId];
        
    
}


-(void)getLikerHandler:(id)sender{
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
            
            NSLog(@"value of string %@",strForResponce);
            NSLog(@"value of string ********** %@",[[strForResponce class] description]);
            [self killHUD];
            if ([strForResponce count]>0) {
                dicForData =(NSMutableDictionary*)strForResponce;
                NSLog(@"value of Data %@",dicForData);
                [tableForLikker reloadData];
            }else{
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle: @"Message"
                                           message: @"NO data found."
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)actionOnBack:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}     


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([dicForData count]>0) {
        int countCell=0;
        
        if ([[dicForData valueForKey:@"rating_count_1"] count]>0) {
            countCell=countCell+1;
            [dicForExpand setValue:@"rating_count_1" forKey:[NSString stringWithFormat:@"%d",countCell]];
        }
        if ([[dicForData valueForKey:@"rating_count_2"] count]>0){
            countCell=countCell+1;
            [dicForExpand setValue:@"rating_count_2" forKey:[NSString stringWithFormat:@"%d",countCell]];
        }
        if ([[dicForData valueForKey:@"rating_count_3"] count]>0){
            countCell=countCell+1;
            [dicForExpand setValue:@"rating_count_3" forKey:[NSString stringWithFormat:@"%d",countCell]];
        } 
        if ([[dicForData valueForKey:@"rating_count_4"] count]>0){
            countCell=countCell+1;
            [dicForExpand setValue:@"rating_count_4" forKey:[NSString stringWithFormat:@"%d",countCell]];
        }
        if ([[dicForData valueForKey:@"rating_count_5"] count]>0){
            countCell=countCell+1;
            [dicForExpand setValue:@"rating_count_5" forKey:[NSString stringWithFormat:@"%d",countCell]];
        }
        NSLog(@"value of cell Count %d",countCell);
        return countCell+1;
    }
	return  0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[dicForExpand valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"YES"] && indexPath.row>0) {
        if ([dicForExpand valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]]!=nil) {
           
        NSString *str=[dicForExpand valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        NSArray *arrayForUser=[dicForData valueForKey:str];
        int photoCount=[arrayForUser count];
        int countForPage=(photoCount/6);
        if (photoCount<6 || photoCount==6) {
            countForPage=1;
        }else{
            if (photoCount%6 != 0) {
                countForPage=countForPage+1;
            }
        }
        NSLog(@"count of page %d",countForPage);
        return (countForPage)*70;
        }else return 70;
    }else{
    
    }
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell= (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    int photoCount=0;
    if (indexPath.row==0) {
        [cell.textLabel setTextColor:[UIColor colorWithRed:55.0/255.0 green:151.0/255.0 blue:255.0/255.0 alpha:1.0]];
        cell.textLabel.text=@"WeLiike rating";
        
        
    }else if (indexPath.row>0){
        
               
        NSString *str=[dicForExpand valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        NSArray *arrayForUser=[dicForData valueForKey:str];
        photoCount=[arrayForUser count];
        
        CustomStarRank *customRank=[[CustomStarRank alloc] initWithFrame:CGRectMake(5, 2,60, 12)];
        [customRank setValue:[[[arrayForUser objectAtIndex:0] valueForKey:@"entity_rating_count"] intValue]];
        [customRank setStrImage:@"star_small.png"];
        [customRank setStrStarActImage:@"star_active_small.png"];
        [customRank setUserInteractionEnabled:NO];
        [cell addSubview:customRank];
        
        UILabel *lblForAddress=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        [lblForAddress setText:[NSString stringWithFormat:@"%d",photoCount]];
        [lblForAddress setFont:[UIFont boldSystemFontOfSize:30]];
        [lblForAddress setTextAlignment:UITextAlignmentCenter];
        [lblForAddress setBackgroundColor:[UIColor clearColor]];
        [lblForAddress setTextColor:[UIColor colorWithRed:55.0/255.0 green:151.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [cell addSubview:lblForAddress];
        
        UIButton *btnForComment=[[UIButton alloc] initWithFrame:CGRectMake(0, 45, 70, 25)];
        [btnForComment setTitle:@"UP" forState:UIControlStateNormal];
        [btnForComment.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [btnForComment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnForComment setBackgroundColor:[UIColor clearColor]];
        btnForComment.layer.cornerRadius=5;
        btnForComment.layer.masksToBounds=YES;
        btnForComment.tag=indexPath.row;
        [btnForComment addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnForComment];
        
        //*****************************************************
        
        if ([[dicForExpand valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"NO"]) {
            int xForimage=70;
            for (int i=0; i<photoCount && i<6; i++) {
                
                AsyncImageViewSmall *image=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(xForimage, 4, 37, 50)];
                NSString *strURL=[[arrayForUser objectAtIndex:i] valueForKey:@"profile_picture"];
                if ([strURL length]>0) {
                    [image loadImage:strURL];
                }
                
                [cell addSubview:image];
                
                UILabel *lblForName=[[UILabel alloc] initWithFrame:CGRectMake(xForimage, 45, 37, 25)];
                [lblForName setText:[[arrayForUser objectAtIndex:i] valueForKey:@"user_name"]];
                [lblForName setFont:[UIFont boldSystemFontOfSize:8]];
                [lblForName setTextAlignment:UITextAlignmentCenter];
                [lblForName setBackgroundColor:[UIColor clearColor]];
                [lblForName setTextColor:[UIColor blackColor]];
                [cell addSubview:lblForName];
                
                xForimage=xForimage+41;
                
            }
        }else{
            
            
            int countForPage=(photoCount/6);
            if (photoCount<6 || photoCount==6) {
                countForPage=1;
            }else{
                if (photoCount%6 != 0) {
                    countForPage=countForPage+1;
                }
            }
            int yForImage=4;
            for (int j = 0; j < countForPage; j++) {
                
                int countForLastPage=6;
                if (j==countForPage-1 && photoCount != 6 && photoCount%6 != 0) {
                    countForLastPage=photoCount%6;
                }
                int xForimage=70;
                
                for (int i=0; i<countForLastPage && i<6; i++) {
                    
                    AsyncImageViewSmall *image=[[AsyncImageViewSmall alloc] initWithFrame:CGRectMake(xForimage, yForImage, 37, 50)];
                    NSString *strURL=[[arrayForUser objectAtIndex:i] valueForKey:@"profile_picture"];
                    if ([strURL length]>0) {
                        [image loadImage:strURL];
                    }
                    [cell addSubview:image];
                    
                    UILabel *lblForName=[[UILabel alloc] initWithFrame:CGRectMake(xForimage, yForImage+45, 37, 25)];
                    [lblForName setText:[[arrayForUser objectAtIndex:i] valueForKey:@"user_name"]];
                    [lblForName setFont:[UIFont boldSystemFontOfSize:8]];
                    [lblForName setTextAlignment:UITextAlignmentCenter];
                    [lblForName setBackgroundColor:[UIColor clearColor]];
                    [lblForName setTextColor:[UIColor blackColor]];
                    [cell addSubview:lblForName];
                    
                    xForimage=xForimage+41;
                    
                }
                yForImage=yForImage+70;
            }
        }
        
        //*****************************************************
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
	return cell;
}
//[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableForLikker];
    NSIndexPath *indexPath = [self.tableForLikker indexPathForRowAtPoint: currentTouchPosition];
    if ([[dicForExpand valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] isEqualToString:@"YES"]) {
        [dicForExpand setValue:@"NO" forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    }else{
        [dicForExpand setValue:@"YES" forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    }
    if (indexPath != nil)
    {
        [self.tableForLikker reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
