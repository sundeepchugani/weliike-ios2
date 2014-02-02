

#import "EGOPhotoScrollView.h"
#import "FeedViewController.h"
#import "ZoomView.h"
extern BOOL checkForFeedScreen;

@implementation EGOPhotoScrollView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		self.scrollEnabled = YES;
		self.pagingEnabled = NO;
		self.clipsToBounds = NO;
		self.maximumZoomScale = 3.0f;
		self.minimumZoomScale = 1.0f;
		self.showsVerticalScrollIndicator = NO;
		self.showsHorizontalScrollIndicator = NO;
		self.alwaysBounceVertical = NO;
		self.alwaysBounceHorizontal = NO;
		self.bouncesZoom = YES;
		self.bounces = YES;
		self.scrollsToTop = NO;
		self.backgroundColor = [UIColor blackColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		
    }
    return self;
}

- (void)zoomRectWithCenter:(CGPoint)center{
	
	if (self.zoomScale > 1.0f) {

		[((ZoomView*)self.superview) killScrollViewZoom];
	    //[((FeedViewController*)self.superview) killScrollViewZoom];
        [self performSelector:@selector(toggleBars) withObject:nil afterDelay:.2];
		return;
	}

	CGRect rect;
	rect.size = CGSizeMake(self.frame.size.width / 2.5, self.frame.size.height / 2.5);
	rect.origin.x = MAX((center.x - (rect.size.width / 2.0f)), 0.0f);		
	rect.origin.y = MAX((center.y - (rect.size.height / 2.0f)), 0.0f);
	
	CGRect frame = [self.superview convertRect:self.frame toView:self.superview];
	CGFloat borderX = frame.origin.x;
	CGFloat borderY = frame.origin.y;
	
	if (borderX > 0.0f && (center.x < borderX || center.x > self.frame.size.width - borderX)) {
				
		if (center.x < (self.frame.size.width / 2.0f)) {
			
			rect.origin.x += (borderX/2.5);
			
		} else {
			
			rect.origin.x -= ((borderX/2.5) + rect.size.width);
			
		}	
	}
	
	if (borderY > 0.0f && (center.y < borderY || center.y > self.frame.size.height - borderY)) {
				
		if (center.y < (self.frame.size.height / 2.0f)) {
			
			rect.origin.y += (borderY/2.5);
			
		} else {

			rect.origin.y -= ((borderY/2.5) + rect.size.height);
			
		}
		
	}

	[self zoomToRect:rect animated:YES];	

}

- (void)toggleBars{
   // if (checkForFeedScreen==YES) {
  //      [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveZoomView" object:nil];
  //  }else{
       [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveZoomView" object:nil];
  //  }
	
}


#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesEnded:touches withEvent:event];
	UITouch *touch = [touches anyObject];
	
	if (touch.tapCount == 1) {
		[self performSelector:@selector(toggleBars) withObject:nil afterDelay:.2];
	} else if (touch.tapCount == 2) {
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toggleBars) object:nil];
		[self zoomRectWithCenter:[[touches anyObject] locationInView:self]];
	}
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [super dealloc];
}


@end
