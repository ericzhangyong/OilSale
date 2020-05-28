//
//  PSPhotoViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPhotoViewModel.h"
#import "PSPhotoConfirmRequest.h"
#import "PSSavePhotoRequest.h"
#import "UserInfoProfile.h"
#import "PSStationPhoteRequest.h"
#import "PSStationPhotoSaveRequest.h"


@implementation PSPhotoViewModel


-(void)didSelectWithOrderNoCode:(NSString *)orderCode{
    
    for (int i = 0; i<self.dataSource.count; i++) {
        PSPhotoConfirmModel *model = self.dataSource[i];
        if ([model.way_bill_code isEqualToString:orderCode]) {
            self.currentSelectIndex = i;
            self.photoModel = model;
        }
    }
}
-(void)didSelectWithIndex:(NSInteger)index{
    if (index>=self.dataSource.count) {
        
    }else{
        self.currentSelectIndex = index;
        self.photoModel = self.dataSource[index];
    }

}

-(BOOL)billOrderIsHaveOilGun{
    return YES;
}
-(PSBucketModel *)ps_getBucketModelAtIndex:(NSInteger)index{
    if (IsUSerStationType) {
        return nil;
    }
    if (index>=self.photoModel.bucket_info_list.count) {
        return  nil;
    }
    return self.photoModel.bucket_info_list[index];
}

-(BOOL)isOilGunCellAtIndex:(NSInteger)index{
    
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    return bucketModel.isOilGunCell;
}

-(void)ps_setOilGunValue:(NSString *)value{
    
    self.photoModel.nozzle_num = value;
}

-(NSInteger)ps_getBucketCountAtIndex:(NSInteger)index{
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    return bucketModel.bucket_do_img_urls.count;
}
-(NSString *)ps_getBucketImgeUrlAtIndex:(NSInteger)index row:(NSInteger)row{
    
    if (IsUSerStationType) {
        if (row>=[self ps_getStationSelectCarModel].oil_photo_do_pic_urls.count) {
            return nil;
        }
        return [self ps_getStationSelectCarModel].oil_photo_do_pic_urls[row];
    }else{
        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
           if (row>bucketModel.bucket_do_img_urls.count) {
               return @"";
           }
           return bucketModel.bucket_do_img_urls[row];
    }
}
-(BOOL)ps_getBucketIsShowAddIconAtIndex:(NSInteger)index row:(NSInteger)row{
    
    if (IsUSerStationType) {
           if (row>=[self ps_getStationSelectCarModel].oil_photo_do_pic_urls.count) {
               return NO;
           }        
        NSString *imageUrl= [self ps_getStationSelectCarModel].oil_photo_do_pic_urls[row];
        if ([BaseVerifyUtils isNullOrSpaceStr:imageUrl]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
        if (row>bucketModel.bucket_do_img_urls.count) {
            return NO;
        }
        NSString *imageUrl= bucketModel.bucket_do_img_urls[row];
        if ([BaseVerifyUtils isNullOrSpaceStr:imageUrl]) {
            return YES;
        }else{
            return NO;
        }
    }
    
}
/// bucket图片是否显示删除按钮
-(BOOL)ps_getBucketIsShowDeleteBtnAtIndex:(NSInteger)index row:(NSInteger)row{
    
    return ![self ps_getBucketIsShowAddIconAtIndex:index row:row];
}
-(NSString *)ps_getBucketUploadImgeUrlAtIndex:(NSInteger)index row:(NSInteger)row{
    if (IsUSerStationType) {
        
        if (row>[self ps_getStationSelectCarModel].oil_photo_up_pic_urls.count) {
            return nil;
        }
        return [self ps_getStationSelectCarModel].oil_photo_up_pic_urls[row];
    }else{
        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
        if (row>bucketModel.bucket_up_img_urls.count) {
            return nil;
        }
        return bucketModel.bucket_up_img_urls[row];
    }
}

-(NSString *)ps_getBucketTitleAtIndex:(NSInteger)index{
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    return bucketModel.bucket_type;
}
-(NSString *)ps_getBucketDensityAtIndex:(NSInteger)index{
    
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];

    NSString *content = [NSString stringWithFormat:@"%@",bucketModel.density];
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:16],NSForegroundColorAttributeName:color_333333}];
////    NSRange range = [content rangeOfString:@"密度："];
//    if (range.location !=NSNotFound) {
//        [attr addAttributes:@{NSForegroundColorAttributeName:color_333333} range:range];
//    }
    return  content;
}
-(NSString *)ps_getVolumeAtIndex:(NSInteger)index{
    if (IsUSerStationType) {
        PSStationChangeModel *model = [self ps_getStationSelectCarModel];

       return  model.oil_volume_num;
    }else{

        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
        return bucketModel.volume;
    }
}
-(NSString *)ps_getRoughWeightAtIndex:(NSInteger)index{
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    return bucketModel.weight;

}
-(NSString *)ps_getGrossWeightAtIndex:(NSInteger)index{
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    return bucketModel.gross_weight;
}
/// 设置体积
-(void)ps_setVolumeWithText:(NSString *)text AtIndex:(NSInteger)index{
    if (IsUSerStationType) {
        PSStationChangeModel *model = [self ps_getStationSelectCarModel];
        model.oil_volume_num = text;
    }else{
        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
        bucketModel.volume = text;
    }
}
/// 设置净重
-(void)ps_setWeightWithText:(NSString *)text AtIndex:(NSInteger)index{
    
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    bucketModel.weight = text;
}
/// 设置毛重
-(void)ps_setGrossWeightWithText:(NSString *)text AtIndex:(NSInteger)index{
    
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    bucketModel.gross_weight = text;
}
/// 设置密度
-(void)ps_setDensityWithText:(NSString *)text AtIndex:(NSInteger)index{
    
    PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
    bucketModel.density = text;
}

