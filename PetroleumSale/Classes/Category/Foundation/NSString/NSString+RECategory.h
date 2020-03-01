//
//  NSString+RECategory.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RECategory)
/**
 获取字符串高度
 
 @param font 字号
 @param width 字符串的宽度
 @return 字符串的高度
 */
- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width;


- (NSString *)md5String;



/**
 获取字符串的宽度
 
 @param font 字号
 @return 宽度
 */
- (CGFloat)widthWithFont:(UIFont *)font;


/**
 去除字符串的换行和空格
 */
-(NSString *)getNoWhiteLineAndSpaceString;

/**
 判断是否为空
 
 @return YES:空
 */
- (BOOL)isNullOrSpaceString;


- (id)we_stringToJsonDictionary;

+ (CGFloat)boundingWidthWithStr:(NSString *)str font:(UIFont *)fontSize sizeHeight:(CGFloat)sizeHeight;

+ (NSString *)getParam:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
