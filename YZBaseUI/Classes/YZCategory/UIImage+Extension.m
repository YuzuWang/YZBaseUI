//
//  UIImage+Extension.m
//  Apiyoo
//
//  Created by Nansi on 2020/3/16.
//  Copyright © 2020 apiyoo. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (instancetype)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
