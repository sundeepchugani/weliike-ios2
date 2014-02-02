//
//  zoomViewController.m
//  MakaMaka
//
//  Created by techvalens on 13/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "zoomViewController.h"

@implementation zoomViewController
@synthesize imgOnZoom;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *keyView = self.view;
    ZoomView *zoomView1=[[ZoomView alloc] initWithFrame:keyView.bounds];
    if (imgOnZoom != nil) {
        [zoomView1 setImageOn:imgOnZoom];
        
    }else{
       [zoomView1 setImageOn:[UIImage imageNamed:@"NoPicture.png"]];
    }
    [self.view addSubview:zoomView1];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeZoom:) 
                                                 name:@"RemoveZoomView"
                                               object:nil];

    
    // Do any additional setup after loading the view from its nib.
}
- (void) removeZoom:(NSNotification *) notification{
    
    [self dismissModalViewControllerAnimated:YES];
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
