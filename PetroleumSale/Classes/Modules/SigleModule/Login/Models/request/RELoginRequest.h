//
//  RELoginRequest.h
//  FireStore
//
//  Created by eric on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface RELoginRequest : BaseRequest


/** 手机号 */
@property (nonatomic,copy) NSString *user_phone;
/** 密码 */
@property (nonatomic,copy) NSString *user_pwd;

/** 短信验证码(2必填) */
@property (nonatomic,copy) NSString *ver_code;
///：pwd-->密码登陆  code--->短信验证码登陆
@property (nonatomic,copy) NSString *verify_type;
@end

NS_ASSUME_NONNULL_END
