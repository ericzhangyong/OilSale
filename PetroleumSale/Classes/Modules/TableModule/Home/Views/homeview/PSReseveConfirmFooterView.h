//
//  PSReseveConfirmFooterView.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSReseveConfirmFooterView : BaseView

@property (weak, nonatomic) IBOutlet UIButton *btn_selelcted;

@property (weak, nonatomic) IBOutlet UIButton *btn_aggreement;


/// clicktype 1.购买协议 2.立即预订
@property (nonatomic,copy) void(^footBtnDidClick)(NSInteger clickType);

@end

NS_ASSUME_NONNULL_END
