//
//  PSDriverViemModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSDriverModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSDriverViemModel : BaseViewModel

//司机要派送的订单id
@property (nonatomic,copy) NSArray *orderIdArr;
//当前查看的司机index
@property (nonatomic,assign) NSInteger currentDriverIndex;

#pragma mark- 数据加工
-(NSInteger)ps_getSectionCountAtIndex:(NSInteger)index;

-(NSString *)ps_getOrderNoAtIndex:(NSInteger)index row:(NSInteger)row;
-(NSString *)ps_getDriverNameAtIndex:(NSInteger)index;
-(NSString *)ps_getDriverOrderCountAtIndex:(NSInteger)index;
-(BOOL)ps_getDriverIsSelectedAtIndex:(NSInteger)index;
-(void)ps_setDriverIsSelectedAtIndex:(NSInteger)index isSelected:(BOOL)isSelected;
-(NSString *)ps_getSendTimeAtIndex:(NSInteger)index row:(NSInteger)row;
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index row:(NSInteger)row;
-(NSMutableAttributedString *)ps_getSendLastTimeAtIndex:(NSInteger)index row:(NSInteger)row;


#pragma mark- 接口

-(void)requestDriverListComplete:(completeBlock)complete;

-(void)requestSendDeliveryComplete:(completeBlock)complete;
@end

NS_ASSUME_NONNULL_END
