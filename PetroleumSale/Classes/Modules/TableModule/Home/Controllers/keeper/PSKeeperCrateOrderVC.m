//
//  PSKeeperCrateOrderVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperCrateOrderVC.h"
#import "PSKeeperCreateOrderRequest.h"

@interface PSKeeperCrateOrderVC ()


@property (weak, nonatomic) IBOutlet UITextField *tf_num;
@property (weak, nonatomic) IBOutlet UITextField *tf_verity;
@property (weak, nonatomic) IBOutlet UITextField *tf_bianhao;

@property (weak, nonatomic) IBOutlet UITextField *tf_density;
@property (weak, nonatomic) IBOutlet UITextField *tf_weight;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;

@end

@implementation PSKeeperCrateOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"创建进货单";
    self.view.backgroundColor = color_lightDart_f3f3f3;
}

- (IBAction)actionSave:(UIButton *)sender {
    
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_num.text]) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入进货单号"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_num.text]) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入种类"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_num.text]) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入编号"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_num.text]) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入密度"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_num.text]) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入重量"];
        return;
    }
    
    PSKeeperCreateOrderRequest *create = [PSKeeperCreateOrderRequest new];
    [create postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            [MBProgressHUD toastMessageAtMiddle:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];

}

@end
