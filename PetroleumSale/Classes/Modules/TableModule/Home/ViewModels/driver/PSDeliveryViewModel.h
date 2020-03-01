//
//  PSDeliveryViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/13.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSDeliveryModel.h"

NS_ASSUME_NONNULL_BEGIN
//typedef NS_ENUM(NSInteger,PSDeliverType){
//
//    PSDeliverTypeTodayOrder,//当日运单
//    PSDeliverTypeHistoryOrder //历史运单
//};
typedef NS_ENUM(NSInteger,DeliveryListType){
    DeliveryListTypeToaday, //今日运单
    DeliveryListTypeOther,   //其他运单
    DeliveryListTypeSelect  //选择运单
};


@interface PSDeliveryViewModel : BaseViewModel

@property (nonatomic,assign) DeliveryListType deliverListType;

#pragma mark- 数据处理


-(NSString *)ps_getDeliverNoAtIndex:(NSInteger)index;
-(CGFloat)ps_getDeliverNoHeightAtIndex:(NSInteger)index;
-(NSString *)ps_getDeliverNoCodeAtIndex:(NSInteger)index;

-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index;

-(NSString *)ps_getTitleAtIndex:(NSInteger)index;

-(NSString *)ps_getTimeAtIndex:(NSInteger)index;

-(NSString *)ps_getAddressAtIndex:(NSInteger)index;


#pragma mark- 接口处理

-(void)requestDeliverDataWithTime:(NSString *)waybill_time
                             page:(NSInteger)page
                         Complete:(completeDataArrBlock)complete;
@end

NS_ASSUME_NONNULL_END
