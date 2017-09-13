//
//  QRGTabBarController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "QRG.pch"

#import "QRGTabBar.h"
#import "QRGTabBarController.h"
#import "QRGNavigationController.h"


#import "EssenceViewController.h"
#import "FriendTrendsViewController.h"
#import "MeViewController.h"
#import "NewViewController.h"
#import "PublishViewController.h"


@interface QRGTabBarController ()<UITabBarControllerDelegate,QRGTabBarPostDelegate>

@end

@implementation QRGTabBarController

+ (void)initialize{
    
    UITabBarItem *tabBar = [UITabBarItem appearance];
    
    [tabBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:kRGBColor(129, 121, 118)} forState:UIControlStateNormal];
    
    [tabBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:kRGBColor(71, 71, 71)} forState:UIControlStateSelected];

    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.delegate = self;
    
    
    [self setViewController:@"EssenceViewController" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    [self setViewController:@"NewViewController" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];

    [self setViewController:@"FriendTrendsViewController" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];

    [self setViewController:@"MeViewController" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];
    
    [self setValue:[[QRGTabBar alloc] init] forKeyPath:@"tabBar"];


}



- (void)setViewController:(NSString *)aViewController image:(NSString *)aImage selectedImage:(NSString *)aSelectedImage title:(NSString *)aTitle{
    

    UIViewController *vc = [[NSClassFromString(aViewController) alloc] init];
    
    UIImage *image = [[UIImage imageNamed:aImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [[UIImage imageNamed:aSelectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:aTitle image:image selectedImage:selectedImage];
    
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:na];
    


}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%ld---tabBarController",tabBarController.selectedIndex);
    
}
#pragma mark - QRGTabBarPostDelegate

- (void)QRGTabBarClikePost{
    
    PublishViewController *public = [[PublishViewController alloc] init];
    
    [self presentViewController:public animated:YES completion:nil];

}
@end
