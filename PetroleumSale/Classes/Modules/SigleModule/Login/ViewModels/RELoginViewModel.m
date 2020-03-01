//
//  fsLoginViewModel.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "RELoginViewModel.h"
#import "NSString+RECategory.h"
#import "UserInfoProfile.h"
#import "REGetVerifyRequest.h"
#import "REGetVerfyBase64Request.h"
#import "RERegistRequest.h"
#import "RELoginRequest.h"
#import "REForgetSecretRequest.h"
#import "BaseKeyChain.h"
#import "REThirdLoginRequest.h"
#import "REBindingRequest.h"
#import "REThirdRegistRequest.h"
#import "REUpdateSecretRequest.h"
#import "REThirdAppleLoginRequest.h"
#import "REThirdAppleRegistRequest.h"
#import "REMainTabManager.h"

#define verifyKeyStr [BaseKeyChain getDeviceIdFromKeyChain]

@implementation RELoginViewModel

/**
 获取导航栏标题
 */
-(NSString *)fs_getNavTitle{
    
//    if (self.loginType == RELoginTypeSecretForget) {
//        return @"忘记密码";
//    }else if (self.loginType == RELoginTypeSecretModify){
//        return @"修改密码";
//    }
//    else if (self.loginType == RELoginTypeRegistSetSecret || self.loginType == RELoginTypeSecretForgetSet){
//        return @"设置密码";
//    }else if(self.loginType == RELoginTypePhoneBinding){
//        return @"手机绑定";
//    }
//    else{
        return @"";
//    }
}
/**
 是否显示注册按钮
 */
-(BOOL)fs_isShowRegistBtn{
    
//    if (self.loginType == RELoginTypeSecretCode || self.loginType == RELoginTypeLoginSmsCode) {
//        return YES;
//    }else{
        return NO;
//    }
}

/**
 获取标题
 */
-(NSString *)fs_getThemeTitle{
    
    if (self.loginType == RELoginTypeSecretCode ){
        return @"密码登录";
    }else if (self.loginType == RELoginTypeRegist ){
        return @"注册";
    }else if (self.loginType == RELoginTypeSecretForgetGetVerify||self.loginType == RELoginTypeSecretForgetSetNew){
        return @"重设密码";
    }else if (self.loginType == RELoginTypeResetSecret){
        return @"修改密码";
    }else if (self.loginType == RELoginTypeBinding){
        return @"手机绑定";
    }
    else{
        return @"";
    }
}
/**
 获取标题的高度
 */
-(CGFloat)fs_getLabelTitleHeight{
    
    return 25;
}
/**
 获取标题的top
 */
-(CGFloat)fs_getLabelTitleTop{
    
    return 30;
}
/**
 获取标题的bottom
 */
-(CGFloat)fs_getLabelTitleBottom{
    if (self.loginType == RELoginTypeLoginSmsCode || self.loginType == RELoginTypeSecretCode) {
        return 33;
    }
    return 12;
}
-(CGFloat)fs_getBtnLoginTop{
    
    CGFloat height = 112;
    if (self.loginType == RELoginTypeRegist||self.loginType == RELoginTypeResetSecret) {
        height = 50;
    }else if (self.loginType == RELoginTypeLoginSmsCode|| self.loginType == RELoginTypeSecretCode||self.loginType == RELoginTypeSecretForgetGetVerify || self.loginType == RELoginTypeSecretForgetSetNew){
        height = 112;
    }else if (self.loginType == RELoginTypeBinding){
        height = 80;
    }else if (self.loginType == RELoginTypeBinding){
        height = 112;
    }
    return height;
}

-(CGFloat)fs_getInputViewHeight{

    CGFloat height = self.fs_getViewPhoneHeight + self.fs_getViewBindingSecreteHeight+ self.fs_getViewVerifyHeight + self.fs_getViewGraphHeight + self.fs_getViewSecretSethHeight + self.fs_getViewResetSecretSetVeroifyHeight;
    return height;
}

