//
//  TCInfoViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/12.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TCInfoViewController.h"
#import "MyInfoViewController.h"
#import "BmobSDK/BmobProFile.h"
@interface TCInfoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sex;
@property (weak, nonatomic) IBOutlet UITextField *identityTF;

@property (weak, nonatomic) IBOutlet UITextField *addressCity;
@property (weak, nonatomic) IBOutlet UITextField *addressArea;
@property (weak, nonatomic) IBOutlet UITextField *workPlaceTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *noteTF;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,strong)NSString *sexChoose;

@property(nonatomic,strong)NSString *objId;
@property(nonatomic,strong)NSArray *identifyArr;
@property(nonatomic,strong)NSData *iconIM;

@property(nonatomic,strong)NSString *imageURLStr;
@property(nonatomic,assign)CGFloat progress;
@property(nonatomic,strong)NSString *downLoadLocalPath;
@end

@implementation TCInfoViewController

//从手机相册获取照片当头像
- (IBAction)iconPhoto:(id)sender {
    UIImagePickerController *pc = [UIImagePickerController new];
    pc.delegate = self;
    pc.allowsEditing = YES;
    [self presentViewController:pc animated:YES completion:nil];
}
/**获取手机相册*/
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取编辑后的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.iconBtn setBackgroundImage:image forState:0]
    ;
    self.iconIM = UIImageJPEGRepresentation(image, 1.0f);
    //不会自动取消，需要手动取消
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//完成按钮
- (void)finish {
    //从持久化的plist中找到登录名
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {
                NSLog(@"找到id了");
                self.objId = [obj objectId];
                break;
            }else{
                NSLog(@"no find");
            }
        }
    }];
    
    //上传文件
    [BmobProFile uploadFileWithFilename:@"image.jpg" fileData:self.iconIM block:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url,BmobFile *bmobFile) {
        if (isSuccessful) {
            NSLog(@"bmobFile.url:%@\n",bmobFile.url);
            
            NSLog(@"fileName: %@",filename);
            
            //                NSString *filename = @"91E6DF554A964C66A33B2E844312BA08.jpg";
            [BmobProFile downloadFileWithFilename:filename block:^(BOOL isSuccessful, NSError *error, NSString *filepath) {
                //下载的文件所存放的路径
                if (isSuccessful) {
                    NSLog(@"filepath:%@",filepath);
                    self.downLoadLocalPath = filepath;
                } else if (error) {
                    NSLog(@"%@",error);
                } else {
                    NSLog(@"Unknow error");
                }
            } progress:^(CGFloat progress) {
                //下载的进度
                NSLog(@"progress %f",progress);
            }];
            
            
            
            self.imageURLStr = bmobFile.url;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getImageURLStrFinish" object:nil];
        } else {
            if (error) {
                NSLog(@"error %@",error);
            }
        }
    } progress:^(CGFloat progress) {
        //上传进度，此处可编写进度条逻辑
        //            NSLog(@"progress %f",progress);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(writeToBmob) name:@"getImageURLStrFinish" object:nil];
    
}
- (void)writeToBmob {
    BmobObject *bmobObject = [BmobObject objectWithoutDatatWithClassName:@"userInfo"  objectId:self.objId];
    [bmobObject setObject:self.workPlaceTF.text forKey:@"workingPlace"];
    [bmobObject setObject:self.sexChoose forKey:@"sex"];
    [bmobObject setObject:self.phoneNumberTF.text forKey:@"phoneNumber"];
    [bmobObject setObject:self.noteTF.text forKey:@"note"];
    [bmobObject setObject:self.identityTF.text forKey:@"identity"];
    [bmobObject setObject:self.addressCity.text forKey:@"addressCity"];
    [bmobObject setObject:self.addressArea.text forKey:@"addressArea"];
    [bmobObject setObject:self.imageURLStr forKey:@"icon"];
    
    [bmobObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            if (self.addressArea.text.length!=0&&self.addressCity.text.length!=0&&self.workPlaceTF.text.length!=0&&self.phoneNumberTF.text.length!=0) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode=MBProgressHUDModeText;//只显示label
                hud.labelText = @"已保存！";
                [hud hide:YES afterDelay:2];
                //                            [se lf dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"添加成功");
            }else{
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode=MBProgressHUDModeText;//只显示label
                hud.labelText = @"请完善个人信息！";
                [hud hide:YES afterDelay:2];
                
            }
            [self saveData];
        }
    }];
    
    
}


