//
//  BaseModel.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject<NSCopying,NSCoding>
#pragma mark - json字典转换成Model
+ (id)convertModelWithJsonDic:(NSDictionary *)jsonDic;
#pragma mark - json字符串转换成Model
+ (id)convertModelWithJsonStr:(NSString *)jsonStr;
#pragma mark - json数组model化
+ (NSArray *)convertModelWithJsonArr:(NSArray *)jsonArr;


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper;
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass;

@end
@interface NSObject (BaseModel)

/**
 *  将model转成json对象
 *
 *  @return NSDictionary 或 NSArray类型
 */
- (NSMutableDictionary *)modelToJsonDictionary;


- (NSString *)modelToJsonString;

@end

NS_ASSUME_NONNULL_END
