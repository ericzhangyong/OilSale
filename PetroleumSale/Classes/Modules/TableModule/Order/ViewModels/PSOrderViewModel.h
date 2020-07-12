//
//  PSOrderViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSOrderModel.h"


NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PSOrderListType){
    PSOrderListTypeCurrent,
    PSOrderListTypeHistory
};
typedef NS_ENUM(NSInteger,PSOrderBottomBtnType){
    PSOrderBottomBtnTypeConfirmReceive,//确认收货
    PSOrderBottomBtnTypeCancelOrder,//取消订单
    PSOrderBottomBtnTypeCheckContract,//查看合同
    PSOrderBottomBtnTypeArrivePic, //到货照片
    PSOrderBottomBtnTypeCancerReserve //取消预订加油站

};

@interface PSOrderViewModel : BaseViewModel


@property (nonatomic,assign) PSOrderListType listType;


#pragma mark- 数据处理
-(PSOrderModel *)ps_getOrderModelAtIndex:(NSInteger)index;

-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index;
/// 获取订单号
/// @param index index
-(NSString *)ps_getOrderNoAtIndex:(NSInteger)index;
-(NSString *)ps_getOrderTimeAtIndex:(NSInteger)index;
/// 获取订单code
/// @param index index
-(NSString *)ps_getOrderIdAtIndex:(NSInteger)index;
/// 获取订单id
/// @param index index
-(NSString *)ps_getOrderCodeAtIndex:(NSInteger)index;
/// 获取油桶数量
/// @param index index
-(NSString *)ps_getBuckerTypeAtIndex:(NSInteger)index;
/// 获取订单状态
/// @param index index
-(NSString *)ps_getOrderStatusAtIndex:(NSInteger)index;
-(UIColor *)ps_getOrderStatusTextColorAtIndex:(NSInteger)index;
-(NSString *)ps_getOrderContractUrlAtIndex:(NSInteger)index;
/// 是否含税
/// @param index index
-(NSString *)ps_getOrderTaxStatusAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowOrderTaxStatusAtIndex:(NSInteger)index;

/// 获取订单价格
/// @param index index
-(NSMutableAttributedString *)ps_getOrderPriceAtIndex:(NSInteger)index;
/// 获取订单地址
/// @param index index
-(NSString *)ps_getOrderAddressAtIndex:(NSInteger)index;
/// 获取底部左边btnt标题
/// @param index index
-(NSString *)ps_getLeftBottomBtnTitleAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowLeftBottomBtnTitleAtIndex:(NSInteger)index;
-(NSString *)ps_getRightBottomBtnTitleAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowRightBottomBtnTitleAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowCheckBottomBtnTitleAtIndex:(NSInteger)index;
-(PSOrderBottomBtnType)ps_getBottomBtnTypeWithIsLeft:(BOOL)isLeft AtIndex:(NSInteger)index;
-(void)ps_deleteOrderIndex:(NSInteger)index;


#pragma mark- 到货照片处理

-(NSArray *)ps_getPicsArrAtIndex:(NSInteger)index;

/// 到货照片Model
/// @param index 订单Index
/// @param row 照片row
-(PSOrderImageModel *)ps_getImageModelAtInex:(NSInteger)index
                                         row:(NSInteger)row;
/// 照片url
-(NSString *)ps_getOrderPicImageUrlAtIndex:(NSInteger)index
                                       row:(NSInteger)row
                                  picIndex:(NSInteger)picIndex;
/// 到货照片title
-(NSString *)ps_getImageModelTitleAtInex:(NSInteger)index
                                     row:(NSInteger)row;
-(NSString *)ps_getImageModelDestinyAtInex:(NSInteger)index
                                       row:(NSInteger)row;
-(NSString *)ps_getImageModelVolumeAtInex:(NSInteger)index
                                      row:(NSInteger)row;
-(NSString *)ps_getImageModelWeightAtInex:(NSInteger)index
                                      row:(NSInteger)row;

#pragma mark- 接口

-(void)requestOrderListWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete;


/// 确认收货和取消订单
/// @param operateType 1.确认收货 2.取消订单
/// @param complete 回调
-(void)requestOrderOperateWithOperateType:(NSInteger)operateType
                                 order_id:(NSString *)order_id
                               order_code:(NSString *)order_code
                                 complete:(completeDataBlock)complete;
@end

NS_ASSUME_NONNULL_END
