//
//  FoundBaseViewController.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/17.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundBaseViewController : UIViewController
{
    UIButton * navRightButton;
    UIImageView* _clearImg;
    bool _clearFlag;
    
    UIButton* _lcksBtn;
    UIButton* _wjxxBtn;
    UIButton* _jkpgBtn;
    UIButton* _jkjhBtn;
    
    int _mmMainFX;
    int _mmMainFY;
    int _vFX;
    int _vFY;
}
@end
