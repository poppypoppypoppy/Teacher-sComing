//
//  FourMenuViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/6.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "FourMenuViewController.h"
#import "MySelfView.h"
#import <QuartzCore/QuartzCore.h>
@interface FourMenuViewController ()
enum {
    TopLeftViewTag               = 0,
    TopRightViewTag              = 1,
    BottomLeftViewTag            = 3,
    BottomRightViewTag           = 2,
};

@property (nonatomic,strong) UIImageView *centerImageView;

@property (nonatomic,strong) UIView *topLeftView;
@property (nonatomic,strong) UIView *topRightView;
@property (nonatomic,strong) UIView *bottomLeftView;
@property (nonatomic,strong) UIView *bottomRightView;


@property (nonatomic,strong) MySelfView *maskViewTopLeft;
@property (nonatomic,strong) MySelfView *maskViewTopRight;
@property (nonatomic,strong) MySelfView *maskViewbottomLeft;
@property (nonatomic,strong) MySelfView *maskViewbottomRight;


@property (nonatomic) CGRect topLeftRect;
@property (nonatomic) CGRect topRightRect;
@property (nonatomic) CGRect bottomLeftRect;
@property (nonatomic) CGRect bottomRightRect;

@end

@implementation FourMenuViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithTopLeft:(UIViewController *)tl TopRight:(UIViewController *)tr bottomLeft:(UIViewController *)bl bottomRight:(UIViewController *)br
{
    self.topLeftController = tl;
    self.topRightController =tr;
    self.bottomLeftController = bl;
    self.bottomRightController = br;
    
    return self;
}



- (void)rotationToTopLeft
{
    [self.maskViewTopLeft removeFromSuperview];
    [self rotation:180 withAnimation:YES completion:^(BOOL finished) {
        [self displayViewController:self.topLeftController];
    }];
}

- (void)rotationToTopRight
{
    [self.maskViewTopRight removeFromSuperview];
    [self rotation:90 withAnimation:YES completion:^(BOOL finished){
        [self displayViewController:self.topRightController];
    }];
}

- (void)rotationToBottomLeft
{
    [self.maskViewbottomLeft removeFromSuperview];
    [self rotation:-90 withAnimation:YES completion:^(BOOL finished){
        [self displayViewController:self.bottomLeftController];
    }];
}

- (void)rotationToBottomRight
{
    [self.maskViewbottomRight removeFromSuperview];
    [self rotation:0 withAnimation:YES completion:^(BOOL finished) {
        [self displayViewController:self.bottomRightController];
    }];
}

- (void)rotationToDefault
{
    [self rotation:DEFAUTROTATION withAnimation:YES completion:nil];
}

- (void)rotation:(CGFloat) degrees withAnimation:(BOOL) animation completion:(void (^)(BOOL finished))completion
{
    
    CGFloat r = DEGREES_TO_RADIANS(degrees);
    if ( animation ){
        [UIView animateWithDuration:0.3f
                         animations:^{
                             [self rotation:r];
                         }
                         completion:completion
         ];
    } else {
        [self rotation:r];
    }
    
}

-(void)rotation:(CGFloat) r
{
    self.topLeftController.view.transform = CGAffineTransformMakeRotation(-r);
    self.topRightController.view.transform = CGAffineTransformMakeRotation(-r);
    self.bottomLeftController.view.transform = CGAffineTransformMakeRotation(-r);
    self.bottomRightController.view.transform = CGAffineTransformMakeRotation(-r);
    
    self.layerView.transform = CGAffineTransformMakeRotation(r);
    
}

-(void)buttonClick:(id)sender
{
    if (self.currentController){
        [self closeViewController];
        return;
    }
    
    NSInteger tag = ((UIButton *)sender).tag;
    if ( TopLeftViewTag == tag )
        [self rotationToTopLeft];
    else if ( TopRightViewTag == tag )
        [self rotationToTopRight];
    else if ( BottomLeftViewTag == tag )
        [self rotationToBottomLeft];
    else if ( BottomRightViewTag == tag )
        [self rotationToBottomRight];
    
}

