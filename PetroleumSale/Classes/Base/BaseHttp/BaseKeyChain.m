//
//  WEKeyChain.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/2.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseKeyChain.h"

#define serviceName @"com.waterElephant.video"

#define deviceIdAccount @"deviceIdAccount"

@implementation BaseKeyChain


+(BOOL)setKeyChainValue:(NSString *)value forkey:(NSString *)key{
    
    return nil;
}

+(BOOL)saveKeyChain{
    
    NSString *key = deviceIdAccount;
    NSString *value = [NSUUID UUID].UUIDString;
    
    NSMutableDictionary *keychainDict = [self getKeyChainQueryDictWithKey:key];
    OSStatus status = -1;
    CFTypeRef result = nil;
   status = SecItemCopyMatching((__bridge CFDictionaryRef)keychainDict, &result);
    //先查询是否创建过
    if (status == errSecItemNotFound) {
        //创建
        NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
        [keychainDict setObject:valueData forKey:(__bridge id)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)keychainDict, &result);
    }else if(status == errSecSuccess){
        //更新
        NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *updateDict =[[NSMutableDictionary alloc] initWithDictionary:keychainDict];
        [updateDict setObject:valueData forKey:(id)kSecValueData];
        status = SecItemUpdate((__bridge CFDictionaryRef)keychainDict, (__bridge CFDictionaryRef)updateDict);
    }
    
    if (status == errSecSuccess) {
        return YES;
    }else{
        return NO;
    }
    
    //对错误进行处理
    
}


+(NSString *)getDeviceIdFromKeyChain{
    
    NSString *devicedId = [self queryKeychainWithKey:deviceIdAccount];
    return devicedId;
}


+(NSString *)queryKeychainWithKey:(NSString *)key{
    
    if (key) {
        NSMutableDictionary *query = [self getKeyChainQueryDictWithKey:key];
        [query setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
        CFTypeRef dataRef = nil;
        OSStatus errorCode = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&dataRef);
        if (errorCode == errSecSuccess) {
            NSString *value = [[NSString alloc] initWithData:(__bridge NSData *)dataRef encoding:NSUTF8StringEncoding];
            return value;
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}

+(NSMutableDictionary *)getKeyChainQueryDictWithKey:(NSString *)key{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [dict setObject:serviceName forKey:(__bridge id)kSecAttrService];
    [dict setObject:key forKey:(__bridge id)kSecAttrAccount];
    return dict;
}

@end
