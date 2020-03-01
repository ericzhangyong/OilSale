//
//  BaseRequest.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"
#import "HYBNetworking.h"
#import "BaseRequestHeader.h"
#import "BaseRequestHUD.h"
#import "AFNetworking.h"
#import "RELoginViewController.h"
#import "UserInfoProfile.h"

static NSMutableDictionary *cancelVCDic;

@interface BaseRequest ()

@property (nonatomic , weak) HYBURLSessionTask *urlSession;


@end
@implementation BaseRequest
+(void)load {
    [HYBNetworking configRequestType:kHYBRequestTypeJSON responseType:kHYBResponseTypeJSON shouldAutoEncodeUrl:NO callbackOnCancelRequest:NO];
    [HYBNetworking enableInterfaceDebug:NO];
}

-(instancetype)init
{
    self = [super init];
    [self setDefault];
    return self;
}
-(void)setDefault
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cancelVCDic = [NSMutableDictionary dictionaryWithCapacity:1];
    });
    _url = [self requestUrl];
    _showProgressHUD = NO;
    _showErrorMsg = YES;
    _showNoNetMsg = YES;
    _isAutoPopLoginVC = YES;
    [self setupData];
}
-(void)setupData
{
    
}

-(NSString *)requestUrl
{
    return [[self requestHandler] stringByAppendingString:[self requestMethod]];
}

-(NSString *)requestHandler
{
    return [BaseConfigUrl shareConfigUrl].webInstance;
}

-(NSString *)requestMethod
{
    return nil;
}

+(NSArray *)getIgnoredKeys
{
    return @[];
}

/**
 *   突然出现bug 待解决 及使用 YYModel 替换
 */
+(NSMutableArray *)mj_totalIgnoredPropertyNames
{
    return @[@"url",@"showProgressHUD",@"showErrorMsg",@"showNoNetMsg",@"debugDescription",@"description",@"hash",@"superclass",@"urlSession",@"isAutoPopLoginVC"].mutableCopy;
}

+ (nullable NSArray<NSString *> *)modelPropertyBlacklist
{
    NSArray *ignoredArr = [self getIgnoredKeys];
    NSArray *baseArr = [self mj_totalIgnoredPropertyNames];
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:baseArr];
    [mArr addObjectsFromArray:ignoredArr];
    return mArr.copy;
}



-(NSDictionary *)getParams
{
    NSMutableDictionary *paramDic = [self yy_modelToJSONObject];
    return paramDic.copy;
}
-(BOOL)isNeedRequestParamType{
    return YES;
}
-(BOOL)isNeedRequestBodyType{
    return NO;
}
-(id)getBodyStringParam{
    
    //    NSError *error
    NSData *bodyData = [self yy_modelToJSONData];
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+(instancetype)createWithParams:(NSDictionary*)params
{
    BaseRequest *ins = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        ins = [self yy_modelWithDictionary:params];
    }
    return ins;
}

- (void)getRequestCompleted:(DataCompletionBlock)respenseBlock{
    
    [self addHeaderParam];
    NSDictionary *params = [self getParams];
    BOOL showHUD = _showProgressHUD;
    if (showHUD) {
        [[BaseRequestHUD sharedRequestHUD] showRequestBusying];
    }
    [self getWithUrl:_url Param:params completed:^(BaseResponse *respense) {
        if (showHUD) {
            [[BaseRequestHUD sharedRequestHUD] hideRequestBusying];
        }
        respenseBlock(respense);
    }];
}
- (void)putRequestCompleted:(DataCompletionBlock)respenseBlock{
    
    [self addHeaderParam];
    NSDictionary *params = [self getParams];
    BOOL showHUD = _showProgressHUD;
    if (showHUD) {
        [[BaseRequestHUD sharedRequestHUD] showRequestBusying];
    }
    
    
    [HYBNetworking cacheGetRequest:NO shoulCachePost:NO];
    //设置传参类型
    //    [HYBNetworking setConfigHeaderNeedParam:[self isNeedRequestParamType] neddBody:[self isNeedRequestBodyType]];
    [HYBNetworking setRequestParametersInURISet:[self getParametersInURISet]];
    HYBURLSessionTask *task = [HYBNetworking putWithUrl:_url refreshCache:NO params:params progress:nil success:^(id response) {
        if (showHUD) {
            [[BaseRequestHUD sharedRequestHUD] hideRequestBusying];
        }
        respenseBlock([self parseRespense:response]);
    } fail:^(NSError *error) {
        if (showHUD) {
            [[BaseRequestHUD sharedRequestHUD] hideRequestBusying];
        }
        respenseBlock([self parseNetworkError:error]);
    }];
    
    _urlSession = task;
}

