//
//  WeliikeCropViewController.h
//  WeLiiKe
//
//  Created by anoop gupta on 01/05/13.
//
//

#import <UIKit/UIKit.h>


@protocol croppedImageDelegate <NSObject>

@required
-(void)getCroppedImage:(UIImage*)image;

@end


@interface WeliikeCropViewController : UIViewController<UIScrollViewDelegate>{

    UIScrollView *scrollViewForCrop;
    UIImageView *imgView;
    UIImage *imgSet;
    //UIImageView *imgViewForMain;
    //id <croppedImageDelegate> delegate;
    CGRect sizeForCrop;
    UILabel *lbl;
//    NSString *s;
}
@property (nonatomic, assign) id <croppedImageDelegate> delegate;
@property(nonatomic,retain)UIImage *imgSet;
@property(nonatomic,retain)IBOutlet UILabel *lbl;
@property(nonatomic,assign)CGRect sizeForCrop;
@property(nonatomic,assign)NSString *s;
-(IBAction)actionOnBack:(id)sender;
-(IBAction)actionOnDone:(id)sender;
UIImage* imageFromView1(UIImage* srcImage, CGRect* rect);
-(UIImage*)scaleAndRotateImage:(UIImage *)image :(int)kMaxResolution;
@end
