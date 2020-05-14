//
//  BaseConfigUrl.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseConfigUrl.h"


#pragma mark- 用户登录控制器


NSString *const method_regist = @"user/register.do";
NSString *const method_smsCode = @"user/send_ver_code.do";
NSString *const method_login = @"user/login.do";
NSString *const method_userInfo = @"clients/qry_client_mine.do";
NSString *const method_userForgetSecret = @"user/findpwd.do";
NSString *const method_returnCan = @"clients/qry_returned_bucket_info.do";
NSString *const method_canConfirm = @"clients/returned_bucket_info.do";
NSString *const method_addressMessage = @"clients/qry_receipt_addr_edit.do";
NSString *const method_addressSave = @"clients/receipt_addr.do";
NSString *const method_messageList = @"clients/qry_notice_list.do";
NSString *const method_messageDriverList = @"driver/qry_notice_list.do";
NSString *const method_getPersonAccount = @"clients/qry_user_edit.do";
NSString *const method_addPersonSonAccount = @"clients/user_edit.do";
NSString *const method_uploadImamgePath = @"clients/get_verify_pic_url.do";
NSString *const method_oploadImage = @"clients/report_upload_state.do";
NSString *const method_messageSetRead = @"clients/set_notice_readed.do";
NSString *const method_messageDriverSetRead = @"driver/set_notice_readed.do";

NSString *const method_getcheckImage= @"clients/get_verify_pic_load_url.do";
NSString *const method_accountInfo= @"/clients/qry_account_info.do";




#pragma mark- 首页
NSString *const method_home= @"clients/qry_client_home.do";
NSString *const method_addShopCart= @"clients/add_to_shopping_car.do";
NSString *const method_orderList= @"clients/qry_client_order.do";
NSString *const method_shopCartList= @"clients/qry_client_shopping_car.do";
NSString *const method_shopCartEdit= @"clients/sub_shopping_car_info.do";
NSString *const method_orderOperate= @"clients/order_operate.do";
NSString *const method_operate_car_num= @"clients/operate_car_num.do";
NSString *const method_reserveConfirm= @"clients/confirm_farp_order.do";




#pragma mark- 司机接口
NSString *const method_photoConfirm= @"driver/qry_photo_confirm.do";
NSString *const method_driverOrderList= @"driver/qry_driver_home.do";
NSString *const method_driverGetCan= @"driver/recovery_bucket.do";
NSString *const method_driverSavePhoto= @"driver/sub_photo_confirm.do";
NSString *const method_driverCarMessage= @"driver/operate_driver_car_info.do";

#pragma mark- 派单接口
NSString *const method_senderOrderList= @"dispatch/qry_client_order.do";
NSString *const method_senderDeliverUnSenderList= @"dispatch/qry_dispatch_waybill.do";
NSString *const method_senderDeliverSendedList= @"dispatch/qry_have_dispatch_waybill.do";
NSString *const method_senderDriverList= @"dispatch/qry_dispatch_driver.do";
NSString *const method_senderSend= @"dispatch/dispatch_to_driver.do";
NSString *const method_senderPickOneSelf= @"dispatch/qry_mention_dispatch_waybill.do";
NSString *const method_senderPickOneSelfCode= @"dispatch/sub_mention_code.do";

#pragma mark- 加油点接口
NSString *const method_stationOrderList= @"farp/qry_farp_home.do";
NSString *const method_stationMine= @"farp/qry_client_mine.do";
NSString *const method_addressStation = @"farp/qry_farp_addr_edit.do";
NSString *const method_addressStationSave = @"farp/farp_addr.do";
NSString *const method_stationPhoto = @"farp/qry_farp_photo_info.do";
NSString *const method_stationPhotoSave = @"farp/sub_farp_photo_info.do";

#pragma mark- 销售员接口
NSString *const method_salesmanHome = @"sale/qry_client_list.do";
NSString *const method_salesmanVisit = @"sale/visit_client.do";
NSString *const method_salesmanOrderlist = @"sale/qry_client_order_list.do";
NSString *const method_salesmanMine = @"sale/qry_sale_mine.do";
NSString *const method_salesmanMineMessage = @"sale/qry_sale_notice_list.do";
NSString *const method_salesmanMineMessageRead = @"sale/set_sale_notice_readed.do";

#pragma mark- 仓库接口
NSString *const method_keeperMineMessage = @"storage/qry_storage_notice_list.do";
NSString *const method_keeperHomelist = @"storage/qry_stock_info.do";
NSString *const method_keeperMineMessageRead = @"storage/set_storage_notice_readed.do";
NSString *const method_keeperOrderList = @"storage/qry_verify_order.do";
NSString *const method_keeperMine= @"storage/qry_storage_mine.do";
NSString *const method_keeperAgressOrder= @"storage/operate_verify_order.do";
NSString *const method_keeperPropertyClientList= @"storage/qry_client_property_info.do";
NSString *const method_keeperPropertyMineList= @"storage/qry_my_property_info.do";
NSString *const method_keeperPropertyHandle= @"storage/back_property_info.do";
NSString *const method_keeperWareHourseList= @"storage/qry_storage_addr.do";
NSString *const method_keeperWareHourseEdit= @"storage/edit_storage_addr.do";

NSString *const method_keeperCreateOrder= @"storage/sub_stock_info.do";











@interface BaseConfigUrl ()


@end
@implementation BaseConfigUrl

+(instancetype)shareConfigUrl{
    
    static BaseConfigUrl *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config =  [[BaseConfigUrl alloc] init];
    });
    return config;
}

-(instancetype)init{
    if (self = [super init]) {
        
        //
        _webInstance = [NSString stringWithFormat:@"%@/",RootUrl];//
                
    }
    return self;
}





@end
