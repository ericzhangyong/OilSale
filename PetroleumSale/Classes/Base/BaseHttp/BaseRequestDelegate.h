//
//  WERequestDelegate.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//


@class BaseResponse;

@protocol BaseRequestDelegate <NSObject>

@optional

/**
 *  设置默认信息
 */
-(void)setupData;

/**
 *  添加请求 头信息
 */
-(void)addHeaderParam;
-(void)resetHeaderParam;

/**
 *  请求的URL
 */
-(NSString *)requestUrl;
-(NSString *)requestHandler;
-(NSString *)requestMethod;
/**
 *  过滤的参数
 */
+(NSArray *)getIgnoredKeys;

/**
 *  默认参数
 */
-(NSDictionary *)addDefaultParams;


/**
 *  参数处理
 */
- (BOOL)requestValidator;

/**
 *  返回值处理
 */
- (BaseResponse *)parseRespenseData:(BaseResponse *)baseRespense;
- (BaseResponse *)parseRespense:(id )info;

@end


