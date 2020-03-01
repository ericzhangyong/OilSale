//
//  PSShopCartVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSShopCartVC.h"
#import "PSShopCartCell.h"
#import "PSShopCartViewModel.h"
#import "UIImageView+BaseWebCache.h"
#import "PSShopBottomView.h"
#import "PSShopEditBottomView.h"
#import "PSOrderConfirmVC.h"


@interface PSShopCartVC ()
@property (nonatomic,strong) PSShopCartViewModel *cartViewModel;
@property (nonatomic,strong) PSShopBottomView *view_money;
@property (nonatomic,strong) UIButton *btn_edit;
@end

@implementation PSShopCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}
-(void)initNavView{
    self.navigationItem.title = @"购物车";
    
    self.btn_edit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
    [self.btn_edit setTitle:@"完成" forState:UIControlStateSelected];
    [self.btn_edit setTitleColor:color_666666 forState:UIControlStateNormal];
    [self.btn_edit setTitleColor:color_666666 forState:UIControlStateSelected];
    [self.btn_edit addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btn_edit.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btn_edit];
}
-(void)initBaseDatas{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebDataSource) name:FSNotificationConfirmOrderSuccesKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebDataSource) name:FSNotificationAddShopCartSuccesKey object:nil];

    
}
-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.cartViewModel requestShopCartListComplete:^(BOOL isFinished, NSArray * _Nonnull dataArr) {
        if (isFinished) {
            [weakSelf.tableView reloadData];
            [weakSelf reloadBottomView];
        }
        [self endRefreshingWithCount:-1];
    }];
}

-(void)initBaseViews{
    
    [self.view addSubview:self.view_money];
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSShopCartCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSShopCartCell.class)];
    
    [self.view_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(55);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view_money.mas_top);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

-(void)reloadBottomView{
    
    WEAK_SELF;
    
    self.view_money.monyeStr = self.cartViewModel.ps_getSelectedTotalMoney;
    self.view_money.editType = self.cartViewModel.editType;
    self.view_money.isSelectAll = self.cartViewModel.isSelectAll;
    if (self.cartViewModel.ps_getSelectedDataArr.count>0) {
        self.view_money.btn_confirm.enabled = YES;
        self.view_money.btn_confirm.alpha = 1;
    }else{
        self.view_money.btn_confirm.enabled = NO;
        self.view_money.btn_confirm.alpha = 0.5;
    }
    
    self.view_money.didClick = ^(NSInteger clickType) {
        if (clickType == 1) {
            if (weakSelf.cartViewModel.isSelectAll) {
                weakSelf.cartViewModel.isSelectAll = NO;
            }else{
                weakSelf.cartViewModel.isSelectAll = YES;
            }
            [weakSelf.tableView reloadData];
            [weakSelf reloadBottomView];
        }else if (clickType == 2){//确认
            PSOrderConfirmVC *confirmVC = [[PSOrderConfirmVC alloc] initWithShopCartViewModel:weakSelf.cartViewModel];
            [weakSelf.navigationController pushViewController:confirmVC animated:YES];
        }else if (clickType == 3){//删除
            [weakSelf.cartViewModel requesShopCartEditType:2 pay_type:@"" Complete:^(BOOL isFinished) {
                if (isFinished) {
                    [weakSelf.tableView reloadData];
                    [weakSelf reloadBottomView];
                }
            }];
        }
    };
}

#pragma mark- click

-(void)editClick:(UIButton *)button{
    if (self.cartViewModel.editType == PSShopCartEidtTypeEidt) {
        self.cartViewModel.editType = PSShopCartEidtTypeDefault;
    }else{
        self.cartViewModel.editType = PSShopCartEidtTypeEidt;
    }
    button.selected = !button.selected;
    [self reloadBottomView];
}

#pragma mark- UITableViewDeelgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  self.cartViewModel.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor  = color_F3F3F3;
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSShopCartCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index  = indexPath.section;
    
    [cell.imageView_header setImageWithUrl:[self.cartViewModel ps_getImageUrlAtIndex:index] placeholder:defaultHolder160_160];
    cell.label_title.text = [self.cartViewModel ps_getTitlelAtIndex:index];
    cell.label_price.text= [self.cartViewModel ps_getPriceAtIndex:index];
    cell.label_money.attributedText= [self.cartViewModel ps_getMoneyAtIndex:index];
    

    cell.isSelected =  [self.cartViewModel ps_getIsSelectedAtIndex:index];
    WEAK_SELF;
    cell.selectBlock = ^(BOOL isSelected) {
        
        [weakSelf.cartViewModel ps_setIsSelectedAtIndex:index isSeleceted:isSelected];
        [weakSelf.tableView reloadData];
        [weakSelf reloadBottomView];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL isSelected =  [self.cartViewModel ps_getIsSelectedAtIndex:indexPath.section];
    WEAK_SELF;
    
    [weakSelf.cartViewModel ps_setIsSelectedAtIndex:indexPath.section isSeleceted:!isSelected];
    [weakSelf.tableView reloadData];
    [weakSelf reloadBottomView];
}


#pragma mark- lazy
-(PSShopCartViewModel *)cartViewModel{
    if (!_cartViewModel) {
        _cartViewModel = [PSShopCartViewModel new];
        _cartViewModel.editType = PSShopCartEidtTypeDefault;
    }
    return _cartViewModel;
}

-(PSShopBottomView *)view_money{
    if (!_view_money) {
        _view_money = [PSShopBottomView new];
        
    }
    return _view_money;
}





@end
