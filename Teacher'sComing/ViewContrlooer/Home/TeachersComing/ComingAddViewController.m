//
//  ComingAddViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/17.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "ComingAddViewController.h"

@interface ComingAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *subjectTF;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *money;
@property (weak, nonatomic) IBOutlet UITextField *detail;


@end

@implementation ComingAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.title = @"添加";
}
- (IBAction)finishBtn:(id)sender {
    if ([self.subjectTF.text isEqualToString:@""]||[self.time.text isEqualToString:@""]||[self.money.text isEqualToString:@""]||[self.detail.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;//只显示label
        hud.labelText = @"请填写完整信息！";
        [hud hide:YES afterDelay:2];
    }else{
    BmobObject  *coming = [BmobObject objectWithClassName:@"coming"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                BmobUser *author = [BmobUser objectWithoutDatatWithClassName:dic[@"name"] objectId:userid];
                [coming setObject:author forKey:@"author"];
                [coming setObject:self.subjectTF.text forKey:@"title"];
                [coming setObject:self.time.text forKey:@"time"];
                [coming setObject:self.money.text forKey:@"money"];
                [coming setObject:self.detail.text forKey:@"detail"];
                [coming saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }else{
                        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"小狮祝贺" message:@"添加信息成功！" preferredStyle:UIAlertControllerStyleAlert];
                        [self presentViewController:alertC animated:YES completion:nil];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
                        [alertC addAction:okAction];
                    }
                }];
            }
        }
    }];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)close:(id)sender {
}

@end
