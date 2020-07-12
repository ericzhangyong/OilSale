//
//  PSPersonEditViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPersonEditViewModel.h"
#import "PSGetPersonDataReqeust.h"
#import "PSPersonAccountSaveRequest.h"


@implementation PSPersonEditViewModel

-(void)setPersonEditData{
    
    if (self.dataSource.count>0) {
        [self.dataSource removeAllObjects];
    }
    
    PSPersonEditSetModel *nameModel = [PSPersonEditSetModel new];
    nameModel.editType = PSPersonEditTypeName;
    nameModel.title = @"修改名称";
    nameModel.content = self.accountModel.user_name;
    nameModel.placeHolder = @"请输入名称";
    [self.dataSource addObject:@[nameModel]];
    
    NSMutableArray *data = [NSMutableArray array];
    PSPersonEditSetModel *accountModel = [PSPersonEditSetModel new];
    accountModel.editType = PSPersonEditTypeMainPhoneNum;
    accountModel.title = @"主账号";
    accountModel.content = self.accountModel.account;
    accountModel.placeHolder = @"请输入主账户";
    [data addObject:accountModel];
    
    PSPersonEditSetModel *sub1Model = [PSPersonEditSetModel new];
    sub1Model.editType = PSPersonEditTypeSub1;
    sub1Model.title = @"子账号1";
    sub1Model.content = self.accountModel.sub_account_1;
    sub1Model.placeHolder = @"添加子账号";
    [data addObject:sub1Model];
    
    PSPersonEditSetModel *sub2Model = [PSPersonEditSetModel new];
    sub2Model.editType = PSPersonEditTypeSub2;
    sub2Model.title = @"子账号2";
    sub2Model.content = self.accountModel.sub_account_2;
    sub2Model.placeHolder = @"添加子账号";
    [data addObject:sub2Model];

    [self.dataSource addObject:data];
    
//    [self.dataSource setArray:@[@[@{@"title":@"修改名称",@"content":self.accountModel.user_name,@"placeHolder":@"请输入名称"}],@[@{@"title":@"主账号",@"content":self.accountModel.account,@"placeHolder":@"请输入主账户"},@{@"title":@"子账号1",@"content":self.accountModel.sub_account_1,@"placeHolder":@"添加子账号"},@{@"title":@"子账号2",@"content":self.accountModel.sub_account_2,@"placeHolder":@"添加子账号"}]]];
    
}

-(void)requestPersonAccountComplete:(completeBlock)complete{
    
    PSGetPersonDataReqeust *getPersonReqeust =[PSGetPersonDataReqeust new];
    [getPersonReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            PSPersonAcountModel *accountModel = [PSPersonAcountModel convertModelWithJsonDic:response.result[@"user_edit_value"]];
            self.accountModel = accountModel;
            
            [self setPersonEditData];
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

-(void)requestAddPersonSonAccountComplete:(completeBlock)complete{
    
    NSDictionary *dict = [self.accountModel modelToJsonDictionary];
    PSPersonAccountSaveRequest *saveRequest  =[PSPersonAccountSaveRequest createWithParams:dict];
    [saveRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}


@end
