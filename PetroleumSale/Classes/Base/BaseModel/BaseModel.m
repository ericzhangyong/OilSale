//
//  BaseModel.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

#pragma mark - json字典转换成Model
+ (id)convertModelWithJsonDic:(NSDictionary *)jsonDic {
    
    return [self yy_modelWithDictionary:jsonDic];
}

#pragma mark - json字符串转换成Model
+ (id)convertModelWithJsonStr:(NSString *)jsonStr {
    
    return [self yy_modelWithJSON:jsonStr];
}

#pragma mark - json数组model化
+ (NSArray *)convertModelWithJsonArr:(NSArray *)jsonArr {
    
    return [NSArray yy_modelArrayWithClass:self json:jsonArr];
}
#pragma mark- 过滤
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return nil;
}
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return nil;
}


#pragma mark - Coding/Copying/hash/equal
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    
    return [self yy_modelIsEqual:object];
}

- (NSString *)description {
    
    return [self yy_modelDescription];
}
@end



@implementation NSObject (BaseModel)

#pragma mark - model转成json对象
- (NSMutableDictionary *)modelToJsonDictionary {
    
    id obj = [self yy_modelToJSONObject];
    return obj;
}

- (NSString *)modelToJsonString
{
    return [self yy_modelToJSONString];
}

@end
