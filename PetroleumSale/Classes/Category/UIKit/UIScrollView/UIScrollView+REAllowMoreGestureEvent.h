//
//  UIScrollView+REAllowMoreGestureEvent.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/4.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (REAllowMoreGestureEvent)<UIGestureRecognizerDelegate>


/** 是否允许多个触摸时间下传 */
@property (nonatomic,assign) NSNumber *isAllowMoreGestureEvent;

@end

NS_ASSUME_NONNULL_END
