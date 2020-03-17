//
//  PSSalesmanOrderCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_name;

@property (weak, nonatomic) IBOutlet UILabel *label_status;

@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_cancelReason;
//购买合同
@property (weak, nonatomic) IBOutlet UIView *view_buyContract;

//销售奖励
@property (weak, nonatomic) IBOutlet UILabel *label_saleMoney;



@end

NS_ASSUME_NONNULL_END
