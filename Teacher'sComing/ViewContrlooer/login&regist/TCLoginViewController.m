//
//  TCLoginViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/10/27.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TCLoginViewController.h"
#import "TCRegistVCViewController.h"


@interface TCLoginViewController ()

@property(nonatomic,strong)BmobObject *usersInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/*
 *老狮来啦！label
 */
@property (weak, nonatomic) IBOutlet UILabel *laoLb;
@property (weak, nonatomic) IBOutlet UIImageView *shiIV;
@property (weak, nonatomic) IBOutlet UILabel *laiLb;
@property (weak, nonatomic) IBOutlet UILabel *laLb;
@property (weak, nonatomic) IBOutlet UILabel *markLb;
/*
 *用户名和密码textfield
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTF;
/*
 *下方图案
 */
@property (weak, nonatomic) IBOutlet UIImageView *bottomimageView;

/*
 *登陆注册button
 */
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
/*
 *约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;//老 的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shiLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *laiLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *laLeftConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *markLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeftConstraint;
//路径 用于保存用户输入的数据
@property(nonatomic,strong)NSString *userPlistPath;
@end
@implementation TCLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //登录数据持久化
    [self initData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveData) name:UIApplicationWillTerminateNotification object:nil];
    //登陆界面背景添加毛玻璃效果
    [GlassView glassView:self.imageView rectX:0 rectY:0 rectW:self.imageView.frame.size.width rectH:self.imageView.frame.size.height];
    //登陆界面控件动画
//        [self viewAnimationWithDipatch];
    //[self rotationAnimation];
}


- (IBAction)registVC:(id)sender {
       [self presentViewController:kVCFromSb(@"TCRegistVCViewController", @"Main") animated:YES completion:nil];
}
- (IBAction)login:(id)sender {
    /*
     *验证登陆信息
     */
    BmobQuery *checkName = [BmobQuery queryWithClassName:@"userInfo"];
    [checkName findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        int flag = 0;
        for (BmobObject *obj in array) {
            if ([self.userNameTF.text isEqualToString:[obj objectForKey:@"userName"]]) {//存在
                if ([self.userPwdTF.text isEqualToString:[obj objectForKey:@"userPwd"]]) {
                    flag = 1;
                    break;
                }else{
                    flag = 2;
                }
            }else{
                flag = 3;
            }
        }
        if (flag == 1) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"登陆成功" message:@"enjoy!" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertC animated:YES completion:nil];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                /**推出tabBarController界面*/
                [self presentViewController:kVCFromSb(@"tabBarController", @"Main") animated:YES completion:nil];
            }];
            [alertC addAction:sureAction];
        }else{
            NSLog(@"error");
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"sorry" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertC animated:YES completion:nil];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:sureAction];
        }
    }];
    
    [self saveData];
}


/*
 *点击空白处
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)usernameLogin:(id)sender {
}

- (IBAction)userpwdLogin:(id)sender {
    
}

//用户注册信息数据库表的懒加载
- (BmobObject *)usersInfo {
    if(_usersInfo == nil) {
        _usersInfo = [BmobObject objectWithClassName:@"userInfo"];
    }
    return _usersInfo;
}


/**plist数据持久化技术*/
-(void)initData{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.userPlistPath]) {
        NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:self.userPlistPath];
        _userNameTF.text = dataDic[@"name"];
        _userPwdTF.text = dataDic[@"pwd"];
    }
}
-(void)saveData{
    BmobQuery *checkName = [BmobQuery queryWithClassName:@"userInfo"];
    
    [checkName findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            
            if ([self.userNameTF.text isEqualToString:[obj objectForKey:@"userName"]]) {//存在
                
                NSDictionary *loginInfo = @{
                                            @"name":_userNameTF.text,
                                            @"pwd":_userPwdTF.text,
                                            @"addressCity":[[obj objectForKey:@"addressCity"] isEqualToString:@" "]?@"":[obj objectForKey:@"addressCity"],
                                            @"addressArea":[[obj objectForKey:@"addressArea"]  isEqualToString:@" "]?@" ":[obj objectForKey:@"addressArea"],
                                            @"workingPlace":[[obj objectForKey:@"workingPlace"] isEqualToString:@" "]?@" ":[obj objectForKey:@"workingPlace"] ,
                                            @"phoneNumber":[[obj objectForKey:@"phoneNumber"] isEqualToString:@" "]?@" ":[obj objectForKey:@"phoneNumber"] ,
                                            @"note":[[obj objectForKey:@"note"] isEqualToString:@" "]?@" ":[obj objectForKey:@"note"],
                                            @"icon":[[obj objectForKey:@"icon"] isEqualToString:@" "]?@" ":[obj objectForKey:@"icon"],
                                            @"sex":[[obj objectForKey:@"sex"] isEqualToString:@" "]?@" ":[obj objectForKey:@"sex"],
                                            @"identity":[[obj objectForKey:@"identity"]isEqualToString:@" "]?@" ":[obj objectForKey:@"identity"]
                                            };
                [loginInfo writeToFile:kLoginPath atomically:YES];
                break;
            }
        }
        
    }];
}
- (NSString *)userPlistPath {
    if(_userPlistPath == nil) {
        NSString *path = kDocumentPath;
        _userPlistPath = [path stringByAppendingPathComponent:@"login.plist"];
        NSLog(@"path %@",_userPlistPath);
    }
    return _userPlistPath;
}


