//
//  PSStationCarSelectVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/12.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSStationPhotoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSStationCarSelectVC : BasePullTableVC


-(instancetype)initWithDataArray:(NSArray  *)data complte:(void(^)(NSString *car_info_id))complete;

@end

NS_ASSUME_NONNULL_END
