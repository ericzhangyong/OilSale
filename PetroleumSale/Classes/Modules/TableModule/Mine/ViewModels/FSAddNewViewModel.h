//
//  FSAddNewViewModel.h
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSAddresReceiveModel.h"
#import "PSAddNewAddressModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,FSAddNewEditType){
    
    FSAddNewEditTypeCreateNew,
    FSAddNewEditTypeUpdate
};
@interface FSAddNewViewModel : BaseViewModel

//@property (nonatomic,copy) NSArray<PSAddNewAddressModel *> *receipt_addr_edit;


/** 用于修改地址 */
@property (nonatomic,strong) PSAddresReceiveModel *addressModel;
//类型
@property (nonatomic,assign) FSAddNewEditType editType;


@property (nonatomic,strong) NSArray *rec_region_list;

-(void)setDataSource;

-(PSAddNewAddressModel *)fs_getAddNewModelAtIndex:(NSInteger)index;

-(CGFloat)fs_getCellHeightAtIndex:(NSInteger)index;

/// 获取placeHolder
/// @param form_name 类型
-(NSString *)ps_getPlaceHolderWithForm_name:(NSString *)form_name;

-(PSAddNewAddressModel *)ps_getAddNewModelAddNewAddressType:(FSAddNewAddressType)addressType;



#pragma mark- 接口


-(void)requestAddressParamMessageComplete:(completeDataBlock)complete;

/**
 保存收货人信息

 @param FSAddresReceiveModel 收货人信息
 */
-(void)fs_saveNewAddressWithFSAddresReceiveModel:(PSAddresReceiveModel *)FSAddresReceiveModel
                                        complete:(completeBlock)complete;

/**
 删除收货地址

 @param addressId 地址ID
 @param complete 回调
 */
-(void)fs_deleteAddressWithAddressId:(NSString *)addressId complete:(completeBlock)complete;



@end

NS_ASSUME_NONNULL_END
