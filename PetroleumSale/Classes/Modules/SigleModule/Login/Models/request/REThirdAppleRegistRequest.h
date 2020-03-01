//
//  REThirdAppleRegistRequest.h
//  RippleElephantPlatform
//
//  Created by zhangyong on 2019/10/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REThirdAppleRegistRequest : BaseRequest

/** openid */
@property (nonatomic,copy) NSString *openid;
///** 第三方unionid */
//@property (nonatomic,copy) NSString *unionid;
//


/** 头像 */
@property (nonatomic,copy) NSString *headImg;

/** 昵称 */
@property (nonatomic,copy) NSString *nickName;

@end

NS_ASSUME_NONNULL_END
