//
//  PSSenderDriverSelectVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderDriverSelectVC : BasePullTableVC


-(instancetype)initWithOrderIdArr:(NSArray *)orderIdArr;


/// <#des#>
@property (nonatomic,copy) void(^selectCompleteBlock)(NSString *dirverId);
@end

NS_ASSUME_NONNULL_END
