//
//  PSSavePhotoRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/20.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSavePhotoRequest.h"

@implementation PSSavePhotoRequest

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"sub_bucket_info_list":[PSBucketModel class]};
}

-(NSString *)requestMethod{
    
    return method_driverSavePhoto;
}

@end
