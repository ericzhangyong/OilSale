//
//  BaseBlueNavView.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseBlueNavView : BaseView


@property (nonatomic,copy) NSString *title;


-(void)showRightBtnWithTitle:(NSString *)title
                    callBack:(void(^)(BOOL isClick))callBack;


/// <#des#>
@property (nonatomic,copy) void(^rightBtnCallBack)(BOOL isClick);

@end

NS_ASSUME_NONNULL_END
