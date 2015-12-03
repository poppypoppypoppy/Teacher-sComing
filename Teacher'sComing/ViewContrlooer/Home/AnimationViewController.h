//
//  AnimationViewController.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/3.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <UIKit/UIKit.h>

//协议
@protocol TCItemViewDelegate <NSObject>
- (void)didTapped:(NSInteger)index;
@end

@interface AnimationViewController : UIViewController
@end

@interface TCItemView : UIButton
@property (nonatomic, weak) id <TCItemViewDelegate>delegate;

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title;
@end