//
//  tripModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "tripModel.h"

@implementation tripModel
-(instancetype)initWithTime:(NSString *)time trip:(NSString *)trip{
    if (self = [super init]) {
        self.time = time;
        self.trip = trip;
    }
    return self;
}
+(instancetype)tripWithTime:(NSString *)time trip:(NSString *)trip{
    return [[tripModel alloc]initWithTime:time trip:trip];
}
@end
