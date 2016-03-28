//
//  TripAddViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TripAddViewController.h"
#import "TripViewController.h"
@interface TripAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tripDetailTF;
@end

@implementation TripAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(285, 7, 35, 35)];
    [btn setBackgroundImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFinish) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

}
-(void)addFinish{
    if ([self.tripDetailTF.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;//只显示label
        hud.labelText = @"详情不能为空！";
        [hud hide:YES afterDelay:2];
    }else{
        [self addMessage];
//        [self.navigationController popViewControllerAnimated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"添加成功";
        [hud hide:YES afterDelay:2];
        
//        if ([self.delegate respondsToSelector:@selector(VCAddMessageSuccessUpdateMessage:)]) {
//            NSLog(@"%s",__FUNCTION__);
//            [self.delegate VCAddMessageSuccessUpdateMessage:self];
//        }
    }

}
-(void)addMessage{
    BmobObject  *tripInfo = [BmobObject objectWithClassName:@"tripInfo"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                BmobUser *author = [BmobUser objectWithoutDatatWithClassName:dic[@"name"] objectId:userid];
                [tripInfo setObject:author forKey:@"author"];
                [tripInfo setObject:self.tripDetailTF.text forKey:@"tripDetail"];
                [tripInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }else{
                        NSLog(@"finish");
                        NSLog(@"%@",tripInfo);
                    }
                }];
            }
        }
    }];
}
- (IBAction)closeKB:(UITextField *)sender {
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




@end
