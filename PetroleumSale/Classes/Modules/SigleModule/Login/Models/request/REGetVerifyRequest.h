//
//  REGetVerifyRequest.h
//  FireStore
//
//  Created by eric on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REGetVerifyRequest : BaseRequest



/** 手机号 */
@property (nonatomic,copy) NSString *user_phone;

/// 验证码类型 1 注册验证码 2 登录验证码 3 密码找回验证码
@property (nonatomic,assign) NSInteger code_type;




@end

NS_ASSUME_NONNULL_END