- (void)deleteRequestCompleted:(DataCompletionBlock)respenseBlock{
    [self addHeaderParam];
    NSDictionary *params = [self getParams];
    BOOL showHUD = _showProgressHUD;
    if (showHUD) {
        [[BaseRequestHUD sharedRequestHUD] showRequestBusying];
    }
    
    [HYBNetworking cacheGetRequest:NO shoulCachePost:NO];
    //设置传参类型
    //    [HYBNetworking setConfigHeaderNeedParam:[self isNeedRequestParamType] neddBody:[self isNeedRequestBodyType]];
    [HYBNetworking setRequestParametersInURISet:[self getParametersInURISet]];
    HYBURLSessionTask *task = [HYBNetworking deleteWithUrl:_url refreshCache:NO params:params progress:nil success:^(id response) {
        if (showHUD) {
            [[BaseRequestHUD sharedRequestHUD] hideRequestBusying];
        }
        respenseBlock([self parseRespense:response]);
    } fail:^(NSError *error) {
        if (showHUD) {
            [[BaseRequestHUD sharedRequestHUD] hideRequestBusying];
        }
        respenseBlock([self parseNetworkError:error]);
    }];
    _urlSession = task;
    //    AFHTTPSessionManager *deleteManager = [AFHTTPSessionManager manager];
    //
    //    [deleteManager DELETE:_url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        if (showHUD) {
    //            [[FFRequestHUD sharedRequestHUD] hideRequestBusying];
    //        }
    //        respenseBlock([self parseRespense:responseObject]);
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        respenseBlock([self parseNetworkError:error]);
    //        if (showHUD) {
    //            [[FFRequestHUD sharedRequestHUD] hideRequestBusying];
    //        }
    //    }];
}

- (void)postRequestCompleted:(DataCompletionBlock)respenseBlock
{
    [self addHeaderParam];
    [self requestValidator];
    NSDictionary *params = [self getParams];
    
    BOOL showHUD = _showProgressHUD;
    if (showHUD) {
        [[BaseRequestHUD sharedRequestHUD] showRequestBusying];
    }
    
    //    [MobClick beginEvent:@"request_duration" label:self.url];
    //    NSInteger rDuration = [NSDate date].timeIntervalSinceReferenceDate * 1000;
    [self postWithUrl:self.url params:params completed:^(BaseResponse *respense) {
        //        int dd =  [NSDate date].timeIntervalSinceReferenceDate * 1000 - rDuration;
        //        NSLog(@"统计时长:%zd",dd);
        //        [MobClick event:@"request_duration" label:self.url durations:dd] ;
        //        if(self.url){
        //            [MobClick event:@"request_duration" attributes:@{@"url" : self.url} counter:dd];
        //            [MobClick event:@"request_duration" attributes:@{@"url" : self.url} durations:dd];
        //        }
        //        [MobClick endEvent:@"request_duration" label:self.url];
        if (showHUD) {
            [[BaseRequestHUD sharedRequestHUD] hideRequestBusying];
        }
        respenseBlock(respense);
    }];
}


