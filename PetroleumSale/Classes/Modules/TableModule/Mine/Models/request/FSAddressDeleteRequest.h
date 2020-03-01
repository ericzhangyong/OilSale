//
//  FSAddressDeleteRequest.h
//  FireStore
//
//  Created by eric on 2019/9/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSAddressDeleteRequest : BaseRequest


/** 地址ID */
@property (nonatomic,assign) NSInteger addressId;
@end

NS_ASSUME_NONNULL_END
