//
//  PSWarehourseEditVC.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/25.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSKeeperWareHourseAddModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PSKeeperWareHouseType){
    PSKeeperWareHouseTypeNew,
    PSKeeperWareHouseTypeEdit
};

@interface PSWarehourseEditVC : UIViewController

-(instancetype)initWithSto_id:(NSString *)sto_id;
@property (nonatomic,strong) PSKeeperWareHourseAddModel *model;
@property (nonatomic,copy) NSArray *regionList;



@end

NS_ASSUME_NONNULL_END
