//
//  MapForCurrentLocationViewController.m
//  WeLiiKe
//
//  Created by Techvalens on 8/14/13.
//
//

#import "MapForCurrentLocationViewController.h"
#import "MyAnnotation.h"
@interface MapForCurrentLocationViewController ()

@end

@implementation MapForCurrentLocationViewController
@synthesize serverData,MapViewForLocation, lbl_MapLocation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"server data = = = = = = = %@", serverData);
//    [MapViewForLocation setFrame:CGRectMake(0, 100, 320, 420)];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSMutableArray *arrayForLatLong = [[NSMutableArray alloc]init];
    if (![[[[serverData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"latitute"] isEqual:[NSNull null]]) {
        [dic setValue:[[[serverData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"latitute"] forKey:@"lat"];
        [dic setValue:[[[serverData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"longitude"] forKey:@"lng"];
        [arrayForLatLong addObject:dic];
    }
    if ([[[serverData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"address"] !=[NSNull null]) {
        [lbl_MapLocation setText:[[[serverData valueForKey:@"entity_info"] objectAtIndex:0] valueForKey:@"address"]];
    }
    [self showpin:arrayForLatLong];
    

//    MapViewForLocation.userInteractionEnabled=NO;

//    MapViewForLocation.layer.borderWidth=5;
    //[MapViewForLocation setShowsUserLocation:YES];
//    MapViewForLocation.layer.borderColor=[UIColor whiteColor].CGColor;
    // Do any additional setup after loading the view from its nib.
}
-(void)showpin:(NSArray *)arrayForLocation{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.longitudeDelta= 00.0005000;
    span.latitudeDelta=00.0050000;
    CLLocationCoordinate2D center;
    if ([arrayForLocation count]>0) {
        center.latitude=[[[arrayForLocation objectAtIndex:0]valueForKey:@"lat"] doubleValue];
        center.longitude=[[[arrayForLocation objectAtIndex:0]valueForKey:@"lng"] doubleValue];
    } else{
    }
    
    
    region.span=span;
    region.center=center;
    [MapViewForLocation setRegion:region animated:YES];
    
    for (int i = 0; i<[arrayForLocation count];i++) {
        MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
        
        CLLocationCoordinate2D theCoordinate1;////22.717911//75.889332
        theCoordinate1.latitude = [[[arrayForLocation objectAtIndex:i]valueForKey:@"lat"] doubleValue];
        theCoordinate1.longitude = [[[arrayForLocation objectAtIndex:i]valueForKey:@"lng"] doubleValue];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionOnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setMapViewForLocation:nil];
    [self setLbl_MapLocation:nil];
    [super viewDidUnload];
}
@end
