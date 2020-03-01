//
//  PSSaveUploadImageUrl.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/5.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSaveUploadImageUrl : BaseRequest

/// 失败无需上传，则当前值直接写 true就好
@property (nonatomic,assign) BOOL state;
/// 上传的url的id
@property (nonatomic,assign) NSInteger upload_id;
@end

NS_ASSUME_NONNULL_END
