//
//  TripViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TripViewController.h"
#import "TripCell.h"
#import "TripAddViewController.h"
#import "tripModel.h"
@interface TripViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *messageArray;
@end

@implementation TripViewController
- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
        [self searchMessageInDB];
    }
    return _messageArray;
}
-(void)searchMessageInDB{
    NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dicLogin[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                NSLog(@"%@",userid);
                
                
                BmobQuery *query = [BmobQuery queryWithClassName:@"tripInfo"];
                //按updatedAt进行降序排列
                [query orderByDescending:@"updatedAt"];
                //返回最多20条数据
                query.limit = 20;
                //执行查询
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    for (BmobObject *obj in array) {
                        if ([userid isEqualToString:[[obj objectForKey:@"author"] objectId]]) {
                            NSString *detail = [obj objectForKey:@"tripDetail"];
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSString *createdAt = [obj objectForKey:@"createdAt"];
                            
                            NSURL *imageURL = [NSURL URLWithString:dicLogin[@"icon"]];
                            NSData *data = [NSData dataWithContentsOfURL:imageURL];
                            UIImage *image = [UIImage imageWithData:data];
                            
                            tripModel *message = [tripModel tripWithIconIV:image time:createdAt trip:detail];
                            [_messageArray addObject:message];
                        }
                        [self.tableView reloadData];
                    }
                }];
            }
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripCell"];
    
    cell.message = [self.messageArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

//去除高亮效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.userInteractionEnabled = NO;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)addVC{
    TripAddViewController *vc = kVCFromSb(@"TripAddViewController", @"Main");
    [self.navigationController pushViewController:vc animated:YES];
    vc.delegate = self;
}


#pragma mark - LAFAddViewControllerDelegate

- (void)VCAddMessageSuccessUpdateMessage:(TripAddViewController *)addVC {
    NSLog(@"执行到这里啦！！！！");
    self.messageArray = nil;
    [self.tableView reloadData];
    NSLog(@"jjjjj");
}
@end
