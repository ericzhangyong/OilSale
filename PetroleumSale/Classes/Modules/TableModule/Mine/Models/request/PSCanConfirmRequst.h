//
//  PSCanConfirmRequst.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/5.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSCanConfirmRequst : BaseRequest

@property (nonatomic,copy) NSArray *notice_list;
@end

NS_ASSUME_NONNULL_END
