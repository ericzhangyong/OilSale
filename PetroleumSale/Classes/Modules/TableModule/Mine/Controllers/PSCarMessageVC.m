//
//  PSCarMessageVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/14.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSCarMessageVC.h"
#import "UserInfoProfile.h"
#import "PSSaveCartMessageRequest.h"

@interface PSCarMessageVC ()


@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_carNumber;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;


@property (weak, nonatomic) IBOutlet UIView *view_input;

@end

@implementation PSCarMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"车辆信息";
    self.view_input.backgroundColor = color_lightDart_white;
    self.view.backgroundColor = color_lightDart_white_black;
    
    
    
    self.tf_name.text = UserInfoProfile.shareUserInfo.userInfo.car_info.driver_name;
    self.tf_carNumber.text = UserInfoProfile.shareUserInfo.userInfo.car_info.car_number;
    
}


#pragma mark- click

- (IBAction)actionSave:(UIButton *)sender {
    
    NSString *carInfoId = UserInfoProfile.shareUserInfo.userInfo.car_info.car_info_id;
    PSSaveCartMessageRequest *saveCarMessage = [PSSaveCartMessageRequest new];
    saveCarMessage.car_number = self.tf_carNumber.text;
    saveCarMessage.driver_name = self.tf_name.text;
//    saveCarMessage.car_info_id = self.
    if (![BaseVerifyUtils isNullOrSpaceStr:carInfoId] && carInfoId.integerValue != 0) {
        saveCarMessage.car_info_id = carInfoId.integerValue;
    }
    [saveCarMessage postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            [MBProgressHUD toastMessageAtMiddle:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

@end
