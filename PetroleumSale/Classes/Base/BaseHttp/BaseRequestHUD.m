//
//  BaseRequestHUD.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/23.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseRequestHUD.h"
#import "MBProgressHUD.h"
#import "MMIndicator.h"

@interface BaseRequestHUD ()
{
    MBProgressHUD *_busyingHud;
    MBProgressHUD *_tipHud;
}
@end

@implementation BaseRequestHUD



+ (instancetype)sharedRequestHUD
{
    static BaseRequestHUD *ffRequestHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ffRequestHUD = [[BaseRequestHUD alloc] init];
    });
    
    return ffRequestHUD;
}

-(void)clearAllHUD
{
    
}

-(void)showRequestBusying
{
    if (_busyingHud) {
        [_busyingHud hideAnimated:NO];
        _busyingHud = nil;
    }
    UIView *result = [UIApplication sharedApplication].keyWindow;
    _busyingHud = [[MBProgressHUD alloc] initWithView:result];
    _busyingHud.removeFromSuperViewOnHide = YES;
    //    _busyingHud.userInteractionEnabled = NO;
    //    _busyingHud.dimBackground = YES;
    _busyingHud.bezelView.color = [UIColor clearColor];
    _busyingHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _busyingHud.mode = MBProgressHUDModeCustomView;
    MMIndicator *spinnerView = [[MMIndicator alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    spinnerView.progressColor = fsColor_207DF3;
    spinnerView.lineWidth = 3.0;
    [spinnerView startAnimating];
    _busyingHud.customView = spinnerView;
    
    
    [result addSubview:_busyingHud];
    [_busyingHud showAnimated:YES];;
    //    return _busyingHud;
}
-(void)hideRequestBusying
{
    [_busyingHud hideAnimated:YES];
    _busyingHud = nil;
}

-(void)showTipView:(UIView*)view
{
    if (_tipHud) {
        [_tipHud hideAnimated:NO];
        _tipHud = nil;
    }
    UIView *result = [UIApplication sharedApplication].keyWindow;;
    _tipHud = [[MBProgressHUD alloc] initWithView:result];
    _tipHud.removeFromSuperViewOnHide = YES;
    _tipHud.bezelView.color = [UIColor clearColor];
    _tipHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _tipHud.mode = MBProgressHUDModeCustomView;
    _tipHud.customView = view;
    _tipHud.backgroundView.color = [UIColor colorWithWhite:0.0 alpha:0.6];
    
    [result addSubview:_tipHud];
    [_tipHud showAnimated:YES];
    [_tipHud hideAnimated:YES afterDelay:3.0];
}
-(void)hideTipView
{
    
    
}
@end
