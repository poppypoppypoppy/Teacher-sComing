//
//  QuestionsCell.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/13.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsModel.h"

@interface QuestionsCell : UITableViewCell

@property(nonatomic,strong)QuestionsModel *question;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end
