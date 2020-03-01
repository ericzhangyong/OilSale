//
//  NSString+RECategory.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "NSString+RECategory.h"
#include <CommonCrypto/CommonCrypto.h>


@implementation NSString (RECategory)
- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width {
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

- (CGFloat)widthWithFont:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
}

-(NSString *)getNoWhiteLineAndSpaceString{
    
    NSString *phoneum = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneum  = [phoneum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return phoneum;
}

- (NSString *)md5String{
    if (self == nil || self.length == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

- (id)we_stringToJsonDictionary {
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    if (error) {
        return nil;
    } else {
        return jsonDic;
    }
}

+ (CGFloat)boundingWidthWithStr:(NSString *)str font:(UIFont *)fontSize sizeHeight:(CGFloat)sizeHeight
{
    
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(10000, sizeHeight)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:@{NSFontAttributeName:fontSize}
                                       context:nil].size;
    
    return retSize.width;
}

//将字典转换为H5拼接的字符串
+ (NSString *)getParam:(NSDictionary *)param
{
    NSArray *allKeys = param.allKeys;
    NSArray *allValues = param.allValues;
    
    NSString *string = @"";
    for (int i = 0; i < allKeys.count; i++)
    {
        NSString *key = allKeys[i];
        NSString *value = allValues[i];
        NSString *keyAndValue = [NSString stringWithFormat:@"%@=%@",key,value];
        string = [string stringByAppendingString:keyAndValue];
        string = [string stringByAppendingString:@"&"];
    }
    
    string = [string substringToIndex:string.length - 1];
    
    return string;
}
@end
