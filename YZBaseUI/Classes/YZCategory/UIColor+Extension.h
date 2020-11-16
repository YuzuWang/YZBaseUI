//
//  UIColor+Extension.h
//  Apiyoo
//
//  Created by Nansi on 2020/3/14.
//  Copyright © 2020 apiyoo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

/// Hex 颜色转换
/// 默认 alpha 为1
/// @param stringToConvert HEX 色值
+ (UIColor *)s_colorWithHexString: (NSString *) stringToConvert;

/// 动态颜色
/// @param lightColor 默认模式下的颜色
/// @param darkColor 暗黑模式下的颜色
+ (instancetype)dynamicColorWithLight:(UIColor *)lightColor
                                 dark:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
