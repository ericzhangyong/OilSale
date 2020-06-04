//
//  WEBaseWebViewController.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/5.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "BaseWeakScriptDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : UIViewController<WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>


/// is
@property (nonatomic,assign) BOOL isDefaultShowTitle;

@property (nonatomic, strong) WKWebView *wkwebView;

@property (nonatomic,strong) NSString *webUrl;

@property (nonatomic,strong) WKWebViewConfiguration *configuration;

@property (nonatomic,strong) WKUserContentController *userContentController;

/**
 返回按钮响应事件
 */
- (void)returnBtnDidselected;

-(void)addContentView;

/**
 加载网页
 */
- (void)loadWebDataSource;

/**
 添加监听js方法代理
 */
- (void)addWKScriptMessageHandlerDelegate;
@end

NS_ASSUME_NONNULL_END