/// 设置imageurl
-(void)ps_setImageUrlWithUrl:(NSString *)url AtIndex:(NSInteger)index row:(NSInteger)row{
    
    if (IsUSerStationType) {
        
    }else{
        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
        [bucketModel.bucket_up_img_urls replaceObjectAtIndex:row withObject:url];
        [bucketModel.bucket_do_img_urls replaceObjectAtIndex:row withObject:url];
    }
}
-(void)ps_setImageWithImage:(UIImage *)image AtIndex:(NSInteger)index row:(NSInteger)row{
    
    if (IsUSerStationType) {
        
    }else{
        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];

        [bucketModel.bucket_do_img_urls_temp replaceObjectAtIndex:row withObject:image];
    }
    
}
-(UIImage *)ps_getImageAtIndex:(NSInteger)index row:(NSInteger)row{
    if (IsUSerStationType) {
        return nil;
    }else{
        PSBucketModel *bucketModel = [self ps_getBucketModelAtIndex:index];
        if (row>bucketModel.bucket_do_img_urls_temp.count) {
            return nil;
        }
        if ([bucketModel.bucket_do_img_urls_temp[row] isKindOfClass:[UIImage class]]) {
            return bucketModel.bucket_do_img_urls_temp[row];
        }else{
            return nil;
        }
    }
}

-(NSString *)ps_getHeaderLabeTitle{
    
    if (IsUSerStationType) {
        return @"车牌号";
    }else{
        return @"送货单号";
    }
}
-(NSString *)ps_getHeaderLabeContent{
    if (IsUSerStationType) {
        PSStationChangeModel *selectCarModel = [self ps_getStationSelectCarModel];
        return selectCarModel.farp_car_info.car_number;
    }else{
        return self.photoModel.way_bill_code;
    }
}

-(PSStationChangeModel *)ps_getStationSelectCarModel{
    
    for (PSStationChangeModel *model in self.stationPhotoModel.farp_file) {
        if (model.isSelected) {
            return model;
            break;
        }
    }
    return nil;
}

-(NSString *)ps_getHeaderRegion{
    
    if (IsUSerStationType) {
        return self.stationPhotoModel.farp_info.region;
    }else{
        return self.photoModel.region;
    }
    
}
-(NSString *)ps_getHeaderCompleteAddress{
    if (IsUSerStationType) {
        return self.stationPhotoModel.farp_info.complete_address;
    }else{
        return self.photoModel.complete_address;
    }
}
-(NSString *)ps_getHeaderName{
    if (IsUSerStationType) {
        return self.stationPhotoModel.farp_info.consignee;
    }else{
        return self.photoModel.consignee;
    }
}
-(NSString *)ps_getHeaderPhoneNum{
    if (IsUSerStationType) {
        return self.stationPhotoModel.farp_info.phone_num;
    }else{
        return self.photoModel.phone_num;
    }
}
-(void)ps_setSelectCarWithcarInfoId:(NSString *)car_info_id{
    
    
        for (int i = 0; i<self.stationPhotoModel.farp_file.count; i++) {
            PSStationChangeModel *carModel = self.stationPhotoModel.farp_file[i];
            carModel.isSelected = NO;
            if ([carModel.farp_car_info.car_info_id isEqualToString:car_info_id]) {
                carModel.isSelected = YES;
            }
        }
}

