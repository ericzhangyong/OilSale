//
//  PSConfirmFooterView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSConfirmFooterView.h"


@interface PSConfirmFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *btn_accountBalance;
@property (weak, nonatomic) IBOutlet UIButton *btn_accountOidCard;

@end
@implementation PSConfirmFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.conrol_accountBalance.selected = YES;
    self.btn_accountBalance.selected = YES;
    
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
        self.control_accountOidCardd.selected = NO;
        self.btn_accountOidCard.selected = NO;
        self.btn_accountBalance.selected = sender.selected;
        if (self.didClick) {
            self.didClick(FooterClickTypeAccountBalance);
        }
    }
}

- (IBAction)actionAccountOidCard:(UIControl *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
        self.conrol_accountBalance.selected = NO;
        self.btn_accountBalance.selected = NO;
        self.btn_accountOidCard.selected = sender.selected;
        if (self.didClick) {
            self.didClick(FooterClickTypeAccountOilCard);
        }
    }
    
}

@end
