//
//  PSMineViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSMineSetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSMineViewModel : BaseViewModel

#pragma mark- 数据处理

@property (nonatomic,assign) BOOL isCustomerRole;


/// 审核图片
@property (nonatomic,copy) NSArray *file_url_arr;

-(void)setMineDataSource;

-(NSString *)ps_getHeaderImageIcon;
-(NSString *)ps_getUserNickName;
-(NSString *)ps_getUserPhone;
-(NSMutableAttributedString *)ps_getShouHouString;
-(CGFloat)ps_getCellHeight;

-(CGFloat)ps_getTableCellHeightWithIndex:(NSInteger)index;
-(PSMineCellType)ps_getTableCellCellTypeIndex:(NSInteger)index;
-(NSString *)ps_getTableCellIconUrlIndex:(NSInteger)index;
-(NSString *)ps_getTableCellTitleUrlIndex:(NSInteger)index;
-(NSString *)ps_getTableCellContentUrlIndex:(NSInteger)index;
-(NSString *)ps_getTableCellContentImageUrlIndex:(NSInteger)index;
-(BOOL)ps_getIsShowTableCellRightArrowIndex:(NSInteger)index;


-(void)requestOutLoginComplete:(completeBlock)complete;



-(void)requestUPloadImageComplete:(completeBlock)complete;
@end

NS_ASSUME_NONNULL_END
