//
//  PSWarehourseEditVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/25.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSWarehourseEditVC.h"
#import "PlaceHolderTextView.h"
#import "PSWareHourseEditReqeust.h"
#import "PSKeeperWareHourseAddModel.h"
#import "PSRegionPickerView.h"


@interface PSWarehourseEditVC ()<BasePickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UILabel *label_region;
@property (weak, nonatomic) IBOutlet PlaceHolderTextView *tv_detailAdd;
@property (nonatomic,strong) PSRegionPickerView *cityPicker;

@property (nonatomic,assign) PSKeeperWareHouseType type;
/// <#des#>
@property (nonatomic,copy) NSString *sto_id;

@end

@implementation PSWarehourseEditVC
-(instancetype)initWithSto_id:(NSString *)sto_id{
    if (self = [super init]) {
        
        self.sto_id = sto_id;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tv_detailAdd.placeholder = @"请输入详细地址";

    self.navigationItem.title = [BaseVerifyUtils isNullOrSpaceStr:self.sto_id]?@"新增仓库":@"编辑仓库";
    [self.tf_name addTarget:self action:@selector(editingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self loadWebDataSource];
    
    
}

-(void)loadWebDataSource{
    
    if (self.model) {
        self.label_region.text = self.model.sto_region;
        self.tf_name.text = self.model.sto_name;
        self.tv_detailAdd.text = self.model.sto_addr;
    }
    

}

-(void)editingDidBegin:(UITextField *)tf{
    
    
}

- (IBAction)actionSelectArea:(UIControl *)sender {
    
    [self.view endEditing:YES];

    
    if (![BaseVerifyUtils isNullOrSpaceStr:self.model.sto_region]) {
        NSString *placeHolder =   self.model.sto_region;
        for (int i = 0; i<self.regionList.count; i++) {
            if ([placeHolder isEqualToString:self.regionList[i]]) {
                self.cityPicker.currentSelectIndex = i;
            }
        }
    }
    [self.cityPicker.dataSource setArray:self.regionList];
    [self.cityPicker showPickerView];
}
-(void)onItemSelectedData:(NSString *)data{
   
    
    self.model.sto_region = data;
    self.label_region.text = data;
}


- (IBAction)actionSave:(UIButton *)sender {
    
    

    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_name.text]) {
         [MBProgressHUD toastMessageAtMiddle:@"请输入仓库名"];
         return;
     }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tv_detailAdd.text]) {
         [MBProgressHUD toastMessageAtMiddle:@"请输入详细地址"];
         return;
     }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.label_region.text]) {
         [MBProgressHUD toastMessageAtMiddle:@"请选择区域"];
         return;
     }
    
    PSWareHourseEditReqeust *edit = [PSWareHourseEditReqeust new];
    if (![BaseVerifyUtils isNullOrSpaceStr:self.sto_id]) {
        edit.sot_id = self.sto_id.integerValue;
    }
    edit.sto_name = self.tf_name.text;
    edit.sto_region = self.label_region.text;
    edit.sto_addr = self.tv_detailAdd.text;
    [edit postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            [MBProgressHUD toastMessageAtMiddle:@"保存成功"];
            [[NSNotificationCenter defaultCenter]  postNotification:@"wareHourseChange"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}


-(PSRegionPickerView *)cityPicker{
    if (!_cityPicker) {
        _cityPicker = [[PSRegionPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cityPicker.delegate =self;
        
    }
    return _cityPicker;
}


@end
