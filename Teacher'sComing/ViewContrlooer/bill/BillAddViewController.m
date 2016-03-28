//
//  BillAddViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "BillAddViewController.h"
#import "BilllViewController.h"
@interface BillAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *detailTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@end

@implementation BillAddViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(285, 7, 35, 35)];
    [btn setBackgroundImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFinish) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //设置填费用时弹出数字键盘
    self.moneyTF.keyboardType =  UIKeyboardTypeNumberPad;
}
-(void)addFinish{
    if (self.isIN == 1) {
        if ([self.detailTF.text isEqualToString:@""]) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode=MBProgressHUDModeText;//只显示label
            hud.labelText = @"详情不能为空！";
            [hud hide:YES afterDelay:2];
        }else if ([self.moneyTF.text isEqualToString:@""]){
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode=MBProgressHUDModeText;//只显示label
            hud.labelText = @"金额不能为空！";
            [hud hide:YES afterDelay:2];
        }else{
            [self addInMessage];
//            [self.navigationController popViewControllerAnimated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"添加成功";
            [hud hide:YES afterDelay:2];
//            if ([self.delegate respondsToSelector:@selector(VCAddMessageSuccessUpdateMessage:)]) {
//                NSLog(@"%s",__FUNCTION__);
//                [self.delegate VCAddMessageSuccessUpdateMessage:self];
//            }

        }
        
    }
    else{
        if ([self.detailTF.text isEqualToString:@""]||[self.moneyTF.text isEqualToString:@""]) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode=MBProgressHUDModeText;//只显示label
            hud.labelText = @"请填写完整信息！";
            [hud hide:YES afterDelay:2];
        }else{
            [self addOutMessage];
            [self.navigationController popViewControllerAnimated:YES];
//            if ([self.delegate respondsToSelector:@selector(VCAddMessageSuccessUpdateMessage:)]) {
//                NSLog(@"%s",__FUNCTION__);
//                [self.delegate VCAddMessageSuccessUpdateMessage:self];
//            }

        }
        
    }
}
-(void)addOutMessage{
    BmobObject  *billOut = [BmobObject objectWithClassName:@"billOut"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                BmobUser *author = [BmobUser objectWithoutDatatWithClassName:dic[@"name"] objectId:userid];
                [billOut setObject:author forKey:@"author"];
                [billOut setObject:self.detailTF.text forKey:@"billDetail"];
                [billOut setObject:self.moneyTF.text forKey:@"money"];
                [billOut saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
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
-(void)addInMessage{
    BmobObject  *billIn = [BmobObject objectWithClassName:@"billIn"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                BmobUser *author = [BmobUser objectWithoutDatatWithClassName:dic[@"name"] objectId:userid];
                [billIn setObject:author forKey:@"author"];
                [billIn setObject:self.detailTF.text forKey:@"billDetail"];
                [billIn setObject:self.moneyTF.text forKey:@"money"];
                [billIn saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
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
- (IBAction)close1:(UITextField *)sender {
}
- (IBAction)close2:(UITextField *)sender {
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
