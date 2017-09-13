//
//  PictureViewController.m
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/10.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation PictureViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:request];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"show_image_back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}

- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    QRGLog;
    [SVProgressHUD setStatus:@"正在加载图片---- "];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    QRGLog;
    [SVProgressHUD dismiss];
    
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
