//
//  AnswersModel.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/22.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "AnswersModel.h"

@implementation AnswersModel

-(instancetype)initWithAnswer:(NSString *)answer time:(NSString *)time{
    if (self = [super init]) {
        self.answer = answer;
        self.time = time;
    }
    return self;
}
+(instancetype)answerWithAnswer:(NSString *)answer time:(NSString *)time{
    return [[AnswersModel alloc]initWithAnswer:answer time:time];
}

@end
