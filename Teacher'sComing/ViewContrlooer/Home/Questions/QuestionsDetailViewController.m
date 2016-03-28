//
//  QuestionsDetailViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/21.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "QuestionsDetailViewController.h"
#import "AnswerAddViewController.h"
#import "AnswersModel.h"
#import "AnswersCell.h"

@interface QuestionsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *note;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *messageArray;
@end

@implementation QuestionsDetailViewController

- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
        [self searchMessageInDB];
    }
    return _messageArray;
}

-(void)searchMessageInDB{
    BmobQuery *query = [BmobQuery queryWithClassName:@"answers"];
    //按updatedAt进行降序排列
    [query orderByDescending:@"updatedAt"];
    //返回最多20条数据
    query.limit = 20;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            NSString *objID =  [obj objectForKey:@"questionsID"];
            if ([objID isEqualToString:self.questions.questionsID]) {
                NSString *answerDetail = [obj objectForKey:@"answers"];
                NSString *createdAt = [obj objectForKey:@"createdAt"];
                NSString *time = [createdAt substringToIndex:10];
                AnswersModel *answer = [AnswersModel answerWithAnswer:answerDetail time:time];
                            [_messageArray addObject:answer];
            }
        
        }
        [self.tableView reloadData];
    }];
    
             
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"疑难详情";
    self.question.text = self.questions.questions;
    self.detail.text = self.questions.detail;
    self.note.text = self.questions.note;
    self.time.text = self.questions.time;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"解答" style:UIBarButtonItemStyleDone target:self action:@selector(addAnswers)];
    self.navigationItem.rightBarButtonItem = item1;
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba20"]]];
//    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView = [UIView new];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswersCell"];
    
    cell.answers = [self.messageArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (IBAction)addAnswers{
    AnswerAddViewController *anVC = kVCFromSb(@"AnswerAddViewController", @"Main");
    anVC.questions = self.questions;
    [self.navigationController pushViewController:anVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
@end
