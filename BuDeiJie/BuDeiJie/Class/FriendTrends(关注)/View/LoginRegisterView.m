//
//  LoginRegisterView.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "LoginRegisterView.h"

@implementation LoginRegisterView



+ (instancetype)createLoginView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil]firstObject];
}

+ (instancetype)createRegisterView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
}
@end
