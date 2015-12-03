//
//  TeacherComingModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/2.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TeacherComingModel.h"

@implementation TeacherComingModel
-(instancetype)initWithIconIM:(UIImage *)image time:(NSString *)time title:(NSString *)title money:(NSString *)money detail:(NSString *)detail address:(NSString *)address{
    if (self = [super init]) {
        self.iconIM = image;
        self.time = time;
        self.title = title;
        self.detail = detail;
        self.money = money;
        self.address = address;
    }
    return self;
}
+(instancetype)teacherWithIconIM:(UIImage *)image time:(NSString *)time title:(NSString *)title money:(NSString *)money detail:(NSString *)detail address:(NSString *)address{
    return [[TeacherComingModel alloc]initWithIconIM:image time:title title:title money:money detail:detail address:address];
    
}
@end
