//
//  UIView+BaseCategory.m
//  FireStore
//
//  Created by eric on 2019/8/29.
//  Copyright © 2019 eric. All rights reserved.
//

#import "UIView+BaseCategory.h"
#import <objc/runtime.h>


@implementation UIView (BaseCategory)


#pragma mark - 取当前view的父控制器
- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 取当前view的导航栏控制器
- (UINavigationController *)navViewController{
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
    }
    return nil;
}


-(void)setZy_shadowLayer:(CALayer *)zy_shadowLayer{
    objc_setAssociatedObject(self, @selector(zy_shadowLayer), zy_shadowLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CALayer *)zy_shadowLayer{
    return  objc_getAssociatedObject(self, @selector(zy_shadowLayer));
}

-(void)setZy_gradientLayer:(CALayer *)zy_gradientLayer{
    objc_setAssociatedObject(self, @selector(zy_gradientLayer), zy_gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CALayer *)zy_gradientLayer{
    return  objc_getAssociatedObject(self, @selector(zy_shadowLayer));
}



-(void)zy_setShadowColor:(UIColor *)shadowColor
            shadowOffset:(CGSize)shadowOffset
            shadowRadius:(CGFloat)shadowRadius
           shadowOpacity:(CGFloat)shadowOpacity {
    
    [self.superview layoutIfNeeded];
    CALayer *subLayer=[CALayer layer];
    CGRect fixframe = self.frame;
    subLayer.frame= fixframe;
    subLayer.cornerRadius=5;
    subLayer.backgroundColor=[UIColor whiteColor].CGColor;
    subLayer.masksToBounds=NO;
    subLayer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = shadowOffset;//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    subLayer.shadowOpacity = shadowOpacity;//阴影透明度，默认0
    subLayer.shadowRadius = shadowRadius;//阴影半径，默认3
    subLayer.shouldRasterize = YES;
    subLayer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    CALayer *oldLayer = self.zy_shadowLayer;
    if (oldLayer) {
        [self.superview.layer replaceSublayer:self.zy_shadowLayer with:subLayer];
    }else{
        [self.superview.layer insertSublayer:subLayer below:self.layer];
    }
    self.zy_shadowLayer = subLayer;
}

-(void)zy_adRectCorner:(UIRectCorner)rectCorner
           cornerRadii:(CGSize)cornerRadii{
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    self.layer.masksToBounds = YES;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    //    self.view_shadow.contentMode  = UIViewContentModeScaleAspectFill;
}
-(void)zy_cornerRaidus:(CGFloat)radius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)zy_borderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)color{
    
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}

-(void)zy_addGradientLayerStartPoint:(CGPoint)startPoint
                            endPoint:(CGPoint)endPoint
                          startColor:(UIColor *)startColor
                            endColor:(UIColor *)endColor
                        cornerRadius:(CGFloat)cornerRadius{
    
    [self.superview layoutIfNeeded];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,  (__bridge id)endColor.CGColor];//这里颜色渐变
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.frame;
    gradientLayer.cornerRadius = cornerRadius;
    CALayer *oldLayer = self.zy_gradientLayer;
    if (oldLayer) {
        [self.superview.layer replaceSublayer:self.zy_gradientLayer with:gradientLayer];
    }else{
        [self.superview.layer insertSublayer:gradientLayer below:self.layer];
    }
}


#pragma mark - Ovrride methods
+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(hitTest:withEvent:));
    Method swizzleMethod = class_getInstanceMethod([self class], @selector(bm_hitTest:withEvent:));
    
    BOOL didAddMethod = class_addMethod([self class], @selector(bm_hitTest:withEvent:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    if (didAddMethod) {
        class_replaceMethod([self class], @selector(hitTest:withEvent:), method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

- (UIView *)bm_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [self bm_hitTest: point withEvent: event];
    if (self.extendRegionType == ClickExtendRegion) {
        if (!hitView) {
            for (UIView *subView in self.subviews) {
                CGPoint newPoint = [subView convertPoint: point fromView: self];
                if (CGRectContainsPoint(subView.bounds, newPoint)) {
                    hitView = subView;
                }
            }
        }
    }
    if (IOS_VERSION_11_OR_LATER) {
        if (!hitView && [NSStringFromClass([self class]) isEqualToString: @"_UITAMICAdaptorView"]) {
            for (UIView *subview in self.subviews) {
                if (subview.subviews > 0) {
                    for (UIView *item in subview.subviews) {
                        CGPoint newPoint = [item convertPoint: point fromView: self];
                        if (CGRectContainsPoint(item.bounds, newPoint)) {
                            hitView = item;
                        }
                    }
                }
            }
        }
    }
    return hitView;
}

#pragma mark - Custome methods
- (ExtendRegionType)extendRegionType {
    return [objc_getAssociatedObject([self class], @selector(extendRegionType)) unsignedIntegerValue];
}

- (void)setExtendRegionType:(ExtendRegionType)extendRegionType {
    objc_setAssociatedObject([self class], @selector(extendRegionType), @(extendRegionType), OBJC_ASSOCIATION_ASSIGN);
}




@end