/** 手机号view高度 */
-(CGFloat)fs_getViewPhoneHeight{
    if (self.fs_getIsShowViewPhone) {
        return 60;
    }else{
        return 0;
    }
}
/** 绑定手机号输入密码view高度 */
-(CGFloat)fs_getViewBindingSecreteHeight{
    return self.fs_getIsShowViewBingdingSecret?60:0;
}
/** 验证码view高度 */
-(CGFloat)fs_getViewVerifyHeight{
    if (self.fs_getIsShowViewVerify) {
        return 60;
    }else{
        return 0;
    }
}
-(CGFloat)fs_getViewGraphHeight{
    return self.fs_getIsShowViewGrap?60:0;
}

-(CGFloat)fs_getViewSecretSethHeight{
    return self.fs_getIsShowViewSecretSet?60:0;
}
-(CGFloat)fs_getViewResetSecretSetVeroifyHeight{
    return self.fs_getIsShowViewResetSecretSetVerify?60:0;
}
-(BOOL)fs_getIsShowViewPhone{
    if (self.loginType == RELoginTypeSecretForgetSetNew) {
        return NO;
    }else{
        return YES;
    }
}
/** 是否显示绑定手机号输入密码view */
-(BOOL)fs_getIsShowViewBingdingSecret{
    
    if (self.loginType == RELoginTypeRegist) {
        return YES;
    }else{
        return NO;
    }
}
/** 是否显示验证码view */
-(BOOL)fs_getIsShowViewVerify{
    if (self.loginType == RELoginTypeSecretForgetSetNew||self.loginType == RELoginTypeResetSecret) {
        return NO;
    }else{
        return YES;
    }
}

-(BOOL)fs_getIsShowViewGrap{
    if ( self.loginType == RELoginTypeRegist) {
        return YES;
    }else{
        return NO;
    }
    
}
-(BOOL)fs_getIsShowViewSecretSet{
    if (self.loginType == RELoginTypeSecretCode||self.loginType == RELoginTypeLoginSmsCode||self.loginType == RELoginTypeBinding) {
        return NO;
    }else{
        return YES;
    }
}
-(BOOL)fs_getIsShowViewResetSecretSetVerify{
    if (self.loginType == RELoginTypeResetSecret||self.loginType == RELoginTypeRegist||self.loginType == RELoginTypeSecretForgetSetNew) {
        return YES;
    }else{
        return NO;
    }
}
/**
 绑定手机号&修改密码 输入密码placeholder
 */
-(NSString *)fs_getBindingResetScretPlaceHolderString{
    
    if (self.loginType == RELoginTypeRegist) {
        return @"请输入用户姓名（非必填）";
    }
    return @"";
}
/**
 验证码的placeholder
 */
-(NSString *)fs_getVerifyCodePlaceHolderString{
   
    if (self.loginType == RELoginTypeSecretCode) {
        return @"请输入密码";
    }
    return @"请输入短信验证码";
}
-(NSString *)fs_getNewSecretPlaceHolderString{
    if (self.loginType == RELoginTypeRegist) {
        return @"请输入密码";
    }
    return @"请输入新密码";
}
/**
  验证码密码的输入键盘
  */
-(UIKeyboardType)fs_getVerifyCodeKeyboardType{
    
//    if (self.loginType ==RELoginTypeVerifyCode|| self.loginType == RELoginTypeRegist) {
//        return UIKeyboardTypeNumberPad;
//    }else{
        return UIKeyboardTypeDefault;
//    }
}
/**
 密码不可见的模式 输入内容不可见
 */
-(BOOL)fs_getVerifyCodeIsSecretModel{
    
    if (self.loginType == RELoginTypeSecretCode) {
        return YES;
    }else{
        return NO;
    }
}
/**
 获取登录按钮的名称
 */
