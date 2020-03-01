//
//  PSConfirmHeaderView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSConfirmHeaderView : BaseView


@property (weak, nonatomic) IBOutlet UILabel *label_region;
@property (weak, nonatomic) IBOutlet UILabel *label_completeAdd;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_phone;

@property (nonatomic,copy) void(^selectAddBlock)(BOOL isClick);
@property (weak, nonatomic) IBOutlet UIButton *btn_AddAddressNotice;

@end

NS_ASSUME_NONNULL_END
