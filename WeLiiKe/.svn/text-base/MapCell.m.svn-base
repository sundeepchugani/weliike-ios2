//
//  MapCell.m
//  WeLiiKe
//
//  Created by techvalens on 22/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MapCell.h"

@implementation MapCell
@synthesize MapViewForLocation,btnForZoom;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        MapViewForLocation=[[MKMapView alloc] init];
        self.MapViewForLocation.showsUserLocation=YES;
        [self addSubview:MapViewForLocation];
        
        btnForZoom=[[UIButton alloc] init];
        [self addSubview:btnForZoom];
        
        //MapViewForLocation.userInteractionEnabled=NO;
        //MapViewForLocation.layer.borderWidth=5;
        //MapViewForLocation.layer.borderColor=[UIColor whiteColor].CGColor;

    }
    return self;
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
