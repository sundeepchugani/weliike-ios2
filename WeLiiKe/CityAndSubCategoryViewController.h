//
//  CityAndSubCategoryViewController.h
//  WeLiiKe
//
//  Created by Techvalens on 8/28/13.
//
//

#import <UIKit/UIKit.h>
extern NSString *myConstString;
extern NSString *const anotherConstString;
@interface CityAndSubCategoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arry;
    NSMutableArray *arrayForData;

//    NSString *strForCitySubCategory;
}
//@property (nonatomic , strong)IBOutlet NSMutableArray *arrayForData;
@property (nonatomic , strong)IBOutlet  NSString *strForCitySubCategory;
@property (nonatomic , strong)IBOutlet NSMutableArray *arry;
-(IBAction)actionOnBackButton:(id)sender;
@end
