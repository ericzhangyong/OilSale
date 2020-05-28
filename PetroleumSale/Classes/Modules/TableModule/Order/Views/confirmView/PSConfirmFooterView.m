//
//  PSConfirmFooterView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSConfirmFooterView.h"
#import "UIButton+EnlargeArea.h"


@interface PSConfirmFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *btn_accountBalance;
@property (weak, nonatomic) IBOutlet UIButton *btn_accountOidCard;
@property (weak, nonatomic) IBOutlet UIButton *btn_cash;
@property (weak, nonatomic) IBOutlet UIButton *btn_selectAgree;

@end
@implementation PSConfirmFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = color_lightDart_f3f3f3;
    self.conrol_accountBalance.selected = YES;
    self.btn_accountBalance.selected = YES;
    
    
    [self.btn_selectAgree setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    
    [self.btn_accountBalance addTarget:self action:@selector(actionAccountBalance:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_accountOidCard addTarget:self action:@selector(actionAccountOidCard:) forControlEvents:UIControlEventTouchUpInside];

}

- (IBAction)actionSelectWareHouse:(UIControl *)sender {
    if (self.didClick) {
        self.didClick(FooterClickTypeSelectWareHouse);
    }
}

- (IBAction)actionAgress:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.didClick) {
        self.didClick(FooterClickTypeAggreeBtn);
    }
}

- (IBAction)actionLookAgreement:(UIButton *)sender {
    if (self.didClick) {
        self.didClick(FooterClickTypeAggressment);
    }
}

- (IBAction)actionConfirm:(UIButton *)sender {
    if (self.didClick) {
        self.didClick(FooterClickTypeConfirm);
    }
}

- (IBAction)actionAccountBalance:(UIControl *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
        self.btn_accountBalance.selected = sender.selected;
        self.control_accountOidCardd.selected = NO;
        self.btn_accountOidCard.selected = NO;
        self.control_cash.selected = NO;
        self.btn_cash.selected = NO;
        if (self.didClick) {
            self.didClick(FooterClickTypeAccountBalance);
        }
    }
}

- (IBAction)actionAccountOidCard:(UIControl *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
        self.btn_accountOidCard.selected = sender.selected;

        self.conrol_accountBalance.selected = NO;
        self.btn_accountBalance.selected = NO;
        self.control_cash.selected = NO;
        self.btn_cash.selected = NO;
        if (self.didClick) {
            self.didClick(FooterClickTypeAccountOilCard);
        }
    }
    
}
- (IBAction)actionCash:(UIControl *)sender {
    
    if (sender.selected == NO) {
        sender.selected = YES;
        self.btn_cash.selected = sender.selected;
        self.conrol_accountBalance.selected = NO;
        self.btn_accountBalance.selected = NO;
        self.control_accountOidCardd.selected = NO;
        self.btn_accountOidCard.selected = NO;
        if (self.didClick) {
            self.didClick(FooterClickTypeAccountOilCard);
        }
    }
    
}



@end
