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
       self.title = @"ComingAdd";
}
- (IBAction)finishBtn:(id)sender {
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
                        NSLog(@"finish");
                    }
                }];
            }
        }
    }];
}

@end
