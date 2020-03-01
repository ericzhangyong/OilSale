//
//  PSStationSearchView.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/12.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSStationSearchView : BaseView


@property (nonatomic,copy) void(^textfieldDidChange)(NSString *text);


-(NSString *)getTextFieldText;


@end

NS_ASSUME_NONNULL_END
