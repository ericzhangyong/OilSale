//
//  WEWeakTimer.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^WETimerHandler)(_Nullable id userInfo);


@interface BaseWeakTimer : NSObject

+ ( NSTimer * _Nonnull ) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                                 target:(_Nonnull id)aTarget
                                               selector:(_Nonnull SEL)aSelector
                                               userInfo:(_Nullable id)userInfo
                                                repeats:(BOOL)yesOrNo;

+ (NSTimer * _Nonnull) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                                block:(_Nonnull WETimerHandler)block
                                             userInfo:(nullable id)userInfo
                                              repeats:(BOOL)yesOrNo;
@end

NS_ASSUME_NONNULL_END
