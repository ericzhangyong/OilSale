//
//  BaseRequest.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestDelegate.h"
#import "BaseConfigUrl.h"
#import "YYModel.h"
#import "NSObject+YYModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,RespenseType) {
    RespenseTypeNone,
    RespenseTypeSuccess,
    RespenseTypeFailed,
    RespenseTypeError,
    RespenseTypeOther
};
typedef void (^DataCompletionBlock)(BaseResponse *response);

@interface BaseRequest : NSObject<YYModel,BaseRequestDelegate>


@property (nonatomic,copy) NSString *url;
/**
 *  是否显示 加载HUD 默认不显示 。默认为NO
 */
@property (nonatomic, assign,getter=isShowProgressHUD) BOOL showProgressHUD;

/**
 *  是否显示 错误提示 。默认为YES
 */
@property (nonatomic, assign,getter=isShowErrorMsg) BOOL showErrorMsg;

/**
 *  是否显示 无网提示 。默认为NO
 */
@property (nonatomic, assign,getter=isShowNoNetMsg) BOOL showNoNetMsg;

/**
 *  是否需要自动弹出登录控制器。（错误F2001为未登录或者用户登录过期，）默认为YES
 */
@property (nonatomic, assign,getter=isPopLoginVC) BOOL isAutoPopLoginVC;



/**
 *  通过字典模型 创建对象
 */
+(instancetype)createWithParams:(NSDictionary*)params;

/**
 获取默认的param
 
 @return dict
 */
-(NSDictionary *)getParams;

/**
 body字符串参数-->post Body
 
 @return id
 */
-(id)getBodyStringParam;

#pragma mark- Requst请求
/**
 get请求
 
 @param respenseBlock 请求完成回调
 */
- (void)getRequestCompleted:(DataCompletionBlock)respenseBlock;
/**
 put请求
 
 @param respenseBlock 请求完成回调
 */
- (void)putRequestCompleted:(DataCompletionBlock)respenseBlock;
/**
 delete请求
 
 @param respenseBlock 请求完成回调
 */
- (void)deleteRequestCompleted:(DataCompletionBlock)respenseBlock;


/**
 *  发送网络请求
 *
 *  @param respenseBlock 请求完成回调
 */
- (void)postRequestCompleted:(DataCompletionBlock)respenseBlock;

/**
 通过body传参数
 @param respenseBlock 请求完成回调
 */
- (void)postRequestWithRequestBodyCompleted:(DataCompletionBlock)respenseBlock;
/**
 *  发送网络请求,在UIViewController dealloc 时 自动销毁，vc block使用@weak(self),@strong(self).
 *
 *  @param respenseBlock 请求完成回调
 */
//- (void)postRequestinVC:(UIViewController *)vc completed:(DataCompletionBlock)respenseBlock;
- (void)postWithParams:(NSDictionary *)params requestCompleted:(DataCompletionBlock)respenseBlock;
//上传图片
#pragma mark- 图片上传

/**
 图片上传
 @param images 上传图片数组
 @param fileName fileName
 @param successBlock 请求完成回调
 */
-(void)uploadImages:(NSMutableArray *)images
           fileName:(NSString *)fileName
          Completed:(DataCompletionBlock)successBlock;


/// put方式 上传图片
/// @param image 图片数组
/// @param fileName fileName
/// @param successBlock 回调
-(void)uploadWithPUTImage:(UIImage *)image
                 fileName:(NSString *)fileName
                Completed:(DataCompletionBlock)successBlock;



+ (void)cancelRequestWithUrl:(NSString *)url;
+ (void)cancelRequestAll;
/**
 *  取消请求
 */
- (void)cancelRequest;

/**
 AFN只支持`GET`, `HEAD`, 和 `DELETE
 requestManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"GET", @"GET", @"HEAD"]];
 如果想post支持param拼接请求接口可以设置
 [NSSet setWithArray:@[@"GET", @"GET", @"HEAD",@"POST"]]
 @return HTTPMethodsEncodingParametersInURI [NSSet]
 */
-(NSSet *)getParametersInURISet;

@end

#pragma mark- Response

@interface BaseResponse : NSObject

@property (nonatomic, assign,readonly,getter=isFinished) BOOL finished;
@property (nonatomic, assign,readonly,getter=isFailed) BOOL failed;

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id result;
@property (nonatomic, copy) NSString *appCode;
@property (nonatomic, copy) NSString *appMesg;

@property (nonatomic, assign) RespenseType type;

@end


NS_ASSUME_NONNULL_END
