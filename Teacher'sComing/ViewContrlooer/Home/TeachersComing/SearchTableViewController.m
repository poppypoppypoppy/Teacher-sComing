//
//  SearchTableViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/29.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "SearchTableViewController.h"
//#import "ShowCell.h"
#import "TeacherComingModel.h"
#import "MessageDetailViewController.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"result";
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba21"]]];

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

//        cell.detailTextLabel.text = @"dsd";
//        cell.backgroundColor = [UIColor yellowColor];
//        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba21"]]];
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
}
@end
