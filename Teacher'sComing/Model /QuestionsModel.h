//
//  QuestionsModel.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/13.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionsModel : NSObject

@property(nonatomic,strong)NSString *questions;
@property(nonatomic,strong)NSString *note;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *questionsID;

-(instancetype)initWithQuestions:(NSString *)questions note:(NSString *)note time:(NSString *)time detail:(NSString *)detail questionsID:(NSString *)questionsID;
+(instancetype)questionsWithQuestions:(NSString *)questions note:(NSString *)note time:(NSString *)time detail:(NSString *)detail questionsID:(NSString *)questionsID;


@end
