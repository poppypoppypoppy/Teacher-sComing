//
//  QuestionsShowViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/13.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "QuestionsShowViewController.h"
#import "QuestionsCell.h"
#import "QuestionsModel.h"
#import "QuestionsAddViewController.h"
#import "QuestionsDetailViewController.h"

@interface QuestionsShowViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *messageArray;
@end

@implementation QuestionsShowViewController
- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
        [self searchMessageInDB];
    }
    return _messageArray;
}

-(void)searchMessageInDB{
    BmobQuery *query = [BmobQuery queryWithClassName:@"questions"];
    //按updatedAt进行降序排列
    [query orderByDescending:@"updatedAt"];
    //返回最多20条数据
    query.limit = 20;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            NSString *questiontitle = [obj objectForKey:@"questionTitle"];
            NSString *note = [obj objectForKey:@"note"];
            NSString *questionDetail = [obj objectForKey:@"questionDetail"];
            NSString *createdAt = [obj objectForKey:@"createdAt"];
            NSString *time = [createdAt substringToIndex:10];

            NSString *questionsID = [obj objectId];
            QuestionsModel *question = [QuestionsModel questionsWithQuestions:questiontitle note:note time:time detail:questionDetail questionsID:questionsID];
            
            [_messageArray addObject:question];
            
        }
            [self.tableView reloadData];
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"疑难";
    
     [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba20"]]];
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(281, 7, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    self.tableView.tableFooterView = [UIView new];
}

-(void)add{
    QuestionsAddViewController *addVC = kVCFromSb(@"QuestionsAddViewController", @"Main");
//    addVC.delegate = self;
    
    [self.navigationController pushViewController:addVC animated:YES];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionsCell"];
    
    cell.question = [self.messageArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//去除高亮效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuestionsModel *selectedQuestion = self.messageArray[indexPath.row];
    QuestionsDetailViewController *detailVC = kVCFromSb(@"QuestionsDetailViewController", @"Main");
    detailVC.questions = selectedQuestion;
   [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -- delegate
-(void)QuestionsAddUpdate:(QuestionsAddViewController *)addvc{
    self.messageArray = nil;
    [self.tableView reloadData];
}


@end
