//
//  FSResetSecretRequest.h
//  FireStore
//
//  Created by eric on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REForgetSecretRequest : BaseRequest
/** mobile */
@property (nonatomic,copy) NSString *user_phone;

/** password */
@property (nonatomic,copy) NSString *user_pwd;

/** 短信验证码 */
@property (nonatomic,copy) NSString *ver_code;

@end

NS_ASSUME_NONNULL_END
