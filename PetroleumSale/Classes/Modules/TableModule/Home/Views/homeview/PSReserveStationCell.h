//
//  PSReserveStationCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSReserveStationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_oidName;

@property (weak, nonatomic) IBOutlet UILabel *label_carNum;
@property (weak, nonatomic) IBOutlet UILabel *label_address;

@end

NS_ASSUME_NONNULL_END
