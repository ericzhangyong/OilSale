//
//  UIScrollView+REAllowMoreGestureEvent.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/4.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "UIScrollView+REAllowMoreGestureEvent.h"
#import <objc/runtime.h>

@implementation UIScrollView (REAllowMoreGestureEvent)

//-(void)setZy_shadowLayer:(CALayer *)zy_shadowLayer{
//    objc_setAssociatedObject(self, @selector(zy_shadowLayer), zy_shadowLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//-(CALayer *)zy_shadowLayer{
//    return  objc_getAssociatedObject(self, @selector(zy_shadowLayer));
//}

-(NSNumber *)isAllowMoreGestureEvent{
    
   return  objc_getAssociatedObject(self, @selector(isAllowMoreGestureEvent));
}
-(void)setIsAllowMoreGestureEvent:(NSNumber *)isAllowMoreGestureEvent{
    objc_setAssociatedObject(self, @selector(isAllowMoreGestureEvent), isAllowMoreGestureEvent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if (self.isAllowMoreGestureEvent.boolValue) {
        return YES;
    }
    return NO;
}

@end
