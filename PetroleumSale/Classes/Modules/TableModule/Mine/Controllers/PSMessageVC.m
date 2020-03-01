//
//  PSMessageVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMessageVC.h"
#import "PSMessageCell.h"
#import "PSMessageModel.h"
#import "NSString+RECategory.h"
#import "PSMessageReadRequest.h"
#import "PSMessageListRequest.h"
#import "NSDate+BaseCategory.h"

@interface PSMessageVC ()


@property (nonatomic,assign) PSMeesageType messageType;
@end

@implementation PSMessageVC

-(instancetype)initPSMeesageType:(PSMeesageType)messageType{
    if (self = [super init]) {
        self.messageType = messageType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
    
}
-(void)initNavView{
    
    self.navigationItem.title = @"消息通知";
}
-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSMessageCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSMessageCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
//    PSMessageModel *model = [PSMessageModel new];
//    model.title = @"关于柴油价格上升的通知";
//    model.content = @"关于柴油价格上升的通知关于柴油价格上升的通知关于柴油 价格上升的通知关于柴油价格上升的通知关于柴油价格上升的通知关于柴油价格上升的通知关。";
//    model.publish_time = @"2019.11.01 15:34:33 ";
//    model.read_flag = NO;
//    model.isOpened = NO;
//    [self.dataSource addObject:model];
//
//    PSMessageModel *model1 = [PSMessageModel new];
//    model1.title = @"关于柴油价格上升的通知";
//    model1.content = @"关于柴油价格上升的通知关于柴油价格上升的通知关于柴油 价格上升的通知关于柴油价格上升的通知关于柴油价格上升的通知关于柴油价格上升的通知关。";
//    model1.publish_time = @"2019.03.01 15:34:35 ";
//    model1.read_flag = NO;
//    model1.isOpened = YES;
//    [self.dataSource addObject:model1];
//
//    PSMessageModel *model2 = [PSMessageModel new];
//    model2.title = @"关于柴油价格上升的通知";
//    model2.content = @"关于柴油价格上升的通知关于柴油价格上升的通知关于柴油 价格上升的通知关于柴油价格上升的通知关于柴油价格上升的通知关于柴油价格上升的通知关。";
//    model2.publish_time = @"2019.03.01 15:34:35 ";
//    model2.read_flag = YES;
//    model2.isOpened = NO;
//    [self.dataSource addObject:model2];
    
    PSMessageListRequest *listRequest = [PSMessageListRequest new];
    if (self.pullPageIndex == 1) {
        NSDate *date = [NSDate date];
        listRequest.publish_time = [date zy_stringWithDateFormatter:@"YYYY-MM-dd HH:mm:ss"];
    }else{
        PSMessageModel *lastModel = self.dataSource.lastObject;
        NSString *lastTime = lastModel.publish_time;
        listRequest.publish_time = lastTime;
    }
    if (self.messageType == PSMeesageTypeDriverPunishment) {
        listRequest.notice_type = 2;
    }else{
        listRequest.notice_type = 1;
    }
    [listRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            NSArray *data = [PSMessageModel convertModelWithJsonArr:response.result[@"notice_list"]];
            if (self.pullPageIndex == 1) {
                [self.dataSource setArray:data];
            }else{
                [self.dataSource addObject:data];
            }
            [self.tableView reloadData];
            [self endRefreshingWithCount:data.count];
        }else{
            [self endRefreshingWithCount:-1];
        }
    }];
}


#pragma mark-UITableViewDelegate- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSMessageModel *model = self.dataSource[indexPath.row];
    if (model.isOpened) {
        CGFloat contentHeight = [model.content heightWithFont:[UIFont systemWEPingFangRegularOfSize:12] width:kScreenWidth-30*2]+5;
        return 10+20+5+17+10+contentHeight+15;
    }else{
        return 72;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
    PSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSMessageCell.class) forIndexPath:indexPath];
    
    PSMessageModel *model = self.dataSource[indexPath.row];
    cell.messageModel  = model;
    WEAK_SELF;
    cell.btnUpDownClick = ^(BOOL isSelected) {
        
        model.isOpened = !model.isOpened;
        if (!model.read_flag) {
            //请求已读
            PSMessageReadRequest *readRequest =[PSMessageReadRequest new    ];
            readRequest.notice_ids = @[@(model.notice_id.integerValue)];
            readRequest.notice_state = 1;
            if (weakSelf.messageType == PSMeesageTypeDriverPunishment) {
                readRequest.notice_type = 2;
            }else {
                readRequest.notice_type = 1;
            }
            [readRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
                if (response.isFinished) {
                    model.read_flag = YES;
                    [weakSelf.tableView reloadData];
                }
            }];
        }else{
            [weakSelf.tableView reloadData];
        }
    };
    return cell;
}


@end
