//
//  PSSalesmanVisitRequest.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanVisitRequest : BaseRequest

/// client_id
@property (nonatomic,copy) NSString *client_id;

@end

NS_ASSUME_NONNULL_END
