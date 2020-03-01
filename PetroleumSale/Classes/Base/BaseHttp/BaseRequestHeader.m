//
//  BaseRequestHeader.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseRequestHeader.h"
#import "BaseKeyChain.h"
@interface BaseRequestHeader ()

@property (nonatomic, strong) NSMutableDictionary *defaultHeaders;

@end
@implementation BaseRequestHeader


+(instancetype)shareRequestHeader{
    
    static BaseRequestHeader *header = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        header = [BaseRequestHeader new];
    });
    return header;
}

- (NSMutableDictionary *)defaultHeaders {
    
    if (!_defaultHeaders) {
        

        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:REUserTokenKey];
        _defaultHeaders = [NSMutableDictionary dictionary];
        if (![BaseVerifyUtils isNullOrSpaceStr:token]) {
            [_defaultHeaders setObject:token forKey:REUserTokenKey];
        }
//        NSString *devicedId  = [BaseKeyChain getDeviceIdFromKeyChain];
//        [_defaultHeaders setObject:devicedId forKey:@"deviceId"];
//        //1-other; 2-IOS; 3-Android; 4-H5 --设备类型
//        [_defaultHeaders setObject:@"2" forKey:@"deviceType"];
//
        
    }
    return _defaultHeaders;
}


-(void)setUp{
    
}

-(NSDictionary *)getRequestHeaderDict{
    
    return self.defaultHeaders;
}
- (void)updateLoginToken:(NSString *)token{
    
    
    [self.defaultHeaders setObject:token forKey:REUserTokenKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:REUserTokenKey];
}

-(void)deleteLoginToken{
    _defaultHeaders = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:REUserTokenKey];
}

-(NSString  *)getLoginToken{
    return self.defaultHeaders[REUserTokenKey];
}


@end
