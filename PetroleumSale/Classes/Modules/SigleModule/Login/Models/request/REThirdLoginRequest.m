//
//  WEThirdLoginRequest.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/23.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "REThirdLoginRequest.h"

@implementation REThirdLoginRequest


//-(NSString *)requestUrl{
//
//    return @"http://media.gateway.app.cef0e73c879624990a12fcf7c3cd3ea9d.cn-shanghai.alicontainer.com/api/user/fegin/userThreeLogin";
//}

//-(NSString *)requestHandler{
//
//    return @"http://192.168.133.207:28305/";
//}




-(NSString *)requestMethod{
    return @"123";
}

//- (NSInteger)sourceApplication{
//    return 1;
//}

#pragma mark - response fail
- (BaseResponse *)parseFailResponse:(NSDictionary *)info {
    BOOL shouldShowErr = YES;
    BaseResponse *baseRespense = [BaseResponse new];
    NSString *appCode = info[@"appCode"] ;
    NSString *appMesg = [NSString stringWithFormat:@"%@",info[@"appMesg"]];
    baseRespense.appCode = appCode;
    baseRespense.appMesg = appMesg;
    baseRespense.result = info;
    baseRespense.type = RespenseTypeFailed;
    
    if([appCode isEqualToString:@"S1001"] && self.isAutoPopLoginVC){//@"用户未登录或者在其他设备上登录，请重新登录！"
        shouldShowErr = NO;
        //登录过期或者未登录
    }else if ([appCode isEqualToString:@"S1020"]){
        shouldShowErr = NO;
    }
    if (self.showErrorMsg && shouldShowErr) {
        [MBProgressHUD toastMessageAddedTo:nil message:[NSString stringWithFormat:@"%@",appMesg]];
    }
    
    return [self parseRespenseData:baseRespense];
}

@end
