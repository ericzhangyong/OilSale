//
//  PSDriverCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSDriverOrderCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *label_orderNo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_driverName;
@property (weak, nonatomic) IBOutlet UILabel *label_estiTime;
@property (weak, nonatomic) IBOutlet UILabel *label_lastTime;

@end

NS_ASSUME_NONNULL_END
