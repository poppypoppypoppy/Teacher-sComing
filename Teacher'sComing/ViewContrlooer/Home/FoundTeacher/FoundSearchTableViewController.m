//
//  FoundSearchTableViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/29.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "FoundSearchTableViewController.h"
#import "MessageDetailViewController.h"
#import "TeacherComingModel.h"

@interface FoundSearchTableViewController ()

@end

@implementation FoundSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba21"]]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.tableFooterView = [UIView new];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TeacherComingModel *p = self.resultArray[indexPath.row];
    
    cell.textLabel.text = p.title;

      cell.backgroundColor = [UIColor clearColor];

    
    return cell;
}

//去除高亮效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TeacherComingModel *selectedHero = self.resultArray[indexPath.row];
    MessageDetailViewController *detailvc = kVCFromSb(@"MessageDetailViewController", @"Main");
    //将选中的hero对象交给detailvc来显示
    detailvc.message = selectedHero;
    [self.navigationController pushViewController:detailvc animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}@end
