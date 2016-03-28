//
//  AnswersModel.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/22.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswersModel : NSObject

@property(nonatomic,strong)NSString *answer;
@property(nonatomic,strong)NSString *time;

-(instancetype)initWithAnswer:(NSString *)answer time:(NSString *)time;
+(instancetype)answerWithAnswer:(NSString *)answer time:(NSString *)time;

@end
