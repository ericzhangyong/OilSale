//
//  RERegistRequest.h
//  FireStore
//
//  Created by eric on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface RERegistRequest : BaseRequest

/** phone */
@property (nonatomic,copy) NSString *user_phone;

/** 真实姓名 */
@property (nonatomic,copy) NSString *real_name;

/** 邀请码 */
@property (nonatomic,copy) NSString *invite_code;

/** 登录密码 */
@property (nonatomic,copy) NSString *user_pwd;

/** 短信验证码id */
@property (nonatomic,copy) NSString *ver_code;



@end

NS_ASSUME_NONNULL_END
