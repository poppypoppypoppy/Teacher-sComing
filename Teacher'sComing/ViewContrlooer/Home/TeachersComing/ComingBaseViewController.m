//
//  ComingBaseViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/17.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "ComingBaseViewController.h"
#import "ComingShowViewController.h"
#import "ComingSearchViewController.h"
#import "ComingAddViewController.h"
#import "HomeViewController.h"

@interface ComingBaseViewController ()

@end

@implementation ComingBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mmMainFX = self.view.bounds.origin.x;
    _mmMainFY = 20 + 44;
    _clearFlag = YES;
    
    [self initNavBtn];
    [self initView];
}
///**右侧菜单栏*/
-(void)initNavBtn
{
    navRightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [navRightButton setFrame:CGRectMake(281, 7, 30, 30)];
    [navRightButton setBackgroundImage:[UIImage imageNamed:@"c_nav-60-60"] forState:UIControlStateNormal];
    [navRightButton addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightButton];
}
-(void)rightNavBtn
{
    if (_clearFlag)
    {
        _clearImg.hidden = NO;
        
        CGAffineTransform navRound =CGAffineTransformMakeRotation(M_PI*3/-2);//先顺时钟旋转
        navRound =CGAffineTransformTranslate(navRound,0,0);
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,45*1);
                             _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,45*2);
                              _jkjhBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,45*3);
                             _lcksBtn.alpha = 1;
                             _wjxxBtn.alpha = 1;
                             _jkpgBtn.alpha = 1;
                                  _jkjhBtn.alpha = 1;
                             
                             [navRightButton setTransform:navRound];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                 
                                 _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,40.0*0);
                                 _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,40.0*1);
                                 _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,40.0*2);
                                  _jkjhBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,40.0*3);
                                 
                             } completion:NULL];
                         }];
    }
    else
    {
        _clearImg.hidden = YES;
        
        CGAffineTransform navRound =CGAffineTransformMakeRotation(0);//先顺时钟旋转90
        navRound =CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,45*0);
                             _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,45*0);
                             _jkjhBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,45*0);
                             _lcksBtn.alpha = 0;
                             _wjxxBtn.alpha = 0;
                             _jkpgBtn.alpha = 0;
                             _jkjhBtn.alpha = 0;

                             [navRightButton setTransform:navRound];
                             
                         }
                         completion:nil];
    }
    _clearFlag = !_clearFlag;
}
-(void)initView
{
    _vFX = _mmMainFX;
    _vFY = _mmMainFY;
    _clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 460+88-44)];
    _clearImg.backgroundColor = kRGBColor(224, 224, 166);
    _clearImg.hidden = YES;
    
    _vFX = _mmMainFX;
    _vFY = _mmMainFY;
    
    _lcksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lcksBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_lcksBtn setTitle:@"My_Menu_1" forState:UIControlStateNormal];
    
    _wjxxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wjxxBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_wjxxBtn setTitle:@"My_Menu_2" forState:UIControlStateNormal];
    
    _jkpgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jkpgBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_jkpgBtn setTitle:@"My_Menu_3" forState:UIControlStateNormal];
    
    _jkjhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jkjhBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_jkjhBtn setTitle:@"My_Menu_4" forState:UIControlStateNormal];
    _lcksBtn.alpha = 0;
    _wjxxBtn.alpha = 0;
    _jkpgBtn.alpha = 0;
        _jkjhBtn.alpha = 0;
    
    [_lcksBtn addTarget:self action:@selector(comingShow) forControlEvents:UIControlEventTouchUpInside];
    [_wjxxBtn addTarget:self action:@selector(comingAdd) forControlEvents:UIControlEventTouchUpInside];
    [_jkpgBtn addTarget:self action:@selector(comingSearch) forControlEvents:UIControlEventTouchUpInside];
        [_jkjhBtn addTarget:self action:@selector(homeVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_clearImg];
    [self.view addSubview:_lcksBtn];
    [self.view addSubview:_wjxxBtn];
    [self.view addSubview:_jkpgBtn];
    [self.view addSubview:_jkjhBtn];

}
-(void)comingShow
{
    _clearFlag = NO;
    [self rightNavBtn];
    [self.navigationController pushViewController:   kVCFromSb(@"ComingShowViewController", @"Main") animated:YES];
}
-(void)comingAdd{
    _clearFlag = NO;
    [self rightNavBtn];
    [self.navigationController pushViewController:   kVCFromSb(@"ComingAddViewController", @"Main") animated:YES];
    
}
-(void)comingSearch{
    _clearFlag = NO;
    [self rightNavBtn];
    [self.navigationController pushViewController:   kVCFromSb(@"ComingSearchViewController", @"Main") animated:YES];
}
-(void)homeVC{
       [self.navigationController pushViewController:   kVCFromSb(@"HomeViewController", @"Main") animated:YES];
}
@end