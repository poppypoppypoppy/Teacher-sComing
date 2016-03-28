//
//  UserDetailInfoModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/2.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
-(instancetype)initWithIconName:(NSString *)iconName userName:(NSString *)userName userPwd:(NSString *)userPwd sex:(NSString *)sex identity:(NSString *)identity workingPlace:(NSString *)workingPlace address:(NSString *)address phoneNumber:(NSString *)phoneNumber note:(NSString *)note{
    if (self = [super init]) {
        self.iconName = iconName;
        self.userName = userName;
        self.userPwd = userPwd;
        self.sex = sex;
        self.identity = identity;
        self.workingPlace = workingPlace;
        self.address = address;
        self.phoneNumber = phoneNumber;
        self.note = note;
    }
    return self;
}

+(instancetype)userWithIconName:(NSString *)iconName userName:(NSString *)userName userPwd:(NSString *)userPwd sex:(NSString *)sex identity:(NSString *)identity workingPlace:(NSString *)workingPlace address:(NSString *)address phoneNumber:(NSString *)phoneNumber note:(NSString *)note{
    return [[UserInfoModel alloc]initWithIconName:iconName userName:userName userPwd:userPwd sex:sex identity:identity workingPlace:workingPlace address:address phoneNumber:phoneNumber note:note];
    
}

//便于NSLog打印输出
-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@",_userName,_note];
}


@end
