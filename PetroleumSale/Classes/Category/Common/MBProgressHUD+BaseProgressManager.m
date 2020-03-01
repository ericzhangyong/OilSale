//
//  MBProgressHUD+BaseProgressManager.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//


static MBProgressHUD *HUD;

#import "MBProgressHUD+BaseProgressManager.h"

@implementation MBProgressHUD (BaseProgressManager)

+ (void)toastMessageAddedTo:(nullable UIView *)view message:(NSString *)message {
    UIView *superView;
    if (view) {
        superView = view;
    } else {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    if (HUD) {
        [HUD hideAnimated:NO];
        [HUD removeFromSuperview];
    }
    HUD = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    HUD.label.font = [UIFont systemFontOfSize:16];
    HUD.margin = 10;
    HUD.detailsLabel.font = HUD.label.font;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabel.text = message;
    HUD.detailsLabel.textColor = HUD.label.textColor;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    HUD.userInteractionEnabled = NO;
    [HUD hideAnimated:YES afterDelay:2];
}

+ (void)landscapeRightToastMessageAddedTo:(nullable UIView *)view message:(nullable NSString *)message {
    UIView *superView;
    if (view) {
        superView = view;
    } else {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    if (HUD) {
        [HUD hideAnimated:NO];
        [HUD removeFromSuperview];
    }
    HUD = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    HUD.transform = CGAffineTransformMakeRotation(M_PI_2);
    HUD.bounds = CGRectMake(0, 0, CGRectGetHeight(HUD.superview.bounds), CGRectGetWidth(HUD.superview.bounds));
    HUD.center = CGPointMake(CGRectGetMidX(HUD.superview.bounds), CGRectGetMidY(HUD.superview.bounds));
    HUD.label.font = [UIFont systemFontOfSize:16];
    HUD.margin = 10;
    HUD.detailsLabel.font = HUD.label.font;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabel.text = message;
    HUD.detailsLabel.textColor = HUD.label.textColor;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    HUD.userInteractionEnabled = NO;
    [HUD hideAnimated:YES afterDelay:2];
}

+ (void)toastMessageAddedTo:(nullable UIView *)view message:(nullable NSString *)message offsetY:(CGFloat)offsetY {
    UIView *superView;
    if (view) {
        superView = view;
    } else {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    if (HUD) {
        [HUD hideAnimated:NO];
        [HUD removeFromSuperview];
    }
    HUD = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    HUD.label.font = [UIFont systemFontOfSize:16];
    HUD.margin = 10;
    HUD.detailsLabel.font = HUD.label.font;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabel.text = message;
    HUD.detailsLabel.textColor = HUD.label.textColor;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    HUD.userInteractionEnabled = NO;
    HUD.offset = CGPointMake(HUD.offset.x, offsetY);
    [HUD hideAnimated:YES afterDelay:2];
}

+ (void)toastMessageAtMiddle:(NSString *)message{
    
    [MBProgressHUD toastMessageAddedTo:nil message:message];
}

+ (instancetype)showHUDAddedTo:(UIView *)view text:(NSString *)text {
    UIView *superView;
    if (view) {
        superView = view;
    } else {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = 10;
    hud.label.font = [UIFont systemFontOfSize:16];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    if (text) {
        hud.label.text = text;
    } else {
        hud.label.text = nil;
    }
    return hud;
}

+ (instancetype)showHUDAddedTo:(UIView *)view text:(NSString *)text offsetY:(CGFloat)offsetY {
    UIView *superView;
    if (view) {
        superView = view;
    } else {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = 10;
    hud.label.font = [UIFont systemFontOfSize:16];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hud.offset = CGPointMake(hud.offset.x, offsetY);
    
    if (text) {
        hud.label.text = text;
    } else {
        hud.label.text = nil;
    }
    return hud;
}
@end
