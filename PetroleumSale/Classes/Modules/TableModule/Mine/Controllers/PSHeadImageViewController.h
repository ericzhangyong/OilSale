//
//  FPHeadImageViewController.h
//  Funmily
//
//  Created by zhangyong on 16/11/8.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^HeadImagePickComplete)(NSString *headImgPath, UIImage *headImage);

@interface PSHeadImageViewController : BaseViewController


@property (nonatomic,strong)HeadImagePickComplete headImagePickComplete;

-(instancetype)initWithHeadImagePath:(NSString *)headImgPath HeadImagePickComplete:(HeadImagePickComplete)headImagePickComplete;

-(instancetype)initWithHeadImagePath:(NSString *)headImgPath
                   isHiddenUploadBtn:(BOOL)isHiddenUploadBtn;






@end
