//
//  REUpdateSecretRequest.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/10/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REUpdateSecretRequest : BaseRequest


/** newPassword */
@property (nonatomic,copy) NSString *password;

/** 旧密码 */
@property (nonatomic,copy) NSString *oldPwd;

@end

NS_ASSUME_NONNULL_END
