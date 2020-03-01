//
//  UIImage+FSImageCategory.h
//  FireStore
//
//  Created by eric on 2019/8/30.
//  Copyright © 2019 eric. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BaseImageCategory)
/**
 根据颜色生成图片
 
 @param color 颜色
 @param size 图片大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据颜色生成（1，1）图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 改变图片颜色
 
 @param color 颜色
 @return 图片
 */
- (UIImage *)changeImageWithColor:(UIColor *)color;



/**
 *  创建新的image
 *
 *  @param size        给定size
 *  @param contentMode contentMode
 *
 *  @return 新image
 */
- (nullable UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;


+ (UIImage *_Nullable)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
