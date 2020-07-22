//
//  PSHomeViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSHomeViewModel : BaseViewModel


@property (nonatomic,strong) PSHomeModel *homeModel;

-(CGFloat)ps_getHeaderHeight;
-(CGFloat)ps_getNoticeHeight;
-(CGFloat)ps_getBannerHeight;

/// 获取桶类型标题数组
-(NSArray *)ps_getBucket_typeTitleArr;
-(NSString *)ps_getTitleAtSection:(NSInteger)section Index:(NSInteger)index;
-(NSString *)ps_getUnitTypeAtSection:(NSInteger)section
                               Index:(NSInteger)index;
-(NSString *)ps_getImageUrlAtSection:(NSInteger)section Index:(NSInteger)index;
-(NSMutableAttributedString *)ps_getPriceAtSection:(NSInteger)section Index:(NSInteger)index;

-(NSString *)ps_getLeftBtnContentAtSection:(NSInteger)section index:(NSInteger)index;
-(CGFloat)ps_getLeftBtnWidthAtSection:(NSInteger)section index:(NSInteger)index;
-(BOOL)ps_getLeftBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index;
-(void)ps_setLeftBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index withState:(BOOL)isSelect;


-(NSString *)ps_getRightBtnContentAtSection:(NSInteger)section index:(NSInteger)index;
-(CGFloat)ps_getRightBtnWidthAtSection:(NSInteger)section index:(NSInteger)index;
-(BOOL)ps_getRightBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index;
-(void)ps_setRightBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index withState:(BOOL)isSelect;
-(BOOL)ps_getRightBtnEnabledAtSection:(NSInteger)section index:(NSInteger)index;
-(NSString *)ps_getCarPrice;


#pragma mark- 委托加油点
//加油点
-(NSArray *)ps_getFarpListArr;
-(NSArray *)ps_getFarpListFarpAddressArr;
-(NSString *)ps_getSelectFarpAddressName;
-(NSString *)ps_getSelectFarpAddressId;
-(PSStationModel *)ps_getSelectFarpModel;
-(NSString *)ps_getFarpStationPrice;

//车辆
-(void)ps_setCarListWithArr:(NSArray *)arr;
-(NSString *)ps_getFarpStationSelectCar;
-(NSArray *)ps_getFarpStationSelectCarArr;
-(void)ps_setFarpStationWithFarp_id:(NSString *)farp_id;
-(void)ps_cleanFarpStationSelect;



#pragma mark- 接口

-(void)requestHomeDataListComplete:(completeBlock)complete;

-(void)requestAddShopCartAtSection:(NSInteger)section
                             Index:(NSInteger)index
                            buyNum:(NSString *)buyNum
                          Complete:(completeBlock)complete;




@end

NS_ASSUME_NONNULL_END
