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
@property(nonatomic,strong)UIImage *image;

@end

@implementation TripViewController

- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    
        [self searchMessageInDB];
    }
    return _messageArray;
}

-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
//    [self searchMessageInDB];
    NSLog(@"%@",self.messageArray);
    [self.tableView reloadData];
}

-(void)searchMessageInDB{
    NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    
    /**根据用户名查找id*/
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dicLogin[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSString *userid = [obj objectId];
//                NSLog(@"%@",userid);
                
                
                BmobQuery *query = [BmobQuery queryWithClassName:@"tripInfo"];
                //按updatedAt进行降序排列
                [query orderByDescending:@"updatedAt"];
                //返回最多20条数据
//                query.limit = 20;
                //执行查询
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    for (BmobObject *obj in array) {
                        if ([userid isEqualToString:[[obj objectForKey:@"author"] objectId]]) {
                            NSString *detail = [obj objectForKey:@"tripDetail"];
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSString *createdAt = [obj objectForKey:@"createdAt"];
                            tripModel *message = [tripModel tripWithTime:createdAt trip:detail];
                            [_messageArray addObject:message];
        
 
                        }
                        [self.tableView reloadData];
//                        [self hideProgress];
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
    tripModel *p = nil;

        p  = [self.messageArray objectAtIndex:indexPath.row];
    cell.message = p;
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
    
 [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba21"]]];

    self.tableView.tableFooterView = [UIView new];

    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(281, 7, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

}


-(void)addVC{
    TripAddViewController *vc = kVCFromSb(@"TripAddViewController", @"Main");
//        vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}


//#pragma mark - LAFAddViewControllerDelegate
//
//- (void)VCAddMessageSuccessUpdateMessage:(TripAddViewController *)addVC {
//
//    self.messageArray = nil;
//    [self.tableView reloadData];
//
//}

#pragma mark - 表格编辑模式的2问1答

//问1：行 是否可以编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;

}

//问2：行 是何种编辑样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

        return UITableViewCellEditingStyleDelete;

}

//答1 确认提交编辑动作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

        //1.修改数据模型中的数据
        [self.messageArray removeObjectAtIndex:indexPath.row];
        //2.更新界面
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
       DDLogVerbose(@"delete");
}



@end
