//
//  UIView+BaseCategory.h
//  FireStore
//
//  Created by eric on 2019/8/29.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ExtendRegionType) {
    DefaultExtendRegion             =   0,
    ClickExtendRegion               =   1
};

@interface UIView (BaseCategory)




@property (nullable, nonatomic, readonly) UIViewController *viewController;


@property (nullable, nonatomic, readonly) UINavigationController *navViewController;



@property (nonatomic,retain) CALayer *zy_shadowLayer;

@property (nonatomic,retain) CALayer *zy_gradientLayer;


-(void)zy_setShadowColor:(UIColor *)shadowColor
            shadowOffset:(CGSize)shadowOffset
            shadowRadius:(CGFloat)shadowRadius
           shadowOpacity:(CGFloat)shadowOpacity;


//切某角
-(void)zy_adRectCorner:(UIRectCorner)rectCorner
           cornerRadii:(CGSize)cornerRadii;


-(void)zy_cornerRaidus:(CGFloat)radius;
-(void)zy_borderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)color;

//颜色渐变
-(void)zy_addGradientLayerStartPoint:(CGPoint)startPoint
                            endPoint:(CGPoint)endPoint
                          startColor:(UIColor *)startColor
                            endColor:(UIColor *)endColor
                        cornerRadius:(CGFloat)cornerRadius;



@property (nonatomic, assign) ExtendRegionType extendRegionType;

@end

NS_ASSUME_NONNULL_END
