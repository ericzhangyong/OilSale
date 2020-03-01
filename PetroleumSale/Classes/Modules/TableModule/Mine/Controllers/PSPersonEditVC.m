//
//  PSPersonEditVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPersonEditVC.h"
#import "PSPersonEditViewModel.h"
#import "PSPersonEditCell.h"

@interface PSPersonEditVC ()

@property (nonatomic,strong) PSPersonEditViewModel *editViewModel;
@property (nonatomic,strong) UIView *view_bottom;
@property (nonatomic,strong) UIButton *btn_save;
@end

@implementation PSPersonEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadwebDataSourde];
}
-(void)initBaseDatas{
    
    [self.editViewModel setPersonEditData];
}
-(void)initNavView{
    self.navigationItem.title = @"编辑资料";
}
-(void)initBaseViews{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSPersonEditCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSPersonEditCell.class)];
    
    self.tableView.tableFooterView = self.view_bottom;
    

}
-(void)loadwebDataSourde{
    WEAK_SELF;
    [self.editViewModel requestPersonAccountComplete:^(BOOL isFinished) {
        if (isFinished) {
            
            [weakSelf.tableView reloadData];
        }
    }];
}
-(void)saveClick{
   
    WEAK_SELF;
    [self.editViewModel requestAddPersonSonAccountComplete:^(BOOL isFinished) {
        if (isFinished) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
#pragma mark- UITableViewDelegate dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.editViewModel.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.editViewModel.dataSource[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view  = [UIView new];
    view.backgroundColor = color_F3F3F3;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSPersonEditCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSPersonEditCell.class) forIndexPath:indexPath];
    
    PSPersonEditSetModel *model = self.editViewModel.dataSource[indexPath.section][indexPath.row];
    cell.label_title.text = model.title;
    cell.tf_content.text = model.content;
    cell.tf_content.placeholder = model.placeHolder;
    cell.tf_content.enabled  = self.editViewModel.accountModel.account_type;
    
    WEAK_SELF;
    cell.textFieldDidChanged = ^(NSString * _Nonnull value) {
        if (model.editType == PSPersonEditTypeMainPhoneNum) {
            weakSelf.editViewModel.accountModel.account = value;
        }else if (model.editType == PSPersonEditTypeSub1){
            weakSelf.editViewModel.accountModel.sub_account_1 = value;
        }else if (model.editType == PSPersonEditTypeSub2){
            weakSelf.editViewModel.accountModel.sub_account_2 = value;
        }else if (model.editType == PSPersonEditTypeName){
            weakSelf.editViewModel.accountModel.user_name = value;
        }
    };
    return cell;
}



#pragma mark- lazy
-(PSPersonEditViewModel *)editViewModel{
    if (!_editViewModel) {
        _editViewModel =[PSPersonEditViewModel new];
    }
    return _editViewModel;
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


@end
