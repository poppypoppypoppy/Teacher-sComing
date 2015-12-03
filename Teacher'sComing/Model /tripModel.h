//
//  tripModel.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tripModel : NSObject
@property(nonatomic,strong)NSString *trip;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)UIImage *iconIV;
-(instancetype)initWithIconIV:(UIImage *)imageIV time:(NSString *)time trip:(NSString *)trip;
+(instancetype)tripWithIconIV:(UIImage *)imageIV time:(NSString *)time trip:(NSString *)trip;
@end
