//
//  RELoginViewModel.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseViewModel.h"

typedef NS_ENUM(NSInteger,RELoginType){
    RELoginTypeSecretCode,//密码登录
    RELoginTypeLoginSmsCode,//验证码登录
    RELoginTypeSecretForgetGetVerify,//忘记密码--获取验证码
    RELoginTypeSecretForgetSetNew,//忘记密码--设置新的密码
    RELoginTypeRegist,//注册
    RELoginTypeResetSecret,//修改密码
    RELoginTypeBinding,//绑定手机
    RELoginTypeUnBinding,//解绑手机号
};



@interface RELoginViewModel: BaseViewModel

@property(nonatomic,assign) RELoginType loginType;

//o用于保存上一页的手机号和验证码
/**
 手机号
 */
@property (nonatomic,copy) NSString *mobile;
/**
 验证码
 */
@property (nonatomic,copy) NSString *smsCode;
/**
 图片验证码
 */
@property (nonatomic,copy) NSString *imgCode;



#pragma mark- UI设置--------
#pragma mark- 标题
/**
 获取导航栏标题
 */
-(NSString *)fs_getNavTitle;
/**
 是否显示注册按钮
 */
-(BOOL)fs_isShowRegistBtn;
/**
 获取标题
 */
-(NSString *)fs_getThemeTitle;
/**
 获取标题的高度
 */
-(CGFloat)fs_getLabelTitleHeight;
/**
 获取标题的top
 */
-(CGFloat)fs_getLabelTitleTop;
/**
 获取标题的bottom
 */
-(CGFloat)fs_getLabelTitleBottom;
/**
 btnlogin的Top
 */
-(CGFloat)fs_getBtnLoginTop;

#pragma mark- inputView相关高度
/** 输入view高度 */
-(CGFloat)fs_getInputViewHeight;
/** 手机号view高度 */
-(CGFloat)fs_getViewPhoneHeight;
/** 绑定手机号输入密码view高度 */
-(CGFloat)fs_getViewBindingSecreteHeight;
/** 验证码view高度 */
-(CGFloat)fs_getViewVerifyHeight;
/** 输入图形view高度 */
-(CGFloat)fs_getViewGraphHeight;
/**  密码设置的view高度 */
-(CGFloat)fs_getViewSecretSethHeight;
/** 再次输入密码view高度 */
-(CGFloat)fs_getViewResetSecretSetVeroifyHeight;

/** 是否显示手机号view */
-(BOOL)fs_getIsShowViewPhone;
/** 是否显示绑定手机号输入密码view */
-(BOOL)fs_getIsShowViewBingdingSecret;
/** 是否显示验证码view */
-(BOOL)fs_getIsShowViewVerify;
/** 是否显示图片验证码view */
-(BOOL)fs_getIsShowViewGrap;
/** 是否显示密码view */
-(BOOL)fs_getIsShowViewSecretSet;
/** 是否显示重复输入密码 */
-(BOOL)fs_getIsShowViewResetSecretSetVerify;

/**
 绑定手机号&修改密码 输入密码placeholder
 */
-(NSString *)fs_getBindingResetScretPlaceHolderString;
/**
 验证码的placeholder
 */
-(NSString *)fs_getVerifyCodePlaceHolderString;
/**
 新密码的placeholder
 */
-(NSString *)fs_getNewSecretPlaceHolderString;
/**
 验证码密码的输入键盘
 */
-(UIKeyboardType)fs_getVerifyCodeKeyboardType;
/**
 密码不可见的模式 输入内容不可见
 */
-(BOOL)fs_getVerifyCodeIsSecretModel;
/**
 获取登录按钮的名称
 */
-(NSString *)fs_getLoginBtnTitle;
/**
 是否显示忘记密码btn
 */
-(BOOL)fs_isShowBtnForget;
/**
 是否显示获取验证码btn
 */
