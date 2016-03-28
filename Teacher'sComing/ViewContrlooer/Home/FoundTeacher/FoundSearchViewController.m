//
//  FoundSearchViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/17.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "FoundSearchViewController.h"
#import "TeacherComingModel.h"
#import "FoundSearchTableViewController.h"
#import "MessageDetailViewController.h"

@interface FoundSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)FoundSearchTableViewController *searchResultViewController;
@property(nonatomic,strong)UISearchController *searchController;
@end

@implementation FoundSearchViewController
- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [NSMutableArray array];
        [self searchMessageInDB];
    }
    return _messages;
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
                        
                        [_messages addObject:message];
                        
                        
                    }
                    [self.tableView reloadData];
                }
                
            }];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"搜索";
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ba20"]]];
    self.tableView.tableFooterView = [UIView new];
    
    self.searchResultViewController = [[FoundSearchTableViewController alloc]init];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchResultViewController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //代理
    self.searchResultViewController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    
    self.definesPresentationContext = YES;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowCell"];
    
    cell.message = [self.messages objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchText = searchController.searchBar.text;
    NSInteger index = searchController.searchBar.selectedScopeButtonIndex;
    NSLog(@"%ld",index);
    NSMutableArray *searchResults = [NSMutableArray array];
    for (TeacherComingModel *p in self.messages) {
        if ([p.title rangeOfString:searchText].length>0||[p.createtime rangeOfString:searchText].length>0||[p.time rangeOfString:searchText].length>0||[p.money rangeOfString:searchText].length>0||[p.detail rangeOfString:searchText].length>0||[p.address rangeOfString:searchText].length>0) {
            [searchResults addObject:p];
        }
    }
    
    self.searchResultViewController.resultArray = searchResults;
    [self.searchResultViewController.tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//去除高亮效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeacherComingModel *selectedHero = self.messages[indexPath.row];
    MessageDetailViewController *detailvc = kVCFromSb(@"MessageDetailViewController", @"Main");
    //将选中的hero对象交给detailvc来显示
    detailvc.message = selectedHero;
    [self.navigationController pushViewController:detailvc animated:YES];
}

@end
