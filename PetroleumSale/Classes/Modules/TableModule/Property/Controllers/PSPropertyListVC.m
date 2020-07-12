//
//  PSPropertyListVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPropertyListVC.h"
#import "PSPropertyViewModel.h"
#import "PSPropertyListCell.h"
#import "PSPropertyBottomBarView.h"
#import "PSPropertyPopHandleView.h"

@interface PSPropertyListVC ()

@property (nonatomic,strong) PSPropertyViewModel *propertyViewModel;
@property (nonatomic,strong) PSPropertyBottomBarView *view_bottom;

@end

@implementation PSPropertyListVC

-(instancetype)initWithListType:(PSPropertyListType)listType{
    if (self  = [super init]) {
        self.propertyViewModel.listType = listType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSPropertyListCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSPropertyListCell.class)];
    
    [self.view addSubview:self.view_bottom];
    [self.view_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(55);
    }];
    
    WEAK_SELF;
    self.view_bottom.btnClickCallBack = ^(NSInteger clickType) {
        if (clickType == 1) {
            [weakSelf showHandleViewWithType:@"delete"];
        }else if(clickType == 2){
            [weakSelf showHandleViewWithType:@"add"];
        }else if(clickType == 3){
            [weakSelf showHandleViewWithType:@"update"];
        }
    };
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view_bottom.mas_top);
    }];
    
}
/// 操作类型 delete 为处理 add为新增 update为回收
-(void)showHandleViewWithType:(NSString *)handleType{
    
    NSArray *storeNamArr = self.propertyViewModel.getNameArr;
    if (storeNamArr.count==0) {
        [MBProgressHUD toastMessageAtMiddle:@"没有可选仓库列表"];
        return;
    }
    PSPropertyPopHandleView  *hangdleView = [PSPropertyPopHandleView createHandleView];
    hangdleView.confirmClick = ^(NSString * _Nonnull storage_id, NSString * _Nonnull back_num, NSString * _Nonnull back_type) {
        [self.propertyViewModel requestPropertyHandleType:handleType storage_id:storage_id back_num:back_num back_type:back_type complete:^(BOOL isFinished) {
            if (isFinished) {
                [MBProgressHUD toastMessageAtMiddle:@"操作成功！"];
            }
        }];
    };
    [hangdleView showHandleViewWithPropertyViewModel:self.propertyViewModel];
}

-(UITableViewStyle)re_tableViewStryle{
    return UITableViewStyleGrouped;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadWebDataSource];
}
-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.propertyViewModel requestPropertyListComplete:^(BOOL isFinished) {
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshingWithCount:-1];
    }];
}


#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.propertyViewModel.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section+1 == self.propertyViewModel.dataSource.count) {
        return 10;
    }
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.propertyViewModel.listType == PSPropertyListTypeClient) {
        return 115;
    }
    return 145;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSPropertyListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSPropertyListCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger index = indexPath.section;
    cell.label_name.text = [self.propertyViewModel ps_getKeepNameAtIndex:index];
    cell.label_tieBucketType.text = [self.propertyViewModel ps_getTieBucket_numAtIndex:index];
    cell.label_tunBucketCount.text = [self.propertyViewModel ps_getDunBucket_numAtIndex:index];
    cell.label_oidGun.text = [self.propertyViewModel ps_getOilGun_numAtIndex:index];
    cell.label_addresss.text  = [self.propertyViewModel ps_getAddressAtIndex:index];
    cell.label_addresss.hidden = self.propertyViewModel.listType == PSPropertyListTypeClient;
    
    return cell;
}

#pragma mark- layz

-(PSPropertyViewModel *)propertyViewModel{
    if (!_propertyViewModel) {
        _propertyViewModel = [PSPropertyViewModel new];
    }
    return _propertyViewModel;
}

-(PSPropertyBottomBarView *)view_bottom{
    if (!_view_bottom) {
        _view_bottom = [[PSPropertyBottomBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    }
    return _view_bottom;;
}

@end
