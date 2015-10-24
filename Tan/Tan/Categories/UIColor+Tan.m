//
//  UIColor+Tan.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "UIColor+Tan.h"

@implementation UIColor (Tan)

+ (UIColor*) colorFromRGB:(NSInteger)RGB
{
    return [UIColor colorWithRed:((CGFloat)((RGB&0xFF0000) >> 16))/255.0
                           green:((CGFloat)((RGB&0x00FF00) >> 8))/255.0
                            blue:((CGFloat)((RGB&0x0000FF)))/255.0
                           alpha:(CGFloat)1.0];
}

+ (UIColor*) colorFromRGB:(NSInteger)RGB withAlpha:(CGFloat)alpha
{
    if (alpha < 0.0) alpha = 0.0;
    if (alpha > 1.0) alpha = 1.0;
    
    return [UIColor colorWithRed:((CGFloat)((RGB&0xFF0000) >> 16))/255.0
                           green:((CGFloat)((RGB&0x00FF00) >> 8))/255.0
                            blue:((CGFloat)((RGB&0x0000FF)))/255.0
                           alpha:(CGFloat)alpha];
}

@end
