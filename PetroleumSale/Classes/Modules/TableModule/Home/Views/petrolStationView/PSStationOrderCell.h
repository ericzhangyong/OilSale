//
//  PSStationOrderCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSStationOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_stationOrder;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_pic;
@property (weak, nonatomic) IBOutlet UILabel *label_carMsg;
@property (weak, nonatomic) IBOutlet UILabel *label_petrolTime;


@property (weak, nonatomic) IBOutlet UIView *view_pic;
@property (weak, nonatomic) IBOutlet UILabel *label_address;
@property (weak, nonatomic) IBOutlet UILabel *label_petrolVolume;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_carNum;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_volume;

@end

NS_ASSUME_NONNULL_END
