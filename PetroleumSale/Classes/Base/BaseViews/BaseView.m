//
//  BaseView.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/20.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView



+(instancetype)initViewWithFrame:(CGRect)frame{

    BaseView *baseView = [[self alloc] initWithFrame:frame];
    return baseView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initBaseSubViews];
    }
    return self;
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self initBaseSubViews];
//    }
//    return self;
//}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initBaseSubViews];

}

+(instancetype)initNibView{
    
    BaseView *baseView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;

    return baseView;
}

-(void)initBaseSubViews{
    
}
@end
