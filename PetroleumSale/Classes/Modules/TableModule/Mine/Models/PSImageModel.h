//
//  PSImageModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/16.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSImageModel : BaseModel
/// file_id
@property (nonatomic,copy) NSString *file_id;
/// 图片地址
@property (nonatomic,copy) NSString *file_url;
//@property (nonatomic,strong) UIImage *image_header;
/// <#des#>
@property (nonatomic,assign) CGSize imageSize;
@end

NS_ASSUME_NONNULL_END
