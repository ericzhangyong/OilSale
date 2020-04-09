//
//  PSPlatformRouter.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/5.
//  Copyright © 2020 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlutterBoost.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSPlatformRouter : NSObject<FLBPlatform>

@property (nonatomic,strong) UINavigationController *navigationController;


/// 注册methodChannel
/// @param engine FlutterEngine
-(void)registFlutterMethodChannelWithEngine:(FlutterEngine *)engine;



/// native调用flutter
/// @param eventName flutter需监听的eventName
/// @param arguments 参数
// callback flutter端返回值callback
+ (void)sendEventToFlutter:(NSString *)eventName
                 arguments:(NSDictionary * _Nullable)arguments
                    result:(FlutterResult _Nullable)callback;

@end

NS_ASSUME_NONNULL_END
