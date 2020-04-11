//
//  PSPropertyViewModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSPropertyListModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,PSPropertyListType){
    PSPropertyListTypeClient,
    PSPropertyListTypeMine
};

@interface PSPropertyViewModel : BaseViewModel


///
@property (nonatomic,assign) PSPropertyListType listType;

-(NSString *)ps_getTieBucket_numAtIndex:(NSInteger)index;
-(NSString *)ps_getDunBucket_numAtIndex:(NSInteger)index;
-(NSString *)ps_getOilGun_numAtIndex:(NSInteger)index;
-(NSString *)ps_getKeepNameAtIndex:(NSInteger)index;
-(NSString *)ps_getAddressAtIndex:(NSInteger)index;


-(NSArray *)getNameArr;
-(NSArray *)getVarityArr;
-(NSString *)getVarityArrTypeAtIndex:(NSInteger)index;
-(NSString *)ps_getStorage_idAtIndex:(NSInteger)index;


-(void)requestPropertyListComplete:(completeBlock)complete;

/// 处理资产
/// @param operate_type 操作类型 delete 为处理 add为新增 update为回收
/// @param storage_id 仓库id
/// @param back_num 回收数量
/// @param back_type 回收类型 bucket 油桶 ibc 吨桶 gun 加油枪
-(void)requestPropertyHandleType:(NSString *)operate_type
                      storage_id:(NSString *)storage_id
                        back_num:(NSString *)back_num
                       back_type:(NSString *)back_type
                        complete:(completeBlock)complete;


@end

NS_ASSUME_NONNULL_END
