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
@end

@implementation TripCell
- (void)setMessage:(tripModel *)message {
    _message = message;

    
    self.timeLB.text = self.message.time;
    
    self.tripDetailLB.text = self.message.trip;
    
}



@end