- (void) loadView
{
    [super loadView];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    NSInteger size = 4;
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size * width, size*height)];
    self.layerView.backgroundColor = [UIColor blackColor];
    self.topLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width * size/2 , height * size/2)];
    self.topLeftView.clipsToBounds = YES;
    self.maskViewTopLeft = [[MySelfView alloc]initWithFrame:self.topLeftView.frame];
    
    self.topRightView = [[UIView alloc]initWithFrame:CGRectMake(width * size/2, 0, width * size/2, height * size/2)];
    self.topRightView.clipsToBounds = YES;
    self.maskViewTopRight = [[MySelfView alloc]initWithFrame:self.topRightView.frame];
    
    self.bottomLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, height * size/2 , width * size/2, height * size/2 )];
    self.bottomLeftView.clipsToBounds = YES;
    self.maskViewbottomLeft = [[MySelfView alloc]initWithFrame:self.bottomLeftView.frame];
    
    self.bottomRightView = [[UIView alloc]initWithFrame:CGRectMake(width * size/2, height * size/2, width * size/2, height * size/2)];
    self.bottomRightView.clipsToBounds = YES;
    self.maskViewbottomRight = [[MySelfView alloc]initWithFrame:self.bottomRightView.frame];
    
    self.topLeftBtn = [self createButtonWithImageNameForNormal:BUTTON_IMAGE_OF_TOPLEFT
                                      imageNameForHightlighted:BUTTON_IMAGE_OF_TOPLEFT_H
                                             transformRotation:180
                                                     buttonTag:TopLeftViewTag];
    self.topLeftBtn.frame = CGRectOffset(self.topLeftBtn.frame
                                         ,CGRectGetMaxX(self.topLeftView.frame)- CGRectGetWidth(self.topLeftBtn.frame)
                                         ,CGRectGetMaxY(self.topLeftView.frame)- CGRectGetHeight(self.topLeftBtn.frame));
    
    self.topRightBtn = [self createButtonWithImageNameForNormal:BUTTON_IMAGE_OF_TOPRIGHT
                                       imageNameForHightlighted:BUTTON_IMAGE_OF_TOPRIGHT_H
                                              transformRotation:-90
                                                      buttonTag:TopRightViewTag];
    
    self.topRightBtn.frame = CGRectOffset(self.topRightBtn.frame
                                          ,CGRectGetMinX(self.topRightView.frame)
                                          ,CGRectGetMaxY(self.topRightView.frame)- CGRectGetHeight(self.topLeftBtn.frame));
    
    self.bottomLeftBtn = [self createButtonWithImageNameForNormal:BUTTON_IMAGE_OF_BOTTOMLEFT
                                         imageNameForHightlighted:BUTTON_IMAGE_OF_BOTTOMLEFT_H
                                                transformRotation:90
                                                        buttonTag:BottomLeftViewTag];
    self.bottomLeftBtn.frame = CGRectOffset(self.bottomLeftBtn.frame
                                            ,CGRectGetMaxX(self.bottomLeftView.frame) - CGRectGetWidth(self.bottomLeftBtn.frame)
                                            ,CGRectGetMinY(self.bottomLeftView.frame) );
    
    self.bottomRightBtn = [self createButtonWithImageNameForNormal:BUTTON_IMAGE_OF_BOTTOMRIGHT
                                          imageNameForHightlighted:BUTTON_IMAGE_OF_BOTTOMRIGHT_H
                                                 transformRotation:0
                                                         buttonTag:BottomRightViewTag];
    self.bottomRightBtn.frame = CGRectOffset(self.bottomRightBtn.frame
                                             ,CGRectGetMinX(self.bottomRightView.frame)
                                             ,CGRectGetMinY(self.bottomRightView.frame));
    
    self.centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BUTTON_IMAGE_OF_CENTER]];
    self.centerImageView.center = self.bottomRightBtn.frame.origin;
    
    [self.layerView addSubview:self.topLeftView];
    [self.layerView addSubview:self.topRightView];
    [self.layerView addSubview:self.bottomLeftView];
    [self.layerView addSubview:self.bottomRightView];
    
    
    [self.view addSubview:self.layerView];
    
}

