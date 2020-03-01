//
//  PSPersonEditSetModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PSPersonEditType){
    
    PSPersonEditTypeName, //主账户名称
    PSPersonEditTypeMainPhoneNum,// 主账户联系方式
    PSPersonEditTypeSub1,  //
    PSPersonEditTypeSub2
};
@interface PSPersonEditSetModel : BaseModel


@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *placeHolder;
@property (nonatomic,assign) PSPersonEditType editType;

@end

NS_ASSUME_NONNULL_END
