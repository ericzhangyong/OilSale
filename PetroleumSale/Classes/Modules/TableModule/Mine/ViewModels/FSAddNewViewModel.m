//
//  FSAddNewViewModel.m
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import "FSAddNewViewModel.h"
#import "FSAddressDeleteRequest.h"
#import "NSString+RECategory.h"
#import "PSAddressEditRequest.h"
#import "UserInfoProfile.h"
#import "PSAddressSaveRequest.h"
#import "FSAddNewViewModel.h"

@implementation FSAddNewViewModel

-(PSAddresReceiveModel *)addressModel{
    if (!_addressModel) {
        _addressModel = [PSAddresReceiveModel new];
    }
    return _addressModel;
}

-(void)setDataSource{
    
    if (self.dataSource.count>0) {
        [self.dataSource removeAllObjects];
    }
    
    PSAddNewAddressModel *nickNameModel = [PSAddNewAddressModel new];
    nickNameModel.addNewType = FSAddNewAddressTypeNickName;
    nickNameModel.title = @"收货人";
    NSString *name = self.addressModel.consignee;
    if ([BaseVerifyUtils isNullOrSpaceStr:name]) {
        name= @"";
    }
    nickNameModel.content = name;
    nickNameModel.placeHolder = @"请输入姓名";
    [self.dataSource addObject:nickNameModel];
    
    PSAddNewAddressModel *phoneModel = [PSAddNewAddressModel new];
    phoneModel.addNewType = FSAddNewAddressTypePhone;
    phoneModel.title = @"手机号码";
    NSString *phone = self.addressModel.phone_num;
    if ([BaseVerifyUtils isNullOrSpaceStr:phone]) {
        phone= @"";
    }
    phoneModel.content = phone;
    phoneModel.placeHolder = @"请输入手机号码";
    [self.dataSource addObject:phoneModel];
    
    PSAddNewAddressModel *cityModel = [PSAddNewAddressModel new];
    cityModel.addNewType = FSAddNewAddressTypeCity;
    cityModel.title = @"所在区域";
    NSString *area = self.addressModel.region;
    if ([BaseVerifyUtils isNullOrSpaceStr:area]) {
        area= @"";
    }
    cityModel.content = area;
    cityModel.placeHolder = @"请选择";
    [self.dataSource addObject:cityModel];
    
    PSAddNewAddressModel *detailModel = [PSAddNewAddressModel new];
    detailModel.addNewType = FSAddNewAddressTypeDetail;
    detailModel.title = @"详细地址";
    NSString *detail = self.addressModel.complete_address;
    if ([BaseVerifyUtils isNullOrSpaceStr:detail]) {
        detail= @"";
    }
    detailModel.content = detail;
    detailModel.placeHolder = @"请输入详细地址";
    [self.dataSource addObject:detailModel];
    
}

-(PSAddNewAddressModel *)fs_getAddNewModelAtIndex:(NSInteger)index{
    
    if (index>= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}
-(CGFloat)fs_getCellHeightAtIndex:(NSInteger)index{
    
    PSAddNewAddressModel *model = [self fs_getAddNewModelAtIndex:index];

    if (model.addNewType == FSAddNewAddressTypeDetail ) {
        CGFloat height  = [model.content heightWithFont:[UIFont systemWEPingFangRegularOfSize:14] width:kScreenWidth-15*2];
        return height+40+15+12;
    }else{
        return 55;
    }
}
-(PSAddNewAddressModel *)ps_getAddNewModelAddNewAddressType:(FSAddNewAddressType)addressType{
    
    PSAddNewAddressModel *selectModel  = nil;
    for (PSAddNewAddressModel *model in self.dataSource) {
        if (model.addNewType == addressType) {
            selectModel = model;
        }
    }
    return selectModel;
}

-(NSString *)ps_getPlaceHolderWithForm_name:(NSString *)form_name{
    if ([form_name isEqualToString:@"consignee"]) {
        return @"请输入姓名";
    }else if ([form_name isEqualToString:@"phone_num"]){
        return @"请输入手机号码";
    }else if ([form_name isEqualToString:@"region"]){
        return @"请选择区域";
    }else if ([form_name isEqualToString:@"complete_address"]){
        return @"请输入详细地址";
    }else{
        return @"请输入...";
    }
}
-(FSAddNewAddressType)ps_getAddNewAddressTypeWithForm_name:(NSString *)form_name{
    if ([form_name isEqualToString:@"consignee"]) {
        return FSAddNewAddressTypeNickName;
    }else if ([form_name isEqualToString:@"phone_num"]){
        return FSAddNewAddressTypePhone;
    }else if ([form_name isEqualToString:@"region"]){
        return FSAddNewAddressTypeCity;
    }else if ([form_name isEqualToString:@"complete_address"]){
        return FSAddNewAddressTypeDetail;
    }else{
        return FSAddNewAddressTypeNickName;
    }
}

-(NSArray *)handleAddNewTypeWithDataArr:(NSArray *)dataArr{
    for (PSAddNewAddressModel *model in dataArr) {
        NSString *form_name = model.form_name;
        model.addNewType = [self ps_getAddNewAddressTypeWithForm_name:form_name];
        model.placeHolder = [self ps_getPlaceHolderWithForm_name:form_name];
    }
    return dataArr;
}

#pragma mark- 接口

-(void)requestAddressParamMessageComplete:(completeDataBlock)complete{

    PSAddressEditRequest *editParamRequest = [PSAddressEditRequest new];
    [editParamRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
//            NSArray *data = [PSAddNewAddressModel convertModelWithJsonArr:response.result[@"receipt_addr_edit"]];
//            [self.dataSource setArray:[self handleAddNewTypeWithDataArr:data]];
           
            PSAddresReceiveModel *recevieModel = [PSAddresReceiveModel convertModelWithJsonDic:response.result[@"rec_addr_edit_value"]];
            if (!recevieModel && UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation) {
                recevieModel =[PSAddresReceiveModel convertModelWithJsonDic:response.result[@"frap_addr_edit_value"]];
            }
            self.addressModel = recevieModel;
            
            if ([BaseVerifyUtils isNullOrSpaceStr:recevieModel.rec_addr_id]) {
                self.editType = FSAddNewEditTypeCreateNew;
            }
            
            self.rec_region_list = response.result[@"rec_region_list"];
            [self setDataSource];
            complete(YES,recevieModel);
        }else{
            complete(NO,[PSAddresReceiveModel new]);
        }
    }];
}

/**
 保存收货人信息
 
 @param receiveModel 收货人信息
 */
-(void)fs_saveNewAddressWithFSAddresReceiveModel:(PSAddresReceiveModel *)receiveModel complete:(completeBlock)complete{
    
    PSAddressSaveRequest *editRequest =[PSAddressSaveRequest createWithParams:receiveModel.modelToJsonDictionary];
    [editRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            UserInfoProfile.shareUserInfo.userInfo.region = receiveModel.region;
            UserInfoProfile.shareUserInfo.userInfo.complete_address = receiveModel.complete_address;
            [UserInfoProfile.shareUserInfo updataUserInfoAndCache];
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}


-(void)fs_deleteAddressWithAddressId:(NSString *)addressId complete:(completeBlock)complete{
    
//    FSAddressDeleteRequest *deleteReqeust = [FSAddressDeleteRequest new];
//    deleteReqeust.addressId = addressId.integerValue;
//    [deleteReqeust postRequestCompleted:^(WEBaseResponse * _Nonnull response) {
//        if (response.isFinished) {
//            complete(YES);
//        }else{
//            complete(NO);
//        }
//    }];
}




@end
