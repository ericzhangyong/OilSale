//
//  PSConfirmFooterView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,FooterClickType){
    FooterClickTypeSelectWareHouse,
    FooterClickTypeAggreeBtn,
    FooterClickTypeAggressment,
    FooterClickTypeConfirm,
    FooterClickTypeAccountBalance,//记账余额
    FooterClickTypeAccountOilCard
};
@interface PSConfirmFooterView : BaseView

@property (weak, nonatomic) IBOutlet UILabel *label_wareHouse;
@property (weak, nonatomic) IBOutlet UILabel *label_totalMoney;
@property (weak, nonatomic) IBOutlet UIButton *btn_confirm;

@property (weak, nonatomic) IBOutlet UIControl *conrol_accountBalance;
@property (weak, nonatomic) IBOutlet UIControl *control_accountOidCardd;




/// 1.选择仓库 2.同意 3.购买协议 4.立即下单
@property (nonatomic,copy) void(^didClick)(FooterClickType clickType);
@end

NS_ASSUME_NONNULL_END
