//
//  YHAddShopCartView.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/2/26.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "PSAddShopCartView.h"
#import "UIView+BaseCategory.h"
#import "UIButton+EnlargeArea.h"

@interface PSAddShopCartView ()<UITextFieldDelegate>

@property (nonatomic,assign) BOOL isEndEditing;

@property (nonatomic,strong) UILabel *label_dunType;

@end
@implementation PSAddShopCartView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpViews];
        [self setBtnAction];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUpViews];
    [self setBtnAction];
}

-(void)setUpViews{
    
    //创建通知中心监听键盘的frame
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.addCartStyle = AddShopCartStyleProdcutDetailModel;
    //frame 90
    
    UIView *folderView = [UIView new];
    folderView.backgroundColor = [UIColor clearColor];
    [self addSubview:folderView];
//    [folderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsZero);
//    }];
    self.view_folder = folderView;
    
    UIButton *foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [foldBtn setImage:[UIImage imageNamed:@"add_white"] forState:UIControlStateNormal];
    [foldBtn setBackgroundColor:color_47B34E];
    [folderView addSubview:foldBtn];
//    [foldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(folderView.mas_right);
//        make.centerY.equalTo(folderView.mas_centerY);
//        make.height.width.mas_equalTo(26);
//    }];
    foldBtn.tag = 100;
    self.btn_folder = foldBtn;
    
    UIView *addView = [UIView new];
    addView.backgroundColor = color_lightDart_white;
//    addView.layer.cornerRadius = 15;
    [self addSubview:addView];

    self.view_add = addView;
    //minuBtn
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [minusBtn setImage:[UIImage imageNamed:@"hp_icon_jian"] forState:UIControlStateNormal];
    minusBtn.backgroundColor = fsColor_F4F4F4;
    minusBtn.tag = 101;
    [addView addSubview:minusBtn];
    self.btn_minus = minusBtn;
    [self.btn_minus setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn setImage:[UIImage imageNamed:@"hp_icon_add"] forState:UIControlStateNormal];
    plusBtn.backgroundColor = fsColor_F4F4F4;
    plusBtn.tag = 102;
    [addView addSubview:plusBtn];
    self.btn_plus = plusBtn;
    [self.btn_plus setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];

    
    UITextField *tf_input = [[UITextField alloc] init];
    tf_input.textColor = color_lightDart_333333;
    tf_input.textAlignment = NSTextAlignmentCenter;
    tf_input.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    tf_input.returnKeyType = UIReturnKeyDone;
    tf_input.keyboardType = UIKeyboardTypeDecimalPad;
    [addView addSubview:tf_input];
    self.tf_input = tf_input;

    [self.view_add addSubview:self.label_dunType];
    
    self.view_add.hidden = YES;
    self.view_folder.hidden= NO;
    
    self.btn_folder.layer.masksToBounds = YES;
    self.btn_folder.layer.cornerRadius = 5;
}

-(void)setBtnAction{
    
    [self.btn_plus addTarget:self action:@selector(btnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_minus addTarget:self action:@selector(btnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_folder addTarget:self action:@selector(btnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    self.tf_input.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:) name:UIKeyboardDidHideNotification object:nil];
    [self textFiledDidChange];
    self.tf_input.text = @"0";
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.btn_folder zy_setShadowColor:color_4084FF shadowOffset:CGSizeMake(0, 2) shadowRadius:2 shadowOpacity:0.4];
    
    [self.view_folder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    [self.btn_folder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view_folder.mas_right).offset(-10);
        make.centerY.equalTo(self.view_folder.mas_centerY);
        make.height.width.mas_equalTo(20);
        
    }];
    
    [self.view_add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [self.btn_minus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_add.mas_left).offset(10);
        make.centerY.equalTo(self.view_add.mas_centerY);
        make.height.width.mas_equalTo(24);
    }];
    
    [self.btn_plus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view_add.mas_right).offset(-10);
        make.centerY.equalTo(self.view_add.mas_centerY);
        make.height.width.mas_equalTo(24);
    }];
    [self.label_dunType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn_plus.mas_left).offset(2);
        make.width.mas_equalTo(20);
        make.centerY.equalTo(self.view_add.mas_centerY);
    }];
    [self.tf_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn_minus.mas_right);
        make.right.equalTo(self.label_dunType.mas_left);
        make.centerY.equalTo(self.view_add.mas_centerY);
        make.height.mas_equalTo(21);
    }];
    
    if (self.btn_folder.hidden == NO) {
        [self.btn_folder zy_setShadowColor:color_47B34E shadowOffset:CGSizeMake(0, 2) shadowRadius:2 shadowOpacity:0.4];
    }
}
-(void)setIsShowView_add:(BOOL)isShowView_add{
    self.view_add.hidden = !isShowView_add;
    self.view_folder.hidden = isShowView_add;
    if (isShowView_add) {
        self.tf_input.text = @"";
    }
}

