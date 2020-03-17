//
//  PSMineSetModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,PSMineCellType){
    PSMineCellTypeAddress,//收货地址
    PSMineCellTypeMessage, //消息通知
    PSMineCellTypeUploadImage,//上传图片
    PSMineCellTypeCanCount,//油桶数量
    PSMineCellTypeCarMessage,//车辆信息
    PSMineCellTypeCollectCan, //收油桶
    PSMineCellTypeAcountMoney, //记账金额
    PSMineCellTypeStationAddress,//加油点地址
    PSMineCellTypeStationReserves, //加油点储量
    PSMineCellTypeStationInvite //邀请码



};

@interface PSMineSetModel : BaseModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *iconImageUrl;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *content;

@property (nonatomic,assign) PSMineCellType mineCellType;


@end

NS_ASSUME_NONNULL_END
