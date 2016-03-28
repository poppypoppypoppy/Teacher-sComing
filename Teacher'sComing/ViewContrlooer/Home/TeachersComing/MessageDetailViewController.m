//
//  MessageDetailViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/13.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "UserDetailTableViewController.h"

@interface MessageDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *maintitle;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *publisher;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maintitle.text = self.message.title;
    self.time.text = self.message.time;
    self.money.text = self.message.money;
    self.detail.text = self.message.detail;
    [self.publisher setTitle:self.message.user.userName forState:UIControlStateNormal];
    [self.publisher addTarget:self action:@selector(gotoUserMessage) forControlEvents:UIControlEventTouchUpInside];

}
-(void)gotoUserMessage{
    UserDetailTableViewController *detailvc = kVCFromSb(@"UserDetailTableViewController", @"Main");
    //将选中的hero对象交给detailvc来显示
    detailvc.user = self.message.user;
    [self.navigationController pushViewController:detailvc animated:YES];
}

@end
