//
//  EssenceViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "EssenceViewController.h"


#import "AllTableViewController.h"
#import "VideoTableViewController.h"
#import "VoiceTableViewController.h"
#import "PictureTableViewController.h"
#import "TopicTableViewController.h"


#import "TopTitleView.h"

const NSInteger selectedIndex = 4;

@interface EssenceViewController ()<TopTitleViewDelegate,UIScrollViewDelegate>

/** <#class#>*/
@property(nonatomic,strong) TopTitleView  *top;

@property (nonatomic,strong) UIScrollView * contentScrollView;
@end

@implementation EssenceViewController

-(UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        
        UIScrollView  *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        ScrollView.delegate = self;
        ScrollView.pagingEnabled = YES;
        ScrollView.bounces = NO;
        ScrollView.backgroundColor = [UIColor whiteColor];
        _contentScrollView = ScrollView;
    }
    return _contentScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
    
    [self setUI];
    
    
}

- (void)setUI{
    
    NSArray *titleData = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.contentSize = CGSizeMake(kScreenWidth * titleData.count, self.contentScrollView.height);
    
    self.top = [[TopTitleView alloc] init];
    self.top.delegate = self;
    self.top.topTtileData = titleData;

    self.top.selectedIndex = selectedIndex;
    self.top.frame  =CGRectMake(0, 64, kScreenWidth, 50);

    [self.view addSubview:self.top];
    
    
    
    [self addChildViewController:[[AllTableViewController alloc] init]];
    [self addChildViewController:[[VideoTableViewController alloc] init]];
    [self addChildViewController:[[VoiceTableViewController alloc] init]];
    [self addChildViewController:[[PictureTableViewController alloc] init]];
    [self addChildViewController:[[TopicTableViewController alloc] init]];
    
    
    [self TopTitleViewClikeTitleWithIndexPath:selectedIndex];
    
    
}

#pragma mark --- TopTitleViewDelegate

/**
点击topic title

 @param aIndex <#aIndex description#>
 */
- (void)TopTitleViewClikeTitleWithIndexPath:(NSInteger)aIndex{
    
    
    __block typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [weakSelf.contentScrollView setContentOffset:CGPointMake(kScreenWidth * aIndex, 0) animated:YES];
        
    } completion:^(BOOL finished) {
        
        UIView *vc = weakSelf.childViewControllers[aIndex].view;
        
        if(vc.window) return ; //
        
        vc.frame = CGRectMake(weakSelf.contentScrollView.width * aIndex, 0, weakSelf.contentScrollView.width, weakSelf.contentScrollView.height);
//        vc.frame = self.contentScrollView.bounds;
        [weakSelf.contentScrollView addSubview:vc];
        
        
    }];
    
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"%f---scrollView",scrollView.contentOffset.x);
    
    int index = scrollView.contentOffset.x / scrollView.width;
    
    NSLog(@"%zd---index",index);
    
    [self TopTitleViewClikeTitleWithIndexPath:index];
    
    self.top.selectedIndex = index;
}

@end
