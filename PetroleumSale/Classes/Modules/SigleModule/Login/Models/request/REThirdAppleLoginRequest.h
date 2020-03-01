//
//  REThirdAppleLoginRequest.h
//  RippleElephantPlatform
//
//  Created by zhangyong on 2019/10/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REThirdAppleLoginRequest : BaseRequest
@property (nonatomic,copy) NSString *openid;
@property (nonatomic,copy) NSString *nickName;

@end

NS_ASSUME_NONNULL_END
