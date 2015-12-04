//
//  BilllViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "BilllViewController.h"
#import "billCell.h"
#import "BillAddViewController.h"
@interface BilllViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign)BOOL isIn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *messageArray;
@end

@implementation BilllViewController
- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
        [self searchMessageInDB];
    }
    return _messageArray;
}

-(void)searchMessageInDB{
    NSLog(@"搜索数据库");
    //    NSDictionary *dicInfo = [NSDictionary dictionaryWithContentsOfFile:kInfoPPath];
    NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dicLogin[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
                NSLog(@"%@",userid);
                
                
                BmobQuery *query = [BmobQuery queryWithClassName:self.isIn?@"billIn":@"billOut"];
                //按updatedAt进行降序排列
                [query orderByDescending:@"updatedAt"];
                //返回最多20条数据
                query.limit = 20;
                //执行查询
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    for (BmobObject *obj in array) {
                        if ([userid isEqualToString:[[obj objectForKey:@"author"] objectId]]) {
                            NSString *detail = [obj objectForKey:@"billDetail"];
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSString *createdAt = [obj objectForKey:@"createdAt"];
                            
                            NSString *money = [obj objectForKey:@"money"];
//                            
//                            NSURL *imageURL = [NSURL URLWithString:dicLogin[@"icon"]];
//                            NSData *data = [NSData dataWithContentsOfURL:imageURL];
//                            UIImage *image = [UIImage imageWithData:data];
                            
                            billModel *message = [billModel billWithTime:createdAt money:money detail:detail];
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
    billCell *cell = [tableView dequeueReusableCellWithIdentifier:@"billCell"];
    
    cell.message = [self.messageArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (IBAction)outOrIn:(UISegmentedControl *)sender {
    self.isIn = !sender.selectedSegmentIndex;
    self.messageArray = nil;
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.userInteractionEnabled = NO;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.isIn = !self.segmentedControl.selectedSegmentIndex;
}

-(void)addVC{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BillAddViewController *vc = [storyboard instantiateInitialViewController];
    vc = [storyboard instantiateViewControllerWithIdentifier:@"BillAddViewController"];
    vc.isIN = self.isIn;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}@end
