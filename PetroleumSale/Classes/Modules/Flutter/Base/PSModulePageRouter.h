//
//  PSModulePageRouter.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/5.
//  Copyright © 2020 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^pageResultCallback)(NSDictionary *result);
typedef void(^openPageFinished)(BOOL isFinish);

@interface PSModulePageRouter : NSObject

//+(instancetype)shareManager{
//    static PSModulePageRouter  = nil;
//
//}

/// 打开仓库列表
/// @param urlParam <#urlParam description#>
/// @param resultCallback <#resultCallback description#>
/// @param complete <#complete description#>
+ (void)openWareHoursePageWithParam:(NSDictionary *)urlParam
                         PageFinish:(pageResultCallback)resultCallback
                           complete:(openPageFinished)complete;



@end

NS_ASSUME_NONNULL_END
