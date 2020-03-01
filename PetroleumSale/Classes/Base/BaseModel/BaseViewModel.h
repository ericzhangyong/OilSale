//
//  BaseViewModel.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^completeBlock)(BOOL isFinished);

typedef void(^completeDataBlock)(BOOL isFinished,id data);
typedef void(^completeDataArrBlock)(BOOL isFinished,NSArray *dataArr);


@interface BaseViewModel : NSObject<NSCopying>



@property (nonatomic,strong) NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
