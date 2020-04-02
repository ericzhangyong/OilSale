//
//  PSMineViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMineViewModel.h"
#import "PSMineSetModel.h"
#import "UserInfoProfile.h"
#import "PSGetCheckImageRequest.h"

@implementation PSMineViewModel


-(void)setMineDataSource{
    
    UserInfoModel *userInfo = UserInfoProfile.shareUserInfo.userInfo;
    
    if (self.dataSource.count>0) {
        [self.dataSource removeAllObjects];
    }
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {//司机端
        PSMineSetModel *carMessageModel = [PSMineSetModel new];
        carMessageModel.mineCellType = PSMineCellTypeCarMessage;
        carMessageModel.title = @"车辆信息";
        carMessageModel.content = @"录入车辆信息";
        carMessageModel.iconImageUrl = @"userpg_list_adress";
        [self.dataSource addObject:carMessageModel];
        
        PSMineSetModel *messageModel = [PSMineSetModel new];
        messageModel.mineCellType = PSMineCellTypeMessage;
        messageModel.title = @"消息通知";
        messageModel.content = userInfo.notice_un_read_num;
        messageModel.iconImageUrl = @"userpg_list_news";
        [self.dataSource addObject:messageModel];
        
        PSMineSetModel *collectCanModel = [PSMineSetModel new];
        collectCanModel.mineCellType = PSMineCellTypeCollectCan;
        collectCanModel.title = @"我要收桶";
        collectCanModel.content = userInfo.balance;
        collectCanModel.iconImageUrl = @"userpg_list_adre";
        [self.dataSource addObject:collectCanModel];
        
    }else if (userInfo.userType == UserTypeSender){
        
    }else if (userInfo.userType == UserTypePetrolStation){
        PSMineSetModel *addresStationModel = [PSMineSetModel new];
        addresStationModel.mineCellType = PSMineCellTypeAddress;
        addresStationModel.title = @"加油点地址";
        NSString *address = [NSString stringWithFormat:@"%@%@",userInfo.receipt_addr.region,userInfo.receipt_addr.complete_address];
        addresStationModel.content = address;
        addresStationModel.iconImageUrl = @"userpg_list_adress";
        [self.dataSource addObject:addresStationModel];
        
        PSMineSetModel *stationReservesModel = [PSMineSetModel new];
        stationReservesModel.mineCellType = PSMineCellTypeStationReserves;
        stationReservesModel.title = @"加油点储量";
        stationReservesModel.content = [NSString stringWithFormat:@"%@%@",userInfo.reserves,userInfo.reserves_unit];
        stationReservesModel.iconImageUrl = @"userpg_list_record";
        [self.dataSource addObject:stationReservesModel];
    }else if (userInfo.userType == UserTypeSalesman){
       //
        PSMineSetModel *inviteModel =[PSMineSetModel new];
        inviteModel.mineCellType = PSMineCellTypeStationInvite;
        inviteModel.title = @"我的邀请码";
        inviteModel.iconImageUrl = @"userpg_list_adress_salesman";
        inviteModel.content = userInfo.invite_code;
        [self.dataSource addObject:inviteModel];
        
        PSMineSetModel *messageModel = [PSMineSetModel new];
        messageModel.mineCellType = PSMineCellTypeMessage;
        messageModel.title = @"消息通知";
        messageModel.content = userInfo.notice_un_read_num;
        messageModel.iconImageUrl = @"userpg_list_news";
        [self.dataSource addObject:messageModel];
    }
    else if (userInfo.userType == UserTypeKeeper){
        
        PSMineSetModel *wareHourseModel =[PSMineSetModel new];
        wareHourseModel.mineCellType = PSMineCellTypeKeeperWareHourse;
        wareHourseModel.title = @"仓库地址";
        wareHourseModel.iconImageUrl = @"userpg_list_adress";
        wareHourseModel.content = @"";
        [self.dataSource addObject:wareHourseModel];
        
        PSMineSetModel *messageModel = [PSMineSetModel new];
        messageModel.mineCellType = PSMineCellTypeMessage;
        messageModel.title = @"消息通知";
        messageModel.content = userInfo.notice_un_read_num;
        messageModel.iconImageUrl = @"userpg_list_news";
        [self.dataSource addObject:messageModel];
    }
    else{
        PSMineSetModel *accountMoney = [PSMineSetModel new];
        accountMoney.mineCellType = PSMineCellTypeAcountMoney;
        accountMoney.title = @"余额和对账单";
        accountMoney.content = @"";
        accountMoney.iconImageUrl = @"userpg_list_account";
        [self.dataSource addObject:accountMoney];
        
        PSMineSetModel *addresModel = [PSMineSetModel new];
        addresModel.mineCellType = PSMineCellTypeAddress;
        addresModel.title = @"收货地址";
//        NSString *address = [NSString stringWithFormat:@"%@%@",userInfo.receipt_addr.region,userInfo.receipt_addr.complete_address];
        NSMutableString *addressStr = [NSMutableString stringWithString:@""];
        if (![BaseVerifyUtils isNullOrSpaceStr:userInfo.receipt_addr.region]) {
            [addressStr appendString:userInfo.receipt_addr.region];
        }
        if (![BaseVerifyUtils isNullOrSpaceStr:userInfo.receipt_addr.complete_address]) {
            [addressStr appendString:userInfo.receipt_addr.complete_address];
        }
        addresModel.content = addressStr;
        addresModel.iconImageUrl = @"userpg_list_adress";
        [self.dataSource addObject:addresModel];
        
        PSMineSetModel *messageModel = [PSMineSetModel new];
        messageModel.mineCellType = PSMineCellTypeMessage;
        messageModel.title = @"消息通知";
        messageModel.content = userInfo.notice_un_read_num;
        messageModel.iconImageUrl = @"userpg_list_news";
        [self.dataSource addObject:messageModel];
        
        PSMineSetModel *uploadImageModel = [PSMineSetModel new];
        uploadImageModel.mineCellType = PSMineCellTypeUploadImage;
        uploadImageModel.title = @"上传审核图片";
        uploadImageModel.content = @"未上传";
//        uploadImageModel.iconImageUrl = @"";//@"userpg_list_pic";
        if (![BaseVerifyUtils isNullOrSpaceStr:self.file_url]) {
//            uploadImageModel.imageUrl = self.file_url;
            uploadImageModel.content = @"已上传";
        }
        [self.dataSource addObject:uploadImageModel];
        
        PSMineSetModel *canModel = [PSMineSetModel new];
        canModel.mineCellType = PSMineCellTypeCanCount;
        canModel.title = @"油桶数量";
        NSString *weiHuanStr = [NSString stringWithFormat:@"未还%@桶",userInfo.not_returned_bucket_num];
        canModel.content = weiHuanStr;
        canModel.iconImageUrl = @"userpg_list_adress";
        [self.dataSource addObject:canModel];
    }
    
}
-(PSMineSetModel *)getMineSetModelAtIndex:(NSInteger)index{
    if (index>=self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(BOOL)isCustomerRole{
    BOOL isCustomRole = UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeCustomer;
    return isCustomRole;
}

-(NSString *)ps_getHeaderImageIcon{
    if (UserInfoProfile.shareUserInfo.userInfo.user_sex == 1) {
        return @"mine_head_boy";
    }else{
        return @"mine_head_girl";
    }
}

-(NSString *)ps_getUserNickName{
    
    NSString *nickName = UserInfoProfile.shareUserInfo.userInfo.user_name;
    if ([BaseVerifyUtils isNullOrSpaceStr:nickName]) {
        nickName = @"默认昵称";
    }
    return nickName;
}

-(NSString *)ps_getUserPhone{
    
    NSString *phone = [NSString stringWithFormat:@"联系方式:%@",UserInfoProfile.shareUserInfo.userInfo.user_phone];
    return phone;
}
-(NSMutableAttributedString *)ps_getShouHouString{

    NSString *dianhua = UserInfoProfile.shareUserInfo.userInfo.sales_service_hotline;
    NSString *phone = [NSString stringWithFormat:@"售后服务：%@",dianhua];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSMutableString *contentStr = [NSMutableString string];
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeCustomer) {
        [contentStr appendFormat:@"%@\n",phone];
    }
    [contentStr appendFormat:@"版本号：%@(build%@)",version,build];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14],NSForegroundColorAttributeName:color_666666}];
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeCustomer) {
        if (![BaseVerifyUtils isNullOrSpaceStr:dianhua]) {
            NSRange range = [phone rangeOfString:dianhua];
            if (range.location != NSNotFound) {
                [attr addAttributes:@{NSForegroundColorAttributeName:color_4084FF} range:range];
            }
        }
    }
    
    return attr;
}

