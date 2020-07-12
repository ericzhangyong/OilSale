//
//  BaseConfigUrl.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//测试环境
#define RootUrl @"http://api.shengdaoshiyou.com:8080/api/v1"//@"http://106.14.63.137/api/v1"

//正式环境
//#define RootUrl @"https://api.shengdaoshiyou.com:8443/api/v1"
////https://api.shengdaoshiyou.com:8443/


#pragma mark- 用户登录控制器



/** 注册 */
extern NSString *const method_regist;
/** 获取验证码 */
extern NSString *const method_smsCode;
/** 登录 */
extern NSString *const method_login;
/** 获取用户基本信息 */
extern NSString *const method_userInfo;
/** 忘记密码 */
extern NSString *const method_userForgetSecret;
/** 还桶相关信息 */
extern NSString *const method_returnCan;
/** 客户确认还桶 */
extern NSString *const method_canConfirm;
/** 获取地址信息 */
extern NSString *const method_addressMessage;
/** 保存地址信息 */
extern NSString *const method_addressSave;
/** 客户消息列表*/
extern NSString *const method_messageList;
/** 司机消息列表 */
extern NSString *const method_messageDriverList;

/** 获取用户账号和子账户 */
extern NSString *const method_getPersonAccount;
/** 添加子账户 */
extern NSString *const method_addPersonSonAccount;
/** 获取下载图片路径 */
extern NSString *const method_uploadImamgePath;
/** 上传图片 */
extern NSString *const method_oploadImage;
/** 设置消息已读 */
extern NSString *const method_messageSetRead;
/** 设置司机消息已读 */
extern NSString *const method_messageDriverSetRead;


/** 获取审核图片 */
extern NSString *const method_getcheckImage;
/** 记账 */
extern NSString *const method_accountInfo;





#pragma mark- 首页
/** 首页 */
extern NSString *const method_home;
/** 添加购物车 */
extern NSString *const method_addShopCart;
/** 订单列表 */
extern NSString *const method_orderList;
/** 购物车列表 */
extern NSString *const method_shopCartList;
/** 购物车编辑 */
extern NSString *const method_shopCartEdit;
/** 订单确认收货或取消订单 */
extern NSString *const method_orderOperate;
/** 委托加油点新增车辆 */
extern NSString *const method_operate_car_num;
/** 委托加油点预定 */
extern NSString *const method_reserveConfirm;



#pragma mark- 司机接口
/** 拍照确认 */
extern NSString *const method_photoConfirm;
/** 司机端订单列表 */
extern NSString *const method_driverOrderList;
/** 司机端收桶 */
extern NSString *const method_driverGetCan;
/** 保存拍照 */
extern NSString *const method_driverSavePhoto;
/** 车辆信息 */
extern NSString *const method_driverCarMessage;


#pragma mark- 派单接口
/** 订单列表 */
extern NSString *const method_senderOrderList;
/** 运单 未派单 */
extern NSString *const method_senderDeliverUnSenderList;
/** 运单 已派单 */
extern NSString *const method_senderDeliverSendedList;
/** 司机列表 */
extern NSString *const method_senderDriverList;
/** 派单 */
extern NSString *const method_senderSend;

/** 自提单*/
extern NSString *const method_senderPickOneSelf;
/** 查询自提单号*/
extern NSString *const method_senderPickOneSelfCode;
/** 加油点订单列表*/
extern NSString *const method_senderStationList;
/** 加油点派单*/
extern NSString *const method_senderSendFarp;
/** 派单获取仓库列表*/
extern NSString *const method_senderGetStoreList;



#pragma mark- 加油点接口

/** 加油点订单列表 */
extern NSString *const method_stationOrderList;
/** 加油点我的 */
extern NSString *const method_stationMine;
/** 加油点地址 */
extern NSString *const method_addressStation;
/** 保存加油点地址 */
extern NSString *const method_addressStationSave;
/** 委托加油点拍照 */
extern NSString *const method_stationPhoto;
/** 委托加油点保存拍照 */
extern NSString *const method_stationPhotoSave;


#pragma mark- 销售员接口
/** 销售员首页 */
extern NSString *const method_salesmanHome;
/** 销售员拜访 */
extern NSString *const method_salesmanVisit;
/** 销售员订单列表 */
extern NSString *const method_salesmanOrderlist;
/** 销售员我的*/
extern NSString *const method_salesmanMine;
/** 销售员我的消息*/
extern NSString *const method_salesmanMineMessage;
/** 销售员我的消息已读*/
extern NSString *const method_salesmanMineMessageRead;


#pragma mark- 仓库接口
/** 仓库我的消息*/
extern NSString *const method_keeperMineMessage;
/** 仓库我的消息已读*/
extern NSString *const method_keeperMineMessageRead;
/** 仓库首页*/
extern NSString *const method_keeperHomelist;
/** 仓库订单列表*/
extern NSString *const method_keeperOrderList;
/** 仓库我的*/
extern NSString *const method_keeperMine;
/** 仓库订单 同意*/
extern NSString *const method_keeperAgressOrder;
/** 仓库客户资产*/
extern NSString *const method_keeperPropertyClientList;
/** 仓库我的资产*/
extern NSString *const method_keeperPropertyMineList;
/** 仓库处理我的资产*/
extern NSString *const method_keeperPropertyHandle;
/** 仓库地址列表*/
extern NSString *const method_keeperWareHourseList;
/** 仓库地址编辑*/
extern NSString *const method_keeperWareHourseEdit;
/** 创建进货订单*/
extern NSString *const method_keeperCreateOrder;

/** 未派单*/
extern NSString *const method_storageDeliverSendedList;
/** */
extern NSString *const method_storagePickOneSelf;
/** */
extern NSString *const method_storageDeliverUnSenderList;



@interface BaseConfigUrl : NSObject

+(instancetype)shareConfigUrl;


@property (nonatomic,copy) NSString *webInstance;




@end

NS_ASSUME_NONNULL_END
