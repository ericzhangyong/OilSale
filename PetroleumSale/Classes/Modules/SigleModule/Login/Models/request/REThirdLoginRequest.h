//
//  WEThirdLoginRequest.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/23.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REThirdLoginRequest : BaseRequest
///**
// 加密数据(小程序登录传递绑定手机信息时必填)
// */
//@property (nonatomic,copy) NSString *encryptedData;
///**
// 图形验证码
// */
//@property (nonatomic,copy) NSString *imgCode;
///**
// 初始向量
// */
//@property (nonatomic,copy) NSString *iv;
//
///**
// 登录类型(1:账号密码登录; 2:短信登录; 3:第三方登录)(必填)
// */
//@property (nonatomic,assign) NSInteger loginType;
///**
// 手机号码(账号密码登录或短信登录时必填)
// */
//@property (nonatomic,copy) NSString *mobile;

/**
 第三方登录openid
 */
@property (nonatomic,copy) NSString *openid;

/** 第三方unionid */
@property (nonatomic,copy) NSString *unionid;
///**
// 登录密码(账号密码登录必填)
// */
//@property (nonatomic,copy) NSString *password;
//
///**
// 短信验证码(短信登录必填)
// */
//@property (nonatomic,copy) NSString *smsCode;
//
/////**
//// 数据来源终端(1:app 3:微信 4:qq登陆 5:新浪微博 6:其它)(必填)
//// */
////@property (nonatomic,assign) NSInteger sourcePlatform;
//
///**
// 数据来源的应用类型(1:iOS 2:安卓 3:pc )(必填)
// */
//@property (nonatomic,assign) NSInteger sourceApplication;
//
///**
// 数据来源终端(1:手机 2:微信 3:qq登陆 4:新浪微博
// */
//@property (nonatomic,assign) NSInteger sourcePlatform;
//
///**
// 微信code(小程序登录必填)
// */
//@property (nonatomic,copy) NSString *wxCode;

@end

NS_ASSUME_NONNULL_END
