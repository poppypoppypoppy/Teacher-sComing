//
//  tripModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "tripModel.h"

@implementation tripModel
-(instancetype)initWithIconIV:(UIImage *)imageIV time:(NSString *)time trip:(NSString *)trip{
    if (self = [super init]) {
        self.iconIV = imageIV;
        self.time = time;
        self.trip = trip;
    }
    return self;
}
+(instancetype)tripWithIconIV:(UIImage *)imageIV time:(NSString *)time trip:(NSString *)trip{
    return [[tripModel alloc]initWithIconIV:imageIV time:time trip:trip];
}
@end
