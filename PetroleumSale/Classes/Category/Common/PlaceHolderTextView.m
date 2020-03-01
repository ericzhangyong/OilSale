//
//  PlaceHolderTextView.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/26.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "PlaceHolderTextView.h"

@interface PlaceHolderTextView ()


//**
//*  UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
//*/
//@property (nonatomic, weak) UITextView *placeholderView;

/**
 *  文字高度
 */
@property (nonatomic, assign) NSInteger textH;

/**
 *  文字最大高度
 */
@property (nonatomic, assign) NSInteger maxTextH;


@end
@implementation PlaceHolderTextView

- (void)textValueDidChanged:(CM_textHeightChangedBlock)block{
    
    _textChangedBlock = block;
    
}
//- (UITextView *)placeholderView
//{
//    if (!_placeholderView ) {
//        UITextView *placeholderView = [[UITextView alloc] initWithFrame:self.bounds];
//        _placeholderView = placeholderView;
//        //防止textView输入时跳动问题
//        _placeholderView.scrollEnabled = NO;
//        _placeholderView.showsHorizontalScrollIndicator = NO;
//        _placeholderView.showsVerticalScrollIndicator = NO;
//        _placeholderView.userInteractionEnabled = NO;
//        _placeholderView.font =  self.font;
//        _placeholderView.textColor = [UIColor lightGrayColor];
//        _placeholderView.backgroundColor = [UIColor clearColor];
//        [self addSubview:placeholderView];
//    }
//    return _placeholderView;
//}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    _maxNumberOfLines = maxNumberOfLines;
    
    /**
     *  根据最大的行数计算textView的最大高度
     *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
}

- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

///**
// *  通过设置placeholder设置私有属性placeholderView中的textColor
// */
//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    _placeholderColor = placeholderColor;
//
////    self.placeholderView.textColor = placeholderColor;
//}
///**
// *  通过设置placeholder设置私有属性placeholderView中的textColor
// */
//- (void)setPlaceholder:(NSString *)placeholder
//{
//    _placeholder = placeholder;
//
////    self.placeholderView.text = placeholder;
//}
/**
 *  通过设置_placeholderFont设置私有属性placeholderView中的Font
 */
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    
    _placeholderFont = placeholderFont;
    
    //    self.placeholderView.font = placeholderFont;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    //self.layer.borderWidth = 1;
    //self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //实时监听textView值得改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    //self.textContainerInset = UIEdgeInsetsZero;
}

- (void)textDidChange
{
    // 根据文字内容决定placeholderView是否隐藏
    //    self.placeholderView.hidden = self.text.length > 0;
    
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (_textH != height) { // 高度不一样，就改变了高度
        
        // 当高度大于最大高度时，需要滚动
        self.scrollEnabled = height > _maxTextH && _maxTextH > 0;
        
        _textH = height;
        
        //当不可以滚动（即 <= 最大高度）时，传值改变textView高度
        if (_textChangedBlock && self.scrollEnabled == NO) {
            _textChangedBlock(self.text,height);
            
            [self.superview layoutIfNeeded];
            //            self.placeholderView.frame = self.bounds;
            
        }
    }
    if (_textChangedBlock) {
       _textChangedBlock(self.text,height);
    }
    [self setNeedsDisplay];
    
}
//重写
-(void)setPlaceholder:(NSString *)placeholder
{
    //如果是copy类型的 要用[placeholder copy]
    _placeholder=[placeholder copy];
    
    //循环消息  在下一消息循环重绘
    [self setNeedsDisplay];
    
}


-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor=placeholderColor;
    
    [self setNeedsDisplay];
}

//重写设置字体  为了时时响应用户的事件
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    //重绘
    [self setNeedsDisplay];
}
//重写设置文字的 为了使这个控件能时时响应用户的时间 监听用户的时间
//单纯的用通知是无法监听到系统代码产生的事件的
-(void)setText:(NSString *)text
{
    [super setText:text];
    //重绘
    [self setNeedsDisplay];
}

#pragma mark-画图
-(void)drawRect:(CGRect)rect
{
    //判断是否有文字
    if (self.hasText) {
        return;
    }
    
    //设置placeholder的位置和内容颜色字体大小
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    //attrs[NSFontAttributeName]=self.font;
    attrs[NSForegroundColorAttributeName]=self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    attrs[NSFontAttributeName] = self.placeholderFont;
    
    
    //在某个点上画图
    //    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    //在矩形范围内画图
    [self.placeholder drawInRect:CGRectMake(8, 8, self.bounds.size.width-8*2, self.bounds.size.height-8*2) withAttributes:attrs];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
