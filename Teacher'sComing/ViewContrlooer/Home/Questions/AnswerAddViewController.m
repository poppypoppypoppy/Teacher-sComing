//
//  AnswerAddViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/22.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "AnswerAddViewController.h"

@interface AnswerAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *answerTF;
@end

@implementation AnswerAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"解答";
    
}

- (IBAction)addFinish:(UIButton *)sender {
    if ([self.answerTF.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;//只显示label
        hud.labelText = @"解答内容不能为空！";
        [hud hide:YES afterDelay:2];
    }else{
        [self addAnswers];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)addAnswers{
    BmobObject  *answers = [BmobObject objectWithClassName:@"answers"];
    [answers setObject:self.questions.questionsID forKey:@"questionsID"];
    [answers setObject:self.answerTF.text forKey:@"answers"];
    [answers saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
    if (error) {
                NSLog(@"%@",error);
    }else{
               NSLog(@"finish");
    }
}];
}
- (IBAction)close:(id)sender {
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
