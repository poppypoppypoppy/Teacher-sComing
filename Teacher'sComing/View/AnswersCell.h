//
//  AnswersCell.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/22.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswersModel.h"

@interface AnswersCell : UITableViewCell

@property(nonatomic,strong)AnswersModel *answers;

@property (weak, nonatomic) IBOutlet UILabel *answer;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
