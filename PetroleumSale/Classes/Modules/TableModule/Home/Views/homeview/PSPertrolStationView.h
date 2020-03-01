//
//  PSPertrolStationView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PSStationClickType){
    PSStationClickTypeSelectStation,//选择加油点
    PSStationClickTypeCarNum, //选择车牌号
    PSStationClickTypeReserve //加油点预定
};
@interface PSPertrolStationView : BaseView


@property (weak, nonatomic) IBOutlet UIView *view_contain;

@property (weak, nonatomic) IBOutlet UILabel *label_price;

@property (weak, nonatomic) IBOutlet UITextField *tf_petrolStation;
@property (weak, nonatomic) IBOutlet UITextField *tf_carNum;

@property (weak, nonatomic) IBOutlet UIButton *btn_staionDate;

@property (nonatomic,copy) void(^stationViewClick)(PSStationClickType clickType);

@end

NS_ASSUME_NONNULL_END
