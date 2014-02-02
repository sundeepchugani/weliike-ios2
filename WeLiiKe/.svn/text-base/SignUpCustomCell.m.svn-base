//
//  SignUpCustomCell.m
//  HFH
//
//  Created by Praveen on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignUpCustomCell.h"


@implementation SignUpCustomCell

@synthesize textLable,textView,button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
	//- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		textLable=[[UILabel alloc] initWithFrame:CGRectMake(5,10,200,25)];
		//textView=[[UITextField alloc] initWithFrame:CGRectMake(5+95+5,5,225,25)];
        textView=[[UITextField alloc] initWithFrame:CGRectMake(0+90+0,12,200,25)];
		button=[[UIButton alloc] initWithFrame:CGRectMake(5+85+5,5,25,25)];

		[textLable setFont:[UIFont boldSystemFontOfSize:16]];
        
		
		//[textLable setFont:[UIFont ]]
        [textView setBackgroundColor:[UIColor clearColor]];
		[button setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:textLable];
		[self.contentView addSubview:textView];
		[self.contentView addSubview:button];
		
	}
    return self;
}

-(void)layoutSubviews
{
	textLable.frame = CGRectMake(5,10,140,25);
	//textView.frame = CGRectMake(5+95+5,5,225,25);
	
    textView.frame = CGRectMake(0+90+0,12,200,25);
  
    button.frame = CGRectMake(5+85+5,5,25,25);

	
	[super layoutSubviews];
}

//- (void)dealloc {
//	[textLable release];  
//	[textView release];  
//	[button release];
//	
//	[super dealloc];
//}

@end

