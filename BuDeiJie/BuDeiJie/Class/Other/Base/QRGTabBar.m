//
//  QRGTabBar.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "QRGTabBar.h"

#import "QRG.pch"

@interface QRGTabBar()

@property (nonatomic,strong) UIButton * centerBut;

@end

@implementation QRGTabBar



- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [but addTarget:self action:@selector(clikePost:) forControlEvents:UIControlEventTouchUpInside];
        but.backgroundColor = [UIColor greenColor];
        
        [self addSubview:but];
        
        self.centerBut = but;
        
    }
    
    return self;
}
- (void)clikePost:(UIButton *)sends{
    NSLog(@"post --");
    
    if([self.delegate respondsToSelector:@selector(QRGTabBarClikePost)]){
        [self.delegate QRGTabBarClikePost];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    int index = 0;
        
    CGFloat w = kScreenWidth / 5;
    
    for (UIView *vc in self.subviews) {
        
        if([vc isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            
            vc.X = w * index;
            index ++;
            
            if(index == 2){
                index ++;
            }
                    
        }
        
    }

    self.centerBut.width = self.centerBut.currentImage.size.width;
    self.centerBut.height = self.centerBut.currentImage.size.height;
    self.centerBut.centerX = self.centerX;
    

}
@end
