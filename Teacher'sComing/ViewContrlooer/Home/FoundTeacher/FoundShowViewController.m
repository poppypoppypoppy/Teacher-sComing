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
@interface FoundShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *messageArray;
@end

@implementation FoundShowViewController
- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
        //        [self searchMessageInDB];
    }
    return _messageArray;
}
//-(void)searchMessageInDB{
//    NSDictionary *dicInfo = [NSDictionary dictionaryWithContentsOfFile:kInfoPPath];
//    NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
//
//
//
//                BmobQuery *query = [BmobQuery queryWithClassName:@"found"];
//                //按updatedAt进行降序排列
//                [query orderByDescending:@"updatedAt"];
//                //返回最多20条数据
//                query.limit = 20;
//                //执行查询
//                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                    for (BmobObject *obj in array) {
//
//                            NSString *detail = [obj objectForKey:@"detail"];
//                            NSString *title = [obj objectForKey:@"title"];
//                            NSString *money = [obj objectForKey:@"money"];
//                            NSString *address = [dicInfo[@"addressCity"] stringByAppendingString:dicInfo[@"addressArea"]];
//
//                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                            NSString *createdAt = [obj objectForKey:@"createdAt"];
//
//                            NSString *imageString = dicInfo[@"icon"];
//                            NSData *data = [[NSData alloc]initWithBase64Encoding:imageString];
//                            UIImage *image = [UIImage imageWithData:data];
//
//                            TeacherComingModel *message = [TeacherComingModel teacherWithIconIM:image time:createdAt title:title money:money detail:detail address:address];
//
//                            [_messageArray addObject:message];
//                        }
//                        [self.tableView reloadData];
//
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FoundShow";
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
}

@end
