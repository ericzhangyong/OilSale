//
//  MMAlertView+BaseAlertManger.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "MMAlertView.h"


NS_ASSUME_NONNULL_BEGIN

@interface MMAlertView (BaseAlertManger)

+(void)showWithTitle:(nullable NSString *)title sureBtn:(nullable NSString *)sBtn;
+(void)showWithDetail:(nullable NSString *)detail sureBtn:(nullable NSString *)sBtn;
+(void)showWithTitle:(nullable NSString *)title detail:(nullable NSString *)detail sureBtn:(nullable NSString *)sBtn;

+(void)showWithTitle:(nullable NSString *)title detail:(nullable NSString *)detail cancelBtn:(nullable NSString *)cBtn sureBtn:(nullable NSString *)sBtn handler:(nullable void (^)(void))block;
+(void)showWithTitle:(nullable NSString *)title detail:(nullable NSString *)detail cancelBtn:(nullable NSString *)cBtn sureBtn:(nullable NSString  *)sBtn sureOrCanceHandler:(nullable void (^)(BOOL sureButton))block;


@end

NS_ASSUME_NONNULL_END
