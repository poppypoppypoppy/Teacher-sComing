//
//  TCLabelTool.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/12/4.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "TCLabelTool.h"

@implementation TCLabelTool
+(UILabel *)labelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    // label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticalNeue-Light" size:30];
    return label;
}
@end
