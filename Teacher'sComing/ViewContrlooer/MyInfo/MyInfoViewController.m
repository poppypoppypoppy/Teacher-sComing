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
@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 7;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicInfo = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
            cell.titleLb.text = @"头像";
            
            NSURL *imageURL = [NSURL URLWithString:dicInfo[@"icon"]];
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:data];
            
            cell.iconIM.image = image;
            return cell;
        }else if (indexPath.row == 1){
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
            return cell;
            
        }
        
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
        return 90;
    }else{
        return 50;
    }
}

//去除高亮效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0&&indexPath.row == 1) {
        NSLog(@"修改用户名");
    }else if (indexPath.section == 0&&indexPath.row == 2){
        NSLog(@"修改密码");
    }else if (indexPath.section == 1&&indexPath.row == 6){
        NSLog(@"退出");
    }else{
        NSLog(@"修改个人信息");
//        [self.navigationController pushViewController:kVCFromSb(@"TCInfoViewController", @"Main") animated:YES];
//        [self presentViewController:kVCFromSb(@"TCInfoViewController", @"Main") animated:YES completion:nil];
    }
}

@end
