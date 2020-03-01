//
//  BaseView.h
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/20.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BaseViewDelegate <NSObject>

-(void)initBaseSubViews;

@end

@interface BaseView : UIView<BaseViewDelegate>


+(instancetype)initViewWithFrame:(CGRect)frame;

+(instancetype)initNibView;

@end

NS_ASSUME_NONNULL_END
