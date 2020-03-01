//
//  FSConstString.h
//  FireStore
//
//  Created by eric on 2019/9/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSConstString : NSObject



#pragma mark- 第三方账户的信息
/** 微信appID */
extern NSString *const WXAppID;
/** 微信Secret */
extern NSString *const WXSecret;
/** UMAppKey友盟key */
extern NSString *const UMAppKey;

/** appstore共享密钥 */
extern NSString *const AppstoreSecret;
/** 支付共享密钥 */
extern NSString *const privateKey;

/** appstore跳转地址 */
extern NSString *const appstoreLink;
/** 极光推送key */
extern NSString *const REJPUSHKey;



#pragma mark- 通知

extern NSString *const FSNotificationNewAddressKey;
extern NSString *const FSNotificationCancelAfterSalesKey;
/** 已收货*/
extern NSString *const FSNotificationReceiveKey;
/** 下单成功*/
extern NSString *const FSNotificationConfirmOrderSuccesKey;
/** 添加购物成功*/
extern NSString *const FSNotificationAddShopCartSuccesKey;

/** 派单成功*/
extern NSString *const FSNotificationSendSuccessNotifiKey;
/** 确认收货成功 */
extern NSString *const FSNotificationConfirmReceiveSuccesKey;



/** 首页cell滚动到top*/
extern NSString *const RENotificationHomeSorollTopKey;
/** 礼包列表查看更多*/
extern NSString *const RENotificationGiftCheckMoreKey;



@end

NS_ASSUME_NONNULL_END
