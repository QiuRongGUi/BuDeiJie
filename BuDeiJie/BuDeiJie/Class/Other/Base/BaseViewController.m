//
//  BaseViewController.m
//  JIE
//
//  Created by QIUGUI on 2017/8/19.
//  Copyright © 2017年 QIUGUI. All rights reserved.
//

#import "BaseViewController.h"
#import "QRG.pch"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

       
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = kRandomColor;
    
    

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
