//
//  AnswersCell.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/22.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "AnswersCell.h"

@implementation AnswersCell

-(void)setAnswers:(AnswersModel *)answers{
    _answers = answers;
    
    self.answer.text = self.answers.answer;
    self.time.text = self.answers.time;
    
}
@end
