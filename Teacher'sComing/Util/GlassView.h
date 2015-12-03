//
//  GlassView.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/10/31.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 *毛玻璃
 */
@interface GlassView : NSObject

@property(nonatomic,strong)UIView *view;
+(void)glassView:(UIView *)view rectX:(CGFloat)x rectY:(CGFloat)y rectW:(CGFloat)w rectH:(CGFloat)h;

@end