-(CGFloat)ps_getCellHeight{
    
    
    CGFloat height = 0;
    for (PSMineSetModel *setModel in self.dataSource) {
        if (setModel.mineCellType == PSMineCellTypeAddress|| setModel.mineCellType == PSMineCellTypeCarMessage||setModel.mineCellType == PSMineCellTypeStationAddress) {
            height += 72;
        }else{
            height += 50;
        }
    }
    return height;

}
-(CGFloat)ps_getTableCellHeightWithIndex:(NSInteger)index{
    
    PSMineSetModel *setModel = [self getMineSetModelAtIndex:index];
    if (setModel.mineCellType == PSMineCellTypeAddress||setModel.mineCellType == PSMineCellTypeCarMessage|| setModel.mineCellType == PSMineCellTypeStationAddress) {
        return 72;
    }else{
        return 50;
    }
}
-(PSMineCellType)ps_getTableCellCellTypeIndex:(NSInteger)index{
    PSMineSetModel *setModel = [self getMineSetModelAtIndex:index];
    return setModel.mineCellType;
}
-(NSString *)ps_getTableCellIconUrlIndex:(NSInteger)index{
   PSMineSetModel *setModel = [self getMineSetModelAtIndex:index];
   return setModel.iconImageUrl;
}
-(NSString *)ps_getTableCellTitleUrlIndex:(NSInteger)index{
    PSMineSetModel *setModel = [self getMineSetModelAtIndex:index];
    return setModel.title;
}
-(NSString *)ps_getTableCellContentUrlIndex:(NSInteger)index{
    PSMineSetModel *setModel = [self getMineSetModelAtIndex:index];
    return setModel.content;
}
-(NSString *)ps_getTableCellContentImageUrlIndex:(NSInteger)index{
    PSMineSetModel *setModel = [self getMineSetModelAtIndex:index];
    
    return setModel.imageUrl;
}
-(BOOL)ps_getIsShowTableCellRightArrowIndex:(NSInteger)index{
    
    PSMineSetModel *setModel = [self getMineSetModelAtIndex:index];
    if (setModel.mineCellType == PSMineCellTypeStationReserves||setModel.mineCellType == PSMineCellTypeStationInvite) {
        return NO;
    }else{
        return YES;
    }
}


-(void)requestOutLoginComplete:(completeBlock)complete{
    
    [UserInfoProfile.shareUserInfo clearAll];
    
    complete(YES);
    //
}


-(void)requestUPloadImageComplete:(completeBlock)complete{
    
    
    PSGetCheckImageRequest *getImage = [PSGetCheckImageRequest new];
    [getImage postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            NSArray *data = response.result[@"verify_pic_urls"];
            NSDictionary *dict = data.lastObject;
            self.file_url = dict[@"file_url"];
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

@end
