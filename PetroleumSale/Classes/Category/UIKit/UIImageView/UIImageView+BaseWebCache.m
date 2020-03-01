//
//  UIImageView+FSWebCache.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "UIImageView+BaseWebCache.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (BaseWebCache)

-(void)setImageWithUrl:(id)urlStr placeholder:(UIImage *)placeholder{
    
    NSURL *url;
    if ([urlStr isKindOfClass:[NSURL class]]) {
        url = urlStr;
    }else{
        if (![urlStr isKindOfClass:[NSString class]]) {
            self.image = placeholder;
            return;
        }else{
            url = [NSURL URLWithString:urlStr];
        }
    }
    
    //NSString *urlStr = [self getUTF_8EnCodeWithString:url];
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}

-(void)setImageWithUrl:(id)urlStr placeholder:(UIImage *)placeholder completeBlock:(void (^)(UIImage * nullable, BOOL))completeBlock{
    NSURL *url;
    if ([urlStr isKindOfClass:[NSURL class]]) {
        url = urlStr;
    }else{
        if (![urlStr isKindOfClass:[NSString class]]) {
            self.image = placeholder;
            return;
        }else{
            url = [NSURL URLWithString:urlStr];
        }
    }
    
    if (!urlStr) {
        if(completeBlock) {
            completeBlock(nil, YES);
        }
        return;
    }
    //NSString *url = [self getUTF_8EnCodeWithString:urlStr];
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        completeBlock(image,YES);
    }];
}

-(NSString *)getUTF_8EnCodeWithString:(NSString *)string{
    
    NSCharacterSet *charSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    //"#%<>[\]^`{|}
    NSString *newString = [string stringByAddingPercentEncodingWithAllowedCharacters:charSet];
    if (newString) {
        return newString;
    }
    return string;
    //    NSCharacterSet *set = [NSCharacterSet URLPathAllowedCharacterSet];
    //    string = [string stringByAddingPercentEncodingWithAllowedCharacters:set];
    //    return string;
}




-(void)drawDottedLine{
    
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    //设置虚线颜色为blackColorf
    [dotteShapeLayer setStrokeColor:[UIColor colorWithHexString:@"EEEEEE"].CGColor];
    //设置虚线宽度
    dotteShapeLayer.lineWidth = 1.0f ;
    //10=线的宽度 5=每条线的间距
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithInt:2], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, 0 ,0);
    CGPathAddLineToPoint(dotteShapePath, NULL, self.frame.size.width, 0);
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    //把绘制好的虚线添加上来
    //    [imageView.layer ];
    [self.layer addSublayer:dotteShapeLayer];
}
@end
