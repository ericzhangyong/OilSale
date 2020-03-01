//
//  MMAlertView+BaseAlertManger.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "MMAlertView+BaseAlertManger.h"

@implementation MMAlertView (BaseAlertManger)

+(void)showWithTitle:(NSString  *)title sureBtn:(NSString *)sBtn
{
    [self showWithTitle:title detail:nil cancelBtn:nil sureBtn:sBtn handler:nil];
}
+(void)showWithDetail:(NSString *)detail sureBtn:(NSString *)sBtn
{
    [self showWithTitle:nil detail:detail cancelBtn:nil sureBtn:sBtn handler:nil];
}
+(void)showWithTitle:(NSString *)title detail:(NSString *)detail sureBtn:(NSString *)sBtn
{
    [self showWithTitle:title detail:detail cancelBtn:nil sureBtn:sBtn handler:nil];
}

+(void)showWithTitle:(nullable NSString *)title detail:(nullable NSString *)detail cancelBtn:(nullable NSString *)cBtn sureBtn:(nullable NSString *)sBtn handler:(void (^)(void))block
{
    NSMutableArray *tArr = [NSMutableArray new];
    if (cBtn) {
        MMPopupItem *item1 =MMItemMake(cBtn, MMItemTypeNormal, ^(NSInteger index) {
            
        });
        [tArr addObject:item1];
    }
    if (sBtn) {
        MMPopupItem *item2 =MMItemMake(sBtn, MMItemTypeHighlight, ^(NSInteger index) {
            if (block) {
                block();
            }
        });
        item2.highlight = YES;
        [tArr addObject:item2];
    }
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    config.splitColor = fsColor_DDDDDD;
    config.itemHighlightColor = fsColor_207DF3;
    config.itemNormalColor = fsColor_333333;
    config.titleFontSize =16;
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:detail items:tArr];
    [alertView show];
}

+(void)showWithTitle:(nullable NSString *)title detail:(nullable NSString *)detail cancelBtn:(nullable NSString *)cBtn sureBtn:(nullable NSString *)sBtn sureOrCanceHandler:(void (^)(BOOL sureButton))block
{
    NSMutableArray *tArr = [NSMutableArray new];
    if (cBtn) {
        MMPopupItem *item1 =MMItemMake(cBtn, MMItemTypeNormal, ^(NSInteger index) {
            if (block) {
                block(NO);
            }
        });
        [tArr addObject:item1];
    }
    if (sBtn) {
        MMPopupItem *item2 =MMItemMake(sBtn, MMItemTypeHighlight, ^(NSInteger index) {
            if (block) {
                block(YES);
            }
        });
        item2.highlight = YES;
        [tArr addObject:item2];
    }
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    config.splitColor = fsColor_DDDDDD;
    config.itemHighlightColor = fsColor_207DF3;
    config.itemNormalColor = fsColor_333333;
    config.titleFontSize =16;
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:detail items:tArr];
    [alertView show];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:14];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    
    return hud;
}
@end