-(UIButton *)createButtonWithImageNameForNormal:(NSString *)normal imageNameForHightlighted:(NSString *)hightlighted transformRotation:(CGFloat) degree buttonTag:(NSInteger)tag
{
    UIImage *img_n = [UIImage imageNamed:normal];
    UIImage *img_p = [UIImage imageNamed:hightlighted];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, img_n.size.width, img_n.size.height)];
    
    [btn setImage:img_n forState:UIControlStateNormal];
    [btn setImage:img_p forState:UIControlStateHighlighted];
    btn.transform =  CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degree));
    btn.tag = tag;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    [self.topLeftView addSubview:self.topLeftController.view];

    self.topLeftRect = CGRectMake(self.topLeftView.frame.size.width - width/2, self.topLeftView.frame.size.height-height/2, width, height);
    self.topLeftController.view.frame = self.topLeftRect;
    self.topLeftController.view.layer.anchorPoint = CGPointMake(0.5f + (CENTERPOINT_OFFSET_X /width) , 0.5f + (CENTERPOINT_OFFSET_Y/height));
    
    [self.topRightView addSubview:self.topRightController.view];

    self.topRightRect = CGRectMake(- width/2, self.topRightView.frame.size.height - height/2, width, height);
    self.topRightController.view.frame = self.topRightRect;
    self.topRightController.view.layer.anchorPoint = CGPointMake(0.5f + (CENTERPOINT_OFFSET_X /width) , 0.5f + (CENTERPOINT_OFFSET_Y/height));
    
    [self.bottomLeftView addSubview:self.bottomLeftController.view];
 
    self.bottomLeftRect = CGRectMake(self.topRightView.frame.size.width - width/2, -height/2, width, height);
    self.bottomLeftController.view.frame = self.bottomLeftRect;
    self.bottomLeftController.view.layer.anchorPoint = CGPointMake(0.5f + (CENTERPOINT_OFFSET_X /width) , 0.5f + (CENTERPOINT_OFFSET_Y/height));
    
    [self.bottomRightView addSubview:self.bottomRightController.view];
    
    self.bottomRightRect = CGRectMake(-width/2, -height/2, width, height);
    self.bottomRightController.view.frame = self.bottomRightRect;
    self.bottomRightController.view.layer.anchorPoint = CGPointMake(0.5f + (CENTERPOINT_OFFSET_X /width) , 0.5f + (CENTERPOINT_OFFSET_Y/height));
    
    [self.layerView addSubview:self.maskViewTopLeft];
    [self.layerView addSubview:self.maskViewTopRight];
    [self.layerView addSubview:self.maskViewbottomLeft];
    [self.layerView addSubview:self.maskViewbottomRight];
    
    
    UITapGestureRecognizer *tapRecognizer;
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTopLeft:)] ;
    [self.topLeftView addGestureRecognizer:tapRecognizer];
    [self.maskViewTopLeft addGestureRecognizer:tapRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTopRight:)] ;
    [self.topRightView addGestureRecognizer:tapRecognizer];
    [self.maskViewTopRight addGestureRecognizer:tapRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBottomLeft:)] ;
    [self.bottomLeftView addGestureRecognizer:tapRecognizer];
    [self.maskViewbottomLeft addGestureRecognizer:tapRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBottomRight:)] ;
    [self.bottomRightView addGestureRecognizer:tapRecognizer];
    [self.maskViewbottomRight addGestureRecognizer:tapRecognizer];
    
    self.layerView.center = CGPointMake(width/2+ CENTERPOINT_OFFSET_X,height/2+ CENTERPOINT_OFFSET_Y);
    
    [self.layerView addSubview:self.centerImageView];
    
    [self.layerView addSubview:self.topLeftBtn];
    [self.layerView addSubview:self.topRightBtn];
    [self.layerView addSubview:self.bottomLeftBtn];
    [self.layerView addSubview:self.bottomRightBtn];
    
    [self rotation:DEFAUTROTATION withAnimation:NO completion:nil];
}


- (void)handleTapTopLeft:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)     {
        NSLog(@"Tap handleTapTopLeft");
        [self rotationToTopLeft];
    }
}

