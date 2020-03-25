//
//  PSCanDetailVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSCanDetailVC.h"
#import "PSCanRetureRequest.h"
#import "NSDate+BaseCategory.h"
#import "PSDriverConfirmCell.h"
#import "PSCanReturnRecordCell.h"
#import "PSCanListModel.h"
#import "PSCanConfirmRequst.h"

@interface PSCanDetailVC ()

@property (nonatomic,strong) UILabel *label_unRetureIbcCount;//铁桶
@property (nonatomic,strong) UILabel *label_unReturnBucketCount;//吨桶
@property (nonatomic,strong) UILabel *label_unReturnNozzleCount;//加油枪


@property (nonatomic,strong) UIView *view_header;

@property (nonatomic,strong) PSCanListModel *listModel;

@property (nonatomic,strong) NSString *lastTime;


@end

@implementation PSCanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadWebDataSource];
}

-(void)initNavView{
    self.navigationItem.title = @"油桶数量";
}

-(void)initBaseViews{
    
    self.tableView.tableHeaderView = self.view_header;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSDriverConfirmCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSDriverConfirmCell.class)];
   [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSCanReturnRecordCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSCanReturnRecordCell.class)];
    
    
    [self.view_header addSubview:self.label_unRetureIbcCount];
    [self.label_unRetureIbcCount mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_header);
        make.centerY.equalTo(self.view_header);
        make.width.mas_equalTo(kScreenWidth/3.0);
    }];
    
    [self.view_header addSubview:self.label_unReturnBucketCount];
    [self.label_unReturnBucketCount mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_unRetureIbcCount.mas_right);
        make.centerY.equalTo(self.view_header);
        make.width.mas_equalTo(kScreenWidth/3.0);
    }];
    
    [self.view_header addSubview:self.label_unReturnNozzleCount];
    [self.label_unReturnNozzleCount mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_unReturnBucketCount.mas_right);
        make.centerY.right.equalTo(self.view_header);
    }];

}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    self.defaultPageSize = 10;
    PSCanRetureRequest *canRetuen = [PSCanRetureRequest new];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    NSString *dateStr = [NSDate zy_stringWithDateFormatter:@"YYYY-MM-dd HH:mm:ss" Value:timeSp.doubleValue];
    if (self.lastTime != nil && self.pullPageIndex >1) {
        dateStr = self.lastTime;
    }
    canRetuen.return_time = dateStr;
    
    [canRetuen postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            PSCanListModel *model = [PSCanListModel convertModelWithJsonDic:response.result];
            if (self.pullPageIndex == 1) {
                self.listModel = model;
            }else{
                if (model.returned_record_list.count>0) {
                    [self.listModel.returned_record_list addObjectsFromArray:model.returned_record_list];
                }
            }
            
            if (self.dataSource.count>0) {
                [self.dataSource removeAllObjects];
            }
            if (self.listModel.wait_confirm_info.count>0) {
                [self.dataSource addObject:self.listModel.wait_confirm_info];
            }
            if (self.listModel.returned_record_list.count) {
                [self.dataSource addObject:self.listModel.returned_record_list];
            }
            [self updateUI];
            [self.tableView reloadData];
            [self endRefreshingWithCount:model.returned_record_list.count];
        }else{
            [self endRefreshingWithCount:-1];
        }
    }];
    
  
}

#pragma mark- UITableViewDelegate datasourc

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSCanReturnModel *model  = self.dataSource[indexPath.section][indexPath.row];
    if (model.isDriverReturnType) {
        PSDriverConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSDriverConfirmCell.class) forIndexPath:indexPath];
        
        cell.label_tile.text = [NSString stringWithFormat:@"%@向您回收%@个油桶",model.driver_name,model.recovery_num];
        WEAK_SELF;
        cell.confirmClick = ^(BOOL isClick) {
          
            PSCanConfirmRequst *confirmReqeust = [PSCanConfirmRequst new];
            confirmReqeust.notice_list = @[model.confirm_info_id];
            [confirmReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
                if (response.isFinished) {
                    [MBProgressHUD toastMessageAtMiddle:@"确认成功"];
                    [weakSelf loadWebDataSource];
                }
            }];
        };
        return cell;
    }else{
        PSCanReturnRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSCanReturnRecordCell.class) forIndexPath:indexPath];
        
        cell.label_title.text = [NSString stringWithFormat:@"%@ 还桶数",model.returned_time];
        cell.label_count.text = [NSString stringWithFormat:@"%@个",model.returned_num];
        
        return cell;
    }
    
}



-(void)updateUI{
    
    self.label_unReturnBucketCount.attributedText = [self getUnReturnCountWithCount:self.listModel.no_returned_bucket_num title:@"铁桶"];
    self.label_unRetureIbcCount.attributedText = [self getUnReturnCountWithCount:self.listModel.no_returned_ibc_num title:@"吨桶"];
    self.label_unReturnNozzleCount.attributedText = [self getUnReturnCountWithCount:self.listModel.no_returned_nozzle_num title:@"加油枪"];

}
-(NSMutableAttributedString *)getUnReturnCountWithCount:(NSString *)count title:(NSString *)title{
    NSString *unRepayCount = count;
    NSString *conent = [NSString stringWithFormat:@"%@%@个",title,unRepayCount];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:conent attributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:15],NSForegroundColorAttributeName:color_666666}];
    NSRange range = [conent rangeOfString:unRepayCount];
    if (range.location != NSNotFound) {
        [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:40],NSForegroundColorAttributeName:color_4084FF} range:range];
    }
    return  attr;
}

#pragma mark- click
-(void)btn_oneReapayClick{
    
    
}

#pragma mark- lazy
-(UILabel *)label_unRetureIbcCount{
    if (!_label_unRetureIbcCount) {
        _label_unRetureIbcCount = [UILabel new];
        _label_unRetureIbcCount.textAlignment = NSTextAlignmentCenter;
    }
    return _label_unRetureIbcCount;
}
-(UILabel *)label_unReturnBucketCount{
    if (!_label_unReturnBucketCount) {
        _label_unReturnBucketCount = [UILabel new];
        _label_unReturnBucketCount.textAlignment = NSTextAlignmentCenter;
    }
    return _label_unReturnBucketCount;
}
-(UILabel *)label_unReturnNozzleCount{
    if (!_label_unReturnNozzleCount) {
        _label_unReturnNozzleCount = [UILabel new];
        _label_unReturnNozzleCount.textAlignment = NSTextAlignmentCenter;
    }
    return _label_unReturnNozzleCount;
}


-(PSCanListModel *)listModel{
    if (!_listModel) {
        _listModel = [PSCanListModel new];
    }
    return _listModel;
}

-(UIView *)view_header{
    if (!_view_header) {
        _view_header =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 96)];
    }
    return _view_header;
}

@end
