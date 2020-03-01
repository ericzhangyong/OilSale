//
//  PSShopCartViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSAddresReceiveModel.h"
#import "PSWareHouseModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PSShopCartEidtType){
    PSShopCartEidtTypeDefault, //正常模式 未编辑
    PSShopCartEidtTypeEidt    //正在编辑模式
};

@interface PSShopCartViewModel : BaseViewModel


/// 地址列表
@property (nonatomic,copy) NSArray<PSAddresReceiveModel *> *rec_addr_list;
@property (nonatomic,copy) NSArray<PSWareHouseModel *> *warehouse_list;

@property (nonatomic,assign) PSShopCartEidtType editType;

/// 是否全选
@property (nonatomic,assign) BOOL isSelectAll;

#pragma mark- 确认订单的处理
/// 当前选中的仓库
@property (nonatomic,assign) NSInteger currentWareHouseSelectIndex;
/// 当前选中的地址
@property (nonatomic,assign) NSInteger currentAddressSelectIndex;
/// 是否同意协议
@property (nonatomic,assign) BOOL isAggree;


#pragma mark- 数据处理
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index;
-(NSString *)ps_getTitlelAtIndex:(NSInteger)index;

/// 价格
/// @param index index
-(NSString *)ps_getPriceAtIndex:(NSInteger)index;

/// 预计金额
/// @param index index
-(NSMutableAttributedString *)ps_getMoneyAtIndex:(NSInteger)index;
/// 地址
-(NSString *)ps_getaddress;
-(PSAddresReceiveModel *)ps_getAddressModel;
-(void)ps_setAddressModelWithModel:(PSAddresReceiveModel *)address;
/// 是否被编辑选择
/// @param index index
-(BOOL)ps_getIsSelectedAtIndex:(NSInteger)index;
/// 设置是否被选中
/// @param index index
-(void)ps_setIsSelectedAtIndex:(NSInteger)index
                   isSeleceted:(BOOL)isSelected;

/// 获取选中的数据源
-(NSArray *)ps_getSelectedDataArr;

/// 获取选中订单的总金额
-(NSMutableAttributedString *)ps_getSelectedTotalMoney;
-(NSMutableAttributedString *)ps_getSelectedTotalMoneyAtConfirmVC;
-(PSWareHouseModel *)ps_getSelectedWareHouse;
-(NSString *)ps_getSelectedWareHouseName;


#pragma mark- 接口
-(void)requestShopCartListComplete:(completeDataArrBlock)complete;

/// 购物车编辑
/// @param editType 1.确认订单 2.删除购物车
/// @param payType 支付方式 1 记账余额支付 2 加油卡支付
/// @param complete 回调
-(void)requesShopCartEditType:(NSInteger)editType
                     pay_type:(NSString *)payType
                     Complete:(completeBlock)complete;




@end

NS_ASSUME_NONNULL_END
