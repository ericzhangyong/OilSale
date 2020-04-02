//
//  fsLoginViewController.m
//  WaterElephantLiveStreaming
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "RELoginViewController.h"
#import "BaseWeakTimer.h"
#import "IQKeyboardManager.h"
#import "NSString+RECategory.h"
#import "UserInfoProfile.h"
#import "BaseConfigUrl.h"
#import "BaseNavViewController.h"
#import "CYLTabBarController.h"
#import "REAggreementVC.h"
#import "ZJScrollPageView.h"
#import <AuthenticationServices/AuthenticationServices.h>


API_AVAILABLE(ios(13.0))
@interface RELoginViewController ()<UITextFieldDelegate,ASAuthorizationControllerDelegate>
{
    
    NSTimer *_timer;
    NSInteger _verifyCodeCount;
}

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTop_labelTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_labelTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBottom_labelTitle;


//@property (weak, nonatomic) IBOutlet ZJScrollSegmentView *view_segment;
@property (nonatomic,strong) ZJScrollSegmentView *view_segment;

@property (weak, nonatomic) IBOutlet UIButton *btn_forgetSecret;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTop_btnLogin;

//手机号
@property (weak, nonatomic) IBOutlet UIView *view_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete_phoneNub;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_viewPhone;

//绑定手机号时输入密码View
@property (weak, nonatomic) IBOutlet UIView *view_bindingInPutSecret;
@property (weak, nonatomic) IBOutlet UITextField *tf_bindingSecret;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_viewBindingSecret;


//图形验证码
@property (weak, nonatomic) IBOutlet UIView *view_graphVerify;
@property (weak, nonatomic) IBOutlet UITextField *tf_graphVerify;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_graphVerify;


//验证码
@property (weak, nonatomic) IBOutlet UIView *view_verify;
@property (weak, nonatomic) IBOutlet UITextField *tf_verifyCode;
@property (weak, nonatomic) IBOutlet UIButton *btn_getVerifyCode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_viewVerify;


//注册填写密码
@property (weak, nonatomic) IBOutlet UIView *view_secretSet;
@property (weak, nonatomic) IBOutlet UITextField *tf_secretSet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_secretView;

//再次输入密码
@property (weak, nonatomic) IBOutlet UIView *view_resetVerify;
@property (weak, nonatomic) IBOutlet UITextField *tf_resetVerify;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_tfResetVerifyHeight;



//输入view高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_viewInput;

/** 协议 */
@property (weak, nonatomic) IBOutlet UIView *view_notice;
@property (weak, nonatomic) IBOutlet UIButton *btn_isAggree;



@property (nonatomic,strong) RELoginViewModel *loginViewModel;




@end

@implementation RELoginViewController
-(instancetype)initWithLoginType:(RELoginType)loginType{
    
    if (self = [super init]) {
        self.loginViewModel.loginType = loginType;
    }
    return self;
}
-(RELoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [RELoginViewModel new];
    }
    return _loginViewModel;
}

+(void)presentLoginWithLoginType:(RELoginType)loginType{
    
    
    
    RELoginViewController *loginVC = [[RELoginViewController alloc] initWithLoginType:loginType];
    BaseNavViewController *navigationControl = [[BaseNavViewController alloc] initWithRootViewController:loginVC];
//    UIViewController *rootViewController = (UIViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *rootViewController = (UIViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    navigationControl.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootViewController presentViewController:navigationControl animated:YES completion:^{
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setUpViews];
}

