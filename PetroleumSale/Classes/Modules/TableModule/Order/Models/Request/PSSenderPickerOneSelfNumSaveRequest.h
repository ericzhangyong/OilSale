//
//  PSSenderPickerOneSelfNumSaveRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/25.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderPickerOneSelfNumSaveRequest : BaseRequest


/// 自提号码
@property (nonatomic,copy) NSString *mention_code;

/// 自提订单
@property (nonatomic,assign) NSInteger way_bill_id;

@end

NS_ASSUME_NONNULL_END
