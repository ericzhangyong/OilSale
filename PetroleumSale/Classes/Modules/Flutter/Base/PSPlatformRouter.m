//
//  PSPlatformRouter.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/5.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPlatformRouter.h"
#import "REMainTabManager.h"

@implementation PSPlatformRouter

-(void)registFlutterMethodChannelWithEngine:(FlutterEngine *)engine{
    
    NSObject<FlutterPluginRegistrar>* registrar = [engine registrarForPlugin:@"PSBoostPlugin"];
    [FlutterBoostPlugin registerWithRegistrar:registrar];
}


#pragma mark- FLBPlatform

-(void)open:(NSString *)url urlParams:(NSDictionary *)urlParams exts:(NSDictionary *)exts completion:(void (^)(BOOL))completion{
    
    if ([url isEqualToString:@"native"]) {
        return;
    }
//    BOOL animated = [exts[@"animated"] boolValue];
    FLBFlutterViewContainer *container  = FLBFlutterViewContainer.new;
    [container setName:url params:urlParams];
    
    UINavigationController *nav = REMainTabManager.sharedManager.tabBarController.selectedViewController;
    [nav pushViewController:container animated:YES];
}

-(void)present:(NSString *)url urlParams:(NSDictionary *)urlParams exts:(NSDictionary *)exts completion:(void (^)(BOOL))completion{
    
     if ([url isEqualToString:@"native"]) {
         return;
     }
    //    BOOL animated = [exts[@"animated"] boolValue];
    FLBFlutterViewContainer *container  = FLBFlutterViewContainer.new;
    [container setName:url params:urlParams];
    [self.navigationController presentViewController:container animated:YES completion:^{
        
    }];
}

- (void)close:(NSString *)uid result:(NSDictionary *)result exts:(NSDictionary *)exts completion:(void (^)(BOOL))completion{
    
//    BOOL animated = [exts[@"animated"] boolValue];
    UINavigationController *nav = REMainTabManager.sharedManager.tabBarController.selectedViewController;
    FLBFlutterViewContainer *container = (id)nav.presentingViewController;

    if ([container isKindOfClass:[FLBFlutterViewContainer class]] && [container.uniqueIDString isEqual: uid]) {
        [container dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [nav popViewControllerAnimated:YES];
    }
    
}


+ (void)sendEventToFlutter:(NSString *)eventName
                 arguments:(NSDictionary *)arguments
                    result:(FlutterResult _Nullable)callback
{
//    [[FlutterBoostPlugin sharedInstance].channel invokeMethod:eventName
//                                                     arguments:arguments
//                                                        result:callback];
    
}

@end
