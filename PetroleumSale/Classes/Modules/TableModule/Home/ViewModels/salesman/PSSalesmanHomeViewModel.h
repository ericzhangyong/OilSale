//
//  PSSalesmanHomeViewModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSClientInfoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanHomeViewModel : BaseViewModel


-(NSString *)getClienNameAtIndex:(NSInteger)index;
-(NSString *)getClienRegistTimeAtIndex:(NSInteger)index;
-(NSString *)getClienLastVisitimeAtIndex:(NSInteger)index;
-(BOOL)getClienIsVisitAtIndex:(NSInteger)index;
/// 是否已流失
-(BOOL)getClienIsRunOffAtIndex:(NSInteger)index;
-(NSString *)getClienRunOffStateAtIndex:(NSInteger)index;
-(NSString *)getClienBtnVisitTitleAtIndex:(NSInteger)index;


#pragma mark- 接口
-(void)requestClientListComplete:(completeBlock)complete;
-(void)requestClientVisitAtIndex:(NSInteger)index Complete:(completeBlock)complete;

@end

NS_ASSUME_NONNULL_END
