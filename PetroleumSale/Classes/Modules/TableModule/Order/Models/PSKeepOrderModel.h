//
//  PSKeepOrderModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSKeepOrderModel : BaseModel

/* UserInfo{
user_id:    integer ($int64)
用户主键
user_name:    string
用户姓名
}*/
@property (nonatomic,copy) NSDictionary *buy_user;
/// 铁桶数量
@property (nonatomic,copy) NSString *order_bucket_num;
/// 吨桶数量
@property (nonatomic,copy) NSString *order_ibc_num;
/// 订单id
@property (nonatomic,copy) NSString *order_id;
/// 下单时间
@property (nonatomic,copy) NSString *order_time;
/// 剩余铁桶数量
@property (nonatomic,copy) NSString *will_surplus_bucket_num;
/// 剩余吨桶数量
@property (nonatomic,copy) NSString *will_surplus_ibc_num;


@end



NS_ASSUME_NONNULL_END
