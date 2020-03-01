//
//  MBProgressHUD+BaseProgressManager.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (BaseProgressManager)

/**
 吐司：默认二秒消失
 
 @param view view为nil时添加到window上面
 @param message 显示的文字
 */
+ (void)toastMessageAddedTo:(nullable UIView *)view message:(nullable NSString *)message;


/**
 横屏吐司
 
 @param view 添加到的父类
 @param message 显示的消息
 */
+ (void)landscapeRightToastMessageAddedTo:(nullable UIView *)view message:(nullable NSString *)message;

+ (void)toastMessageAtMiddle:(nullable NSString *)message;


/**
 吐司
 
 @param view 添加到的父类
 @param message 显示的文字
 @param offsetY 剧垂直中心的偏移量
 */
+ (void)toastMessageAddedTo:(nullable UIView *)view message:(nullable NSString *)message offsetY:(CGFloat)offsetY;

/**
 显示HUD
 
 @param view view为nil时添加到window上面
 @param text 显示的文字
 */
+ (instancetype)showHUDAddedTo:(UIView *)view text:(NSString *)text;


/**
 显示HUD
 
 @param view 添加到的父类
 @param text 显示的文字
 @param offsetY 剧垂直中心的偏移量
 @return MBProgressHUD
 */
+ (instancetype)showHUDAddedTo:(UIView *)view text:(NSString *)text offsetY:(CGFloat)offsetY;


@end

NS_ASSUME_NONNULL_END
