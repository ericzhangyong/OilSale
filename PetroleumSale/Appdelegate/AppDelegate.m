//
//  AppDelegate.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/21.
//  Copyright © 2019 eric. All rights reserved.
//

#import "AppDelegate.h"
#import "REMainTabManager.h"
//#import <flutter_boost/FlutterBoost.h>
//#import "PSPlatformRouter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
//    PSPlatformRouter *platformRouter = PSPlatformRouter.new;
//    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:platformRouter onStart:^(FlutterEngine * _Nonnull engine) {
//
//    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];;
    self.window.backgroundColor= [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [REMainTabManager sharedManager].tabBarController;
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
