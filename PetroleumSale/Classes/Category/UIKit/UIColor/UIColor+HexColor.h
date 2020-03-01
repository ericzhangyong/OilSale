//
//  UIColor+FSHexColor.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColor)


/**
 *  六位16进制：0xff00cc
 *  @param hex 六位16进制
 *  @return UIColor
 */
+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

/**
 *  返回十六进制字符串颜色对象
 *
 *  @param hexStr 十六进制字符串颜色
 *
 *  @return 十六进制字符串Color
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr;
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;


/**
 *    随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)randomColor;
@end

NS_ASSUME_NONNULL_END
