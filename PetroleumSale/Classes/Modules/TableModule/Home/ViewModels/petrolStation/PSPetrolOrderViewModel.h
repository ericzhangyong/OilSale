//
//  PSPetrolOrderViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewModel.h"
typedef NS_ENUM(NSInteger,PSStationOrderListType){
    PSStationOrderListTypeCurrent,
    PSStationOrderListTypeHistory,
    PSStationOrderListTypePickOneSelf
};
NS_ASSUME_NONNULL_BEGIN

@interface PSPetrolOrderViewModel : BaseViewModel

/// 订单列表类型
@property (nonatomic,assign) PSStationOrderListType listType;

-(NSString *)ps_getStationOrderCodeAtIndex:(NSInteger)index;
-(NSString *)ps_getStationorderImageAtIndex:(NSInteger)index;
-(NSString *)ps_getStationOrderCarNumAtIndex:(NSInteger)index;
-(NSString *)ps_getStationOrderTimeAtIndex:(NSInteger)index;
-(NSString *)ps_getStationOrderAddressAtIndex:(NSInteger)index;
-(NSString *)ps_getStationOrderVolumeAtIndex:(NSInteger)index;

-(NSString *)ps_getStationOrderPicAtIndex:(NSInteger)index row:(NSInteger)row;
-(CGFloat)ps_getStationOrderCellHeight;
-(BOOL)ps_getIsShowBottomPic;

#pragma mark- 数据接口
-(void)requestDataWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete;



@end

NS_ASSUME_NONNULL_END
