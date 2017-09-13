//
//  NewViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "NewViewController.h"

#import "QRGUIKit.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];


    
}

- (void)clike:(UIButton *)sends{
    
    NSLog(@"%ld---",sends.tag);
    
    
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
