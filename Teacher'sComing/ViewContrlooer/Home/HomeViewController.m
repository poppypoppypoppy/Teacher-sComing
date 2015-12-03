//
//  HomeViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/3.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "HomeViewController.h"
#import "AnimationViewController.h"
@import CoreLocation;

#import "TCInfoViewController.h"
@interface HomeViewController ()<CLLocationManagerDelegate>
@property(nonatomic)CLLocationDistance longitude;
@property(nonatomic)CLLocationDistance latitude;
@property(nonatomic,strong) CLLocationManager *manager;
@property(nonatomic,strong)AnimationViewController *viewController;
@end

@implementation HomeViewController
- (void)dealloc {
    [_viewController.view removeFromSuperview];
    [_viewController removeFromParentViewController];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewController = ({
        AnimationViewController *viewController = [[AnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"个人信息" style:UIBarButtonItemStyleDone target:self action:@selector(selfInfo)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(281, 7, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"CLl"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(myaddress) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self CoreLocation];
}


-(void)selfInfo{
    NSLog(@"这是我的个人信息");
    [self.navigationController pushViewController:kVCFromSb(@"TCInfoViewController", @"Main") animated:YES];
}
/**点击按钮定位*/
-(void)myaddress{
    NSLog(@"定位");
    /**反地理编码*/
    CLGeocoder *geocoder = [CLGeocoder new];
    CLLocation *location=[[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *mark in placemarks) {
            NSLog(@"省：%@，市：%@,区：%@",mark.administrativeArea,mark.locality,mark.subLocality);
            self.title = mark.name;
        }
    }];
}
/**定位*/
-(void)CoreLocation{
    //创建定位服务管理
    self.manager = [[CLLocationManager alloc]init];
    //判断是否启动了定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务没有开启,请设置打开");
        return;
    }
    //如果用户还没有决定是否使用定位服务
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        //向用户请求授权
        [self.manager requestWhenInUseAuthorization];
    }
    //设置委托对象,当定位服务发生事件时通知委托
    self.manager.delegate = self;
    
    //开始定位
    [self.manager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coord = location.coordinate;
    NSLog(@"经度:%f, 纬度:%f, 海拔:%f, 航向:%f, 速度:%f,time:%@", coord.longitude, coord.latitude, location.altitude, location.course, location.speed,location.timestamp);
    //只定位一次，即定位完成后 停止更新位置
    [self.manager stopUpdatingLocation];
    self.longitude = coord.longitude;
    self.latitude = coord.latitude;
    NSLog(@"lon %f, lat %f",self.longitude,self.latitude);
    NSLog(@"finish");
}

@end