-(BOOL)fs_isShowBtnGetVerfifyCode;
/**
 是否显示密码登录btn
 */
-(BOOL)fs_isShowBtnSecretLogin;


/**
 是否显示第三方登录微信---->后期要关注手机是否安装微信app
 */
-(BOOL)fs_isShowBtnThirdLoginWechat;

/**
 校验手机号
 */
-(BOOL)fs_isPhoneNumIslegalWithPhoneNum:(NSString *)phoneNum;
/**
 登录按钮是否可用
 */
-(BOOL)fs_isLoginBtnCanUseWithPhoneNum:(NSString *)phoneNum VerfifyCode:(NSString *)verifyCode;

/**
 是否显示最后一行notice
 */
-(BOOL)fs_isShowNoticeTitle;
/**
 最后一行文字
 */
-(NSMutableAttributedString *)fs_getNoticeTitle;

/**
 获取默认填写的手机号---设置默认的手机：忘记密码-设置密码。注册--设置密码

 @return 手机号
 */
-(NSString *)fs_getDefaultPhoneNum;

/**
 第三方登录吊起

 @param sourcePlatform 1.微信 2.apple
 @param complete 回调
 */
-(void)sendThirdLoginAtSourcePlatForm:(NSInteger)sourcePlatform
                                 atVC:(UIViewController *)vc
                             complete:(completeBlock)complete;
/**
苹果登录
*/
-(void)appleLoginWithAppleId:(NSString *)appleId nickName:(NSString *)nickName code:(NSString *)code complete:(completeBlock)complete;

#pragma mark-  接口--------------


/**
 获取手机验证码

 @param mobile 手机号
 */
-(void)re_requestGetVerifyCodeWithMobile:(NSString *)mobile
                                complete:(completeDataBlock)complete;
/**
 获取base64图片校验码
 */
-(void)fs_reqeustBase64ImageVerifyCodeComplete:(completeDataBlock)complete;



/**
 登录
 
 @param mobile 手机号
 @param password 密码
 @param smsCode 验证码
 @param loginType 登录类型(1:账号密码登录; 2:短信登录; 3:第三方登录)(必填)
 @param complete 回调
 */
-(void)fs_requestLoginWithMobile:(NSString *)mobile
                         password:(NSString *)password
                          smsCode:(NSString *)smsCode
                        loginType:(NSInteger)loginType
                         complete:(completeBlock)complete;

/**
 忘记密码

 @param mobile 手机号
 @param newPwd 新密码
 @param smsCode 短信验证码
 @param imgCode 图片验证码
 */
-(void)fs_requestForgetSecrettWithMobile:(NSString *)mobile
                                  newPwd:(NSString *)newPwd
                                 smsCode:(NSString *)smsCode
                                complete:(completeBlock)complete;

/**
 修改密码

 @param mobile 手机号
 @param originPassword 原密码
 @param newPassword 新密码
 @param complete 回调
 */
-(void)fs_requestResetSecretWithMobile:(NSString *)mobile
                        originPassword:(NSString *)originPassword
                           newPassword:(NSString *)newPassword
                              complete:(completeBlock)complete;



/**
  注册

 @param mobile 手机号
 @param smsCode 验证码
 @param complete 回调
 */
-(void)fs_requestRegistSmsCodeWithMobile:(NSString *)mobile
                                 smsCode:(NSString *)smsCode
                                password:(NSString *)password
                             invite_code:(NSString *)invite_code
                                realName:(NSString *)realName
                                complete:(completeBlock)complete;


/**
 绑定
 
 @param mobile 手机号
 @param smsCode 验证码
 @param complete 回调
 */
-(void)fs_requestBingPhoneWithMobile:(NSString *)mobile
                             smsCode:(NSString *)smsCode
                            password:(NSString *)password
                           imageCode:(NSString *)imageCode
                            complete:(completeBlock)complete;




#pragma mark- 登录跳转





@end

