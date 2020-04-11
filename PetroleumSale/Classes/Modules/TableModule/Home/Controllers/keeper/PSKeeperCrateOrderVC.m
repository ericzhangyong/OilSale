//
//  PSKeeperCrateOrderVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperCrateOrderVC.h"

@interface PSKeeperCrateOrderVC ()


@property (weak, nonatomic) IBOutlet UILabel *label_orderNum;
@property (weak, nonatomic) IBOutlet UILabel *label_varity;
@property (weak, nonatomic) IBOutlet UILabel *label_number;
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
    
    
    [MBProgressHUD toastMessageAtMiddle:@"保存成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
