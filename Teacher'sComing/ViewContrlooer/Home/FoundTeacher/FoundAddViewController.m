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
   self.title = @"FoundAdd";

}
- (IBAction)finishBtn:(id)sender {
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
                        NSLog(@"finish");
                    }
                }];
            }
        }
    }];
    

}

@end
