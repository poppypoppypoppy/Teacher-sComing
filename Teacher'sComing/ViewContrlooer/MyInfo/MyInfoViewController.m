//
//  MyInfoViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/5.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "MyInfoViewController.h"
#import "HeaderCell.h"
#import "DetailCell.h"
#import "ExitCell.h"
#import "TCInfoViewController.h"
#import "TCLoginViewController.h"

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MyInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
 [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba20"]]];
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 7;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicInfo = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"用户名";
            cell.detailLb.text = dicInfo[@"name"];
            return cell;
        }else{
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"密码";
            cell.detailLb.text = dicInfo[@"pwd"];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"性别";
            cell.detailLb.text = dicInfo[@"sex"];
            return cell;
        }else if (indexPath.row == 1){
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"身份";
            cell.detailLb.text = dicInfo[@"identity"];
            return cell;
        }else if (indexPath.row == 2){
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"地址";
            cell.detailLb.text = [dicInfo[@"addressCity"] stringByAppendingString:dicInfo[@"addressArea"]];
            return cell;
        }else if (indexPath.row == 3){
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"单位";
            cell.detailLb.text = dicInfo[@"workingPlace"];
            return cell;
            
        }else if (indexPath.row == 4){
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"手机";
            cell.detailLb.text = dicInfo[@"phoneNumber"];
            return cell;
        }else if (indexPath.row == 5){
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            cell.titleLb.text = @"备注";
            cell.detailLb.text = dicInfo[@"note"];
            return cell;
        }else{
            ExitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExitCell"];
            [cell.exitBtn setTitle:@"退出" forState:0];
            [cell.exitBtn addTarget:self action:@selector(exitAPP) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }
}
-(void)exitAPP{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"小狮确认" message:@"您要退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alertC animated:YES completion:nil];
    /**
     *为弹出框添加按钮
     */
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"确认按钮被点击");
        TCLoginViewController *loginVC = kVCFromSb(@"TCLoginViewController", @"Main");
        loginVC.userNameTF.text = @"";
        loginVC.userPwdTF.text = @"";
        [self presentViewController:loginVC animated:YES completion:nil];
    }];
    [alertC addAction:cancelAction];
    [alertC addAction:okAction];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 50;
}

//去除高亮效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0&&indexPath.row == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"小狮提醒" message:@"用户名不可修改哦！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:okAction];
    }else if (indexPath.section == 0&&indexPath.row == 1){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"小狮提醒" message:@"密码不可修改哦！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:okAction];

    }else if(indexPath.section == 1 && indexPath.row == 6){
        NSLog(@"退出，但被btn覆盖");
    }else{
        [self.navigationController pushViewController:kVCFromSb(@"TCInfoViewController", @"Main") animated:YES];
    }
}

@end