- (void)postRequestWithRequestBodyCompleted:(DataCompletionBlock)respenseBlock{
    
    id body = [self getBodyStringParam];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *reqest = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:self.url parameters:body error:nil];
    [reqest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [reqest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //请求body参数
    //    [reqest setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    //请求头
    NSDictionary *paramDic = [[BaseRequestHeader shareRequestHeader] getRequestHeaderDict];
    [reqest setAllHTTPHeaderFields:paramDic];
    for (NSString *key in paramDic.allKeys) {
        if (paramDic[key] != nil) {
            [manager.requestSerializer setValue:paramDic[key] forHTTPHeaderField:key];
        }
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"                                                                            ]];
    manager.requestSerializer.timeoutInterval = 60;
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    [[manager dataTaskWithRequest:reqest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            respenseBlock([self parseRespense:responseObject]);
        } else {
            [self parseFailResponse:responseObject];
        }
    }] resume] ;
}

- (void)postWithParams:(NSDictionary *)params requestCompleted:(DataCompletionBlock)respenseBlock
{
    [self postWithUrl:self.url params:params completed:^(BaseResponse *respense) {
        respenseBlock(respense);
    }];
}

//- (void)postRequestinVC:(UIViewController *)vc completed:(DataCompletionBlock)respenseBlock
//{
//    NSString *vcStr = [NSString stringWithFormat:@"%p",vc];
//    [cancelVCDic setValue:self forKey:vcStr];
//    [self postRequestCompleted:^(BaseResponse *respense) {
//        [cancelVCDic removeObjectForKey:vcStr];
//        respenseBlock(respense);
//    }];
//}

- (void)cancelRequest
{
    if (_urlSession) {
        if (_showProgressHUD) {
            [[BaseRequestHUD sharedRequestHUD] hideRequestBusying];
        }
        [HYBNetworking cancelRequestWithTask:_urlSession];
        _urlSession = nil;
    }
}

#pragma mark- 图片上传

-(void)uploadImages:(NSMutableArray *)images
           fileName:(NSString *)fileName
          Completed:(DataCompletionBlock)successBlock{
    
    [self addHeaderParam];
    [self requestValidator];
    NSDictionary *params = [self getParams];
    
    BOOL showHUD = _showProgressHUD;
    if (showHUD) {
        [[BaseRequestHUD sharedRequestHUD] showRequestBusying];
    }
    NSString *mineType = @"image/jpg/png/jpeg";
    [HYBNetworking uploadWithImages:images url:_url filename:fileName name:fileName mimeType:mineType parameters:params progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        
    } success:^(id response) {
        //(@"图片上传成功");
        successBlock([self parseRespense:response]);
    } fail:^(NSError *error) {
        successBlock([self parseNetworkError:error]);
    }];
}
-(void)uploadWithPUTImage:(UIImage *)image
                 fileName:(NSString *)fileName
                Completed:(DataCompletionBlock)successBlock{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);//image为要上传的图片(UIImage)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]];//&security-token=SecurityToken
    
    request.HTTPMethod = @"PUT";
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *configurationdd = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configurationdd];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
//    NSURLSessionUploadTask *taskdd = [manager uploadTaskWithRequest:request fromData:imageData progress:^(NSProgress * _Nonnull uploadProgress) {
//
//
//            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//        }];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromData:imageData progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                successBlock([self parseRespense:response]);
            }else{
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:@"success" forKey:@"code"];
                successBlock([self parseRespense:dict]);
            }
        }else{
            successBlock([self parseRespense:response]);
        }
    }];
    [uploadTask resume];

    
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT" URLString:self.url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (int i = 0;i<images.count ;i++)
//        {
//            UIImage * image = images[i];
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.1);//image为要上传的图片(UIImage)
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            formatter.dateFormat = @"yyyyMMddHHmmss";
//            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg",[formatter stringFromDate:[NSDate date]],i];
////            NSString *mineType = @"image/jpg/png/jpeg";
//            NSString *mineType = @"application/octet-stream";//阿里的方式上传
//            [formData appendPartWithFileData:imageData name:@"" fileName:fileName mimeType:mineType];
//        }
//    } error:nil];
//    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
//    __block NSURLSessionDataTask *task;
//    task = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//        if (!error) {
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                successBlock([self parseRespense:response]);
//            }else{
//                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//                [dict setValue:@"success" forKey:@"code"];
//                successBlock([self parseRespense:dict]);
//            }
//        }else{
//            successBlock([self parseRespense:response]);
//        }
//    }];
//    [task resume];
}