-(void)setUpViews{
    //nav
    if (self.loginViewModel.loginType == RELoginTypeSecretCode||self.loginViewModel.loginType == RELoginTypeBinding) {
        self.navigationItem.leftBarButtonItem = [self barButtonWithNormalImage:[UIImage imageNamed:@"hp_icon_back_a"] highlightedImage:[UIImage imageNamed:@"hp_icon_back_a"] target:self selector:@selector(back)];
    }
    if (self.loginViewModel.loginType == RELoginTypeSecretCode || self.loginViewModel.loginType == RELoginTypeLoginSmsCode) {
      self.navigationItem.rightBarButtonItem= [self barButtonWithText:@"注册" textColor:color_lightDart_333333 textFont:[UIFont systemWEPingFangRegularOfSize:16] target:self selector:@selector(btnRegistClick)];
    }
    self.navigationItem.title = self.loginViewModel.fs_getNavTitle;
    
    self.view.backgroundColor = color_lightDart_white_black;
    [self setUpTitle];
    //labelITtle
    self.label_title.text = self.loginViewModel.fs_getThemeTitle;
    self.layoutTop_labelTitle.constant = self.loginViewModel.fs_getLabelTitleTop;
    self.layoutHeight_labelTitle.constant = self.loginViewModel.fs_getLabelTitleHeight;
    self.layoutBottom_labelTitle.constant = self.loginViewModel.fs_getLabelTitleBottom;
    self.layoutHeight_viewInput.constant = self.loginViewModel.fs_getInputViewHeight;
    self.layoutHeight_viewPhone.constant = self.loginViewModel.fs_getViewPhoneHeight;
    self.layoutHeight_viewBindingSecret.constant = self.loginViewModel.fs_getViewBindingSecreteHeight;
    self.layoutHeight_viewVerify.constant = self.loginViewModel.fs_getViewVerifyHeight;
    self.layoutHeight_graphVerify.constant = self.loginViewModel.fs_getViewGraphHeight;
    self.layoutHeight_secretView.constant = self.loginViewModel.fs_getViewSecretSethHeight;
    self.layout_tfResetVerifyHeight.constant = self.loginViewModel.fs_getViewResetSecretSetVeroifyHeight;
    
    self.view_phone.hidden = !self.loginViewModel.fs_getIsShowViewPhone;
    self.view_bindingInPutSecret.hidden = !self.loginViewModel.fs_getIsShowViewBingdingSecret;
    self.view_verify.hidden = !self.loginViewModel.fs_getIsShowViewVerify;
    self.view_graphVerify.hidden = !self.loginViewModel.fs_getIsShowViewGrap;
    self.view_secretSet.hidden = !self.loginViewModel.fs_getIsShowViewSecretSet;
    self.view_resetVerify.hidden = !self.loginViewModel.fs_getIsShowViewResetSecretSetVerify;

    self.tf_phoneNum.delegate = self;
    self.tf_verifyCode.delegate = self;
    self.tf_verifyCode.keyboardType = self.loginViewModel.fs_getVerifyCodeKeyboardType;
    self.tf_verifyCode.secureTextEntry = [self.loginViewModel fs_getVerifyCodeIsSecretModel];
    self.tf_verifyCode.placeholder = self.loginViewModel.fs_getVerifyCodePlaceHolderString;
    //设置默认的手机：忘记密码-设置密码。注册--设置密码
    tf_phoneNumIndex = 0;
    self.tf_phoneNum.text = self.loginViewModel.fs_getDefaultPhoneNum;
    self.tf_phoneNum.placeholder = @"请输入手机号";
    [self textFieldDidChange:self.tf_phoneNum];
    self.tf_secretSet.placeholder = self.loginViewModel.loginType == RELoginTypeResetSecret?@"请输入新密码":@"请输入密码";
    self.tf_resetVerify.placeholder = @"请再次输入密码";
    self.tf_bindingSecret.placeholder= self.loginViewModel.fs_getBindingResetScretPlaceHolderString;
    self.tf_graphVerify.placeholder =  self.loginViewModel.loginType == RELoginTypeRegist?@"请输入邀请码（非必填）":@"请输入新密码";
    
    [self.tf_phoneNum addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf_verifyCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf_graphVerify addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf_secretSet addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf_resetVerify addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf_bindingSecret addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    //btn_login
    [self.btn_login setTitle:self.loginViewModel.fs_getLoginBtnTitle forState:UIControlStateNormal];
    [self.btn_login setTitle:self.loginViewModel.fs_getLoginBtnTitle forState:UIControlStateDisabled];
    self.btn_login.enabled = [self.loginViewModel fs_isLoginBtnCanUseWithPhoneNum:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString VerfifyCode:self.tf_verifyCode.text];
    self.btn_login.alpha = 0.5;
    self.layoutTop_btnLogin.constant = self.loginViewModel.fs_getBtnLoginTop;
    //
    self.btn_getVerifyCode.hidden = !self.loginViewModel.fs_isShowBtnGetVerfifyCode;
    self.btn_forgetSecret.hidden = !self.loginViewModel.fs_isShowBtnForget;
    _verifyCodeCount = 60;
    
   
}

- (UIBarButtonItem *)barButtonWithText:(nullable NSString *)text textColor:(nonnull UIColor *)textColor textFont:(nonnull UIFont *)textFont target:(nullable id)target selector:(nullable SEL)selector {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:target action:selector];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,textColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,textColor, NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    return barButtonItem;
}

