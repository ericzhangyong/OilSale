//
//  PSSenderSendRequest.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderSendFarpRequest : BaseRequest

@property (nonatomic,copy) NSArray *order_id;
@end

NS_ASSUME_NONNULL_END
