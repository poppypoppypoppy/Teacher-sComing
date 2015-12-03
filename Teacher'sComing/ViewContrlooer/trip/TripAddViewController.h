//
//  TripAddViewController.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TripAddViewController;

@protocol TripAddViewControllerDelegate <NSObject>

@optional

- (void)VCAddMessageSuccessUpdateMessage:(TripAddViewController *)addVC;

@end

@interface TripAddViewController : UIViewController

@property(nonatomic,weak)id<TripAddViewControllerDelegate> delegate;

@end