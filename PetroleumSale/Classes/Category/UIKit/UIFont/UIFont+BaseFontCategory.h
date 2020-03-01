//
//  UIFont+FSFontCategory.h
//  FireStore
//
//  Created by eric on 2019/8/30.
//  Copyright © 2019 eric. All rights reserved.
//



//NS_ASSUME_NONNULL_BEGIN

@interface UIFont (BaseFontCategory)
/**
 *  设置系统字号
 */
+ (UIFont *)systemWEFontOfSize:(CGFloat)fontSize;

+ (UIFont *)systemPlusFontOfSize:(CGFloat)fonSize;
/**
 *  设置加粗系统字号
 */
+ (UIFont *)boldSystemLJFontOfSize:(CGFloat)fontSize;


/**
 *  设置字体格式为 PingFangSC Light 方法
 */
+ (UIFont *)systemWEPingFanglightFontOfSize:(CGFloat)fontSize;

/**
 *  设置字体格式为 PingFangSC Regular 方法
 */
+ (UIFont *)systemWEPingFangRegularOfSize:(CGFloat)fontSize;

/**
 *  设置字体格式为 PingFangSC Bold 方法
 */
+ (UIFont *)systemWEPingFangBoldFontOfSize:(CGFloat)fontSize;
/**
 *  设置字体格式为 PingFangSC Medium 方法
 */
+ (UIFont *)systemWEPingFangMediumFontOfSize:(CGFloat)fontSize;

@end

//NS_ASSUME_NONNULL_END
