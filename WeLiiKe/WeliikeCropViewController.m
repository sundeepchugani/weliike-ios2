//
//  WeliikeCropViewController.m
//  WeLiiKe
//
//  Created by anoop gupta on 01/05/13.
//
//

#import "WeliikeCropViewController.h"


@implementation WeliikeCropViewController
@synthesize sizeForCrop,imgSet,s,lbl;

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
    [self.tabBarController setTabBarHidden:YES animated:NO completion:NULL];
    scrollViewForCrop=[[UIScrollView alloc] initWithFrame:sizeForCrop];
    NSLog(@"string    = = = = = = %@",s);
    lbl.text = s;
    [scrollViewForCrop setBackgroundColor:[UIColor whiteColor]];
    scrollViewForCrop.delegate=self;
    [scrollViewForCrop setShowsHorizontalScrollIndicator:NO];
    [scrollViewForCrop setShowsVerticalScrollIndicator:NO];
    //scrollViewForCrop.userInteractionEnabled=NO;
    [self.view addSubview:scrollViewForCrop];
    //NSLog(@"image width %f and hieght %f",imgSet.size.width,imgSet.size.height);
    imgSet=[self scaleAndRotateImage:imgSet :960];
     //NSLog(@"image width %f and hieght %f",imgSet.size.width,imgSet.size.height);
    UIImage *imageload=imgSet;
    imgView=[[UIImageView alloc] initWithImage:imageload];
    //imgView.contentMode=UIViewContentModeCenter;
    
    CGFloat imageWidth = imageload.size.width;
    CGFloat imageHeight = imageload.size.height;
    
    int scrollWidth = scrollViewForCrop.frame.size.width;
    int scrollHeight = scrollViewForCrop.frame.size.height;
    
    float scaleX = scrollWidth / imageWidth;
    float scaleY = scrollHeight / imageHeight;
    float scaleScroll =  (scaleX < scaleY ? scaleY : scaleX);
    //scrollViewTakePhoto.bounds = CGRectMake(0, 0,imageWidth , imageHeight );
    scrollViewForCrop.contentSize = imageload.size;
    scrollViewForCrop.maximumZoomScale = scaleScroll*3;
    scrollViewForCrop.minimumZoomScale = scaleScroll;
    scrollViewForCrop.zoomScale = scaleScroll;
    [scrollViewForCrop addSubview:imgView];
    
    // Do any additional setup after loading the view from its nib.
}

-(UIImage*)scaleAndRotateImage:(UIImage *)image :(int)kMaxResolution
{
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform); 
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


/****** UIScrollView delegate for zooming **********/
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}
/**************************************************/



-(IBAction)actionOnBack:(id)sender{
    
    [self.tabBarController setTabBarHidden:NO animated:NO completion:NULL];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)actionOnDone:(id)sender{
    
    //(100, 100, 150, 280)
    
    [self.tabBarController setTabBarHidden:NO animated:NO completion:NULL];
    
    CGRect visibleRect;
    float scale = 1.0f/scrollViewForCrop.zoomScale;
    visibleRect.origin.x = scrollViewForCrop.contentOffset.x * scale;
    visibleRect.origin.y = scrollViewForCrop.contentOffset.y * scale;
    visibleRect.size.width = scrollViewForCrop.bounds.size.width * scale;
    visibleRect.size.height = scrollViewForCrop.bounds.size.height * scale;
	

    UIImage* cropped = imageFromView1(imgView.image, &visibleRect);
    
    if ([_delegate respondsToSelector:@selector(getCroppedImage:)]) {
        [_delegate getCroppedImage:cropped];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
UIImage* imageFromView1(UIImage* srcImage, CGRect* rect)
{
    CGImageRef cr = CGImageCreateWithImageInRect(srcImage.CGImage, *rect);
    UIImage* cropped = [UIImage imageWithCGImage:cr];
    
    CGImageRelease(cr);
    return cropped;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
