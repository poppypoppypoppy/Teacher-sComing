//
//  FoundShowViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/17.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "FoundShowViewController.h"
#import "ShowCell.h"
#import "TeacherComingModel.h"
#import "UserInfoModel.h"
#import "MessageDetailViewController.h"

@interface FoundShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *messageArray;
//@property(nonatomic,strong)NSString *objID;
@end

@implementation FoundShowViewController
- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
                [self searchMessageInDB];
    }
    return _messageArray;
}
-(void)searchMessageInDB{
                BmobQuery *query = [BmobQuery queryWithClassName:@"found"];
                //按updatedAt进行降序排列
                [query orderByDescending:@"updatedAt"];
                //返回最多20条数据
                query.limit = 20;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            NSString *detail = [obj objectForKey:@"detail"];
            NSString *title = [obj objectForKey:@"title"];
            NSString *money = [obj objectForKey:@"money"];
            NSString *createdAt = [obj objectForKey:@"createdAt"];
            NSString *createtime = [createdAt substringToIndex:10];
            NSString *time = [obj objectForKey:@"time"];
            NSString *objID =  [[obj objectForKey:@"author"] objectId];
            
            BmobQuery *query = [BmobQuery queryWithClassName:@"userInfo"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                for (BmobObject *obj in array) {
                    if ([[obj objectId] isEqualToString:objID]) {
                        
                        NSString *address = [[obj objectForKey:@"addressCity"] stringByAppendingString:[obj objectForKey:@"addressArea"]];
                        
                        UIImage *image = [UIImage imageNamed:@"lion22"];
                        
                        NSString *iconName = [obj objectForKey:@"icon"];
                        NSString *userName = [obj objectForKey:@"userName"];
                        NSString *userPwd = [obj objectForKey:@"userPwd"];
                        NSString *sex = [obj objectForKey:@"sex"];
                        NSString *identity = [obj objectForKey:@"identity"];
                        NSString *workingPlace = [obj objectForKey:@"workingPlace"];
                        NSString *phoneNumber = [obj objectForKey:@"phoneNumber"];
                        NSString *note = [obj objectForKey:@"note"];
                        
                        UserInfoModel *user = [UserInfoModel userWithIconName:iconName userName:userName userPwd:userPwd sex:sex identity:identity workingPlace:workingPlace address:address phoneNumber:phoneNumber note:note];
                        
                        TeacherComingModel *message = [TeacherComingModel teacherWithIconIM:image time:time title:title money:money detail:detail address:address user:user createtime:createtime];
                        
                        [_messageArray addObject:message];
                        
                        
                    }
                    [self.tableView reloadData];
                }
                
            }];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家教信息";
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba21"]]];

    self.tableView.tableFooterView = [UIView new];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowCell"];
    
    cell.message = [self.messageArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//去除高亮效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeacherComingModel *selectedHero = self.messageArray[indexPath.row];
    MessageDetailViewController *detailvc = kVCFromSb(@"MessageDetailViewController", @"Main");
    //将选中的hero对象交给detailvc来显示
    detailvc.message = selectedHero;
    [self.navigationController pushViewController:detailvc animated:YES];
}

@end
