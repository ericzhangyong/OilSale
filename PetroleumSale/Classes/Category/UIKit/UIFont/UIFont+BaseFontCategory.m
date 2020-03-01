//
//  UIFont+FSFontCategory.m
//  FireStore
//
//  Created by eric on 2019/8/30.
//  Copyright © 2019 eric. All rights reserved.
//

#import "UIFont+BaseFontCategory.h"

static CGFloat fontFloat = 1.0;
@implementation UIFont (BaseFontCategory)

+ (UIFont *)systemWEFontOfSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:fontSize];
}

+(UIFont *)systemPlusFontOfSize:(CGFloat)fontSize{
    
    if (kScreenWidth == 414)
    {
        return [UIFont systemFontOfSize:fontSize * fontFloat];
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)boldSystemLJFontOfSize:(CGFloat)fontSize
{
    if (kScreenWidth == 414)
    {
        return [UIFont boldSystemFontOfSize:fontSize * fontFloat];
    }
    return [UIFont boldSystemFontOfSize:fontSize];
}

//iOS9之前没有平方字体
+ (UIFont *)systemWEPingFanglightFontOfSize:(CGFloat)fontSize
{
    if([UIDevice currentDevice].systemVersion.floatValue < 9.0f){
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
}

+ (UIFont *)systemWEPingFangRegularOfSize:(CGFloat)fontSize
{
    if([UIDevice currentDevice].systemVersion.floatValue < 9.0f){
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)systemWEPingFangBoldFontOfSize:(CGFloat)fontSize
{
    if([UIDevice currentDevice].systemVersion.floatValue < 9.0f){
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}
+ (UIFont *)systemWEPingFangMediumFontOfSize:(CGFloat)fontSize
{
    if([UIDevice currentDevice].systemVersion.floatValue < 9.0f){
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}
@end
