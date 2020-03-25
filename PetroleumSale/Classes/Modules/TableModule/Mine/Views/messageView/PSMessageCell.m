//
//  PSMessageCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMessageCell.h"

@interface PSMessageCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_imageViewDot;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft_label_title;

@end
@implementation PSMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.label_title.textColor = color_lightDart_333333;
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    [self.btn_upDown addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setMessageModel:(PSMessageModel *)messageModel{
    _messageModel = messageModel;
    
    
    self.label_title.text = messageModel.title;
    self.label_content.text = messageModel.content;
    self.label_time.text = messageModel.publish_time;
    
    if (messageModel.read_flag) {
        self.layoutWidth_imageViewDot.constant = 0 ;
        self.layoutLeft_label_title.constant = 0;
    }else{
        self.layoutWidth_imageViewDot.constant = 6 ;
        self.layoutLeft_label_title.constant = 7;
    }
    
    self.btn_upDown.selected = messageModel.isOpened;
}

#pragma mark- click
-(void)btnClick:(UIButton *)button{
    
    if (button.selected == YES) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    if (self.btnUpDownClick) {
        self.btnUpDownClick(button.selected);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