-(NSURLSessionTask *)getCurrentTask{
    return (NSURLSessionTask *)_urlSession;
}

+ (void)cancelRequestWithUrl:(NSString *)url
{
    [HYBNetworking cancelRequestWithURL:url];
}
-(NSSet *)getParametersInURISet{
    
    return [NSSet setWithArray:@[@"GET", @"HEAD", @"DELETE",@"PUT"]];
}
+ (void)cancelRequestAll
{
    [HYBNetworking cancelAllRequest];
}

- (HYBURLSessionTask *)getWithUrl:(NSString*)url
Param:(NSDictionary *)param
completed:(DataCompletionBlock)successBlock
{
    
    url = _url;
    [HYBNetworking cacheGetRequest:NO shoulCachePost:NO];
    //设置传参类型
    //    [HYBNetworking setConfigHeaderNeedParam:[self isNeedRequestParamType] neddBody:[self isNeedRequestBodyType]];
    
    [HYBNetworking setRequestParametersInURISet:[self getParametersInURISet]];
    HYBURLSessionTask *task = [HYBNetworking getWithUrl:url refreshCache:YES params:param success:^(id response) {
        successBlock([self parseRespense:response]);
    } fail:^(NSError *error) {
        successBlock([self parseNetworkError:error]);
    }];
    //    HYBURLSessionTask *task = [HYBNetworking getWithUrl:url refreshCache:YES success:^(id response) {
    //        successBlock([self parseRespense:response]);
    //    } fail:^(NSError *error) {
    //        successBlock([self parseNetworkError:error]);
    //    }];
    _urlSession = task;
    return task;
}




- (HYBURLSessionTask *)postWithUrl:(NSString*)url params:(id )params completed:(DataCompletionBlock)successBlock
{
    
    NSDictionary *paramDic;
    if ([params isKindOfClass:[BaseRequest class]]) {
        paramDic = [(BaseRequest*)(params) getParams];
    }else{
        paramDic = [params copy];
    }
    
    NSDictionary *addParams = [self addDefaultParams];
    if (addParams) {
        NSMutableDictionary *tempDic = [paramDic mutableCopy];
        [tempDic addEntriesFromDictionary:addParams];
        paramDic = [tempDic copy];
    }
    
    url = _url;
    
    //设置传参类型
    //    [HYBNetworking setConfigHeaderNeedParam:[self isNeedRequestParamType] neddBody:[self isNeedRequestBodyType]];
    [HYBNetworking setRequestParametersInURISet:[self getParametersInURISet]];
    HYBURLSessionTask *task = [HYBNetworking postWithUrl:url refreshCache:NO params:paramDic success:^(id response) {
        successBlock([self parseRespense:response]);
    } fail:^(NSError *error) {
        successBlock([self parseNetworkError:error]);
    }];
    _urlSession = task;
    return task;
}

#pragma mark - normal response
- (BaseResponse *)parseRespense:(id)info
{
    if (![info isKindOfClass:[NSDictionary class]]) {
        return [BaseResponse new];
    }
    
    // success
    NSString *appCode = info[@"code"];
    if ([appCode isEqualToString:@"success"]) {
        BaseResponse *baseRespense = [BaseResponse new];
        id itemsDic = [info objectForKey:@"data"];
        baseRespense.result = itemsDic;
        baseRespense.type = RespenseTypeSuccess;
        return [self parseRespenseData:baseRespense];
    }
    // fail
    return [self parseFailResponse:info];
}

