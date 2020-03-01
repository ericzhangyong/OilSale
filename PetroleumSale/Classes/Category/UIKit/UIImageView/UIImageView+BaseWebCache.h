//
//  UIImageView+FSWebCache.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (BaseWebCache)

-(void)setImageWithUrl:(id)urlStr placeholder:(UIImage *)placeholder;

-(void)setImageWithUrl:(id)urlStr placeholder:(UIImage *)placeholder
         completeBlock:(void(^)(UIImage *image,BOOL isFinish))completeBlock;


-(void)drawDottedLine;
@end

NS_ASSUME_NONNULL_END
