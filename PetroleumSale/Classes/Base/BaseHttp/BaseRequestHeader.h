//
//  BaseRequestHeader.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define REUserTokenKey @"auth-token"

@interface BaseRequestHeader : NSObject

+(instancetype)shareRequestHeader;



- (NSDictionary *)getRequestHeaderDict;

//更新Token
- (void)updateLoginToken:(NSString *)token;
//删除TOken
-(void)deleteLoginToken;
-(NSString  *)getLoginToken;


@end

NS_ASSUME_NONNULL_END
