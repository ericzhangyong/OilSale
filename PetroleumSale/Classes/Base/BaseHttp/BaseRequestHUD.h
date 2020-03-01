//
//  BaseRequestHUD.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/23.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequestHUD : NSObject

+ (instancetype)sharedRequestHUD;


-(void)clearAllHUD;

-(void)showRequestBusying;
-(void)hideRequestBusying;

-(void)showTipView:(UIView*)view;
-(void)hideTipView;
@end

NS_ASSUME_NONNULL_END
