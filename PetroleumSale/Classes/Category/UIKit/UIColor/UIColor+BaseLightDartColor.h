//
//  UIColor+BaseLightDartColor.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/23.
//  Copyright © 2020 eric. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define color_lightDart_f3f3f3 [UIColor color_lightDart_hexString:@"f3f3f3"]
#define color_lightDart_white [UIColor color_lightDart_WhiteColor]
#define color_lightDart_333333 [UIColor color_lightDart_hexString:@"333333"]
#define color_lightDart_white_black [UIColor color_lightDart_hexString:@"ffffff" darkHexStr:@"000000"]
#define color_lightDart_fafafa [UIColor color_lightDart_hexString:@"fafafa"]
#define color_lightDart_f3f3f3_333333 [UIColor color_lightDart_hexString:@"f3f3f3" darkHexStr:@"333333"]
#define color_lightDart_f3f3f3_000000 [UIColor color_lightDart_hexString:@"f3f3f3" darkHexStr:@"000000"]
#define color_lightDart_E9E9E9 [UIColor color_lightDart_hexString:@"E9E9E9"]


@interface UIColor (BaseLightDartColor)


/// 白色
+(UIColor *)color_lightDart_WhiteColor;
/// 黑色
+(UIColor *)color_lightDart_blackColor;
/// hex
+(UIColor *)color_lightDart_hexString:(NSString *)hexString;
/// hex
+(UIColor *)color_lightDart_hexString:(NSString *)hexString
                           darkHexStr:(NSString *)darkHexStr;

@end

NS_ASSUME_NONNULL_END
