//
//  PSCarNumVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSCarNumVC.h"
#import "PSPetrolStationCell.h"
#import "PSCustomerCarSelecBottomView.h"
#import "PSCustomerCarNumEditBottomView.h"
#import "PSNewCarNumVC.h"
#import "PSHomeRequest.h"
#import "PSHomeModel.h"
#import "PSNewStationCarNumRequest.h"

@interface PSCarNumVC ()

@property (nonatomic,strong) PSCustomerCarSelecBottomView *view_confirm;
@property (nonatomic,strong) PSCustomerCarNumEditBottomView *view_edit;
@property (nonatomic,strong) UIButton *btn_right;


@end

@implementation PSCarNumVC

-(instancetype)initWithDataArray:(NSArray<PSStationCarModel *> *)data{
    if (self = [super init]) {
       
        [self.dataSource setArray:data];
        
//        for (int i = 0; i<self.dataSource.count; i++) {
//            PSStationCarModel *model = self.dataSource[i];
//
//        }
//        self.complete = complete;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}
-(void)initNavView{
    
    self.navigationItem.title = @"选择车牌号";
//    [self rightBarButtonWithText:@"编辑" textColor:color_333333 textFont:[UIFont systemWEPingFangRegularOfSize:16] target:self selector:@selector(confrimClick)];
    
    self.btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_right addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btn_right.frame = CGRectMake(0, 0, 44, self.navigationController.navigationBar.bounds.size.height);
    [self.btn_right setTitle:@"编辑" forState:UIControlStateNormal];
    [self.btn_right setTitle:@"完成" forState:UIControlStateSelected];
    [self.btn_right setTitleColor:color_333333 forState:UIControlStateNormal];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:self.btn_right];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    
    [self.btn_right addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"selected"];
    
}

-(void)rightBtnClick:(UIButton *)btn{
    
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected  = YES;
    }
}



-(void)initBaseViews{
    
    [self.view addSubview:self.view_confirm];
    [self.view addSubview:self.view_edit];
    self.view_confirm.hidden = NO;
    self.view_edit.hidden = YES;
    [self.view_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    [self.view_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-56);
    }];
    
    WEAK_SELF;
    self.view_confirm.confirmClick = ^{
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (PSStationCarModel *model in weakSelf.dataSource) {
            [dataArr addObject:model];
        }
        if (weakSelf.selectCarNumBlock) {
            weakSelf.selectCarNumBlock(dataArr);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.view_edit.bottomBtnClick = ^(NSInteger clickType) {
        if (clickType == 1) {//新增
            PSNewCarNumVC *newCarNum = [[PSNewCarNumVC alloc] init];
            newCarNum.createCarNumComplete = ^(NSString * _Nonnull car_info_id) {
              
                [weakSelf updateHomeDataCarList];
            };
            [weakSelf.navigationController pushViewController:newCarNum animated:YES];
        }else if (clickType == 2){//删除
            [weakSelf deleteCar];
        }
    };
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib  nibWithNibName:NSStringFromClass(PSPetrolStationCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSPetrolStationCell.class)];
}

-(void)updateHomeDataCarList{
    
    PSHomeRequest *homeRequest =[PSHomeRequest new];
       [homeRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
           if (response.isFinished) {
               PSHomeModel *model = [PSHomeModel convertModelWithJsonDic:response.result];
               
               [self.dataSource setArray:model.farp_product.farp_car_list];
               [self.tableView reloadData];
           }
           [self endRefreshingWithCount:-1];
       }];
}

-(void)deleteCar{
    
    PSNewStationCarNumRequest *deleteCar =[PSNewStationCarNumRequest new];
    deleteCar.operate_type = @"delete";
    NSArray *carNumArr = [self.dataSource valueForKey:@"car_number"];
    deleteCar.car_num = carNumArr;
    [deleteCar postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            [self updateHomeDataCarList];
            [MBProgressHUD toastMessageAtMiddle:@"删除成功"];
        }
    }];
}


-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    
    [self.tableView reloadData];
    [self endRefreshingWithCount:-1];

}

#pragma mark- Click
-(void)confrimClick{
    
//    NSMutableArray *data = [NSMutableArray array];
//    for (PSStationCarModel *model in self.dataSource) {
//        if (model.isSelected) {
//            [data addObject:model];
//        }
//    }
//    NSArray *data = [self.dataSource valueForKey:@"name"];
    self.selectCarNumBlock(self.dataSource);
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == @"selected") {
        NSNumber *new = change[@"new"];
        self.view_confirm.hidden = new.boolValue;
        self.view_edit.hidden = !new.boolValue;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark- UITableViewDelgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSPetrolStationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSPetrolStationCell.class) forIndexPath:indexPath];
    PSStationCarModel *model = self.dataSource[indexPath.row];
    
    cell.label_name.text = model.car_number;
    cell.btn_select.selected = model.isSelected;
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    PSStationCarModel *model = self.dataSource[indexPath.row];
    model.isSelected = !model.isSelected;
//    [self.tableView reloadData];
    
    PSPetrolStationCell *cell= [tableView cellForRowAtIndexPath:indexPath];
    cell.btn_select.selected = model.isSelected;

}

#pragma mark- lazy
-(PSCustomerCarSelecBottomView *)view_confirm{
    if (!_view_confirm) {
        _view_confirm = [PSCustomerCarSelecBottomView initViewWithFrame:CGRectMake(0, kScreenHeight-56, kScreenWidth, 56)];
    }
    return _view_confirm;
}

- (PSCustomerCarNumEditBottomView *)view_edit{
    if (!_view_edit) {
        _view_edit = [PSCustomerCarNumEditBottomView initViewWithFrame:CGRectMake(0, kScreenHeight-56, kScreenWidth, 56)];
    }
    return _view_edit;
}


@end
