//
//  REThirdRegistRequest.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/10/15.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface REThirdRegistRequest : BaseRequest



/** 头像 */
@property (nonatomic,copy) NSString *headImg;

/** 昵称 */
@property (nonatomic,copy) NSString *nickName;

/** 1.男2.女3.未知 */
//@property (nonatomic,assign) NSInteger sex;

///** 数据来源终端(1:手机号码 2-微信 ；3-qq ；4-新浪微博)(必填) */
//@property (nonatomic,assign) NSInteger sourcePlatform;

/** openId */
//@property (nonatomic,copy) NSString *loginName;

/** openid */
@property (nonatomic,copy) NSString *openid;
/** 第三方unionid */
@property (nonatomic,copy) NSString *unionid;

///**
// 数据来源的应用类型(1:iOS 2:安卓 3:pc )(必填)
// */
//@property (nonatomic,assign) NSInteger sourceApplication;

///**
// 生日
// */
//@property (nonatomic,copy) NSString *birthday;
///** 地区一级（省、直辖市）code */
//@property (nonatomic,copy) NSString *district;
///** 地区一级（省、直辖市）名称 */
//@property (nonatomic,copy) NSString *districtCn;
///** 地区二级（地级市）code */
//@property (nonatomic,copy) NSString *sdistrict;
///** 地区二级（地级市名称 */
//@property (nonatomic,copy) NSString *sdistrictCn;
///** 地区三级（区县）id */
//@property (nonatomic,copy) NSString *county;
///** 地区三级（区县）名称 */
//@property (nonatomic,copy) NSString *countyCn;
//
///** 邮箱 */
//@property (nonatomic,copy) NSString *email;
///** 邮箱验证 */
//@property (nonatomic,copy) NSString *emailAudit;
///** 建立时间 */
//@property (nonatomic,copy) NSString *gmtCreated;
///** 更新时间 */
//@property (nonatomic,copy) NSString *gmtModified;
///** 身份照背面照 */
//@property (nonatomic,copy) NSString *idBackPhoto;
///** 身份照正面照 */
//@property (nonatomic,copy) NSString *idFrontPhoto;
///** 手持身份证照 */
//@property (nonatomic,copy) NSString *idHandPhoto;
///** 自我介绍 */
//@property (nonatomic,copy) NSString *intro;
//
///** 登陆密码 */
//@property (nonatomic,copy) NSString *loginPwd;
///** 手机号码 */
//@property (nonatomic,copy) NSString *mobile;
///** 手机验证 */
//@property (nonatomic,copy) NSString *mobileAudit;
///** ocr身份认证（0-未认证 1-已认证） */
//@property (nonatomic,copy) NSString *ocrAudit;
///**  */
//@property (nonatomic,copy) NSString *passwordVerify;
///** 支付密码 */
//@property (nonatomic,copy) NSString *payPwd;
///** 真是名字 */
//@property (nonatomic,copy) NSString *realName;
//
//@property (nonatomic,copy) NSString *unionCompanyId;

@end

NS_ASSUME_NONNULL_END
