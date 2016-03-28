//
//  QuestionsAddViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 16/2/14.
//  Copyright © 2016年 YHL. All rights reserved.
//

#import "QuestionsAddViewController.h"
#import "QuestionsShowViewController.h"

@interface QuestionsAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *questionTitle;
@property (weak, nonatomic) IBOutlet UITextField *questionDetail;
@property (weak, nonatomic) IBOutlet UITextField *note;
@end

@implementation QuestionsAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(285, 7, 35, 35)];
    [btn setBackgroundImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFinish) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
-(void)addFinish{
    if ([self.questionTitle.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;//只显示label
        hud.labelText = @"主题不能为空！";
        [hud hide:YES afterDelay:2];
    }else if([self.questionDetail.text isEqualToString:@""]){
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;//只显示label
        hud.labelText = @"详情不能为空！";
        [hud hide:YES afterDelay:2];
    }else{
        [self addInQuestions];
        [self.navigationController popViewControllerAnimated:YES];
        //
//        if ([self.delegate respondsToSelector:@selector(QuestionsAddUpdate:)]) {
//            NSLog(@"%s",__FUNCTION__);
//            [self.delegate QuestionsAddUpdate:self];
//        }
    }
}

-(void)addInQuestions{
    BmobObject  *questions = [BmobObject objectWithClassName:@"questions"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                BmobUser *author = [BmobUser objectWithoutDatatWithClassName:dic[@"name"] objectId:userid];
                [questions setObject:author forKey:@"author"];
                [questions setObject:self.questionTitle.text forKey:@"questionTitle"];
                [questions setObject:self.questionDetail.text forKey:@"questionDetail"];
                [questions setObject:self.note.text forKey:@"note"];
                [questions saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }else{
                        NSLog(@"finish");
                    }
                }];
            }
        }
    }];
}

- (IBAction)close1:(id)sender {
}
- (IBAction)close2:(id)sender {
}
- (IBAction)close3:(id)sender {
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
