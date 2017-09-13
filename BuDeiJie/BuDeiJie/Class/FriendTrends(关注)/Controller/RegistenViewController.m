//
//  RegistenViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "RegistenViewController.h"

#import "LoginRegisterView.h"

#import "ThreeView.h"

@interface RegistenViewController ()


@property (weak, nonatomic) IBOutlet UIScrollView *scro;

@property (weak, nonatomic) IBOutlet UIView *scroConterView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation RegistenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    LoginRegisterView *login = [LoginRegisterView createLoginView];
    [self.scroConterView addSubview:login];
    
    
    LoginRegisterView *registerV = [LoginRegisterView createRegisterView];
    registerV.X = kScreenWidth;
    [self.scroConterView addSubview:registerV];

    
    ThreeView *three = [ThreeView createThreeView];
    
    [self.bottomView addSubview:three];
    
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)clikeRegister:(UIButton *)sender {
    
    
    sender.selected = ! sender.selected;

    [self.scro setContentOffset:CGPointMake(kScreenWidth * sender.selected, 0) animated:YES];
    

}



@end
