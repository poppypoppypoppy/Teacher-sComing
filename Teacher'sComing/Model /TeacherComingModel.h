//
//  TeacherComingModel.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/2.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UserInfoModel.h"
@interface TeacherComingModel : NSObject
//@property(nonatomic,strong)UserInfoModel *user;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)UIImage *iconIM;
@property(nonatomic,strong)NSString *address;
-(instancetype)initWithIconIM:(UIImage *)image time:(NSString *)time title:(NSString *)title money:(NSString *)money detail:(NSString *)detail address:(NSString *)address;
+(instancetype)teacherWithIconIM:(UIImage *)image time:(NSString *)time title:(NSString *)title money:(NSString *)money detail:(NSString *)detail address:(NSString *)address;
@end
