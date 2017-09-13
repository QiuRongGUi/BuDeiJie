//
//  QRGTabBar.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRGTabBarPostDelegate <UITabBarDelegate>

- (void)QRGTabBarClikePost;

@end

@interface QRGTabBar : UITabBar

@property (nonatomic,weak) id<QRGTabBarPostDelegate> delegate;


@end