- (void)handleTapTopRight:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)     {
        NSLog(@"Tap handleTapTopRight");
        [self rotationToTopRight];
    }
}

- (void)handleTapBottomLeft:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)     {
        NSLog(@"Tap handleTapBottomLeft");
        [self rotationToBottomLeft];
    }
}

- (void)handleTapBottomRight:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)     {
        NSLog(@"Tap handleTapBottomRight");
        [self rotationToBottomRight];
        
    }
}
- (void)btnClickClick:(id) sender
{
    [self closeViewController];
    
}

-(void)displayViewController:(UIViewController *)viewController
{
    NSLog(@"display top left");
    self.currentController = viewController;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         CGFloat moveX = self.layerView.center.x;
                         CGFloat moveY = self.layerView.center.y;
                         
                         self.layerView.center = CGPointMake(0, 0);
                         
                         if ( self.currentController == self.topLeftController)
                             self.topLeftController.view.center = CGPointMake(self.topLeftController.view.center.x - moveX,self.topLeftController.view.center.y - moveY);
                         else if ( self.currentController == self.topRightController)
                             self.topRightController.view.center = CGPointMake(self.topRightController.view.center.x + moveY,self.topRightController.view.center.y - moveX);
                         else if ( self.currentController == self.bottomLeftController)
                             self.bottomLeftController.view.center = CGPointMake(self.bottomLeftController.view.center.x - moveY,self.bottomLeftController.view.center.y + moveX);
                         else if ( self.currentController == self.bottomRightController)
                             self.bottomRightController.view.center = CGPointMake(self.bottomRightController.view.center.x + moveX,self.bottomRightController.view.center.y + moveY);
                         
                         
                     }
                     completion:^(BOOL finished) {
                     }];
}

-(void)closeViewController
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         CGFloat width = self.view.frame.size.width;
                         CGFloat height = self.view.frame.size.height;
                         
                         CGFloat moveX = width/2+ CENTERPOINT_OFFSET_X;
                         CGFloat moveY = height/2+ CENTERPOINT_OFFSET_Y;
                         
                         self.layerView.center = CGPointMake(moveX,moveY);
                         
                         if ( self.currentController == self.topLeftController)
                             self.topLeftController.view.center = CGPointMake(self.topLeftController.view.center.x + moveX,self.topLeftController.view.center.y + moveY);
                         else if ( self.currentController == self.topRightController)
                             self.topRightController.view.center = CGPointMake(self.topRightController.view.center.x - moveY,self.topRightController.view.center.y + moveX);
                         else if ( self.currentController == self.bottomLeftController)
                             self.bottomLeftController.view.center = CGPointMake(self.bottomLeftController.view.center.x + moveY,self.bottomLeftController.view.center.y - moveX);
                         else if ( self.currentController == self.bottomRightController)
                             self.bottomRightController.view.center = CGPointMake(self.bottomRightController.view.center.x - moveX,self.bottomRightController.view.center.y - moveY);
                     }
                     completion:^(BOOL finished) {
                         [self rotation:DEFAUTROTATION withAnimation:YES completion:^(BOOL finished){
                             if ( self.currentController == self.topLeftController)
                                 [self addButtomViewAndMaskView:self.maskViewTopLeft];
                             else if ( self.currentController == self.topRightController)
                                 [self addButtomViewAndMaskView:self.maskViewTopRight];
                             else if ( self.currentController == self.bottomLeftController)
                                 [self addButtomViewAndMaskView:self.maskViewbottomLeft];
                             else if ( self.currentController == self.bottomRightController )
                                 [self addButtomViewAndMaskView:self.maskViewbottomRight];
                             
                             self.currentController = nil;
                             
                         }];
                     }];
}

- (void)addButtomViewAndMaskView:(MySelfView *)maskView
{
    [self.layerView insertSubview:maskView belowSubview:self.centerImageView];
    
}

- (void)removeButtomView
{
    [self.topLeftBtn removeFromSuperview];
    [self.topRightBtn removeFromSuperview];
    [self.bottomLeftBtn removeFromSuperview];
    [self.bottomRightBtn removeFromSuperview];
    
    [self.centerImageView reloadInputViews];
    
}


@end
