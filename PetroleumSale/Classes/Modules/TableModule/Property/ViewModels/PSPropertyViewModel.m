//
//  PSPropertyViewModel.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPropertyViewModel.h"
#import "PSPropertyClientRequest.h"
#import "PSPropertyMineRequest.h"
#import "PSPropertyHandleReqeust.h"

@implementation PSPropertyViewModel


-(PSPropertyListModel *)ps_getPropertyModelAtIndex:(NSInteger)index{
    if (index>=self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)ps_getTieBucket_numAtIndex:(NSInteger)index{
    
    PSPropertyListModel *model = [self ps_getPropertyModelAtIndex:index];
    
    return [NSString stringWithFormat:@"铁桶：%@个",model.bucket_num];
}
-(NSString *)ps_getDunBucket_numAtIndex:(NSInteger)index{
    
    PSPropertyListModel *model = [self ps_getPropertyModelAtIndex:index];
    
    return [NSString stringWithFormat:@"吨桶：%@个",model.irc_num];
}
-(NSString *)ps_getOilGun_numAtIndex:(NSInteger)index{
    PSPropertyListModel *model = [self ps_getPropertyModelAtIndex:index];
    
    return [NSString stringWithFormat:@"加油枪：%@个",model.gun_num];
}
-(NSString *)ps_getKeepNameAtIndex:(NSInteger)index{
    
    if (self.listType == PSPropertyListTypeClient) {
        return @"客户仓库";
    }else{
        PSPropertyListModel *model = [self ps_getPropertyModelAtIndex:index];
        return model.storage_name;
    }
   
}
-(NSString *)ps_getAddressAtIndex:(NSInteger)index{

    PSPropertyListModel *model = [self ps_getPropertyModelAtIndex:index];
    
    return [NSString stringWithFormat:@"地址：%@",model.storage_address];
}


-(NSString *)ps_getStorage_idAtIndex:(NSInteger)index{
    
    PSPropertyListModel *model = [self ps_getPropertyModelAtIndex:index];
    return model.storage_id;
}
-(NSArray *)getNameArr{
    NSArray *nameArr = [self.dataSource valueForKey:@"storage_name"];
    return nameArr;
}

///回收类型 bucket 油桶 ibc 吨桶 gun 加油枪
-(NSString *)getVarityArrTypeAtIndex:(NSInteger)index{
    NSArray *data =  @[@"ibc",@"bucket",@"gun"];
    return data[index];
}
-(NSArray *)getVarityArr{
    return @[@"吨桶",@"铁桶",@"加油枪"];
}



-(void)requestPropertyListComplete:(completeBlock)complete{
    
    if (self.listType == PSPropertyListTypeClient) {
        PSPropertyClientRequest *client = [PSPropertyClientRequest new  ];
        [client postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                NSArray *data = [PSPropertyListModel convertModelWithJsonArr:response.result[@"client_property_info_list"]];
                [self.dataSource setArray:data];
                
                complete(YES);
            }else{
                complete(NO);
            }
        }];
    }else{
        PSPropertyMineRequest *mine = [PSPropertyMineRequest new  ];
        [mine postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                NSArray *data = [PSPropertyListModel convertModelWithJsonArr:response.result[@"stock_info_list"]];
                [self.dataSource setArray:data];
                complete(YES);
            }else{
                complete(NO);
            }
        }];
    }
    
    
}

-(void)requestPropertyHandleType:(NSString *)operate_type
                      storage_id:(NSString *)storage_id
                        back_num:(NSString *)back_num
                       back_type:(NSString *)back_type
                        complete:(completeBlock)complete{
    
    PSPropertyHandleReqeust *handleReqeust =[PSPropertyHandleReqeust new];
    handleReqeust.operate_type = operate_type;
    handleReqeust.storage_id = storage_id.integerValue;
    handleReqeust.back_num = back_num.integerValue;
    handleReqeust.back_type = back_type;
    [handleReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            complete(YES);
        }else{
            complete(NO);
        }
    }];
    
}

@end