- (void)setShowDunOrTongType:(NSString *)showDunOrTongType{
//    self.label_dunType.hidden = !isShowDunType;
    _showDunOrTongType = showDunOrTongType;
    self.label_dunType.text = showDunOrTongType;
    CGFloat width = 20 ;
    [self.label_dunType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
}




#pragma mark- click
-(void)btnClick:(UIButton *)button event:(UIEvent *)event{
    
    
    [self textFiledDidChange];
    
    if (button == self.btn_folder) {
        
        if (self.isShowView_add) {
            self.isShowView_add = NO;
            self.tf_input.text = @"0";
        }else{
            self.isShowView_add = YES;
            self.tf_input.text = @"1";
        }
        
    }else if (button  == self.btn_plus){
        NSString *oldText = self.tf_input.text;
        self.tf_input.text = [NSString stringWithFormat:@"%zd",oldText.integerValue+1];
    }else if (button == self.btn_minus){
        NSString *oldText = self.tf_input.text;
        if (oldText.integerValue<=1) {
            self.tf_input.text = @"0";
            self.isShowView_add = NO;
        }else{
            self.tf_input.text = [NSString stringWithFormat:@"%zd",oldText.integerValue-1];
        }
    }
}

-(void)smallBbtnClick:(UIButton *)button{
    BOOL isAdd;
    if (button == self.btn_minus){
        isAdd = NO;
    }else{
        isAdd = YES;
    }
    if (self.addCartStyle == AddShopCartStyleProdcutDetailModel) {
        
       
    }else{
        if ([self.delegate respondsToSelector:@selector(btnClickIsAdd:complete:)]) {
            [self.delegate btnClickIsAdd:isAdd complete:^(BOOL isFinish,id data) {
                if (isFinish) {
                    //刷新UI
                    [self refreshDataWithData:data];
                }
            }];
        }
    }
}

#pragma mark- UITextFiled
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([string isEqualToString:@"\n"]){
//
//        [textField endEditing:YES];
//        return NO;
//    }
//    return YES;
//}
-(void)textFiledDidChange{

//    if (self.tf_input.text.doubleValue<=1) {
//        self.btn_minus.enabled = NO;
//    }else{
//        self.btn_minus.enabled = YES;
//    }
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    self.confirmView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
//    [self.ff_navViewController.view addSubview:_confirmView];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.doubleValue>10000) {
        [MBProgressHUD toastMessageAtMiddle:@"购买数量过多"];
        return;
    }
//    NSNumber *qty = @(self.tf_input.text.doubleValue);
    if (!self.isEndEditing) {
        self.isEndEditing = YES;
        if (self.addCartStyle == AddShopCartStyleProdcutDetailModel) {
            
        }else{
            if ([self.delegate respondsToSelector:@selector(tf_inputDidEndEditing:complete:)]) {
                [self.delegate tf_inputDidEndEditing:self.tf_input complete:^(BOOL isFinish,id data) {
                    self.isEndEditing = NO;
                    if (isFinish) {
                        //刷新UI
                        [self refreshDataWithData:data];
                    }
                }];
            }
        }
    }
}

-(void)keyboardDidHidden:(NSNotification *)noti{
    self.isEndEditing = NO;
//    [self.confirmView hiddenCartView];
}



-(void)refreshDataWithData:(id)data{
    //刷新当前数据
    NSNumber *dataNumber = data;
    self.tf_input.text = [NSString stringWithFormat:@"%@",dataNumber];
    if (dataNumber.doubleValue == 0) {
        self.view_folder.hidden = NO;
        self.view_add.hidden = YES;
    }else{
        self.view_add.hidden = NO;
        self.view_folder.hidden = YES;
    }
    [self textFiledDidChange];
//    [[NSNotificationCenter defaultCenter] postNotificationName:YHShopCartReloadNoRequestKey object:nil];
}
#pragma mark-监听方法
-(void)keyboardWillChange:(NSNotification *)notification
{
    //    ZHLog(@"notification=%@",notification);
    //这是通知传来的信息
    /**
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 568}, {320, 253}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 441.5},
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {320, 253}},
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 315}, {320, 253}},
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {160, 694.5},
     UIKeyboardAnimationCurveUserInfoKey = 7
     */
    
//    NSDictionary *userInfo=notification.userInfo;
//    //取出键盘字典中的frame
//    CGRect keyboardFrame=[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    //取出键盘弹出或者返回的动画时间 让自定义键盘和它同步
//    double duration=[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    YHLog(@"keyboardFrame = %@ frame = %@",NSStringFromCGRect(keyboardFrame),NSStringFromCGRect(self.confirmView.frame));
//    [UIView animateWithDuration:duration animations:^{
//
//        self.confirmView.ff_y=keyboardFrame.origin.y-self.confirmView.ff_height;
//    }];
    
}


#pragma mark- lazy
-(UILabel *)label_dunType{
    if (!_label_dunType) {
        _label_dunType = [UILabel new];
//        _label_dunType.text = @"吨";
        _label_dunType.font = [UIFont systemWEPingFangRegularOfSize:14];
        _label_dunType.textColor = color_lightDart_333333;
    }
    return _label_dunType;
}


@end