- (IBAction)chooseSex:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        self.sexChoose = @"男";
        NSLog(@"nan");
    }else{
        self.sexChoose = @"女";
        NSLog(@"nv");
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = 0;
    self.sexChoose = @"男";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self initData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveData) name:UIApplicationWillTerminateNotification object:nil];
}
- (IBAction)finishBtn:(id)sender {
    [self finish];
}


/**plist数据持久化技术*/
-(void)initData{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kLoginPath]) {
        
        NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
        self.addressArea.text = dataDic[@"addressArea"];
        self.addressCity.text = dataDic[@"addressCity"];
        self.workPlaceTF.text = dataDic[@"workingPlace"];
        self.phoneNumberTF.text = dataDic[@"phoneNumber"];
        self.noteTF.text = dataDic[@"note"];
        
        NSURL *imageURL = [NSURL URLWithString:dataDic[@"icon"]];
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:data];
        [self.iconBtn setBackgroundImage:image forState:0];
        
        self.sexChoose = dataDic[@"sex"];
        if ([self.sexChoose isEqualToString:@"男"]) {
            self.sex.selectedSegmentIndex = 0;
        }else{
            self.sex.selectedSegmentIndex = 1;
        }
        self.identityTF.text = dataDic[@"identity"];
    }
}
-(void)saveData{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kLoginPath];
    
    BmobQuery *checkName = [BmobQuery queryWithClassName:@"userInfo"];
    
    [checkName findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            
            if ([dic[@"name"] isEqualToString:[obj objectForKey:@"userName"]]) {//存在
                NSLog(@"找到信息，写入plist");
                NSLog(@"bmob   ===  %@",obj);
                NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:kLoginPath];
                [userDic setObject:[obj objectForKey:@"addressCity"] forKey:@"addressCity"];
                [userDic setObject:[obj objectForKey:@"addressArea"] forKey:@"addressArea"];
                [userDic setObject:[obj objectForKey:@"workingPlace"] forKey:@"workingPlace"];
                [userDic setObject:[obj objectForKey:@"phoneNumber"] forKey:@"phoneNumber"];
                [userDic setObject:[obj objectForKey:@"note"] forKey:@"note"];
                [userDic setObject:[obj objectForKey:@"icon"] forKey:@"icon"];
                [userDic setObject:[obj objectForKey:@"sex"] forKey:@"sex"];
                [userDic setObject:[obj objectForKey:@"identity" ] forKey:@"identity"];
                [userDic writeToFile:kLoginPath atomically:YES];
                break;
            }
        }
        
    }];
    
    
    //    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:kLoginPath];
    //    [userDic setObject:self.addressCity.text forKey:@"addressCity"];
    //    [userDic setObject:self.addressArea.text forKey:@"addressArea"];
    //                        [userDic setObject:self.workPlaceTF.text forKey:@"workingP lace"];
    //                        [userDic setObject:self.phoneNumberTF.text forKey:@"phoneNumber"];
    //                        [userDic setObject:self.noteTF.text forKey:@"note"];
    //                                  [userDic setObject:self.iconIM forKey:@"icon"];
    //                                      [userDic setObject:self.sexChoose forKey:@"sex"];
    //                        [userDic setObject:self.identityTF.text forKey:@"identity"];
    //                        [userDic writeToFile:kLoginPath atomically:YES];
    
}

/**键盘*/
//注册键盘通知
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
//键盘弹起时
-(void)openKeyboard:(NSNotification *)notification{
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y =  - 160;
        self.view.frame = frame;
    } completion:nil];
}
//键盘收起时
- (void)closeKeyboard:(NSNotification *)notification{
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    } completion:nil];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)closeadd:(id)sender {
}
- (IBAction)closeadd2:(id)sender {
}
- (IBAction)closeworkplace:(id)sender {
}
- (IBAction)closephone:(id)sender {
}
- (IBAction)closenote:(id)sender {
}

@end
