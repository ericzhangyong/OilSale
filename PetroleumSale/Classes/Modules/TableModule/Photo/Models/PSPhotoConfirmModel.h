//
//  PSPhotoConfirmModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
@class PSBucketModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSPhotoConfirmModel : BaseModel

/// 收货人
@property (nonatomic,copy) NSString *consignee;

/// 手机号码
@property (nonatomic,copy) NSString *phone_num;

/// 区域
@property (nonatomic,copy) NSString *region;

/// 详细地址
@property (nonatomic,copy) NSString *complete_address;

/// 运单编号
@property (nonatomic,copy) NSString *way_bill_code;
/// 运单id
@property (nonatomic,copy) NSString *waybill_id;
//时间
@property (nonatomic,copy) NSString *way_bill_time;
/// 加油枪的id
@property (nonatomic,copy) NSString *nozzle_order_id;
/// 加油枪的个数
@property (nonatomic,copy) NSString *nozzle_num;
/// 购买数量
@property (nonatomic,copy) NSString *order_buy_num;



@property (nonatomic,copy) NSString *bucket_pic_url;

/// 照片
@property (nonatomic,copy) NSArray<PSBucketModel *> *bucket_info_list;



@end


@interface PSBucketModel : BaseModel
/// 桶类型 吨桶 或 铁桶
@property (nonatomic,copy) NSString *bucket_type;
///
@property (nonatomic,copy) NSString *bucket_code;
/// 桶回显地址
@property (nonatomic,strong) NSMutableArray *bucket_do_img_urls;
/// 桶上传地址
@property (nonatomic,strong) NSMutableArray *bucket_up_img_urls;
/// 上传图片临时图片数组
@property (nonatomic,strong) NSMutableArray *bucket_do_img_urls_temp;
/// 密度
@property (nonatomic,copy) NSString *density;
/// 体积
@property (nonatomic,copy) NSString *volume;
/// 净重
@property (nonatomic,copy) NSString *weight;
/// 毛重
@property (nonatomic,copy) NSString *gross_weight;


//@property (nonatomic,copy) NSString *order_buy_num;



@property (nonatomic,assign) BOOL isOilGunCell;


/// 图片上传状态 例： [1,1,1] 表示三个都成功，失败的传0
@property (nonatomic,copy) NSArray *bucket_upload_state;


@end

NS_ASSUME_NONNULL_END
