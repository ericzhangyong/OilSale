//
//  PSAccountCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSAccountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_accoutBalance;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_payType;

@property (weak, nonatomic) IBOutlet UILabel *label_oilCount;
@property (weak, nonatomic) IBOutlet UILabel *label_bucketCount;
@property (weak, nonatomic) IBOutlet UILabel *label_tieCount;

@property (weak, nonatomic) IBOutlet UILabel *label_isNeddGun;
@property (weak, nonatomic) IBOutlet UILabel *label_gunCount;
@property (weak, nonatomic) IBOutlet UILabel *label_dirverName;
@property (weak, nonatomic) IBOutlet UILabel *label_price;

@property (weak, nonatomic) IBOutlet UILabel *label_orderTime;
@property (weak, nonatomic) IBOutlet UILabel *label_sendTime;




@end

NS_ASSUME_NONNULL_END
