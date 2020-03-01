//
//  PSMessageModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSMessageModel : BaseModel

@property (nonatomic,copy) NSString *notice_id;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *publish_time;
@property (nonatomic,assign) BOOL read_flag;

@property (nonatomic,assign) BOOL isOpened;

@end

NS_ASSUME_NONNULL_END
