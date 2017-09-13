//
//  ThreeView.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "ThreeView.h"

@implementation ThreeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createThreeView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil]firstObject];
    
}
@end
