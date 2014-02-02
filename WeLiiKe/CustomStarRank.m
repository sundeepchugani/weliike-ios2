//
//  CustomStarRank.m
//  IftekharCustomClasses
//
//  Created by Gaurav Goyal on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomStarRank.h"

@implementation CustomStarRank
@synthesize delegate,strImage,strStarActImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)]];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)]];
        
        for (float i = 0; i<5; i++)
        {
            UIImageView *image = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(self.bounds.size.width*(i/5),
                                             self.bounds.origin.y,
                                             self.bounds.size.width/5,
                                             self.bounds.size.height)];
            if ([strImage length]>0) {
                [image setImage:[UIImage imageNamed:strImage]];
            }else{
               [image setImage:[UIImage imageNamed:@"star.png"]];
            }
            
            [self addSubview:image];
        }
        getNumberOfStar = 5;
        [self setValue:0];
        isDesable = NO;
    }
    return self;
}

-(NSInteger)NumberOfStar
{
    return getNumberOfStar;
}

-(void) setNumberOfStar:(NSInteger)NumberOfStar
{
    getNumberOfStar = NumberOfStar;
    
    for (UIView *view in self.subviews)
        [view removeFromSuperview];
    
    for (float i = 0; i<getNumberOfStar; i++)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(self.bounds.size.width*(i/getNumberOfStar),    self.bounds.origin.y,
                                         self.bounds.size.width/getNumberOfStar,        self.bounds.size.height)];
        
        [self addSubview:image];
    }
    [self setValue:getValue];
}

-(float)value
{
    NSNumber *myNumber = [NSNumber numberWithDouble:(getValue+0.5)];
    return [myNumber intValue];
}

-(void) setValue:(float)value
{    
    if (isDesable)
    {
        if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(CustomStarRank:Desabled:)])
            [delegate CustomStarRank:self Desabled:YES];
    }
    else
    {
        if (value<1 && (getValue+0.5)>=1) {
            value=0;
        }
        
        if (value<0)
            value = 0;
        else if (value>getNumberOfStar)
            value = getNumberOfStar;
        else
            value += 0.25;
        
        value = (float)(((int)(value*2))/2.0);
    
        if (getValue!=value)
        {
            if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(CustomStarRank:DidChangedValue:)])
                [delegate CustomStarRank:self DidChangedValue:value];            
        }    
        
        getValue = value;
        //NSLog(@"Get:%f",getValue);
           
        NSArray *stars = [[NSArray alloc] initWithArray:self.subviews];
        
        int Changes = getValue*2; 
        
        float i = 0;
        
        for (i = 0; i<Changes/2; i++)
        {
            if ([strStarActImage length]>0) {
                [[stars objectAtIndex:i] setImage:[UIImage imageNamed:strStarActImage]];
            }else{
                [[stars objectAtIndex:i] setImage:[UIImage imageNamed:@"star_active.png"]];
            }
            
            [[stars objectAtIndex:i] setFrame:CGRectMake(self.bounds.size.width*(i/getNumberOfStar), self.bounds.origin.y,
                                                         self.bounds.size.width/getNumberOfStar, self.bounds.size.height)];        
        }
        if (Changes%2)
        {
            if ([strStarActImage length]>0) {
                [[stars objectAtIndex:i] setImage:[UIImage imageNamed:strStarActImage]];
            }else{
                [[stars objectAtIndex:i] setImage:[UIImage imageNamed:@"star_active.png"]];

            }
            
            [[stars objectAtIndex:i] setFrame:CGRectMake(self.bounds.size.width*(i/getNumberOfStar), self.bounds.origin.y,
                                                         self.bounds.size.width/getNumberOfStar, self.bounds.size.height)];
            i++;
        }
        for ( ; i<getNumberOfStar; i++)
        {
            if ([strImage length]>0) {
                [[stars objectAtIndex:i] setImage:[UIImage imageNamed:strImage]];
            }else{
                [[stars objectAtIndex:i] setImage:[UIImage imageNamed:@"star.png"]];
            }
            
            [[stars objectAtIndex:i] setFrame:CGRectMake(self.bounds.size.width*(i/getNumberOfStar), self.bounds.origin.y,
                                                         self.bounds.size.width/getNumberOfStar, self.bounds.size.height)];
        }
        
        if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(CustomStarRank:Desabled:)])
            [delegate CustomStarRank:self Desabled:NO];
    }
}

-(void)setDesable:(BOOL)desable
{
    isDesable = desable;
}

- (void)sliderTapped:(UIGestureRecognizer *)recognizer
{
    
    CGPoint pt = [recognizer locationInView: self];
    CGFloat percentage = pt.x / self.frame.size.width;
    CGFloat delta = percentage * getNumberOfStar;
    CGFloat value = delta;
    if (value<0)
        value = 0;
    else if (value>getNumberOfStar)
        value = getNumberOfStar;
    else
        value = value;
    
    
    [self setValue:value];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if ([delegate respondsToSelector:@selector(tapOnSliderView:)]) {
            [delegate tapOnSliderView:self];
        }
    }
    
}

@end
