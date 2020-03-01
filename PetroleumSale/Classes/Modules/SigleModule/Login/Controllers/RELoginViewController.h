//
//  RELoginViewController.h
//  WaterElephantLiveStreaming
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseViewController.h"
#import "RELoginViewModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface RELoginViewController: BaseViewController


+(void)presentLoginWithLoginType:(RELoginType)loginType;


-(instancetype)initWithLoginType:(RELoginType)loginType;



/**
 传入手机号和验证码

 @param mobile 手机号
 @param smsCode 验证码
 */
-(void)sendToNextVCMobile:(NSString *)mobile smsCode:(NSString *)smsCode;

@end

NS_ASSUME_NONNULL_END
