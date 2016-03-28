//
//  TeacherComingModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/2.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TeacherComingModel.h"

@implementation TeacherComingModel
-(instancetype)initWithIconIM:(UIImage *)image time:(NSString *)time title:(NSString *)title money:(NSString *)money detail:(NSString *)detail address:(NSString *)address user:(UserInfoModel *)user createtime:(NSString *)createtime{
    if (self = [super init]) {
        self.iconIM = image;
        self.time = time;
        self.title = title;
        self.detail = detail;
        self.money = money;
        self.address = address;
        self.user = user;
        self.createtime = createtime;
    }
    return self;
}
+(instancetype)teacherWithIconIM:(UIImage *)image time:(NSString *)time title:(NSString *)title money:(NSString *)money detail:(NSString *)detail address:(NSString *)address user:(UserInfoModel *)user createtime:(NSString *)createtime{
    return [[TeacherComingModel alloc]initWithIconIM:image time:time title:title money:money detail:detail address:address user:user createtime:createtime];
    
}

//便于NSLog打印输出
-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@",_title,_time];
}


@end
