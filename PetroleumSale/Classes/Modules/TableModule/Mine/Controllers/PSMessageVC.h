//
//  PSMessageVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "ZJScrollPageView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PSMeesageType){
    PSMeesageTypeCustomer, //客户消息通知
    PSMeesageTypeDriverSystem,//司机系统消息
    PSMeesageTypeDriverPunishment //司机罚款通知
};
@interface PSMessageVC : BasePullTableVC<ZJScrollPageViewChildVcDelegate>


-(instancetype)initPSMeesageType:(PSMeesageType)messageType;

@end

NS_ASSUME_NONNULL_END