-(NSString *)fs_getLoginBtnTitle{
    if (self.loginType == RELoginTypeRegist){
        return @"注册";
    }else if(self.loginType == RELoginTypeResetSecret){
        return @"确认";
    }else if(self.loginType == RELoginTypeSecretForgetGetVerify){
        return @"确定";
    }else if(self.loginType == RELoginTypeSecretForgetSetNew){
        return @"确定";
    }else if(self.loginType == RELoginTypeBinding){
        return @"绑定";
    }
    else{
        return @"登录";
    }
}

/**
 是否显示忘记密码btn
 */
-(BOOL)fs_isShowBtnForget{
    if (self.loginType == RELoginTypeSecretCode|| self.loginType == RELoginTypeLoginSmsCode) {
        return YES;
    }else{
        return NO;
    }
}
/**
 是否显示获取验证码btn
 */
-(BOOL)fs_isShowBtnGetVerfifyCode{
    if (self.loginType == RELoginTypeRegist || self.loginType == RELoginTypeSecretForgetGetVerify || self.loginType == RELoginTypeLoginSmsCode||self.loginType == RELoginTypeBinding) {
        return YES;
    }else{
        return NO;
    }
}
/**
 是否显示密码登录btn
 */
-(BOOL)fs_isShowBtnSecretLogin{
//    if (self.loginType == RELoginTypeVerifyCode) {
//        return YES;
//    }else{
        return NO;
//    }
}

/**
 是否显示第三方登录微信---->后期要关注手机是否安装微信app
 */
-(BOOL)fs_isShowBtnThirdLoginWechat{
    if ((self.loginType == RELoginTypeLoginSmsCode||self.loginType == RELoginTypeSecretCode)) {
        return YES;
    }else{
        return NO;
    }
}

/**
 校验手机号
 */
-(BOOL)fs_isPhoneNumIslegalWithPhoneNum:(NSString *)phoneNum{
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,1700,199
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if(([regextestmobile evaluateWithObject:phoneNum] == YES)
       || ([regextestcm evaluateWithObject:phoneNum] == YES)
       || ([regextestct evaluateWithObject:phoneNum] == YES)
       || ([regextestcu evaluateWithObject:phoneNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}
/**
 登录按钮是否可用
 */
-(BOOL)fs_isLoginBtnCanUseWithPhoneNum:(NSString *)phoneNum VerfifyCode:(NSString *)verifyCode{

    if (![BaseVerifyUtils isNullOrSpaceStr:verifyCode] && phoneNum.getNoWhiteLineAndSpaceString.length == 11) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)fs_isShowNoticeTitle{
    if (self.loginType == RELoginTypeRegist) {
        return YES;
    }else{
        return NO;
    }
}

-(NSMutableAttributedString *)fs_getNoticeTitle{
    
    NSString *content = @"已阅读并同意《水象协议》《水象隐私权》";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:fsColor_333333}];
    NSRange range = [content rangeOfString:@"《水象协议》《水象隐私权》"];
    if (range.location != NSNotFound) {
        [attr addAttribute:NSForegroundColorAttributeName value:fsColor_207DF3 range:range];
    }
    return attr;
}
/**
 获取默认填写的手机号---设置默认的手机：忘记密码-设置密码。注册--设置密码
 
 @return 手机号
 */
-(NSString *)fs_getDefaultPhoneNum{
    
    if (self.loginType == RELoginTypeSecretForgetGetVerify) {
        return self.mobile;
    }else{
        return @"";
    }

}


-(void)sendThirdLoginAtSourcePlatForm:(NSInteger)sourcePlatform
                                 atVC:(UIViewController *)vc
                             complete:(completeBlock)complete{
    
}

-(void)appleLoginWithAppleId:(NSString *)appleId nickName:(NSString *)nickName code:(NSString *)code complete:(completeBlock)complete{
    
    REThirdAppleLoginRequest *appleLogin = [REThirdAppleLoginRequest new];
    appleLogin.openid = appleId;
    appleLogin.nickName = nickName;
    [appleLogin getRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            //保存token
            NSString *token = response.result;
            [[BaseRequestHeader shareRequestHeader] updateLoginToken:token];
            [UserInfoProfile.shareUserInfo requestUserInfoWitnComplete:^(BOOL isFinish) {
                
            }];
            complete(YES);
        }else{
            if ([response.appCode isEqualToString:@"S1020"]) {
                REThirdAppleRegistRequest *appleRegist = [REThirdAppleRegistRequest new];
                appleRegist.nickName = nickName;
//                    appleRegist.headImg = result.iconurl;
                    appleRegist.openid = appleId;
//                    appleRegist.unionid =result.unionId;
                [appleRegist postRequestCompleted:^(BaseResponse * _Nonnull response) {
                    if (response.isFinished) {
                        //注册成功
                        //保存token
                        NSString *token = response.result;
                        [[BaseRequestHeader shareRequestHeader] updateLoginToken:token];
                        [UserInfoProfile.shareUserInfo requestUserInfoWitnComplete:^(BOOL isFinish) {
                            
                        }];
                        complete(YES);
                    }else{
                        complete(NO);
                    }
                }];
            }else{
                [MBProgressHUD toastMessageAtMiddle:response.appMesg];
                complete(NO);
            }
        }
    }];
}

