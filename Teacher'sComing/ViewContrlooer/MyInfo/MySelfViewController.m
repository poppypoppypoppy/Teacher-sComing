//
//  MySelfViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/3.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "MySelfViewController.h"
#import "MyInfoViewController.h"
#import "MyAccountViewController.h"
#import "MyMessageViewController.h"
#import "MyTripViewController.h"
#import "FourMenuViewController.h"

@interface MySelfViewController ()
@property(nonatomic,strong)FourMenuViewController *menuVC;
@end

@implementation MySelfViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyInfoViewController *infoVC = [storyboard instantiateViewControllerWithIdentifier:@"MyMessageViewController"];
    MyAccountViewController *friendsVC = [storyboard instantiateViewControllerWithIdentifier:@"MyAccountViewController"];
    MyMessageViewController *msgVC = [storyboard instantiateViewControllerWithIdentifier:@"MyInfoViewController"];
    MyTripViewController *downloadVC = [storyboard instantiateViewControllerWithIdentifier:@"MyTripViewController"];
    self.menuVC = [[FourMenuViewController alloc]initWithTopLeft:infoVC TopRight:friendsVC bottomLeft:msgVC bottomRight:downloadVC];
    [self.view addSubview:self.menuVC.view];
    
}
@end
