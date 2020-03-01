//
//  FSAddNewAddressVC.h
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseTableVC.h"
#import "PSAddresReceiveModel.h"
#import "FSAddNewViewModel.h"
NS_ASSUME_NONNULL_BEGIN
//typedef NS_ENUM(NSInteger,AddressNewType){
//
//    AddressNewTypeNew,//新建收货地址
//    AddressNewTypeUpdate //修改收货地址
//};
@interface PSAddNewAddressVC : BaseTableVC

//-(instancetype)initWithAddressModel:(PSAddresReceiveModel *__nullable)addressModel;


@property (nonatomic,assign) FSAddNewEditType editType;

@property (nonatomic,copy) void(^selectAddressBlock)(BOOL isSelect,PSAddresReceiveModel *address);
@end

NS_ASSUME_NONNULL_END
