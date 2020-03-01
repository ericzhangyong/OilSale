//
//  PSDeliveryListVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/13.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "ZJScrollPageView.h"
#import "PSDeliveryViewModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface PSDeliveryListVC : BasePullTableVC<ZJScrollPageViewChildVcDelegate>


-(instancetype)initWithDeliveryListTypeL:(DeliveryListType)deliverListType;

@property (nonatomic,copy) NSArray *selectResultArr;
@property (nonatomic,copy) void(^didSelecBlock)(NSString *deliverOrderNo);



@end

NS_ASSUME_NONNULL_END
