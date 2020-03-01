//
//  PSDeliveryListVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/13.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDeliveryListVC.h"
#import "PSDeliveryViewModel.h"
#import "PSDeliveryCell.h"
#import "UIImageView+BaseWebCache.h"
#import "NSString+RECategory.h"

@interface PSDeliveryListVC ()

@property (nonatomic,strong) PSDeliveryViewModel *deliverViewModel;

@end

@implementation PSDeliveryListVC

-(instancetype)initWithDeliveryListTypeL:(DeliveryListType)deliverListType{
    if (self = [super init]) {
        self.deliverViewModel.deliverListType = deliverListType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}


-(void)initNavView{
    
    if (self.deliverViewModel.deliverListType == DeliveryListTypeSelect) {
        self.navigationItem.title = @"送货单号";
    }
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSDeliveryCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSDeliveryCell.class)];
}

- (void)loadWebDataSource{
    [super loadWebDataSource];
    
    if (self.deliverViewModel.deliverListType == DeliveryListTypeSelect) {
        NSArray *data = [PSDeliveryModel convertModelWithJsonArr:self.selectResultArr];
        [self.deliverViewModel.dataSource setArray:data];
        [self.tableView reloadData];
    }else{
        NSString *time = nil;
        if (self.pullPageIndex != 1 && self.deliverViewModel.dataSource.count>0) {
            PSDeliveryModel *model = self.deliverViewModel.dataSource.lastObject;
            time = model.order_time;
        }
        [self.deliverViewModel requestDeliverDataWithTime:time page:self.pullPageIndex Complete:^(BOOL isFinished, NSArray * _Nonnull dataArr) {
            if (isFinished) {
                
                [self.tableView reloadData];
                [self endRefreshingWithCount:dataArr.count];
            }else{
                [self endRefreshingWithCount:-1];
            }
        }];
    }
    
}

-(void)setSelectResultArr:(NSArray *)selectResultArr{
    _selectResultArr = selectResultArr;
}

#pragma mark- UITabelViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.deliverViewModel.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = color_F3F3F3;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 20;
    NSString *address = [self.deliverViewModel ps_getAddressAtIndex:indexPath.section];
    if (![BaseVerifyUtils isNullOrSpaceStr:address]) {
        height = [address heightWithFont:[UIFont systemWEPingFangRegularOfSize:14] width:kScreenWidth-30*2]+5;
    }
    CGFloat orderNoHeight = [self.deliverViewModel ps_getDeliverNoHeightAtIndex:indexPath.section];
    return 114+height+orderNoHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSDeliveryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSDeliveryCell.class) forIndexPath:indexPath];
    if (self.deliverViewModel.deliverListType != DeliveryListTypeSelect) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSInteger index = indexPath.section;
    [cell.imageView_header setImageWithUrl:[self.deliverViewModel ps_getImageUrlAtIndex:index] placeholder:defaultHolder160_160];
    cell.label_title.text = [self.deliverViewModel ps_getTitleAtIndex:index];
    cell.label_time.text = [self.deliverViewModel ps_getTimeAtIndex:index];
    cell.label_address.text = [self.deliverViewModel ps_getAddressAtIndex:index];
    cell.btn_select.hidden = self.deliverViewModel.deliverListType != DeliveryListTypeSelect;
    cell.label_deliverNo.text = [self.deliverViewModel ps_getDeliverNoAtIndex:index];
    cell.layoutHeight_deliverNo.constant = [self.deliverViewModel ps_getDeliverNoHeightAtIndex:index];
    cell.layoutWidth_btnSelect.constant = self.deliverViewModel.deliverListType != DeliveryListTypeSelect?0:60;
    WEAK_SELF;
    cell.btnDidSelecBlock = ^(BOOL isSelected) {
        if (weakSelf.didSelecBlock) {
            weakSelf.didSelecBlock([weakSelf.deliverViewModel ps_getDeliverNoAtIndex:indexPath.section]);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.deliverViewModel.deliverListType != DeliveryListTypeSelect) {
        return;
    }
    
    if (self.didSelecBlock) {
        self.didSelecBlock([self.deliverViewModel ps_getDeliverNoCodeAtIndex:indexPath.section]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark- lazy

-(PSDeliveryViewModel *)deliverViewModel{
    if (!_deliverViewModel) {
        _deliverViewModel = [PSDeliveryViewModel    new];
    }
    return _deliverViewModel;
}

-(BOOL)needPullFooter{
    if (self.deliverViewModel.deliverListType == DeliveryListTypeSelect) {
        return NO;
    }else{
        return YES;
    }
}
-(BOOL)needPullHeader{
    if (self.deliverViewModel.deliverListType == DeliveryListTypeSelect) {
        return NO;
    }else{
        return YES;
    }

}

@end
