//
//  billCell.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "billCell.h"
@interface billCell ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *money;


@end

@implementation billCell
- (void)setMessage:(billModel *)message {
    _message = message;


    self.time.text = self.message.time;
    self.detail.text = self.message.detail;
    self.money.text = self.message.money;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
