//
//  AsyncImageViewSmall.m
//  Beautifo!
//
//  Created by techvalens on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AsyncImageViewSmall.h"


@implementation AsyncImageViewSmall

-(void)loadImage:(NSString *)url {

    [self setBackgroundColor:[UIColor whiteColor]];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    // [self setShowsTouchWhenHighlighted:YES];
	if( nil==arrayForURL){
		arrayForURL =[[NSMutableArray alloc] initWithObjects:nil];
	}
	delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (url!=nil) {
		if([delegate.dictionaryForImageCacheing objectForKey:url])
		{
            //			[self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateNormal];
            //            [self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateHighlighted];
            UIImage *image=[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]];
//            CGImageRef cr = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(50, 100, 320, 200));
//            UIImage* cropped = [UIImage imageWithCGImage:cr];

            [self setimage:image];
        }else {
			
			//ProgressBar
			[arrayForURL addObject:url];
            //	[self abort];
			if (connection !=nil) {
                //				[connection release];
				connection =nil;
			}
			
			imageData = [[NSMutableData alloc] initWithCapacity:0];
            
            [NSThread detachNewThreadSelector:@selector(loadimagedata:) toTarget:self withObject:url];
		}
	}
}

-(void) loadimagedata:(NSString *)sender{
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    // [indicator setFrame:CGRectMake(self.frame.size.width-40, self.frame.size.height-40, 40, 40)];
    indicator.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    if (self.tag!=999) {
        
        [self addSubview:indicator];
        [indicator startAnimating];
    }
    
    
    NSData *tempImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:sender]];
    
    if (tempImageData!=nil) {
        //        [self setBackgroundImage:[UIImage imageWithData:tempImageData] forState:UIControlStateNormal];
        //        [self setBackgroundImage:[UIImage imageWithData:tempImageData] forState:UIControlStateHighlighted];
        UIImage *image=[UIImage imageWithData:tempImageData];
       // [self setimage:image];
         [self setImage:image forState:UIControlStateNormal];
        [delegate.dictionaryForImageCacheing setObject:tempImageData forKey:sender] ;
    }else{
    
        //[UIImage imageNamed:@"default_user.png"]
        //[self setimage:[UIImage imageNamed:@"default_user.png"]];
    }
    // [delegate.dictionaryForImageCacheing setObject:tempImageData forKey:sender] ;
    
    [indicator stopAnimating];
    [indicator removeFromSuperview];
}


-(void) setimage:(UIImage*)image{
    
    if (image!=nil) {
        
    CGFloat ratioWidth = self.imageView.bounds.size.width/image.size.width;
    CGFloat ratioHeight = self.imageView.bounds.size.height/image.size.height;
    if (ratioHeight>ratioWidth){
        [self.imageView setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,  image.size.width*ratioHeight, self.imageView.frame.size.height)];
    }else{
        [self.imageView setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,  image.size.width, self.imageView.frame.size.height*ratioHeight)];
    }
    [self.imageView setCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2)];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self setImage:image forState:UIControlStateNormal];
    //[self setBackgroundImage:image forState:UIControlStateNormal];
    }
}

@end
