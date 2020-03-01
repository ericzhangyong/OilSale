//
//  BaseVerifyUtils.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseVerifyUtils : NSObject

// 判断是否是纯数字字符串：YES: 是  NO:不是
+ (BOOL)isNumber:(NSString *)numberStr;

// 判断是否是由数字或字母组成
+ (BOOL)isNumberOrAlphabet:(NSString *)checkedString;

/** 是否是邮箱 */
+ (BOOL)isEmail:(NSString *)email;

// 验证手机号码
+ (BOOL)validatePhone:(NSString *)phone;

// 验证身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

// 判断是否是汉字
+ (BOOL)isChinese:(NSString *)input;

/**
 根据accuracy来确认originalStr小数点后保留几位，不足是结果自动补0,超过的直接截掉
 
 @param originalStr 需要操作的字符串
 @param accuracy 小数点后的精度
 @return 操作后的结果
 */
+ (NSString *)decimalsStringWithString:(NSString *)originalStr accuracy:(int)accuracy;

/**
 判断是否为空
 
 @return YES OR NO
 */
+ (BOOL)isNullOrSpaceStr:(NSString *)string;




/**
 点赞数量处理
 */
+(NSString *)handleLikeCountWithCount:(NSString *)count;

@end

NS_ASSUME_NONNULL_END
