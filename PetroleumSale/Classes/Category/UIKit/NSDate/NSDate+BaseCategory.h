//
//  NSDate+BaseCategory.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (BaseCategory)
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger numberOfDaysInMonth;

//从1970年开始到现在经过了多少秒

+(NSString *)getTimeSp;


- (NSDate *)zy_getNowDate;
-(NSString *)zy_stringWithDateFormatter:(NSString *)formatter;

/**
 返回一个dateStr
 
 @param formatter formatter
 @param value 毫秒
 @return string
 */
+(NSString *)zy_stringWithDateFormatter:(NSString *)formatter Value:(double)value;

+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;



/**
 时间格式，刚刚 几分钟前 几小时 几天 时间
 
 @param createTimer 创建时间戳
 @return 返回字符串
 */
+(NSString *)dateForematterToNowDateWithCreateDate:(long long)createTimer;


/**
 获取年龄
 
 @param dateString 生日字符串
 @param dataFormatte 格式：类似2019-1-14
 @return 返回年龄
 */
+(NSString *)getAgeDateFormatterWithString:(NSString *)dateString formatte:(NSString *)dataFormatte;

//获取当前的时间
+(NSString*)getCurrentTimes;


/**
 现在的时间跟创建时间间隔
 
 @param createDate 创建时间
 @return 间隔时间
 */
+(NSTimeInterval)getNowDateToCreateTime:(NSDate *)createDate;




//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate outDateFormatter:(NSString *)outDateFormatter;
    //将本地日期字符串转为UTC日期字符串
    //本地日期格式:2013-08-03 12:53:51
    //可自行指定输入输出格式
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate;
@end

NS_ASSUME_NONNULL_END
