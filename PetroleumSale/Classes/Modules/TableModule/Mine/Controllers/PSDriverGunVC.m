//
//  PSDriverGunVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/7/12.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSDriverGunVC.h"
#import "NSString+RECategory.h"
#import "PSGetCanRequest.h"

@interface PSDriverGunVC ()

@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_gunCount;

@end

@implementation PSDriverGunVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initNavView{
    
    self.navigationItem.title = @"借加油枪";
}

- (IBAction)actionConfirm:(UIButton *)sender {
    
        
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_phone.text.getNoWhiteLineAndSpaceString] ) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入联系方式"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_gunCount.text.getNoWhiteLineAndSpaceString] ) {
        
        [MBProgressHUD toastMessageAtMiddle:@"请输入借加油枪数量"];
        return;
    }
    PSGetCanRequest *canRequest = [PSGetCanRequest new];
    canRequest.phone_num= self.tf_phone.text.getNoWhiteLineAndSpaceString;
    canRequest.nozzle_num = -self.tf_gunCount.text.getNoWhiteLineAndSpaceString.integerValue;
    [canRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            [MBProgressHUD toastMessageAtMiddle:@"发送成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


@end
