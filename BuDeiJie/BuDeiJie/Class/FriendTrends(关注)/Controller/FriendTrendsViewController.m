//
//  FriendTrendsViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "FriendTrendsViewController.h"

#import "RecommendTrendsViewController.h"

#import "RegistenViewController.h"


@interface FriendTrendsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"关注";
    
    UIButton *leftBut = [QRGUIKit buttonWithframe:CGRectMake(0, 0, 30, 30) aTag:1 addTarget:self action:@selector(clikeTrends) aTitleColor:nil aImage:@"friendsRecommentIcon" aHighlightedImage:@"friendsRecommentIcon-click" aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBut];
    
    
    self.lable.text = @"快快登录吧，关注百思最新牛人\n好友动态让你过吧瘾~~\n欧耶~~";
    
}

/**
 关注列表
 */
- (void)clikeTrends{
    
    RecommendTrendsViewController *recommend = [[RecommendTrendsViewController  alloc] initWithNibName:@"RecommendTrendsViewController" bundle:nil];
    [self.navigationController pushViewController:recommend animated:YES];
    
}

- (IBAction)login:(id)sender {
    
    RegistenViewController *regis = [[RegistenViewController  alloc] initWithNibName:@"RegistenViewController" bundle:nil];

    [self presentViewController:regis animated:YES completion:nil];
    
}

@end
