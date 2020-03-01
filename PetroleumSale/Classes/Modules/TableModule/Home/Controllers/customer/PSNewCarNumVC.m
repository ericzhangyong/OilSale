//
//  PSNewCarNumVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/13.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSNewCarNumVC.h"
#import "PSNewStationCarNumRequest.h"

@interface PSNewCarNumVC ()


@property (nonatomic,strong) UIView *view_carNum;
@property (nonatomic,strong) UITextField *tf_inputCarNum;
@property (nonatomic,strong) UILabel *label_carNum;
@property (nonatomic,strong) UIButton *btn_save;
@end

@implementation PSNewCarNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


-(void)initNavView{
    
    self.navigationItem.title = @"新增车牌号";
    
}

-(void)initBaseViews{
    
    self.view.backgroundColor= color_F3F3F3;
    [self.view addSubview:self.view_carNum];
    [self.view_carNum addSubview:self.label_carNum];
    [self.view_carNum addSubview:self.tf_inputCarNum];
    [self.view addSubview:self.btn_save];
    
    [self.view_carNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    
    [self.label_carNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_carNum).offset(15);
        make.centerY.equalTo(self.view_carNum);
        make.width.mas_equalTo(45);
    }];
    [self.tf_inputCarNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_carNum.mas_right).offset(15);
        make.centerY.equalTo(self.view_carNum);
        make.right.equalTo(self.view_carNum).offset(-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.btn_save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_carNum.mas_bottom).offset(50);
        make.left.equalTo(self.view_carNum).offset(30);
        make.right.equalTo(self.view_carNum).offset(-20);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark- click
-(void)saveBtnClick{
    
    
    PSNewStationCarNumRequest *newCar = [PSNewStationCarNumRequest new];
    newCar.car_num = @[self.tf_inputCarNum.text];
    newCar.operate_type = @"add";
    [newCar postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {

            
            self.createCarNumComplete(self.tf_inputCarNum.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark- lazy

-(UIView *)view_carNum{
    if (!_view_carNum) {
        _view_carNum = [UIView new];
        _view_carNum.backgroundColor = [UIColor whiteColor];
    }
    return _view_carNum;
}

-(UILabel *)label_carNum{
    if (!_label_carNum) {
        _label_carNum = [UILabel new];
        _label_carNum.text = @"车牌号";
        _label_carNum.textColor = color_333333;
        _label_carNum.font = [UIFont systemWEPingFangRegularOfSize:14];
        
    }
    return _label_carNum;
}

-(UITextField *)tf_inputCarNum{
    if (!_tf_inputCarNum) {
        _tf_inputCarNum = [[UITextField alloc] initWithFrame:CGRectMake(0, 18, kScreenWidth-100, 30)];
        _tf_inputCarNum.font = [UIFont systemWEPingFangRegularOfSize:14];
        _tf_inputCarNum.textColor = color_333333;
        _tf_inputCarNum.placeholder = @"请输入车牌号";
    }
    return _tf_inputCarNum;
}

-(UIButton *)btn_save{
    if (!_btn_save) {
        _btn_save= [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_save setTitle:@"保存" forState:UIControlStateNormal];
        self.btn_save.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:16];
        [_btn_save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_save.backgroundColor = color_4084FF;
        _btn_save.layer.masksToBounds = YES;
        _btn_save.layer.cornerRadius = 22.5;
        [_btn_save addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_save;
}

@end
