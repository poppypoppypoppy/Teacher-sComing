//
//  ShowCell.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/19.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "ShowCell.h"
@interface ShowCell ()
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;


@end

@implementation ShowCell


- (void)setMessage:(TeacherComingModel *)message {
    _message = message;

    [self.iconBtn setImage:self.message.iconIM forState:0];
    
    self.titleLB.text = self.message.title;
    
    self.timeLB.text = self.message.time;
    
    self.addressLB.text = self.message.address;
    
    self.moneyLB.text = self.message.money;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
