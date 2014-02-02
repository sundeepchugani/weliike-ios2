//
//  AddNewEmailAdress.h
//  HFH
//
//  Created by mini on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpCustomCell.h"

@interface AddNewEmailAdress : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *tablenewcontact;    
    IBOutlet UIButton *btncancel;
    IBOutlet UIButton *btnDone;

	NSMutableArray *contacts;
}
@property(nonatomic,retain)  IBOutlet UITableView *tablenewcontact;   
@property(nonatomic,retain) IBOutlet UIButton *btnDone;
@property(nonatomic,retain)   IBOutlet UIButton *btncancel;
// Array for Name and Email
@property(nonatomic,retain) NSMutableArray *contacts;
-(IBAction)backToEmailContectfromcancel:(id)sender;
-(IBAction)backToEmailcontectfromDone:(id)sender;
-(BOOL) validEmail:(NSString*) emailString;
@end
