//
//  PSModulePageRouter.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/5.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSModulePageRouter.h"
//#import <flutter_boost/FlutterBoostPlugin.h>



//static NSDictionary *map = {
//    @"wareHourse":@"mine//mine_ware_page"
//};


@implementation PSModulePageRouter

+ (void)openWareHoursePageWithParam:(NSDictionary *)urlParam
                         PageFinish:(pageResultCallback)resultCallback
                           complete:(openPageFinished)complete{
    
//    [FlutterBoostPlugin open:@"wareHourse" urlParams:@{kPageCallBackId:@"MycallbackId#1"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary *result) {
//        NSLog(@"call me when page finished, and your result is:%@", result);
//    } completion:^(BOOL f) {
//        NSLog(@"page is opened");
//    }];
}

//打开页面的即时回调，页面一旦打开即回调
//+ (void)openWareHoursePageWithParam:(NSDictionary *)urlParam PageFinish:(onPageFinished)resultCallback complete:(openPageFinished)complete{
//
//}


@end
