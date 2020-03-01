//
//  NSDate+BaseCategory.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "NSDate+BaseCategory.h"

@implementation NSDate (BaseCategory)

+(NSString *)getTimeSp
{
    NSString *time;
    NSDate *fromdate=[NSDate date];
    time = [NSString stringWithFormat:@"%f",[fromdate timeIntervalSince1970]];
    return time;
}


- (NSDate *)zy_getNowDate{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}

-(NSInteger)year{
    return [[NSCalendar currentCalendar]component:NSCalendarUnitYear fromDate:self];
}

-(NSInteger)month{
    return [[NSCalendar currentCalendar]component:NSCalendarUnitMonth fromDate:self];
}

-(NSInteger)day{
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self];
}

-(NSInteger)weekday{
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:self];
}
-(NSInteger)numberOfDaysInMonth{
    NSCalendar *current = [NSCalendar currentCalendar];
    NSRange range = [current rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}



-(NSString *)zy_stringWithDateFormatter:(NSString *)formatter{
    
    NSString *dateStr = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    dateStr =  [dateFormatter stringFromDate:self];
    return dateStr;
}
+(NSString *)zy_stringWithDateFormatter:(NSString *)formatter Value:(double)value{
    
    NSString *dateStr = @"";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value*0.001];
    dateStr =  [date zy_stringWithDateFormatter:formatter];
    return dateStr;
}



//let formatter = DateFormatter()
//formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS+SSSS'Z'"
//formatter.timeZone = TimeZone(identifier: "UTC")
//guard let createdDate = formatter.date(from: time) else {
//    return Date()

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}


+(NSString *)dateForematterToNowDateWithCreateDate:(long long)createTimer{
    
    NSDate *createDate= [NSDate dateWithTimeIntervalSince1970:createTimer*0.001].zy_getNowDate;
    NSDate *nowDate= [NSDate date].zy_getNowDate;
    
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:createDate];
    
    NSString *result;
    long temp = 0;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = timeInterval/(60*60)) < 24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = timeInterval/(24*60*60)) < 3){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }else{
        
        result = [NSDate zy_stringWithDateFormatter:@"YYYY-MM-dd HH:mm" Value:createTimer];
    }
    
    return result;
}

+(NSString *)getAgeDateFormatterWithString:(NSString *)bornString formatte:(NSString *)dataFormatte{
    
    NSDate *bornDate= [NSDate dateWithTimeIntervalSince1970:bornString.doubleValue*0.001].zy_getNowDate;
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //    //获得当前系统时间与出生日期之间的时间间隔
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *dateCompoents = [calendar components:unitFlag fromDate:bornDate toDate:currentDate options:0];
    return [NSString stringWithFormat:@"%zd",dateCompoents.year];
}



//获取当前的时间

+(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

+(NSTimeInterval)getNowDateToCreateTime:(NSDate *)createDate{
    
    NSDate *bornDate= createDate.zy_getNowDate;
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:bornDate];
    
    return timeInterval;
}


//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}
  
//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate outDateFormatter:(NSString *)outDateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.sssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:outDateFormatter];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

@end
