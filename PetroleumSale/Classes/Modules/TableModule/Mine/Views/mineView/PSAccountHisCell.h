//
//  PSAccountHisCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/7/12.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSAccountHisCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_accountMoney;
@property (weak, nonatomic) IBOutlet UILabel *label_residue;
@property (weak, nonatomic) IBOutlet UILabel *label_kouTime;
@property (weak, nonatomic) IBOutlet UILabel *label_payType;

@end

NS_ASSUME_NONNULL_END