-(void)setUpTitle{
    
    if (![self.view_segment isDescendantOfView:self.view]) {
        [self.view addSubview:self.view_segment];
    }
    self.view_segment.hidden = YES;
    self.label_title.hidden = NO;
    if (self.loginViewModel.loginType == RELoginTypeSecretCode || self.loginViewModel.loginType == RELoginTypeLoginSmsCode) {
        self.view_segment.hidden = NO;
        self.label_title.hidden = YES;
    }else{
        self.view_segment.hidden = YES;
        self.label_title.hidden = NO;
    }
}

- (UIBarButtonItem *)barButtonWithNormalImage:(nullable UIImage *)normalImage highlightedImage:(nullable UIImage *)highlightedImage target:(nullable id)target selector:(nullable SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 30, self.navigationController.navigationBar.bounds.size.height);
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}


static NSInteger tf_phoneNumIndex = 0;

#pragma mark- viewDisappear
-(void)sendToNextVCMobile:(NSString *)mobile smsCode:(NSString *)smsCode{
    
    //设置默认的手机：忘记密码-设置密码。注册--设置密码
    self.tf_phoneNum.text = self.loginViewModel.fs_getDefaultPhoneNum;
    [self textFieldDidChange:self.tf_phoneNum];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (_timer!=nil) {
        [self releaseTimer];
    }
    [[IQKeyboardManager sharedManager] resignFirstResponder];
}

#pragma mark- btnClick
-(void)btnRegistClick{
    
    [self pushToViewControllerWithLoginType:RELoginTypeRegist];
}

-(void)back{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}





