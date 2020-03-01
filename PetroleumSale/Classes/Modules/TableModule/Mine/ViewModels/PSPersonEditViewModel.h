//
//  PSPersonEditViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSPersonAcountModel.h"
#import "PSPersonEditSetModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSPersonEditViewModel : BaseViewModel



-(void)setPersonEditData;

@property (nonatomic,strong) PSPersonAcountModel *accountModel;

/// 获取账户和子账户
/// @param complete 回调
-(void)requestPersonAccountComplete:(completeBlock)complete;

/// 添加子账户
-(void)requestAddPersonSonAccountComplete:(completeBlock)complete;


@end

NS_ASSUME_NONNULL_END
