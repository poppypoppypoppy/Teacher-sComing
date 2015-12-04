//
//  billModel.h
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/11/20.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface billModel : NSObject
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *time;
-(instancetype)initWithTime:(NSString *)time money:(NSString *)money detail:(NSString *)detail;
+(instancetype)billWithTime:(NSString *)time money:(NSString *)money detail:(NSString *)detail;
@end
