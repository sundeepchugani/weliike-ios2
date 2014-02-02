//
//  ImageFilterController.h
//
//  Created by Satyendra on 11/4/11.
//  Copyright (c) 2011 Clixtr, Inc. All rights reserved.
//

//#import <QuartzCore/QuartzCore.h>
#import "TVImageFilterController.h"
#import "TVImageFilter.h"
#import "TVImageFilterForFrame.h"
#import "UIImage+FiltrrCompositions.h"

//#import "UIImage+Cngram.h"
#import "UIImage+Filter.h"

//#import "Filters.h"
//#import "define.h"
//@interface TVImageFilterController () {
//    Filters * _filter;
//}
//@end


@implementation TVImageFilterController
//For Free
//>> Sepia Noir
//>> Sapphire Noir
//>> Black&White Grained
//
//For Paid
//>> Halftone Sharp
//>> Derby
//
//For Unlocked
//>> Aged
+ (UIImage *) filteredImageWithImage:(UIImage *)image filter:(int)filterCase{
    TVImageFilterForFrame *filterFrame = [[TVImageFilterForFrame alloc] initImage];
    switch (filterCase) {
        case 0:{
            //-------- Filter for Lamo-fi ------------(Completed)              
            UIImage *img = [filterFrame imageWithBorderFromImage: image :[UIImage imageNamed:@"borderRoughInstagram.png"]];
            //    [filterFrame release];
            return [[[[img bias:0.9999] adjust:0.255 g:0.250 b:0.295] adjust:0.175 g:0.150 b:0.105] brightness:0.887648];
            break;
        }
        case 1:{
            //-------- Filter for Amaro --------------(Resolved but pending transparent image)
            //[filterFrame release];
            //               return [[[[image bias:0.9999] adjust:0.152 g:0.280 b:0.152] saturate:0.791100] brightness:0.988948];//186-85-211
            
            UIImage *img = [[[[image bias:0.9999] adjust:0.152 g:0.280 b:0.152] saturate:0.791100] brightness:0.988948];//186-85-211
            UIImage *img1 = [filterFrame imageWithBorderFromImage:img :[UIImage imageNamed:@"Sutro_filter.png"]];
            return img1;
            //    [filterFrame release];
            
            //               return [[[[image bias:0.9999] adjust:0.152 g:0.351 b:0.152] saturate:0.791100] brightness:0.988948];//186-85-211
            //return [[image bias:0.9999] adjust:0.186 g:0.85 b:0.211];
            break;
        }
        case 2:{
            //-------- Filter for Inkwell ------------(Completed)
            UIImage *img = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"filterBorderPlainWhite.png"]];
            //   [filterFrame release];
            //return [[[image greyscale] adjust:0.255 g:0.255 b:0.255] brightness:1.010540];
            return [[[img greyscale] brightness:1.033940] adjust:0.255 g:0.255 b:0.255];
            break;
        }
        case 3:{
            //-------- Filter for Valencia ----------- 
            //   [filterFrame release];
            //return [[[image polaroidish] brightness:1.043940] adjust:0 g:-3.566 b:0];//sky blue
            //return [[[image polaroidish] brightness:1.045940] adjust:0.028865 g:0 b:0];
            //              return [[[image adjust:0.0 g:0.047970 b:0] brightness:1.089999] saturate:0.981100];
            //return [[[image adjust:0.0 g:0.049970 b:0] brightness:1.089999] saturate:0.781100];
            return [[[[[image polaroidish] adjust:0.12000 g:0 b:0] adjust:0 g:0.10000 b:0] brightness:1.300838] saturate:0.743678];
            //return [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"Valencia_filter.png"]];
            break;
        }
        case 4:{
            //-------- Filter for  X-pro || --------------(Completed)
            UIImage *img = [filterFrame imageWithBorderFromImage: image :[UIImage imageNamed:@"filterBorderBlackBevel.png"]];
            UIImage *img1 = [filterFrame imageWithBorderFromImage:img :[UIImage imageNamed:@"redYellowGradient.png"]];
            //    [filterFrame release];
            return img1;
            break;
        }
        case 5:{
            //-------- Filter for  Rise ----------(Completed But pending for transparent image)
            //   UIImage *img = [[filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"edgeBurn.jpg"]] brightness:0.999999];
            //UIImage *img1 = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"Rise_c2.png"]];
            SEL _track = NSSelectorFromString(@"trackTime:");
            return [image performSelector:_track withObject:@"e5"];
            //   [filterFrame release];
            //return img;
            // return img1;
            
            break;
        }
        case 6:{
            //-------- Filter for  Walden ------------(Pennding apply transparent image)
            //     [filterFrame release];
            //               return [[[[[image polaroidish] adjust:0.23000 g:0 b:0] adjust:0 g:0.10000 b:0] gamma:0.998123] brightness:1.000838];// contrast:0.0000406];
            
            return [[[[[image polaroidish] adjust:0.32000 g:0 b:0] adjust:0 g:0.10000 b:0] brightness:1.000838] saturate:0.743678];// contrast:0.0000406];//255-69-0
            break;
        }
        case 7:{
            //-------- Filter for  Nashville ---------- (Resolved)
            SEL _track = NSSelectorFromString(@"trackTime:");
            //    [filterFrame release];
            //               return [[[[[[image adjust:0.40  g:0 b:0] bias:0.9999] adjust:0.255 g:0.250 b:0.240] polaroidish] brightness:1.0000] contrast:0.999999];// 0.912261 brightness:0.10000];
            
            //return [[[[[image polaroidish] adjust:0.38000 g:0 b:0] adjust:0 g:0.05092 b:0] brightness:0.990999] saturate:0.643678];
            return [image performSelector:_track withObject:@"e1"];
            //return [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"Nashville_filter.png"]];
            break;
        }
        case 8:{
            //-------- Filter for Hudson ------------
            //[filterFrame release];
            // return [[img brightness:1.25] bias:1.1];
            return [[[[image adjust:0 g:0.049970 b:0] opacity:.7]brightness:1.089999] adjust:0 g:0 b:.25] ;
            break;
        }
        case 9:{
            //-------- Filter for Sutro ------------(Resolved)
            //      [filterFrame release];
            return [[[[[image polaroidish] adjust:0.38000 g:0 b:0] adjust:0 g:0.05092 b:0] brightness:0.770948] saturate:0.643678];
            break;
        }
        case 10:{
            //-------- Filter for  Earlybird ---------(Pennding)
            UIImage *img = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"filterBorderBeigeTextured.png"]];
            //UIImage *img1 = [filterFrame imageWithBorderFromImage:img :[UIImage imageNamed:@"earlybird3-1-2.png"]];
            //     [filterFrame release];
            //               return [[[[[img polaroidish] adjust:0.26000 g:0 b:0] adjust:0 g:0.0500 b:0] brightness:1.0000] saturate:0.781100];//178-34-34
            //return [image adjust:0.178 g:0.34 b:0.34];
            
            SEL _track = NSSelectorFromString(@"trackTime:");
            return [img performSelector:_track withObject:@"e5"];
            
            // return img1;
            break;
            
        }
        case 11:{
            //-------- Filter for Brannan ------------(Penning apply transparent image)
            //[filterFrame release];
            //               return img1;
            return [[[[[[[[[[[image adjust:0 g:0 b:0] brightness:1.15] gamma:.99]adjust:0.38000 g:0 b:0] brightness:1.1]polaroidish] adjust:0 g:0.05092 b:0] brightness:0.990999] bias:.95]saturate:0.643678] gamma:.98];
            break;
        }
            
        case 12:{
            //-------- Filter for Toaster_filter ------------(Penning apply transparent image)
            UIImage *img = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"Toaster_filter.png"]];//Toaster_s29_9
            UIImage *img1 = [filterFrame imageWithBorderFromImage:img :[UIImage imageNamed:@"Toaster_s29_9.png"]];
            //     [filterFrame release];
            SEL _track = NSSelectorFromString(@"trackTime:");
            return [img1 performSelector:_track withObject:@"e8"];
            
            // return img1;
            break;
        }
            
        case 13:{
            //-------- Filter for Kelvin_filter ------------
            UIImage *img = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"Kelvin_Filter_Img.png"]];
            //[filterFrame release];
            //               return img;
            return [[[[[img adjust:0 g:0 b:.1]bias:.8] brightness:1.25] saturate:.95] brightness:1.25];
            
            break;           }
            
        case 14:{
            //-------- Filter for Hefe_filter ------------
            UIImage *img = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"Hefe_Filter_Img.png"]];
            //[filterFrame release];
            return [[[[[img adjust:0 g:0 b:.05]bias:.95] brightness:1.05] saturate:.97] brightness:1.05];    // this is original hefe
            return img;
            break;
        }
            
        case 15:{
            //-------- Filter for Lo fi ------------
            // UIImage *img = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"Earlybird_filter.png"]];
            //    [filterFrame release];
            // return img;
            SEL _track = NSSelectorFromString(@"trackTime:");
            return [image performSelector:_track withObject:@"e3"];
            
            break;
        }
            
        case 16:{
            //-------- Filter for 1977_filter ------------
            //UIImage *img = [filterFrame imageWithBorderFromImage:image :[UIImage imageNamed:@"1977_filter.png"]];
            //   [filterFrame release];
            //return img;
            
            SEL _track = NSSelectorFromString(@"trackTime:");
            //    [filterFrame release];
            //               return [[[[[[image adjust:0.40  g:0 b:0] bias:0.9999] adjust:0.255 g:0.250 b:0.240] polaroidish] brightness:1.0000] contrast:0.999999];// 0.912261 brightness:0.10000];
            
            //return [[[[[image polaroidish] adjust:0.38000 g:0 b:0] adjust:0 g:0.05092 b:0] brightness:0.990999] saturate:0.643678];
            return [image performSelector:_track withObject:@"e6"];
            break;
        }
            
        default:
            return image;
            break;
    }
    return image;
    
}

@end