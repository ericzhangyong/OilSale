//
//  UIColor+BaseLightDartColor.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "UIColor+BaseLightDartColor.h"

#define ISDartModel traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark


@implementation UIColor (BaseLightDartColor)

+(UIColor *)color_lightDart_WhiteColor{
    
    if (@available(iOS 13.0, *)) {
      return  [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
           if (ISDartModel) {
               return color_333333;
           }else{
               return [UIColor whiteColor];
           }
        }];
    } else {
        return [UIColor whiteColor];
    }
}
/// 黑色
+(UIColor *)color_lightDart_blackColor{
   if (@available(iOS 13.0, *)) {
      return  [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
           if (ISDartModel) {
               return [UIColor whiteColor];
           }else{
               return [UIColor blackColor];
           }
        }];
    } else {
        return [UIColor blackColor];
    }
}

/// hex
+(UIColor *)color_lightDart_hexString:(NSString *)hexString{
    
    if (@available(iOS 13.0, *)) {
      return  [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
           if (ISDartModel) {
               return [UIColor filterWithHexString:hexString];
           }else{
               return [UIColor colorWithHexString:hexString];
           }
        }];
    } else {
        return [UIColor colorWithHexString:hexString];
    }
}


+(UIColor *)filterWithHexString:(NSString *)hexString{
    
    
    UIColor *color = [self getColorMap][hexString];
    if (color) {
        return color;
    }
    return [UIColor whiteColor];
}

+(NSDictionary *)getColorMap{
    return @{
        @"333333":[UIColor whiteColor],
        @"f3f3f3":color_333333,
        @"fafafa":color_333333
    };
}

/// hex
+(UIColor *)color_lightDart_hexString:(NSString *)hexString
                           darkHexStr:(NSString *)darkHexStr{
    if (@available(iOS 13.0, *)) {
      return  [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
           if (ISDartModel) {
               return [UIColor colorWithHexString:darkHexStr];
           }else{
               return [UIColor colorWithHexString:hexString];
           }
        }];
    } else {
        return [UIColor colorWithHexString:hexString];
    }
}

@end
