//
//  UserDetailInfoModel.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/2.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property(nonatomic,strong)NSString *iconName;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userPwd;
@property(nonatomic,strong)NSString *sex;
/**身份：在职教师、学生、学生家长、中介、在校大学生、其他（社会工作者）*/
@property(nonatomic,strong)NSString *identity;
@property(nonatomic,strong)NSString *workingPlace;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *phoneNumber;
@property(nonatomic,strong)NSString *note;
/*
 *......
 */
@end