#pragma mark-  接口--------------

/**
 获取手机验证码

 @param mobile 手机号
 */
-(void)re_requestGetVerifyCodeWithMobile:(NSString *)mobile
                                complete:(completeDataBlock)complete{
//    //验证码类型 1 注册验证码 2 登录验证码 3 密码找回验证码
    NSInteger type = 2;
    if (self.loginType ==RELoginTypeLoginSmsCode) {
        type = 2;
    }else if (self.loginType == RELoginTypeRegist){
        type = 1;
    }else if (self.loginType == RELoginTypeResetSecret){
        type = 3;
    }

    REGetVerifyRequest *verifyRequest = [REGetVerifyRequest new];
    verifyRequest.user_phone = mobile;
    verifyRequest.code_type = type;
    [verifyRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            complete(YES,response.result);
        }else{
            complete(NO,@"");
        }
    }];
}

-(void)fs_reqeustBase64ImageVerifyCodeComplete:(completeDataBlock)complete{
    
    NSInteger type = 1;
    //1:短信登录 2:忘记密码 3:绑定手机号 4:解绑手机号 5:用户注册 6:设置密码)
    if (self.loginType ==RELoginTypeRegist) {
        type = 5;
    }else if (self.loginType == RELoginTypeSecretForgetGetVerify){
        type = 2;
    }else if (self.loginType == RELoginTypeResetSecret){
        type = 6;
    }else if (self.loginType == RELoginTypeLoginSmsCode){
        type = 1;
    }else if (self.loginType == RELoginTypeBinding){
        type = 3;
    }else if (self.loginType == RELoginTypeUnBinding){
        type = 4;
    }
    
    //deviceID
    if ([BaseVerifyUtils isNullOrSpaceStr:[BaseKeyChain getDeviceIdFromKeyChain]]) {
        [BaseKeyChain saveKeyChain];
    }
    
    REGetVerfyBase64Request *verify64Request = [REGetVerfyBase64Request new];
//    int num = (arc4random() % 10000);
//    NSString  *randomNumber = [NSString stringWithFormat:@"%.4d", num];
    verify64Request.imgCodeToken = verifyKeyStr;
    
    verify64Request.type = type;
    
    [verify64Request postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            NSDictionary *result = response.result;
            NSString *dataStr = result[@"imgCode"];
            NSRange range  = [dataStr rangeOfString:@"data:image/jpeg;base64,"];
            NSString *subString = [dataStr substringFromIndex:range.length];
            NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:subString options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
            
            UIImage *decodedImage = [UIImage imageWithData: decodeData];
            complete(YES,decodedImage);
        }else{
            complete(NO,@"");
        }
    }];
}

/**
 登录

 @param mobile 手机号
 @param password 密码
 @param smsCode 验证码
 @param loginType 登录类型(1:账号密码登录; 2:短信登录(必填)
 @param complete 回调
 */
