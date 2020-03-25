//
//  PSMineVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMineVC.h"
#import "PSMineViewModel.h"
#import "PSMineTableCell.h"
#import "RELoginViewController.h"
#import "PSMineHeaderView.h"
#import "UIImage+BaseImageCategory.h"
#import "PSMineFooterView.h"
#import "UserInfoProfile.h"
#import "PSPersonEditVC.h"
#import "REMainTabManager.h"
#import "MMAlertView+BaseAlertManger.h"
#import "RELoginViewController.h"

@interface PSMineVC ()
@property (nonatomic,strong) PSMineViewModel *mineViewModel;

@property (nonatomic,strong) PSMineHeaderView *view_header;
@property (nonatomic,strong) PSMineFooterView *view_footer;
@end

@implementation PSMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self reloadViews];
}
-(void)initBaseViews{
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerClass:PSMineTableCell.class forCellReuseIdentifier:NSStringFromClass(PSMineTableCell.class)];
    
}

-(void)setHeaderView{
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 210);
    self.view_header.frame = view.bounds;
    [view addSubview:self.view_header];
    self.tableView.tableHeaderView = view;
    
    self.view_header.imageView_header.image = [UIImage imageNamed:self.mineViewModel.ps_getHeaderImageIcon];
    self.view_header.label_nickName.text = self.mineViewModel.ps_getUserNickName;
    self.view_header.label_phone.text = self.mineViewModel.ps_getUserPhone;
    
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    self.view_footer.label_notice.attributedText = self.mineViewModel.ps_getShouHouString;
    self.tableView.tableFooterView = self.view_footer;
    self.view_footer.label_notice.hidden = !self.mineViewModel.isCustomerRole;
    WEAK_SELF;
    self.view_footer.outLoginClick = ^(BOOL isClick){
        
        [MMAlertView showWithTitle:@"是否退出登录！" detail:@"" cancelBtn:@"取消" sureBtn:@"确定" handler:^{
            [weakSelf.mineViewModel requestOutLoginComplete:^(BOOL isFinished) {
                [MBProgressHUD toastMessageAtMiddle:@"退出成功"];
                CYLTabBarController *tab = REMainTabManager.sharedManager.tabBarController;
                tab.selectedIndex = 0;
            }];
            
        }];
    };

    self.view_header.userClick = ^(BOOL isClick) {
        PSPersonEditVC *personEditVC =[[PSPersonEditVC alloc] init];
        [weakSelf.navigationController pushViewController:personEditVC animated:YES];
    };
}



-(void)reloadViews{
    
    [self.mineViewModel setMineDataSource];
    [self setHeaderView];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    WEAK_SELF;
    [UserInfoProfile.shareUserInfo requestUserInfoWitnComplete:^(BOOL isFinish) {
        [weakSelf reloadViews];
    }];
    
    [self.mineViewModel requestUPloadImageComplete:^(BOOL isFinished) {
        if (isFinished) {
            [weakSelf reloadViews];
        }
    }];
    
}

#pragma mark- UITableViewDataSource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.mineViewModel.ps_getCellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSMineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSMineTableCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mineViewModel = self.mineViewModel;
    
    return cell;
}


#pragma mark- lazy
-(PSMineViewModel *)mineViewModel{
    if (!_mineViewModel) {
        _mineViewModel = [PSMineViewModel    new];
    }
    return _mineViewModel;
}

-(PSMineHeaderView *)view_header{
    if (!_view_header) {
        _view_header = [PSMineHeaderView initNibView];
    }
    return _view_header;
}
-(PSMineFooterView *)view_footer{
    if (!_view_footer) {
        _view_footer = [PSMineFooterView initViewWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    }
    return _view_footer;
}

@end
