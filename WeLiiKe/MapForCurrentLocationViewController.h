//
//  MapForCurrentLocationViewController.h
//  WeLiiKe
//
//  Created by Techvalens on 8/14/13.
//
//

#import <UIKit/UIKit.h>

@interface MapForCurrentLocationViewController : UIViewController<MKMapViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_MapLocation;
@property (strong, nonatomic) IBOutlet MKMapView *MapViewForLocation;
@property(nonatomic,strong)NSMutableDictionary *serverData;
- (IBAction)actionOnBack:(id)sender;


@end
