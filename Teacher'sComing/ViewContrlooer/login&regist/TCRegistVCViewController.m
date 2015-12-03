//
//  TCRegistVCViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/10/31.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TCRegistVCViewController.h"
#import "TCLoginViewController.h"

@interface TCRegistVCViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *checkPwdTF;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLB;
@property (weak, nonatomic) IBOutlet UILabel *pwdLB;
@property (weak, nonatomic) IBOutlet UILabel *checkPwdLB;
@property (weak, nonatomic) IBOutlet UIButton *secretBtn;
@property(nonatomic,strong)BmobObject *usersInfo;
//用来计算点击次数，显示影藏密码按钮
@property(nonatomic,assign)NSInteger count;
@end
@implementation TCRegistVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GlassView glassView:self.imageView rectX:0 rectY:0 rectW:self.imageView.frame.size.width rectH:self.imageView.frame.size.height];
    self.count = 0;
    
}

//显示密码&隐藏密码
- (IBAction)secrete:(id)sender {
    //当光标点在一个TF里时，点击按钮使他们放弃第一响应者身份
    [self.usernameTF  resignFirstResponder];
    [self.pwdTF resignFirstResponder];
    [self.checkPwdTF resignFirstResponder];
    
    self.count ++;
    if (self.count % 2 == 0) {
        self.pwdTF.secureTextEntry = YES;
        self.checkPwdTF.secureTextEntry = YES;
        [self.secretBtn setTitle:@"显示密码" forState:0];
    }else{
        self.pwdTF.secureTextEntry = NO;
        self.checkPwdTF.secureTextEntry = NO;
        [self.secretBtn setTitle:@"隐藏密码" forState:0];
    }
    
}

//注册
- (IBAction)registButton:(id)sender {
    /**先取消第一响应者身份，防止点击注册按钮时，第一次点击无效*/
    [self.usernameTF  resignFirstResponder];
    [self.pwdTF resignFirstResponder];
    [self.checkPwdTF resignFirstResponder];
    
    if ([self.usernameLB.text isEqualToString:@"OK"]&&[self.pwdLB.text isEqualToString:@"OK"]&&[self.checkPwdLB.text isEqualToString:@"OK"]) {
        [self.usersInfo setObject:self.usernameTF.text forKey:@"userName"];
        [self.usersInfo setObject:self.pwdTF.text forKey:@"userPwd"];
        
        [self.usersInfo setObject:@" " forKey:@"addressCity"];
        [self.usersInfo setObject:@" " forKey:@"addressArea"];
        [self.usersInfo setObject:@" " forKey:@"workingPlace"];
        [self.usersInfo setObject:@" " forKey:@"phoneNumber"];
        [self.usersInfo setObject:@" " forKey:@"note"];
        [self.usersInfo setObject:@" " forKey:@"icon"];
        [self.usersInfo setObject:@" " forKey:@"sex"];
        [self.usersInfo setObject:@" " forKey:@"identity"];
        [self.usersInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }else{
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"编辑个人信息" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alertC animated:YES completion:nil];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                [alertC addAction:sureAction];
            }
        }];
        
    }else{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"返回注册页面" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //            [self dismissViewControllerAnimated:YES completion:nil];
            //            return;
        }];
        [alertC addAction:sureAction];
        NSLog(@"%@,%@,%@",self.usernameLB.text,self.pwdLB.text,self.checkPwdLB.text);
    }
}
- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


  /**检查用户名合法性*/
- (IBAction)usernameKeyboard:(id)sender {
    [self checkName];
}

//检查密码合法性
- (IBAction)userpwdKeyboard:(id)sender {
    [self checkPWD];
}

//检查两次密码输入
- (IBAction)userpwdCheck:(id)sender {
    [self checkPWDCheck];
}

//检验用户名
-(void)checkName{
    self.usernameLB.textColor = [UIColor redColor];
    if (self.usernameTF.text.length == 0) {
        NSLog(@"用户名不能为空");
    }
    if (self.usernameTF.text.length <= 20&&self.usernameTF.text.length >= 1) {
        /*
         *查询名字是否重复
         */
        BmobQuery *checkName = [BmobQuery queryWithClassName:@"userInfo"];
        [checkName findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                if ([self.usernameTF.text isEqualToString:[obj objectForKey:@"userName"]]) {
                    self.usernameLB.textColor = [UIColor redColor];
                    self.usernameLB.text = @"该用户已存在";
                }else{//数据库中无重复用户名，验证格式
                    NSString *str =@"^[A-Z0-9a-z]+$";
                    NSPredicate *check = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",str];
                    int x = [check evaluateWithObject:self.usernameTF.text];
                    if (x == 1) {
                        self.usernameLB.textColor = [UIColor greenColor];
                        self.usernameLB.text = @"OK";
                    }else{
                        self.usernameLB.text = @"该用户名格式不正确";
                    }
                    
                }
            }
        }];
    }
    if(self.usernameTF.text.length > 20){
        self.usernameLB.text = @"该用户名过长";
    }

}

//检验密码
-(void)checkPWD{
    self.pwdLB.textColor = [UIColor redColor];
    if (self.pwdTF.text.length == 0) {
        self.pwdLB.text = @"请输入密码";
    }
    else if (self.pwdTF.text.length > 0&&self.pwdTF.text.length < 6) {
        self.pwdLB.text = @"该密码太短";
    }

    else if (self.pwdTF.text.length <= 20&&self.pwdTF.text.length >= 6) {
        NSString *str = @"^[A-Z0-9a-z]+$";
        NSPredicate *check = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",str];
        int x = [check evaluateWithObject:self.pwdTF.text];
        if (x == 1) {
            self.pwdLB.textColor = [UIColor greenColor];
            self.pwdLB.text = @"OK";
        }else{
            self.pwdLB.textColor = [UIColor redColor];
            self.pwdLB.text = @"该密码格式不正确";
        }
    }else{
        self.pwdLB.text = @"该密码太长";
    }
}

//验证密码
-(void)checkPWDCheck{
    if (self.pwdTF.text.length == 0||self.checkPwdTF.text.length == 0) {
        return;
    }else if(![self.pwdTF.text isEqualToString:self.checkPwdTF.text]) {
        self.checkPwdLB.textColor = [UIColor redColor];
        self.checkPwdLB.text = @"密码不一致";
    }else {
        self.checkPwdLB.textColor = [UIColor greenColor];
        self.checkPwdLB.text = @"OK";
    }
}

//用户注册信息数据库表的懒加载
- (BmobObject *)usersInfo {
    if(_usersInfo == nil) {
        _usersInfo = [BmobObject objectWithClassName:@"userInfo"];
    }
    return _usersInfo;
}

/*
 *点击空白处
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
