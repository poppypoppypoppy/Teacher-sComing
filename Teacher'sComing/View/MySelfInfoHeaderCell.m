//
//  MySelfInfoHeaderCell.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/12.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "MySelfInfoHeaderCell.h"

@implementation MySelfInfoHeaderCell
- (UILabel *)userIconLB {
    if(_userIconLB == nil) {
        _userIconLB = [[UILabel alloc] init];
        //_userIconLB.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_userIconLB];
        [_userIconLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.size.width.mas_equalTo(100);
        }];
    }
    return _userIconLB;
}

- (UIButton *)userIconBtn {
    if(_userIconBtn == nil) {
        _userIconBtn = [UIButton buttonWithType:0];
        //_userIconLB.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_userIconBtn];
        [_userIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
            make.size.width.mas_equalTo(100);
        }];
    }
    return _userIconBtn;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
