//
//  billModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "billModel.h"

@implementation billModel
-(instancetype)initWithIconIV:(UIImage *)imageIV time:(NSString *)time money:(NSString *)money detail:(NSString *)detail{
    if (self = [super init]) {
        self.iconIV = imageIV;
        self.time = time;
        self.money = money;
        self.detail = detail;
    }
    return self;
}
+(instancetype)billWithIconIV:(UIImage *)imageIV time:(NSString *)time money:(NSString *)money detail:(NSString *)detail{
    return [[billModel alloc]initWithIconIV:imageIV time:time money:money detail:detail];
}
@end
