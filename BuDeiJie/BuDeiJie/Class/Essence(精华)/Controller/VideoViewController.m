//
//  VideoViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/11.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "VideoViewController.h"

#import "KrVideoPlayerController.h"

@interface VideoViewController ()

/**视频**/
@property (nonatomic, strong) KrVideoPlayerController  *videoController;

@end

@implementation VideoViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    if (!self.videoController) {
        
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0,200,kScreenWidth,200)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        
        [self.view addSubview:self.videoController.view];
//        [self.videoController showInWindow];
        
    }
    
    self.videoController.contentURL = [NSURL URLWithString:self.str];
    


}

- (void)toolbarHidden:(BOOL)state{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
