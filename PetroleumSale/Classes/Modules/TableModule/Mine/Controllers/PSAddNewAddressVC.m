//
//  FSAddNewAddressVC.m
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSAddNewAddressVC.h"
#import "FSAddNewViewModel.h"
#import "FSAddNewAddressTFCell.h"
#import "FSAddNewAddressTVCell.h"
#import "FSAddressPickerView.h"
#import "UserInfoProfile.h"
#import "PSRegionPickerView.h"

@interface PSAddNewAddressVC()<BasePickerViewDelegate>

@property (nonatomic,strong) FSAddNewViewModel *addNewViewModel;

@property (nonatomic,strong) UIView *view_bottom;
@property (nonatomic,strong) UIButton *btn_save;

//@property (nonatomic,strong) FSAddressPickerView *cityPicker;
@property (nonatomic,strong) PSRegionPickerView *cityPicker;

@end
@implementation PSAddNewAddressVC

-(instancetype)initWithAddressModel:(PSAddresReceiveModel *__nullable)addressModel{
    
    if (self = [super init]) {
        
        if (addressModel == nil) {
            addressModel = [PSAddresReceiveModel new];
        }
        self.addNewViewModel.addressModel = addressModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

-(void)initNavView{
    
    NSString *title = UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation?@"加油站地址":@"收货地址";
    self.navigationItem.title  = title;
}

-(void)initBaseDatas{
    
    [self.addNewViewModel setDataSource];
    
}

-(void)loadData{
    WEAK_SELF;
    [self.addNewViewModel requestAddressParamMessageComplete:^(BOOL isFinished,PSAddresReceiveModel *model) {
        if (isFinished) {
            
            [weakSelf.tableView reloadData];
        }
    }];
}

-(void)initBaseViews{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(FSAddNewAddressTFCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(FSAddNewAddressTFCell.class)];
    [self.tableView registerNib:[UINib          nibWithNibName:NSStringFromClass(FSAddNewAddressTVCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(FSAddNewAddressTVCell.class)];
    self.tableView.tableFooterView = self.view_bottom;
    
}

-(void)setEditType:(FSAddNewEditType)editType{
    
    self.addNewViewModel.editType = editType;
}

#pragma mark- UITableViewDataSource UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addNewViewModel.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.addNewViewModel fs_getCellHeightAtIndex:indexPath.row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSAddNewAddressModel *model = [self.addNewViewModel fs_getAddNewModelAtIndex:indexPath.row];
    
    if (model.addNewType == FSAddNewAddressTypeDetail) {
        FSAddNewAddressTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FSAddNewAddressTVCell.class) forIndexPath:indexPath];
        cell.label_title.text = model.title;
        cell.tv_input.placeholder = model.placeHolder;
        WEAK_SELF;
        [cell.tv_input textValueDidChanged:^(NSString * _Nonnull text, CGFloat textHeight) {
            model.content = text;
            weakSelf.addNewViewModel.addressModel.complete_address = text;

        }];
        if (![BaseVerifyUtils isNullOrSpaceStr:model.content]) {
            cell.tv_input.text = model.content;
        }
        cell.tv_input.editable = YES;//model.edit_enable;
        return cell;
    }else{
        FSAddNewAddressTFCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FSAddNewAddressTFCell.class) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label_title.text = model.title;
        cell.tf_input.placeholder = model.placeHolder;
        cell.tf_input.enabled = YES;//model.edit_enable;
        cell.textFieldDidChangeBlock = ^(NSString * _Nonnull text) {
            
            model.content = text;
            if (model.addNewType == FSAddNewAddressTypeNickName) {
                self.addNewViewModel.addressModel.consignee = text;
            }else if (model.addNewType == FSAddNewAddressTypePhone){
                self.addNewViewModel.addressModel.phone_num = text;
            }
        };
        cell.isSelectArea = indexPath.row == 2;
        if (![BaseVerifyUtils isNullOrSpaceStr:model.content]) {
            cell.label_selectArea.text = model.content;
            cell.tf_input.text = model.content;
        }
        WEAK_SELF;
        cell.selectAreaTaped = ^(BOOL isTaped) {
            [weakSelf chooseAddress];
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PSAddNewAddressModel *model = [self.addNewViewModel fs_getAddNewModelAtIndex:indexPath.row];

    if (model.addNewType == FSAddNewAddressTypeCity) {
        [self chooseAddress];
    }
    
}

-(void)saveClick{
   
    if ([BaseVerifyUtils isNullOrSpaceStr:self.addNewViewModel.addressModel.consignee]) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入收货人姓名"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.addNewViewModel.addressModel.phone_num]) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入收货人联系方式"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.addNewViewModel.addressModel.region]) {
        [MBProgressHUD toastMessageAtMiddle:@"请选择区域"];
        return;
    }
   
    
    WEAK_SELF;
    self.btn_save.enabled = NO;
    [self.addNewViewModel fs_saveNewAddressWithFSAddresReceiveModel:self.addNewViewModel.addressModel complete:^(BOOL isFinished) {
        self.btn_save.enabled = YES;
        if (isFinished) {
            if (weakSelf.selectAddressBlock) {
                weakSelf.selectAddressBlock(YES, self.addNewViewModel.addressModel);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:FSNotificationNewAddressKey object:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark- 地区选择

-(void)chooseAddress{
    
    [self.view endEditing:YES];
//    PSAddNewAddressModel *regionModel = [self.addNewViewModel ps_getAddNewModelAddNewAddressType:FSAddNewAddressTypeCity];
//    if (regionModel != nil) {
//        for (int i = 0;i<regionModel.option_values.count; i++) {
//            NSDictionary *dict = regionModel.option_values[i];
//            if ([dict[@"option_value"] isEqualToString:self.addNewViewModel.addressModel.region]) {
//                self.cityPicker.currentSelectIndex = i;
//            }
//        }
//    }
    
    NSString *placeHolder =   self.addNewViewModel.addressModel.region;
    for (int i = 0; i<self.addNewViewModel.rec_region_list.count; i++) {
        if ([placeHolder isEqualToString:self.addNewViewModel.rec_region_list[i]]) {
            self.cityPicker.currentSelectIndex = i;
        }
    }
    [self.cityPicker.dataSource setArray:self.addNewViewModel.rec_region_list];
//    [self.cityPicker.dataSource setArray:regionModel.option_values];
    [self.cityPicker showPickerView];
}

-(void)onItemSelectedData:(NSString *)data{
   
    self.addNewViewModel.addressModel.region = data;
    PSAddNewAddressModel *regionModel = [self.addNewViewModel ps_getAddNewModelAddNewAddressType:FSAddNewAddressTypeCity];
    regionModel.content = data;
    [self.tableView reloadData];
    
}



#pragma mark- lazy

-(FSAddNewViewModel *)addNewViewModel{
    if (!_addNewViewModel) {
        _addNewViewModel= [FSAddNewViewModel new];
        
    }
    return _addNewViewModel;
}
-(UIView *)view_bottom{
    if (!_view_bottom) {
        _view_bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        self.btn_save.frame = CGRectMake(30, 50, kScreenWidth-30*2, 45);
        [_view_bottom addSubview:self.btn_save];
    }
    return _view_bottom;
}

-(UIButton *)btn_save{
    if (!_btn_save) {
        _btn_save = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_save setTitle:@"保存" forState:UIControlStateNormal];
        _btn_save.backgroundColor = fsColor_FF4053;
        _btn_save.layer.cornerRadius = 18;
        _btn_save.layer.masksToBounds = YES;
        [_btn_save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_save addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_save;
}

-(PSRegionPickerView *)cityPicker{
    if (!_cityPicker) {
        _cityPicker = [[PSRegionPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cityPicker.delegate =self;
        
    }
    return _cityPicker;
}


//-(FSAddressPickerView *)cityPicker{
//    if (!_cityPicker) {
//        _cityPicker = [[FSAddressPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//
//        NSString *receiverStr = self.addNewViewModel.addressModel.region;
//        NSArray *arr = [receiverStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"省|市|县|区"]];
//        NSString *province = @"";
//        if (arr.count>0) {
//            NSRange range = [receiverStr rangeOfString:arr[0]];
//            province= [NSString stringWithFormat:@"%@%@",arr[0],[receiverStr substringWithRange:NSMakeRange(range.location+range.length, 1)]];
//        }
//        NSString *city = @"";
//        if (arr.count>1) {
//            NSRange range = [receiverStr rangeOfString:arr[1]];
//            city= [NSString stringWithFormat:@"%@%@",arr[1],[receiverStr substringWithRange:NSMakeRange(range.location+range.length, 1)]];
//
//        }
//        NSString *area = @"";
//        if (arr.count>2) {
//            NSRange range = [receiverStr rangeOfString:arr[2]];
//            area= [NSString stringWithFormat:@"%@%@",arr[2],[receiverStr substringWithRange:NSMakeRange(range.location+range.length, 1)]];
//        }
//        [_cityPicker updateAddressAtProvince:province city:city town:area];
//        _cityPicker.delegate = self;
//        _cityPicker.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
//    }
//    return _cityPicker;
//}
@end
