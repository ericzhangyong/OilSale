//
//  PSPhotoViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSPhotoConfirmModel.h"
#import "PSStationPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPhotoViewModel : BaseViewModel


@property (nonatomic,copy) PSPhotoConfirmModel *photoModel;

@property (nonatomic,assign) NSInteger currentSelectIndex;

-(void)didSelectWithOrderNoCode:(NSString *)orderCode;
-(void)didSelectWithIndex:(NSInteger)index;


-(BOOL)billOrderIsHaveOilGun;

-(BOOL)isOilGunCellAtIndex:(NSInteger)index;
-(void)ps_setOilGunValue:(NSString *)value;

-(NSInteger)ps_getBucketCountAtIndex:(NSInteger)index;
/// bucket图片
-(NSString *)ps_getBucketImgeUrlAtIndex:(NSInteger)index row:(NSInteger)row;
/// bucket图片是否显示添加按钮
-(BOOL)ps_getBucketIsShowAddIconAtIndex:(NSInteger)index row:(NSInteger)row;
/// bucket图片是否显示删除按钮
-(BOOL)ps_getBucketIsShowDeleteBtnAtIndex:(NSInteger)index row:(NSInteger)row;

/// bucket上传图片地址
-(NSString *)ps_getBucketUploadImgeUrlAtIndex:(NSInteger)index row:(NSInteger)row;
/// bucke类型
-(NSString *)ps_getBucketTitleAtIndex:(NSInteger)index;
/// bucke密度
-(NSString *)ps_getBucketDensityAtIndex:(NSInteger)index;
/// 体积
-(NSString *)ps_getVolumeAtIndex:(NSInteger)index;
/// 净重
-(NSString *)ps_getRoughWeightAtIndex:(NSInteger)index;
/// 净重
-(NSString *)ps_getGrossWeightAtIndex:(NSInteger)index;

/// 设置体积
-(void)ps_setVolumeWithText:(NSString *)text AtIndex:(NSInteger)index;
/// 设置重量
-(void)ps_setWeightWithText:(NSString *)text AtIndex:(NSInteger)index;
-(void)ps_setDensityWithText:(NSString *)text AtIndex:(NSInteger)index;
-(void)ps_setGrossWeightWithText:(NSString *)text
                         AtIndex:(NSInteger)index;

/// 设置imageurl
-(void)ps_setImageUrlWithUrl:(NSString *)url AtIndex:(NSInteger)index row:(NSInteger)row;
-(void)ps_setImageWithImage:(UIImage *)image AtIndex:(NSInteger)index row:(NSInteger)row;
-(UIImage *)ps_getImageAtIndex:(NSInteger)index row:(NSInteger)row;


-(NSString *)ps_getHeaderLabeTitle;
-(NSString *)ps_getHeaderLabeContent;
-(NSString *)ps_getHeaderRegion;
-(NSString *)ps_getHeaderCompleteAddress;
-(NSString *)ps_getHeaderName;
-(NSString *)ps_getHeaderPhoneNum;
-(void)ps_setSelectCarWithcarInfoId:(NSString *)car_info_id;



#pragma mark- 数据处理-----委托加油点

@property (nonatomic,copy) PSStationPhotoModel *stationPhotoModel;


#pragma mark- 接口请求---司机

-(void)requestPhotoConfirmComplete:(completeBlock)complete;
/// 保存拍照
-(void)reqeustSavePhotoComplete:(completeBlock)complete;




@end

NS_ASSUME_NONNULL_END
