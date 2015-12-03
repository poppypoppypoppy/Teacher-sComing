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
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(addFinish)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)addFinish{
    [self addMessage];
    //    [self.navigationController pushViewController:kVCFromSb(@"TripViewController", @"Main") animated:YES];
    if ([self.delegate respondsToSelector:@selector(VCAddMessageSuccessUpdateMessage:)]) {
        NSLog(@"%s",__FUNCTION__);
        [self.delegate VCAddMessageSuccessUpdateMessage:self];
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
                    }
                }];
            }
        }
    }];
}
@end
