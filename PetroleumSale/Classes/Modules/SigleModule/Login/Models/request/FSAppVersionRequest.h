//
//  FSAppVersionRequest.h
//  FireStore
//
//  Created by eric on 2019/9/9.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSAppVersionRequest : BaseRequest



/** 马甲名称 */
@property (nonatomic,copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
