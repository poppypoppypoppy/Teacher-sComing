//
//  billModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "billModel.h"

@implementation billModel
-(instancetype)initWithTime:(NSString *)time money:(NSString *)money detail:(NSString *)detail{
    if (self = [super init]) {
        self.time = time;
        self.money = money;
        self.detail = detail;
    }
    return self;
}
+(instancetype)billWithTime:(NSString *)time money:(NSString *)money detail:(NSString *)detail{
    return [[billModel alloc]initWithTime:time money:money detail:detail];
}
@end
