//
//  WEBaseWebViewController.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/5.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseWebViewController.h"
//#import "FFLoadView.h"
#import "AFNetworkReachabilityManager.h"


@interface BaseWebViewController ()
@property (nonatomic, strong) UIBarButtonItem *backBarItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarItem;
@property (nonatomic, strong) UIProgressView *progressView;
//@property (nonatomic, strong) FFLoadView *loadStatusView;

@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation BaseWebViewController


#pragma mark - Get
- (WKWebView *)wkwebView {
    if (!_wkwebView) {
        _wkwebView = [self setupContentWebView];
    }
    return _wkwebView;
}

- (UIBarButtonItem *)backBarItem {
    if (!_backBarItem) {
        _backBarItem = [self setUpBackBarItem];
    }
    return _backBarItem;
}

- (UIBarButtonItem *)closeBarItem {
    if (!_closeBarItem) {
        _closeBarItem = [self setUpCloseBarItem];
    }
    return _closeBarItem;
}


- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [self setupProgressView];
    }
    return _progressView;
}
-(UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(44);
            make.top.offset(20 + 2);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [_backBtn addTarget:self action:@selector(clickBackBar:) forControlEvents:UIControlEventTouchUpInside];
        if ([AFNetworkReachabilityManager sharedManager].isReachable) {
            _backBtn.hidden = YES;
        }else{
            _backBtn.hidden = NO;
        }
    }
    return _backBtn;
}

#pragma mark - Configuration
- (WKWebViewConfiguration *)setUpWebViewConfiguration {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    
    WKPreferences *perferences = [[WKPreferences alloc] init];
    perferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    perferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = perferences;
    
    self.configuration = config;
    self.userContentController = [[WKUserContentController alloc] init];
    self.configuration.userContentController = self.userContentController;
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    if (@available(iOS 10.0, *)) {
        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    } else if (IOS_VERSION_9_OR_LATER) {
            config.requiresUserActionForMediaPlayback = NO;
    }else {
        config.allowsAirPlayForMediaPlayback = NO;
    }
    return config;
}

- (WKWebView *)setupContentWebView {
    WKWebViewConfiguration *config = [self setUpWebViewConfiguration];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    webView.translatesAutoresizingMaskIntoConstraints = YES;
    webView.backgroundColor = [UIColor clearColor];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    if (@available(iOS 11.0, *)){
        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [webView addObserver:self
              forKeyPath:NSStringFromSelector(@selector(loading))
                 options:NSKeyValueObservingOptionNew
                 context:nil];
#pragma clang diagnostic pop
    [webView addObserver:self
              forKeyPath:@"estimatedProgress"
                 options:NSKeyValueObservingOptionNew
                 context:nil];
    
    [webView addObserver:self
              forKeyPath:@"title"
                 options:NSKeyValueObservingOptionNew
                 context:nil];
    return webView;
}

- (UIBarButtonItem *)setUpBackBarItem {
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithImage:[[[UIImage imageNamed:@"hp_icon_back_a"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, -10, 0, 0)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBar:)];
    return backBarItem;
}

- (UIBarButtonItem *)setUpCloseBarItem {
    UIBarButtonItem *closeBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_close_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickPopBar:)];
    return closeBarItem;
}

- (UIProgressView *)setupProgressView {
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    progressView.progressTintColor = [UIColor colorWithRed:63/255.0 green:182/255.0 blue:215/255.0 alpha:1.0f];
    return progressView;
}


#pragma mark - ViewController Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addContentView];
    
    [self loadWebDataSource];
    [self addWKScriptMessageHandlerDelegate];
}

- (void)addContentView {
    [self.view addSubview:self.wkwebView];
    [self.view addSubview:self.progressView];
    [self.view insertSubview:self.wkwebView belowSubview:self.progressView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        //        make.top.equalTo(self.view.mas_top);
        make.top.left.right.bottom.insets(UIEdgeInsetsZero);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@(2));
    }];
