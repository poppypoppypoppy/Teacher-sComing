//
//  BillAddViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "BillAddViewController.h"

@interface BillAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *detailTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@end

@implementation BillAddViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(addFinish)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)addFinish{
    if (self.isIN == 1) {
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
    }else{
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
}
@end
