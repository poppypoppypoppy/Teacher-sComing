
//
//  AnimationViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/3.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "AnimationViewController.h"
#import "FoundShowViewController.h"
#import "ComingShowViewController.h"
#import "MoreViewController.h"
#define RADIUS 100.0
#define PHOTONUM 5
#define TAGSTART 1000
#define TIME 1.5
#define SCALENUMBER 1.25
NSInteger array [PHOTONUM][PHOTONUM] = {
    {0,1,2,3,4},
    {4,0,1,2,3},
    {3,4,0,1,2},
    {2,3,4,0,1},
    {1,2,3,4,0}
};

@interface AnimationViewController ()<TCItemViewDelegate>
@property (nonatomic, assign) NSInteger currentTag;
@property(nonatomic,strong)TCItemView *itemView;
@end

@implementation AnimationViewController

CATransform3D rotationTransform1[PHOTONUM];

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configViews];
}

#pragma mark - configViews

- (void)configViews {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
       NSArray *dataArray = @[@"sun1", @"lu", @"ji2", @"shizi", @"yuan"];
    NSArray *titleName = @[@"我是老师",@"更多",@"疑难在线",@"分享",@"我要老师"];
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    
    for (NSInteger i = 0;i < PHOTONUM;i++) {
        CGFloat tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
        CGFloat tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
        self.itemView = [[TCItemView alloc] initWithNormalImage:dataArray[i] highlightedImage:[dataArray[i] stringByAppendingFormat:@"%@", @"_hover"] tag:TAGSTART+i title:titleName[i]];
        self.itemView.frame = CGRectMake(0.0, 0.0,115,115);
        self.itemView.center = CGPointMake(tmpx,tmpy);
        self.itemView.delegate = self;
        rotationTransform1[i] = CATransform3DIdentity;

        CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
        CATransform3D rotationTransform = CATransform3DIdentity;
        rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
        self.itemView.layer.transform=rotationTransform;
        [self.view addSubview:self.itemView];
        
    }
    self.currentTag = TAGSTART;
}

#pragma mark - TCItemViewDelegate
-(void)more{
    NSLog(@"more");
    [self.navigationController pushViewController:kVCFromSb(@"MoreViewController", @"Main") animated:YES];
}
-(void)IAmTeacher{
    [self.navigationController pushViewController:kVCFromSb(@"ComingShowViewController", @"Main") animated:YES];
}
-(void)questions{
    NSLog(@"questions");
}
-(void)share{
    NSLog(@"share");
}
-(void)foundTeacher{
    NSLog(@"foundTeacher");
    [self.navigationController pushViewController:kVCFromSb(@"FoundShowViewController", @"Main") animated:YES];
}
- (void)didTapped:(NSInteger)index {
    //防止点击立即进入效果，要先将点击的按钮显示到最前方，然后点击进入相应界面
    if (self.currentTag  == index) {
//       NSLog(@"自定义处理事件,%ld",index);
        if (index == 1000) {
            [self IAmTeacher];
        }else if (index == 1001) {
            [self more];
        }else if(index == 1002){
            [self questions];
        }else if(index == 1003){
            [self share];
        }else{
            [self foundTeacher];
        }
        //防止第一次点击旋转一圈
        return;
    }

    NSInteger t = [self getIemViewTag:index];
    
    for (NSInteger i = 0;i<PHOTONUM;i++ ) {
        
        UIView *view = [self.view viewWithTag:TAGSTART+i];
        [view.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
        [view.layer addAnimation:[self setscale:TAGSTART+i clicktag:index] forKey:@"transform"];
        
        NSInteger j = array[index - TAGSTART][i];
        CGFloat Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
    }
    self.currentTag  = index;
}

- (CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag {
    
    NSInteger i = array[clicktag - TAGSTART][tag - TAGSTART];
    NSInteger i1 = array[self.currentTag  - TAGSTART][tag - TAGSTART];
    CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
    CGFloat Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
    if (Scalenumber < 0.3) {
        Scalenumber = 0.4;
    }
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = TIME;
    animation.repeatCount =1;
    
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

- (CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num {
    // CALayer
    UIView *view = [self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,view.layer.position.x,view.layer.position.y);
    
    NSInteger p =  [self getIemViewTag:tag];
    CGFloat f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
    CGFloat h = f + 2.0*M_PI *num/PHOTONUM;
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    CGFloat tmpy =  centery + RADIUS*cos(h);
    CGFloat tmpx =	centerx - RADIUS*sin(h);
    view.center = CGPointMake(tmpx,tmpy);
    
    CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = TIME;
    animation.repeatCount = 1;
    animation.calculationMode = @"paced";
    return animation;
}

- (NSInteger)getIemViewTag:(NSInteger)tag {
    
    if (self.currentTag >tag){
        return self.currentTag  - tag;
    } else {
        return PHOTONUM  - tag + self.currentTag ;
    }
}

@end




@interface TCItemView ()

@property (nonatomic, strong) NSString *normal;
@property (nonatomic, strong) NSString *highlighted_;
@property (nonatomic, assign) NSInteger tag_;
@property (nonatomic, strong) NSString *title;

@end

@implementation TCItemView

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title {
    
    self = [super init];
    if (self) {
        _normal = normal;
        _highlighted_ = highlighted;
        _tag_ = tag;
        _title = title;
        [self configViews];
    }
    return self;
}

#pragma mark - configViews

- (void)configViews {
    
    self.tag = _tag_;
    [self setBackgroundImage:[UIImage imageNamed:_normal] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:_highlighted_] forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self setTitle:_title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
}

- (void)btnTapped:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapped:)]) {
        [self.delegate didTapped:sender.tag];
    }
}


@end
