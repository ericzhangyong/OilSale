//
//  PSAccountHeaderView.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSAccountHeaderView : BaseView


@property (weak, nonatomic) IBOutlet UILabel *label_accountBalance;
@property (weak, nonatomic) IBOutlet UILabel *label_accountFarpBalance;

@end

NS_ASSUME_NONNULL_END
