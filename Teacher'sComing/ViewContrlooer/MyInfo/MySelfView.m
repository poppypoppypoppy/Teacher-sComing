//
//  MySelfView.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/5.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "MySelfView.h"

@implementation MySelfView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, .60);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, .80);
    CGRect clips[] = {rect};
    CGContextClipToRects(context, clips, sizeof(clips) / sizeof(clips[0]));
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3.0);
    
    CGContextFillRect(context, self.bounds);
    CGContextStrokeRect(context, self.bounds);
    UIGraphicsEndImageContext();
}
@end
