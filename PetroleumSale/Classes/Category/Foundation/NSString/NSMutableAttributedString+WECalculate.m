//
//  NSMutableAttributedString+WECalculate.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/17.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "NSMutableAttributedString+WECalculate.h"

@implementation NSMutableAttributedString (WECalculate)

-(CGFloat)we_getHeightWithWidth:(CGFloat)width{
    
    NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:option context:nil];
    return rect.size.height;
}
@end
