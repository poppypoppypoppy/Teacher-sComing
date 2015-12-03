//
//  GlassView.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/10/31.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "GlassView.h"

@implementation GlassView
+(void)glassView:(UIView *)view rectX:(CGFloat)x rectY:(CGFloat)y rectW:(CGFloat)w rectH:(CGFloat)h{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(x, y, w, h);
    [view addSubview:effectview];
}
@end
