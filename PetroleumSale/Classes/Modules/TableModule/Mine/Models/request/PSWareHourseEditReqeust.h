//
//  PSWareHourseEditReqeust.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/25.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSWareHourseEditReqeust : BaseRequest

/// <#des#>
@property (nonatomic,assign) NSInteger sot_id;
/// <#des#>
@property (nonatomic,copy) NSString *sto_addr;
/// <#des#>
@property (nonatomic,copy) NSString *sto_name;
/// <#des#>
@property (nonatomic,copy) NSString *sto_region;

@end

NS_ASSUME_NONNULL_END
