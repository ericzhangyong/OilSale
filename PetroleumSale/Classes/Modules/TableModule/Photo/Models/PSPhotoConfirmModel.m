//
//  PSPhotoConfirmModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPhotoConfirmModel.h"

@implementation PSPhotoConfirmModel



+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"region":@[@"region",@"rec_region"],
             @"complete_address":@[@"complete_address",@"rec_complete_address"]
    };
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"bucket_info_list":[PSBucketModel class]};
}

@end


@implementation PSBucketModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"bucket_type":@[@"bucket_type",@"bucket_code"]
    };
}
-(void)setBucket_do_img_urls:(NSMutableArray *)bucket_do_img_urls{
    if (bucket_do_img_urls.count==0) {
        _bucket_do_img_urls  = [NSMutableArray arrayWithObjects:@"123",@"123",@"123", nil];
    }else{
        _bucket_do_img_urls = bucket_do_img_urls;
    }
}
-(void)setBucket_up_img_urls:(NSMutableArray *)bucket_up_img_urls{
    if (bucket_up_img_urls.count==0) {
        _bucket_up_img_urls  = [NSMutableArray arrayWithObjects:@"123",@"123",@"123", nil];
    }else{
        _bucket_up_img_urls = bucket_up_img_urls;
    }
}

-(NSMutableArray *)bucket_do_img_urls_temp{
    if (!_bucket_do_img_urls_temp) {
        _bucket_do_img_urls_temp  = [NSMutableArray arrayWithObjects:@"123",@"123",@"123", nil];
    }
    return _bucket_do_img_urls_temp;
}
@end
