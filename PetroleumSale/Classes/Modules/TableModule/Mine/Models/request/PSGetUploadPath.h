//
//  PSGetUploadPath.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/5.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSGetUploadPath : BaseRequest

/// 请求获取的上传路径个数 0 - 5
@property (nonatomic,assign) NSInteger req_url_num;
@end

NS_ASSUME_NONNULL_END
