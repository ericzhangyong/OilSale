//
//  WEKeyChain.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/2.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseKeyChain : NSObject


/**
 存储uuid到钥匙串中
 @return 是否存储成功
 */
+(BOOL)saveKeyChain;


/**
 获取deviceId
 @return deviceId
 */
+(NSString *)getDeviceIdFromKeyChain;



@end

NS_ASSUME_NONNULL_END