//-(void)rotationAnimation{
//    CABasicAnimation *zRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    zRotation.fromValue = [NSValue valueWithCATransform3D:self.loginButton.layer.transform];
//    zRotation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.loginButton.layer.transform, M_PI, 0, 0, 1.0)];
//    zRotation.duration = 0.5;
//    [self.loginButton.layer addAnimation:zRotation forKey:nil];
//    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
//}
//
//-(void)viewAnimationWithDipatch{
//    NSOperationQueue *queue = [NSOperationQueue new];
//
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(2);
//   [self animationWithUIView:self.laoLb constraint:self.leftConstraint constValue:271 duration:1];
//    }];
//    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(2);
//   [self animationWithUIView:self.shiIV constraint:self.shiLeftConstraint constValue:173 duration:1];
//    }];
//    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(2);
//  [self animationWithUIView:self.laiLb constraint:self.laiLeftConstraint constValue:105 duration:1];
//    }];
//    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(2);
//       [self animationWithUIView:self.laLb constraint:self.laLeftConstraint constValue:50 duration:1];
//    }];
//    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(2);
//   [self animationWithUIView:self.markLb constraint:self.markLeftConstraint constValue:20 duration:1];
//    }];
//    NSBlockOperation *op6 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(2);
//   [self animationWithUIView:self.bottomimageView constraint:self.imageViewLeftConstraint constValue:0 duration:1];
//    }];
//    [queue addOperations:@[op1,op2,op3,op4,op5,op6] waitUntilFinished:NO];
////    dispatch_queue_t queue = dispatch_queue_create("SerialQueue", DISPATCH_QUEUE_CONCURRENT);
////    dispatch_queue_t queue = dispatch_get_main_queue();
////    dispatch_async(queue, ^{
////        [self animationWithUIView:self.laoLb constraint:self.leftConstraint constValue:271 duration:1];
////    });
////    dispatch_async(queue, ^{
////        sleep(0.1);
////       [self animationWithUIView:self.shiIV constraint:self.shiLeftConstraint constValue:173 duration:1];
////    });
//////    dispatch_async(queue, ^{
//////                sleep(0.1);
//////        [self animationWithUIView:self.laiLb constraint:self.laiLeftConstraint constValue:105 duration:1];
//////    });
//////    dispatch_async(queue, ^{
//////                sleep(0.1);
//////        [self animationWithUIView:self.laLb constraint:self.laLeftConstraint constValue:50 duration:1];
//////    });
//////    dispatch_async(queue, ^{
//////                sleep(0.1);
//////      [self animationWithUIView:self.markLb constraint:self.markLeftConstraint constValue:20 duration:1];
//////    });
//////    dispatch_async(queue, ^{
//////                sleep(0.1);
//////      [self animationWithUIView:self.bottomimageView constraint:self.imageViewLeftConstraint constValue:0 duration:1];
//////    });
//
//}

//-(void)animationWithUIView:(UIView *)view constraint:(NSLayoutConstraint *)layoutConstraint constValue:(CGFloat)constValue duration:(CGFloat)duration  {
//    layoutConstraint.constant = constValue;
//    [UIButton animateWithDuration:duration animations:^{
//        [self.view layoutIfNeeded];
//        [view layoutIfNeeded];
//    }];
//}

@end