-(void)fs_requestLoginWithMobile:(NSString *)mobile
                        password:(NSString *)password
                         smsCode:(NSString *)smsCode
                       loginType:(NSInteger)loginType
                        complete:(completeBlock)complete{

    RELoginRequest *loginRequest  = [RELoginRequest new];
    loginRequest.user_phone = mobile;
    if (loginType == 2) {
        loginRequest.verify_type = @"code";
    }else{
        loginRequest.verify_type = @"pwd";
    }
    if (![BaseVerifyUtils isNullOrSpaceStr:smsCode]) {
        loginRequest.ver_code = smsCode;
    }
    if (![BaseVerifyUtils isNullOrSpaceStr:password]) {
        loginRequest.user_pwd = password;
    }
    
    [loginRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            //保存token
            NSDictionary *data = response.result;
            UserInfoModel *userInfo =[UserInfoModel convertModelWithJsonDic:response.result];
            [[BaseRequestHeader shareRequestHeader] updateLoginToken:userInfo.access_token];
            [UserInfoProfile.shareUserInfo updataUserinfoWithDictInfo:data];
            REMainTabManager *manager = [REMainTabManager sharedManager];
            [manager reloadAllChildrenVC];
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}




-(void)fs_requestForgetSecrettWithMobile:(NSString *)mobile
                                  newPwd:(NSString *)newPwd
                                 smsCode:(NSString *)smsCode
                                complete:(completeBlock)complete{

    REForgetSecretRequest *forgetSecret = [REForgetSecretRequest new];
    forgetSecret.user_phone = mobile;
    forgetSecret.user_pwd = newPwd;
    forgetSecret.ver_code = smsCode;
    if (newPwd.length < 6) {
        [MBProgressHUD toastMessageAtMiddle:@"密码应设置6-16位字符"];
        complete(NO);
        return;
    }
    [forgetSecret postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

-(void)fs_requestResetSecretWithMobile:(NSString *)mobile
                        originPassword:(NSString *)originPassword
                           newPassword:(NSString *)newPassword
                              complete:(completeBlock)complete{
    

    REUpdateSecretRequest *resetSecret = [REUpdateSecretRequest new];
    resetSecret.oldPwd = originPassword;
    resetSecret.password = newPassword;
    
    [resetSecret postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}


/**
 注册

 @param mobile 手机号
 @param smsCode 验证码
 @param password 密码
 @param complete 回调
 */
-(void)fs_requestRegistSmsCodeWithMobile:(NSString *)mobile
                                 smsCode:(NSString *)smsCode
                                password:(NSString *)password
                             invite_code:(NSString *)invite_code
                                realName:(NSString *)realName
                                complete:(completeBlock)complete{

    RERegistRequest *regist  = [RERegistRequest new];
    regist.user_phone = mobile.getNoWhiteLineAndSpaceString;
    regist.user_pwd  = password;
    regist.ver_code  = smsCode;
    if (![BaseVerifyUtils isNullOrSpaceStr:realName]) {
        regist.real_name = realName;
    }
    if (![BaseVerifyUtils isNullOrSpaceStr:invite_code]) {
        regist.invite_code = invite_code;
    }
    if (password.length < 6) {
        [MBProgressHUD toastMessageAtMiddle:@"密码应设置6-16位字符"];
        complete(NO);
        return;
    }
    [regist postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            //保存token
            NSString *token = response.result;
            [[BaseRequestHeader shareRequestHeader] updateLoginToken:token];
            //请求个人信息
//            [REUserInfoProfile.shareUserInfo requestUserInfoWitnComplete:^(BOOL isFinish) {
//
//            }];
            [MBProgressHUD toastMessageAtMiddle:@"注册成功"];
           
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

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
                            complete:(completeBlock)complete{
    
    REBindingRequest *bindingRequest = [REBindingRequest new];
    bindingRequest.mobile = mobile;
    bindingRequest.smsCode = smsCode;
    bindingRequest.imgCode = imageCode;
    bindingRequest.imgCodeToken = verifyKeyStr;
    [bindingRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}



@end