- (IBAction)actionWechatlogin:(UIControl *)sender {
    
    //微信第三方登录吊起
    [self.loginViewModel sendThirdLoginAtSourcePlatForm:1 atVC:self complete:^(BOOL isFinished) {
        if (isFinished) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
}

- (IBAction)actionDeletePhoneNum:(UIButton *)sender {
    
    self.tf_phoneNum.text = @"";
    [self textFieldDidChange:self.tf_phoneNum];
}

- (IBAction)actionGetVerifyCodel:(UIButton *)sender {
    
    
    WEAK_SELF;
    sender.userInteractionEnabled = NO;
    [self.loginViewModel re_requestGetVerifyCodeWithMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString complete:^(BOOL isFinished, id  _Nonnull data) {
        if (isFinished) {
//            [MBProgressHUD toastMessageAddedTo:nil message:@"验证码发送成功"];
            //获取验证码 接口
            [weakSelf startGetVerifyCodeTimer];
        }else{
            sender.userInteractionEnabled = YES;
        }
        
    }];
}

- (IBAction)actionForgetSecret:(UIButton *)sender {
    //忘记密码
    [self pushToViewControllerWithLoginType:RELoginTypeSecretForgetGetVerify];
}

- (IBAction)actionLogin:(UIButton *)sender {
    
    if (_timer) {
        [self releaseTimer];
    }
    if (self.loginViewModel.fs_getIsShowViewPhone) {
        NSString *phoneum = [self.tf_phoneNum.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        phoneum  = [phoneum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (![self.loginViewModel fs_isLoginBtnCanUseWithPhoneNum:phoneum VerfifyCode:phoneum]) {
            [MBProgressHUD toastMessageAtMiddle:@"手机账号不合法"];
            return;
        }
    }
    WEAK_SELF;
    if (self.loginViewModel.loginType == RELoginTypeSecretCode){
        //登录到主页
        [self.loginViewModel fs_requestLoginWithMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString password:self.tf_verifyCode.text.getNoWhiteLineAndSpaceString smsCode:@"" loginType:1 complete:^(BOOL isFinished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isFinished) {
                    [MBProgressHUD toastMessageAddedTo:weakSelf.view message:@"登录成功"];
                    //                [[NSNotificationCenter defaultCenter] postNotificationName:fsUserLoginSuccessKey object:nil];
                    //返回进457585入页
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }
            });
        }];
    }else if (self.loginViewModel.loginType == RELoginTypeLoginSmsCode){
        
        [self.loginViewModel fs_requestLoginWithMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString password:@"" smsCode:self.tf_verifyCode.text.getNoWhiteLineAndSpaceString loginType:2 complete:^(BOOL isFinished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isFinished) {
                    [MBProgressHUD toastMessageAddedTo:weakSelf.view message:@"登录成功"];
                    //                [[NSNotificationCenter defaultCenter] postNotificationName:fsUserLoginSuccessKey object:nil];
                    //返回进457585入页
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }
            });
        }];
    }else if (self.loginViewModel.loginType == RELoginTypeSecretForgetGetVerify ){
        //忘记密码---获取验证码
        WEAK_SELF;
        [self.loginViewModel fs_requestForgetSecrettWithMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString newPwd:self.tf_secretSet.text.getNoWhiteLineAndSpaceString smsCode:self.tf_verifyCode.text.getNoWhiteLineAndSpaceString complete:^(BOOL isFinished) {
            if (isFinished) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else if (self.loginViewModel.loginType == RELoginTypeSecretForgetSetNew ){
        //忘记密码---输入新密码
//        if (self.tf_resetVerify.text != self.tf_secretSet.text && self.loginViewModel.loginType == RELoginTypeResetSecret) {
//            [MBProgressHUD toastMessageAtMiddle:@"两次输入密码不同！"];
//            return;
//        }
//        [self.loginViewModel fs_requestForgetSecrettWithMobile:self.loginViewModel.mobile newPwd:self.tf_secretSet.text.getNoWhiteLineAndSpaceString smsCode:self.loginViewModel.smsCode imgCode:self.loginViewModel.imgCode complete:^(BOOL isFinished) {
//            if (isFinished) {
//                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//            }
//        }];
    }
    else if (self.loginViewModel.loginType == RELoginTypeResetSecret){
        //修改密码
        if (self.tf_resetVerify.text != self.tf_secretSet.text && self.loginViewModel.loginType == RELoginTypeResetSecret) {
            [MBProgressHUD toastMessageAtMiddle:@"两次输入密码不同！"];
            return;
        }
        [self.loginViewModel fs_requestResetSecretWithMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString originPassword:self.tf_bindingSecret.text.getNoWhiteLineAndSpaceString newPassword:self.tf_secretSet.text.getNoWhiteLineAndSpaceString complete:^(BOOL isFinished) {
            if (isFinished) {
                [MBProgressHUD toastMessageAtMiddle:@"密码修改成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }else if (self.loginViewModel.loginType == RELoginTypeRegist){
        //注册
        if (![self.tf_secretSet.text.getNoWhiteLineAndSpaceString isEqualToString:self.tf_resetVerify.text.getNoWhiteLineAndSpaceString]) {
            [MBProgressHUD toastMessageAtMiddle:@"两次输入密码不同，请重新输入密码！"];
            return;
        }
        //13244554477
        
        [self.loginViewModel fs_requestRegistSmsCodeWithMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString smsCode:self.tf_verifyCode.text.getNoWhiteLineAndSpaceString password:self.tf_secretSet.text invite_code:self.tf_graphVerify.text.getNoWhiteLineAndSpaceString realName:self.tf_bindingSecret.text.getNoWhiteLineAndSpaceString complete:^(BOOL isFinished) {
            if (isFinished) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }else if (self.loginViewModel.loginType == RELoginTypeBinding){
        //绑定
        if (![self.tf_secretSet.text.getNoWhiteLineAndSpaceString isEqualToString:self.tf_resetVerify.text.getNoWhiteLineAndSpaceString]) {
            [MBProgressHUD toastMessageAtMiddle:@"两次输入密码不同，请重新输入密码！"];
            return;
        }
        [self.loginViewModel fs_requestBingPhoneWithMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString smsCode:self.tf_verifyCode.text.getNoWhiteLineAndSpaceString password:self.tf_bindingSecret.text.getNoWhiteLineAndSpaceString imageCode:self.tf_graphVerify.text.getNoWhiteLineAndSpaceString complete:^(BOOL isFinished) {
            if (isFinished) {
                [MBProgressHUD toastMessageAtMiddle:@"绑定成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}


- (IBAction)actionSecretLogin:(id)sender {
    
    [self pushToViewControllerWithLoginType:RELoginTypeSecretCode];
}

- (IBAction)actionGoWEAgreement:(UIButton *)sender {
    
    REAggreementVC *agreementVC  = [REAggreementVC new];
    agreementVC.webUrl = @"http://sandbox.sxfq.com/huolika/#/registmanage2";
    [self.navigationController  pushViewController:agreementVC animated:YES];
}
- (IBAction)actionBtnAggree:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    [self textFieldDidChange:self.tf_phoneNum];
}

-(void)pushToViewControllerWithLoginType:(RELoginType)loginType{
    RELoginViewController *registVC = [[RELoginViewController alloc] initWithLoginType:loginType];
    
    if (self.loginViewModel.loginType == RELoginTypeSecretForgetGetVerify) {
        //用于传值
//        [registVC sendToNextVCMobile:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString smsCode:self.tf_verifyCode.text];
        registVC.loginViewModel.mobile = self.tf_phoneNum.text.getNoWhiteLineAndSpaceString;
        registVC.loginViewModel.smsCode = self.tf_verifyCode.text.getNoWhiteLineAndSpaceString;
        registVC.loginViewModel.imgCode = self.tf_graphVerify.text.getNoWhiteLineAndSpaceString;
    }
    [self.navigationController pushViewController:registVC animated:YES];
}


#pragma mark- textFieldDelegate
-(void)textFieldDidChange:(UITextField *)textField{
    
    
    if (textField == self.tf_phoneNum) {
        NSString *pureNumbers = [[textField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789 "] invertedSet]] componentsJoinedByString:@""];
        if (pureNumbers.length>13) {
            pureNumbers = [pureNumbers substringToIndex:13];
        }
        textField.text = pureNumbers;
        //删除
        if (textField.text.length!=0) {
            self.btn_delete_phoneNub.hidden  = NO;
        }else{
            self.btn_delete_phoneNub.hidden  = YES;
        }
        //
        if (textField.text.length > tf_phoneNumIndex) {

            if (textField.text.length>=4) {
                if (![[textField.text substringWithRange:NSMakeRange(3, 1)]isEqualToString:@" "]) {
                    NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                    [str insertString:@" " atIndex:3];
                    textField.text = str;
                }
            }
            if (textField.text.length>=9) {
                if (![[textField.text substringWithRange:NSMakeRange(8, 1)]isEqualToString:@" "]) {
                    NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                    [str insertString:@" " atIndex:8];
                    textField.text = str;
                }
            }
            
        }else if (textField.text.length < tf_phoneNumIndex){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
        }
        tf_phoneNumIndex = textField.text.length;
        
    }
    
    //校验是否可以登录
    BOOL isCanUser  = YES;
    if (self.loginViewModel.fs_getIsShowViewPhone && [BaseVerifyUtils isNullOrSpaceStr:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString]) {
        isCanUser = NO;
    }
    else if (self.loginViewModel.fs_getIsShowViewVerify && [BaseVerifyUtils isNullOrSpaceStr:self.tf_verifyCode.text.getNoWhiteLineAndSpaceString]) {
        isCanUser = NO;
    }
    else if (self.loginViewModel.fs_getIsShowViewSecretSet && [BaseVerifyUtils isNullOrSpaceStr:self.tf_secretSet.text.getNoWhiteLineAndSpaceString]) {
        isCanUser = NO;
    }
    else if (self.loginViewModel.fs_getIsShowViewResetSecretSetVerify && [BaseVerifyUtils isNullOrSpaceStr:self.tf_resetVerify.text.getNoWhiteLineAndSpaceString]) {
        isCanUser = NO;
    }
    self.btn_login.enabled = isCanUser;
    self.btn_login.alpha = isCanUser?1:0.5;
}




-(void)startGetVerifyCodeTimer{
    
    [self checkGetVerifyBtnSelected:YES];
    _timer = [BaseWeakTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshVerifyCodeTimer) userInfo:nil repeats:YES];
}

- (void)refreshVerifyCodeTimer {
    
    NSString *btnTitle = [NSString stringWithFormat:@"(%@s)重新获取",@(_verifyCodeCount).stringValue];
    [self.btn_getVerifyCode setTitle:btnTitle forState:UIControlStateNormal];
    _verifyCodeCount--;
    if (_verifyCodeCount == 0) {
        [self releaseTimer];
    }
}

-(void)releaseTimer{

    [self checkGetVerifyBtnSelected:NO];
    _verifyCodeCount = 60;
    [_timer invalidate];
    _timer = nil;
}

-(void)checkGetVerifyBtnSelected:(BOOL)isSelected{
    if (isSelected) {
        self.btn_getVerifyCode.userInteractionEnabled = NO;
        [self.btn_getVerifyCode setTitle:@"(60s)重新获取" forState:UIControlStateNormal];
        [self.btn_getVerifyCode setTitleColor:color_4084FF forState:UIControlStateNormal];
    }else{
        self.btn_getVerifyCode.userInteractionEnabled = YES;
        [self.btn_getVerifyCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.btn_getVerifyCode setTitleColor:color_FE7E10 forState:UIControlStateNormal];
    }
}

#pragma mark- lazy

-(ZJScrollSegmentView *)view_segment{
    
    if (!_view_segment) {
        WEAK_SELF;
        ZJSegmentStyle *style = [ZJSegmentStyle new];
        style.scaleTitle = YES;
        style.showLine = NO;
        style.titleMargin = 30;
        style.scrollLineWidth = 20;
        style.adjustCoverOrLineWidth = NO;
        style.autoAdjustTitlesWidth = NO;
        style.scrollLineColor  = color_FB9510;
        style.selectedTitleColor = color_lightDart_333333;
        style.titleFont = [UIFont systemWEPingFangBoldFontOfSize:18];
        style.normalTitleColor = color_666666;
        _view_segment  = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(30,30, kScreenWidth-30*2, 38) segmentStyle:style delegate:nil titles:@[@"密码登录",@"验证码登录"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            if (index == 0) {
                weakSelf.loginViewModel.loginType = RELoginTypeSecretCode;
            }else{
                weakSelf.loginViewModel.loginType = RELoginTypeLoginSmsCode;
            }
            [weakSelf setUpViews];
        }];
    }
    return _view_segment;
}
@end
