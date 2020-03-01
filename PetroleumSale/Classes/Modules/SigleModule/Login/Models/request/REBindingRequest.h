//
//  REBindingRequest.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/10/9.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REBindingRequest : BaseRequest


/** mobile */
@property (nonatomic,copy) NSString *mobile;

/** 图形验证码token */
@property (nonatomic,copy) NSString *imgCodeToken;

/** 图形验证码 */
@property (nonatomic,copy) NSString *imgCode;

///** password */
//@property (nonatomic,copy) NSString *password;

/** 短信验证码 */
@property (nonatomic,copy) NSString *smsCode;
@end

NS_ASSUME_NONNULL_END