#pragma mark - response fail
- (BaseResponse *)parseFailResponse:(NSDictionary *)info {
    BOOL shouldShowErr = YES;
    BaseResponse *baseRespense = [BaseResponse new];
    NSString *appCode = info[@"code"] ;
    NSString *appMesg = [NSString stringWithFormat:@"%@",info[@"msg"]];
    baseRespense.appCode = appCode;
    baseRespense.appMesg = appMesg;
    baseRespense.result = info;
    baseRespense.type = RespenseTypeFailed;
    
    if(([appMesg isEqualToString:@"用户身份过期"]||[appCode isEqualToString:@"expired"]||[appMesg isEqualToString:@"当前账户不存在"]) && self.isAutoPopLoginVC){//@"用户未登录或者在其他设备上登录，请重新登录！"
        shouldShowErr = NO;
        [UserInfoProfile.shareUserInfo clearAll];
        //登录过期或者未登录
        [RELoginViewController presentLoginWithLoginType:RELoginTypeSecretCode];
    }else if ([appCode isEqualToString:@"S1038"]){
        //挤出账号view
        shouldShowErr = NO;
//        [[RELoginKickNoticeView shareNoticeView] showNoticeView];
    }
    if (_showErrorMsg && shouldShowErr) {
        [MBProgressHUD toastMessageAddedTo:nil message:[NSString stringWithFormat:@"%@",appMesg]];
    }
    
    return [self parseRespenseData:baseRespense];
}

#pragma mark - network Error
- (BaseResponse *)parseNetworkError:(NSError *)error {
    BaseResponse *baseRespense = [BaseResponse new];
    baseRespense.error = error;
    baseRespense.type = RespenseTypeError;
    NSInteger statusCode = [self getStatusCodeFromError:error];
    baseRespense.appCode = @(statusCode).stringValue;
    NSString *errMsg = @"网络异常";
    if(![AFNetworkReachabilityManager sharedManager].isReachable){
        errMsg = @"无法连接到网络，请稍后再试";
    }else if (error.code == NSURLErrorTimedOut) {
        errMsg = @"请求超时,请稍后再试";
    }
    baseRespense.appMesg = errMsg;
    if (_showNoNetMsg) {
        //        [MBProgressHUD toastMessageAddedTo:nil message:errMsg];
    }
    return baseRespense;
}

-(NSInteger)getStatusCodeFromError:(NSError*)error
{
    NSError *responseError = error.userInfo[@"NSUnderlyingError"];
    NSHTTPURLResponse *response = responseError.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    NSInteger statusCode = 0;
    if (response) {
        statusCode = response.statusCode;
        if (statusCode == 0) {
            statusCode = -1;
        }
    }else{
        statusCode = error.code;
    }
    return statusCode;
}

-(void)addHeaderParam
{
    NSDictionary *paramDic = [[BaseRequestHeader shareRequestHeader] getRequestHeaderDict];
    [HYBNetworking configCommonHttpHeaders:paramDic];
    [HYBNetworking setTimeout:defaultTimeOut];
}
-(void)resetHeaderParam
{
    [HYBNetworking configCommonHttpHeaders:nil];
    [HYBNetworking setTimeout:defaultTimeOut];
}

- (BOOL)requestValidator {
    return YES;
}

-(NSDictionary *)addDefaultParams
{
    return nil;
}


- (BaseResponse *)parseRespenseData:(BaseResponse *)baseRespense
{
    return baseRespense;
}
-(void)dealloc
{
    //    DDLogWarn(@"%@---dealloc",NSStringFromClass([self class]));
}

@end

@implementation BaseResponse

-(BOOL)isFinished
{
    return _type == RespenseTypeSuccess;
}
-(BOOL)isFailed
{
    return _type == RespenseTypeFailed;
}


//-(void)dealloc
//{
//    NSLog(@"%@---dealloc",NSStringFromClass([self class]));
//}

@end



@interface UIViewController (RequestDealloc)

@end

@implementation UIViewController (RequestDealloc)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController swizzling];
    });
}

+ (void)swizzling
{
    
    Class class = [self class];
    
    SEL originalSelector = NSSelectorFromString(@"dealloc");
    SEL swizzledSelector = @selector(request_dealloc);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


- (void)request_dealloc{
    //    NSLog(@"-------------%@----------------",NSStringFromClass([self class]));
    BaseRequest *request = [cancelVCDic objectForKey:[NSString stringWithFormat:@"%p",self]];
    if (request) {
        [request cancelRequest];
        request = nil;
    }
    [self request_dealloc];
}
@end