//    self.loadStatusView = [FFLoadView ff_loadStatusView:FFLoadIsLoaing];
//    self.loadStatusView.reloadDelegate = self;
//    [self.view addSubview:self.loadStatusView];
//    [self.loadStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(320);
//        make.height.mas_equalTo(170);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.centerY.equalTo(self.view.mas_centerY);
//    }];
//    [self.loadStatusView ff_reloadData];
//    [self.view insertSubview:self.wkwebView belowSubview:self.loadStatusView];
    [self.navigationItem setLeftBarButtonItems:@[self.backBarItem]];
    [self.view bringSubviewToFront:self.progressView];
    
}
-(void)addWKScriptMessageHandlerDelegate {
    
    //js调用oc
//    WEWeakScriptDelegate *delegte =[[WEWeakScriptDelegate alloc] initWithDelegate:self];
//    [self.userContentController  addScriptMessageHandler:delegte name:@"userInfo"];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.wkwebView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.navigationController.navigationBar.hidden == YES) {
            make.top.equalTo(self.view.mas_top).offset(SafeTop);
        }else{
            make.top.equalTo(self.view.mas_top);
        }
    }];
}

#pragma mark - ProgressView
- (void)showProgressBar {
    //    if (self.progressView.alpha == 0.0) {
    //        self.progressView.alpha = 1.0;
    //    }
    //    if (self.progressView.hidden == YES) {
    self.progressView.hidden = NO;
    //    }
}

- (void)hideProgressbar {
    //    [UIView animateWithDuration:0.3
    //                     animations:^{
    //                         self.progressView.alpha = 0.0f;
    //                     }];
    self.progressView.hidden = YES;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if (![object isKindOfClass:[WKWebView class]]) {
        return;
    }
    WKWebView *webView = (WKWebView *)object;
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        self.progressView.progress = webView.estimatedProgress;
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]) {
        if (!self.navigationItem.title) {
            self.navigationItem.title = webView.title;
        }
        self.navigationItem.title = webView.title;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(loading))]) {
#pragma clang diagnostic pop
    }
    
    if (!webView.isLoading) {
        [self hideProgressbar];
        self.wkwebView.hidden = NO;
        [self updateCloseButton];
//        if (self.loadStatusView.loadType != FFLoadShouldHide) {
//            self.loadStatusView.loadType = FFLoadShouldHide;
//            [self.loadStatusView ff_reloadData];
//        }
//        WKBackForwardList *list = self.wkwebView.backForwardList;
//        if (!list.currentItem) {
//            if (![AFNetworkReachabilityManager sharedManager].isReachable) {
//                self.loadStatusView.loadType = FFLoadNetWorkError;
//                [self.loadStatusView ff_reloadData];
//                self.wkwebView.hidden = YES;
//                NSLog(@"有网了。。。");
//            }
//        }
        
    }
    else {
        [self showProgressBar];
//        if (self.loadStatusView.loadType != FFLoadIsLoaing) {
//            self.loadStatusView.loadType = FFLoadIsLoaing;
//            [self.loadStatusView ff_reloadData];
//        }
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (error) {
       
        if (error.code == NSURLErrorCancelled) {
            //取消不用管
        }else{
            NSString *errMsg = [NSString stringWithFormat:@"%@-%@",[[error userInfo] objectForKey:NSLocalizedFailureReasonErrorKey],@(error.code)];
            [MBProgressHUD toastMessageAtMiddle:errMsg];
        }
    }
}

- (void)updateCloseButton {
    if ([self.wkwebView canGoBack]) {
        [self.navigationItem setLeftBarButtonItems:@[self.backBarItem, self.closeBarItem]];
    }
    else {
        [self.navigationItem setLeftBarButtonItems:@[self.backBarItem]];
    }
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    
    
}

#pragma marl - Button Action
- (void)clickBackBar:(id)sender {
    [self returnBtnDidselected];
    if ([self.wkwebView canGoBack]) {
        [self.wkwebView goBack];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickPopBar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnBtnDidselected{
    
}

- (void)removeContentView {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [_wkwebView removeObserver:self
                    forKeyPath:NSStringFromSelector(@selector(loading))
                       context:nil];
#pragma clang diagnostic pop
    [_wkwebView removeObserver:self
                    forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                       context:nil];
    [_wkwebView removeObserver:self
                    forKeyPath:NSStringFromSelector(@selector(title))
                       context:nil];
    _wkwebView.UIDelegate = nil;
    _wkwebView.navigationDelegate = nil;
    [_wkwebView removeFromSuperview];
    [_progressView removeFromSuperview];
//    [_loadStatusView removeFromSuperview];
    _wkwebView = nil;
    
}

#pragma mark- 重新加载按钮响应
-(void)reloadWebViewAction {
    //移除view 添加view 添加监听js代理
    [self removeContentView];
    [self addContentView];
    [self addWKScriptMessageHandlerDelegate];
    [self loadWebDataSource];
}

-(void)loadWebDataSource {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]];
    [self.wkwebView loadRequest:request];
}


- (void)dealloc {
    
    [self removeContentView];
}

@end
