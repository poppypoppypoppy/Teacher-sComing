//
//  TripCell.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TripCell.h"
@interface TripCell ()
@property (weak, nonatomic) IBOutlet UILabel *tripDetailLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;

@end

@implementation TripCell
- (void)setMessage:(tripModel *)message {
    _message = message;
 
    self.iconIV.image = self.message.iconIV;
    
    self.timeLB.text = self.message.time;
    
    self.tripDetailLB.text = self.message.trip;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
