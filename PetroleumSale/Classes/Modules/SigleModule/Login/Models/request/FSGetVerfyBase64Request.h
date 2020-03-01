//
//  FSGetVerfyBase64Request.h
//  FireStore
//
//  Created by eric on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REGetVerfyBase64Request : BaseRequest

/** 图形验证码token */
@property (nonatomic,copy) NSString *imgCodeToken;


/** 类型(1:短信登录 2:忘记密码 3:绑定手机号 4:解绑手机号 5:用户注册 6:设置密码) */
@property (nonatomic,assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
