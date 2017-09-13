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

@property (nonatomic,strong) LoginRegisterView *login;

@property (nonatomic,strong) LoginRegisterView *registerV;

@property (nonatomic,strong) ThreeView *three ;

@end

@implementation RegistenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.login = [LoginRegisterView createLoginView];
    [self.scroConterView addSubview:self.login];
    
    
    self.registerV = [LoginRegisterView createRegisterView];
    [self.scroConterView addSubview:self.registerV];

    
    self.three = [ThreeView createThreeView];
    [self.bottomView addSubview:self.three];
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    self.login.frame = CGRectMake(0, 0, self.scro.width, self.scro.height);
    self.registerV.frame = CGRectMake(self.scro.width, 0, self.scro.width, self.scro.height);
    self.three.frame = self.bottomView.bounds;

    
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)clikeRegister:(UIButton *)sender {
    
    
    sender.selected = ! sender.selected;

    [self.scro setContentOffset:CGPointMake(kScreenWidth * sender.selected, 0) animated:YES];
}



@end
