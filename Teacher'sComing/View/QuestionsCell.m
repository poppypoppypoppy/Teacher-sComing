//
//  QuestionsCell.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/13.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "QuestionsCell.h"

@implementation QuestionsCell

-(void)setQuestion:(QuestionsModel *)question{
    _question = question;
    
    self.imageview.image = [UIImage imageNamed:@"questions"];
    self.questionLabel.text = self.question.questions;
    self.time.text = self.question.time;
}

@end
