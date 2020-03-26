//
//  UIColor+Extension.m
//  Apiyoo
//
//  Created by Nansi on 2020/3/14.
//  Copyright © 2020 apiyoo. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)


/// Hex 颜色转换
/// @param stringToConvert HEX 色值
+ (UIColor *)s_colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6 && [cString length] != 8) return [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *alpha;
    
    if (cString.length == 8) {
        alpha = [cString substringWithRange:range];
        range.location += 2;
    }else {
        alpha = @"ff";
    }
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location += 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location += 2;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:alpha] scanHexInt:&a];
    
    NSLog(@"%d, %d, %d, %d", r,g,b,a);
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}



/// 动态颜色
/// @param lightColor 默认模式下的颜色
/// @param darkColor 暗黑模式下的颜色
+ (instancetype)dynamicColorWithLight:(UIColor *)lightColor
                                 dark:(UIColor *)darkColor
{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return lightColor;
            }
            else {
                return darkColor;
            }
            
        }];
    } else {
        return lightColor;
    }
    
}


@end
