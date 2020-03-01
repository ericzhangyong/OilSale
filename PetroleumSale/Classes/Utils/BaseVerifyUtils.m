//
//  BaseVerifyUtils.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseVerifyUtils.h"

@implementation BaseVerifyUtils
+ (BOOL)isNumber:(NSString *)numberStr{
    numberStr = [numberStr stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (numberStr.length > 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)isNumberOrAlphabet:(NSString *)checkedString{
    NSString *regex = @"^[a-zA-Z0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:checkedString];
}

+ (NSString *)decimalsStringWithString:(NSString *)originalStr accuracy:(int)accuracy{
    NSString *resultStr = nil;
    if (originalStr.length > 0 && accuracy >= 0) {
        // 添加要显示的0
        NSMutableString *supplementZero = [NSMutableString string];
        for (int i = 0; i < accuracy; i++) {
            [supplementZero appendString:@"0"];
        }
        
        if ([originalStr containsString:@"."]) {
            NSString *strDecimal = [[[[originalStr componentsSeparatedByString:@"."] lastObject] stringByAppendingString:supplementZero] substringToIndex:accuracy];
            resultStr = [NSString stringWithFormat:@"%@.%@",[[originalStr componentsSeparatedByString:@"."] firstObject],strDecimal];
        } else {
            resultStr = [NSString stringWithFormat:@"%@.%@",originalStr,supplementZero];
        }
    }
    return resultStr;
}

+ (BOOL)isEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
    
}

+ (BOOL)validatePhone:(NSString *)phone{
    
    NSString *mobile = @"^1[3-9]\\d{9}$";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobile];
    if ([regexMobile evaluateWithObject:phone]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    NSString *regex = @"\\d{17}[[0-9],0-9xX]";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)isChinese:(NSString *)input {
    if (input.length == 0) return NO;
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:input];
}

+ (BOOL)isNullOrSpaceStr:(NSString *)string
{
    if(string == nil || [string isEqual:@"<null>"] || [string isEqual:[NSNull null]] || [string isEqual:@"null"] || [string isEqual:@"(null)"] || [string isEqual:@"NULL"] || [string isEqual:@""])
        return YES;
    if ([string isKindOfClass:[NSString class]] && [string rangeOfString:@"null null"].length>1) {
        return YES;
    }
    return NO;
}


+(NSString *)handleLikeCountWithCount:(NSString *)count{
    
    double doubCount = count.doubleValue;
    NSString *handleCount = count;
    if (doubCount>= 1000 && doubCount<10000) {
        handleCount = [NSString stringWithFormat:@"%.2lfk",doubCount/1000];
    }else if (doubCount>=10000){
        handleCount = [NSString stringWithFormat:@"%.2lfw",doubCount/10000];
    }
    return handleCount;
}
@end
