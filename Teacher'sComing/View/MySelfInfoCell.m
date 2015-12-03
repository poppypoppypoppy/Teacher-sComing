//
//  MySelfInfoCell.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/12.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "MySelfInfoCell.h"

@implementation MySelfInfoCell
- (UILabel *)lbName {
    if(_lbName == nil) {
        _lbName = [[UILabel alloc] init];
        [self.contentView addSubview:_lbName];
        [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.size.width.mas_equalTo(100);
        }];
    }
    return _lbName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
