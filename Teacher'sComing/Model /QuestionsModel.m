//
//  QuestionsModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/13.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "QuestionsModel.h"

@implementation QuestionsModel
-(instancetype)initWithQuestions:(NSString *)questions note:(NSString *)note time:(NSString *)time detail:(NSString *)detail questionsID:(NSString *)questionsID{
    if (self = [super init]) {
        self.questions = questions;
        self.note = questions;
        self.time = time;
        self.detail = detail;
        self.questionsID = questionsID;
    }
    return self;
}

+(instancetype)questionsWithQuestions:(NSString *)questions note:(NSString *)note time:(NSString *)time detail:(NSString *)detail questionsID:(NSString *)questionsID{
    return [[QuestionsModel alloc]initWithQuestions:questions note:note time:time detail:detail questionsID:questionsID];
}
@end