-(NSArray *)getCarInfoArr{
    
    NSMutableArray *carInfoArr = [NSMutableArray array];
    for (int i = 0; i<self.stationPhotoModel.farp_file.count; i++) {
        PSStationChangeModel *model = self.stationPhotoModel.farp_file[i];
        [carInfoArr addObject:model.farp_car_info];
    }
    return  carInfoArr;
}

#pragma mark- 接口请求

-(void)requestPhotoConfirmComplete:(completeBlock)complete{
    
    
    if (IsUSerStationType) {
        PSStationPhoteRequest *stationPhotoRequest = [PSStationPhoteRequest new];
        [stationPhotoRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                NSDictionary *dataDict = response.result;
                if (dataDict) {
                    PSStationPhotoModel *model = [PSStationPhotoModel convertModelWithJsonDic:dataDict];
                    self.stationPhotoModel =model;
                    if (self.stationPhotoModel.farp_file.count>0) {
                        self.stationPhotoModel.farp_file.firstObject.isSelected = YES;
                    }
                }
                complete(YES);
            }else{
                complete(NO);
            }
        }];
    }else{
         PSPhotoConfirmRequest *photoRequest = [PSPhotoConfirmRequest new];
            [photoRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
                if (response.isFinished) {
                    
                    NSArray *data = [PSPhotoConfirmModel convertModelWithJsonArr:response.result[@"warehouse_model_list"]];
                    
                   
                    [self.dataSource setArray:data];
                    if (self.currentSelectIndex<self.dataSource.count) {
                        self.photoModel = self.dataSource[self.currentSelectIndex];
        //                if (self.billOrderIsHaveOilGun) {
        //                    PSBucketModel *oilGunBucket =[PSBucketModel new];
        //                    oilGunBucket.isOilGunCell = YES;
                            NSMutableArray *dataArr = [NSMutableArray array];
        //                    [dataArr addObject:oilGunBucket];
                            [dataArr addObjectsFromArray:self.photoModel.bucket_info_list];
                            self.photoModel.bucket_info_list = dataArr;
        //                }
                    }
                    complete(YES);
                }else{
                    complete(NO);
                }
            }];
    }
   
}

-(void)reqeustSavePhotoComplete:(completeBlock)complete{
    
    if (IsUSerStationType) {
        PSStationPhotoSaveRequest *stationRequest =[PSStationPhotoSaveRequest new];
        
        stationRequest.order_file_id = [self ps_getStationSelectCarModel].order_file_id.integerValue;
        stationRequest.order_id =[self ps_getStationSelectCarModel].order_id.integerValue;
        stationRequest.oil_volume = [self ps_getStationSelectCarModel].oil_volume_num;
        [stationRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                complete(YES);
            }else{
                complete(NO);
            }
        }];
    }else{
        PSSavePhotoRequest *saveRequest =[PSSavePhotoRequest new];
        NSMutableArray *subBucketList = [NSMutableArray array];
        saveRequest.waybill_id = self.photoModel.waybill_id.integerValue;
        for (int i = 0; i<self.photoModel.bucket_info_list.count; i++) {
            PSBucketModel *sourceModel = self.photoModel.bucket_info_list[i];
            
            if (sourceModel.isOilGunCell) {
                saveRequest.nozzle_num = self.photoModel.nozzle_num.integerValue;
                saveRequest.nozzle_order_id = self.photoModel.nozzle_order_id.integerValue;
            }else{
                PSBucketModel *model = [PSBucketModel new];
                model.bucket_code = sourceModel.bucket_code;
                model.density = sourceModel.density;
                model.volume = sourceModel.volume;
                model.weight = sourceModel.weight;
                model.gross_weight = sourceModel.gross_weight;
                [subBucketList addObject:model];
            }
        }
        saveRequest.sub_bucket_info_list = subBucketList;
        [saveRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                complete(YES);
            }else{
                complete(NO);
            }
        }];
    }
    
}



-(PSPhotoConfirmModel *)photoModel{
    if (!_photoModel) {
        _photoModel = [PSPhotoConfirmModel new];
    }
    return _photoModel;
}
-(PSStationPhotoModel *)stationPhotoModel{
    if (!_stationPhotoModel) {
        _stationPhotoModel = [PSStationPhotoModel new];
    }
    return _stationPhotoModel;
}

@end
