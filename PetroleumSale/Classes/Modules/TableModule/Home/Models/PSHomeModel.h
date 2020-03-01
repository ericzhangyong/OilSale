//
//  PSHomeModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/27.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
#import "PSStationCarModel.h"
#import "PSStationModel.h"
@class PSOilPriceModel;
@class PSProductModel;
@class PSBannerModel;
@class PSFarpProductHomeModel;
@class PSOidPriceCarModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSHomeModel : BaseModel


/// 通知标题
@property (nonatomic,copy) NSString *notice_title;

/// 购买建议 您上次购买2个月前...
@property (nonatomic,copy) NSString *buy_notice;

/// banner轮播图
@property (nonatomic,copy) NSArray<PSBannerModel *> *tool_bar_list;

/// 今日油价
@property (nonatomic,copy) PSOilPriceModel *oil_price_today;

/// 商品列表
@property (nonatomic,copy) NSArray<PSProductModel *> *product_list;
/// 按车批发列表
@property (nonatomic,copy) NSArray<PSProductModel *> *car_product_list;
/// 委托加油点
@property (nonatomic,copy) PSFarpProductHomeModel *farp_product;

@property (nonatomic,copy) PSOidPriceCarModel *oil_price_car_whole_sale;


@end

@interface PSOilPriceModel:BaseModel
@property (nonatomic,copy) NSString *material_id;
/// 材料名称
@property (nonatomic,copy) NSString *material_name;
/// 材料价格
@property (nonatomic,copy) NSString *oil_price;
/// 最后一次上报时间
@property (nonatomic,copy) NSString *update_time;
@end

@interface PSProductModel : BaseModel
/// 桶描述
@property (nonatomic,copy) NSString *bucket_desc;
/// 图片地址
@property (nonatomic,copy) NSString *bucket_pic;
/// 吨桶装或铁通装
@property (nonatomic,copy) NSString *bucket_type;
/// 商品编号
@property (nonatomic,copy) NSString *bucket_type_id;
/// 单价 20/桶 20
@property (nonatomic,copy) NSString *unit_price;
/// 单价单位 20/桶 桶
@property (nonatomic,copy) NSString *unit_type;
/// 含税
@property (nonatomic,copy) NSString *tax_include_price;
/// 不含税
@property (nonatomic,copy) NSString *tax_exclude_price;

/// 规格 最小单位是升 1000升 ------- 1000
@property (nonatomic,copy) NSString *bucket_volume;
/// 配送费用（车装油取当前记录）
@property (nonatomic,copy) NSString *distribution_fee;

/// 购买数量-----
@property (nonatomic,copy) NSString *buy_num;

/// Yes:不含税或者配送  NO：含税 或者自提-------按车批发对应自提和配送
@property (nonatomic,assign) BOOL notContainTaxOrDeliver;


@end

@interface PSBannerModel : BaseModel

/// banner内容
@property (nonatomic,copy) NSString *bar_content;
/// toolbar图片
@property (nonatomic,copy) NSString *bar_pic_url;
/// toolbar标题
@property (nonatomic,copy) NSString *bar_title;
/// 创建时间
@property (nonatomic,copy) NSString *cre_time;
/// 点击后的重定向地址 可能用webview实现 跳转地址
@property (nonatomic,copy) NSString *redirect_uri;

@end



@interface PSFarpProductHomeModel : BaseModel


/// 委托加油点列表
@property (nonatomic,strong) NSArray<PSStationModel *> *farp_addr_list;
/// 委托加油点车辆车牌号列表
@property (nonatomic,strong) NSArray<PSStationCarModel *> *farp_car_list;
/// 委托加油点油的价格
@property (nonatomic,copy) NSString *farp_oil_price;

@end


@interface PSOidPriceCarModel : BaseModel

/// <#Description#>
@property (nonatomic,copy) NSString *material_id;

/// 材料名称
@property (nonatomic,copy) NSString *material_name;

/// 材料价格
@property (nonatomic,copy) NSString *oil_price;

/// 最后一次上报时间
@property (nonatomic,copy) NSString *update_time;
@end


NS_ASSUME_NONNULL_END
