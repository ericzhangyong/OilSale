//
//  PSMineTableCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMineTableCell.h"
#import "PSMineCell.h"
#import "PSMineAddressCell.h"
#import "PSMineImageCell.h"
#import "PSMineMessageCell.h"
#import "NSString+RECategory.h"
#import "PSCanDetailVC.h"
#import "UIView+BaseCategory.h"
#import "PSAddNewAddressVC.h"
#import "PSMessageVC.h"
#import "UserInfoProfile.h"
#import "UIImageView+BaseWebCache.h"
#import "PSHeadImageViewController.h"
#import "PSCarMessageVC.h"
#import "PSDriverMessageVC.h"
#import "PSGetCanVC.h"
#import "UserInfoProfile.h"
#import "PSAccountVC.h"
#import "PSModulePageRouter.h"

@interface PSMineTableCell ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

@end
@implementation PSMineTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews{
    
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSMineCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSMineCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSMineAddressCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSMineAddressCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSMineImageCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSMineImageCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSMineMessageCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSMineMessageCell.class)];

    
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.backgroundColor = color_lightDart_white;
    [self.contentView addSubview:self.tableView];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.bottom.equalTo(self);
    }];
}


-(void)setMineViewModel:(PSMineViewModel *)mineViewModel{
    _mineViewModel = mineViewModel;
    
    
    [self.tableView reloadData];
}

#pragma mark- UITableviewDelegate Datasourc
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mineViewModel.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.mineViewModel ps_getTableCellHeightWithIndex:indexPath.row];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PSMineCellType cellType = [self.mineViewModel ps_getTableCellCellTypeIndex:indexPath.row];
    NSString *iconnUrl = [self.mineViewModel ps_getTableCellIconUrlIndex:indexPath.row];
    NSString *title = [self.mineViewModel ps_getTableCellTitleUrlIndex:indexPath.row];
    NSString *content = [self.mineViewModel ps_getTableCellContentUrlIndex:indexPath.row];
    
    if (cellType == PSMineCellTypeAddress || cellType == PSMineCellTypeCarMessage||cellType == PSMineCellTypeStationAddress) {
        PSMineAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSMineAddressCell.class) forIndexPath:indexPath];
        
        cell.imageView_icon.image = [UIImage imageNamed:iconnUrl];
        cell.label_title.text = title;
        cell.label_content.text = content;
        return cell;
    }else if (cellType == PSMineCellTypeMessage){
        PSMineMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSMineMessageCell.class) forIndexPath:indexPath];
        cell.imageView_icon.image = [UIImage imageNamed:iconnUrl];
        cell.label_title.text = title;
        cell.label_content.text = content;
        CGFloat width = 20;
        if (![BaseVerifyUtils isNullOrSpaceStr:content]) {
            width = [content widthWithFont:[UIFont systemWEPingFangRegularOfSize:11]]+10;
        }
        cell.layoutWith_labelContent.constant = width;

        return cell;
    }
//    else if (cellType == PSMineCellTypeUploadImage){
//        PSMineImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSMineImageCell.class) forIndexPath:indexPath];
//        cell.imageView_icon.image = [UIImage imageNamed:iconnUrl];
//        cell.label_title.text = title;
//        
//        if (![BaseVerifyUtils isNullOrSpaceStr:self.mineViewModel.file_url]) {
//            [cell.imageView_content setImageWithUrl:[self.mineViewModel ps_getTableCellContentImageUrlIndex:indexPath.row] placeholder:defaultHolder160_160];
//        }else{
//            cell.imageView_content.image = [UIImage imageNamed:@"unUpload"];
//        }
//        cell.backgroundColor = [UIColor randomColor];
//
//        return cell;
//    }
    else{
        PSMineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSMineCell.class) forIndexPath:indexPath];
        cell.imageView_icon.image = [UIImage imageNamed:iconnUrl];
        cell.label_title.text = title;
        cell.label_content.text = content;
        cell.imageView_rightArrow.hidden = ![self.mineViewModel ps_getIsShowTableCellRightArrowIndex:indexPath.row];

        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSMineCellType cellType = [self.mineViewModel ps_getTableCellCellTypeIndex:indexPath.row];
    if (cellType == PSMineCellTypeAddress) {
        
        PSAddresReceiveModel *receiveModel = [PSAddresReceiveModel new];
//        receiveModel.consignee = self.mineViewModel.ps_getUserNickName;
//        receiveModel.phone_num= UserInfoProfile.shareUserInfo.userInfo.user_phone;
        PSAddNewAddressVC *editAddress = [[PSAddNewAddressVC alloc] init];
        editAddress.editType = FSAddNewEditTypeUpdate;
        
        [self.contentView.navViewController pushViewController:editAddress animated:YES];
    }else if (cellType == PSMineCellTypeMessage){
        if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {
            PSDriverMessageVC *driverMessageVC = [[PSDriverMessageVC alloc] init];
            [self.contentView.navViewController pushViewController:driverMessageVC animated:YES];
        }else{
            PSMessageVC *messageVC =[[PSMessageVC alloc] initPSMeesageType:PSMeesageTypeCustomer];;
                   [self.contentView.navViewController pushViewController:messageVC animated:YES];
        }
       
    }else if (cellType == PSMineCellTypeCarMessage){
        PSCarMessageVC *carMssage  = [[PSCarMessageVC alloc] init];
        [self.contentView.navViewController pushViewController:carMssage animated:YES];
    }else if (cellType == PSMineCellTypeUploadImage){
        PSHeadImageViewController *uploadImageVC = [[PSHeadImageViewController alloc] initWithHeadImagePath:[self.mineViewModel ps_getTableCellContentImageUrlIndex:indexPath.row] isHiddenUploadBtn:NO];
        [self.contentView.navViewController pushViewController:uploadImageVC animated:YES];
    }else if (cellType == PSMineCellTypeCanCount){
        
        PSCanDetailVC *canDetailVC = [PSCanDetailVC new];
        [self.contentView.navViewController  pushViewController:canDetailVC animated:YES];
    }
    else if(cellType == PSMineCellTypeCollectCan){
        
        PSGetCanVC *getCanVC =[[PSGetCanVC alloc] init];
        [self.contentView.navViewController pushViewController:getCanVC animated:YES];
    }else if (cellType == PSMineCellTypeAcountMoney){
        PSAccountVC *accountVC  =[PSAccountVC new];
        
        [self.contentView.navViewController pushViewController:accountVC animated:YES];
    }else if (cellType == PSMineCellTypeKeeperWareHourse){
        
//        [PSModulePageRouter openWareHoursePageWithParam:@{} PageFinish:^(NSDictionary * _Nonnull result) {
//            
//        } complete:^(BOOL isFinish) {
//            
//        }];
    }

}


#pragma mark- lazy

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}


@end
