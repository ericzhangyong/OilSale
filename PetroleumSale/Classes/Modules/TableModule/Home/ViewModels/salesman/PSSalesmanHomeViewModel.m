//
//  PSSalesmanHomeViewModel.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSalesmanHomeViewModel.h"
#import "PSSalesmanHomeRequest.h"
#import "PSSalesmanVisitRequest.h"

@implementation PSSalesmanHomeViewModel

-(PSClientInfoModel *)getClientModelAtIndex:(NSInteger)index{
    if (index>=self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)getClienNameAtIndex:(NSInteger)index{
    
    PSClientInfoModel *infoModel =[self getClientModelAtIndex:index];
    return [NSString stringWithFormat:@"客户姓名：%@",infoModel.client_name];
}

-(NSString *)getClienRegistTimeAtIndex:(NSInteger)index{

    PSClientInfoModel *infoModel =[self getClientModelAtIndex:index];
    if ([self getClienIsRunOffAtIndex:index]) {
        return [NSString stringWithFormat:@"客户流失时间：%@",infoModel.client_lost_time];
    }else{
        return [NSString stringWithFormat:@"客户注册时间：%@",infoModel.client_regist_time];
    }
}
-(NSString *)getClienLastVisitimeAtIndex:(NSInteger)index{

    PSClientInfoModel *infoModel =[self getClientModelAtIndex:index];
    return [NSString stringWithFormat:@"最后一次拜访客户时间：%@",infoModel.recently_visit_time];
}
-(BOOL)getClienIsVisitAtIndex:(NSInteger)index{

    PSClientInfoModel *infoModel =[self getClientModelAtIndex:index];

    if (infoModel.visit_state.integerValue == 1) {
        return YES;
    }else{
        return NO;
    }
}

/// 是否已流失
-(BOOL)getClienIsRunOffAtIndex:(NSInteger)index{
    
    PSClientInfoModel *infoModel =[self getClientModelAtIndex:index];
    
    if ([infoModel.client_state_desc isEqualToString:@"已流失"]) {
        return YES;
    }else{
        return NO;
    }
}

-(NSString *)getClienRunOffStateAtIndex:(NSInteger)index{
    if ([self getClienIsRunOffAtIndex:index]) {
        return @"已流失";
    }else{
        return @"";
    }
}
-(NSString *)getClienBtnVisitTitleAtIndex:(NSInteger)index{

    if ([self getClienIsVisitAtIndex:index]) {
        return @"已拜访";
    }else{
        return @"拜访";
    }
}




-(void)requestClientListComplete:(completeBlock)complete{
    
    PSSalesmanHomeRequest *homeReqeust =[PSSalesmanHomeRequest new];
    [homeReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            NSArray *result = response.result[@"client_list"];
            NSArray *data =[PSClientInfoModel convertModelWithJsonArr:result];
            [self.dataSource setArray:data];
            complete(YES);
        }else{
            complete(NO);
        }
    }];
    
}

-(void)requestClientVisitAtIndex:(NSInteger)index Complete:(completeBlock)complete{

    
    PSClientInfoModel *model =  [self getClientModelAtIndex:index];
    PSSalesmanVisitRequest *visitRuest = [PSSalesmanVisitRequest new];
    visitRuest.client_id = model.client_id;
    [visitRuest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
    
}


@end
