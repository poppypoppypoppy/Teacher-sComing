//
//  FoundAddViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/17.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "FoundAddViewController.h"

@interface FoundAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *subjectTF;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet UITextField *monetTF;
@property (weak, nonatomic) IBOutlet UITextField *detailTF;
@end

@implementation FoundAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"添加";


}
- (IBAction)finishBtn:(id)sender {
    if ([self.subjectTF.text isEqualToString:@""]||[self.timeTF.text isEqualToString:@""]||[self.monetTF.text isEqualToString:@""]||[self.detailTF.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;//只显示label
        hud.labelText = @"请填写完整信息！";
        [hud hide:YES afterDelay:2];
    }else{
    BmobObject  *found = [BmobObject objectWithClassName:@"found"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                BmobUser *author = [BmobUser objectWithoutDatatWithClassName:dic[@"name"] objectId:userid];
                [found setObject:author forKey:@"author"];
                [found setObject:self.subjectTF.text forKey:@"title"];
                [found setObject:self.timeTF.text forKey:@"time"];
                [found setObject:self.monetTF.text forKey:@"money"];
                [found setObject:self.detailTF.text forKey:@"detail"];
                [found saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
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

- (IBAction)close:(id)sender {
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
