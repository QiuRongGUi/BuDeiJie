//
//  MeViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "MeViewController.h"

#import "QRGUIKit.h"

#import "TableViewCell.h"

#import "FootView.h"


#import "Square_list.h"

#import "QRG.pch"


@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * imageData;

@property (nonatomic,strong) FootView * footView;
@end

@implementation MeViewController

-(NSMutableArray *)imageData
{
    if (!_imageData) {
        _imageData = [NSMutableArray array];
    }
    return _imageData;
}

-(FootView *)footView
{
    if (!_footView) {
        _footView = [[FootView alloc] init];
        self.tableView.tableFooterView = _footView;
    }
    return _footView;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title = @"我的";
    self.tableView.backgroundColor = BaseColor;
    

    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc] initWithCustomView:[QRGUIKit buttonWithframe:CGRectMake(0, 0, 30, 30) aTag:0 addTarget:self action:@selector(moon) aTitleColor:nil aImage:@"mine-moon-icon" aHighlightedImage:@"mine-moon-icon-click" aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:nil]];
    
    UIBarButtonItem *bar2 = [[UIBarButtonItem alloc] initWithCustomView:[QRGUIKit buttonWithframe:CGRectMake(0, 0, 30, 30) aTag:0 addTarget:self action:@selector(setting) aTitleColor:nil aImage:@"mine-setting-icon" aHighlightedImage:@"mine-setting-icon-click" aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:nil]];


    self.navigationItem.rightBarButtonItems = @[bar1,bar2];
    
    
    
    [self loadData];
    
    self.tableView.contentInset = UIEdgeInsetsMake(Margen , 0, 0, 0);
    
    
    

}

- (void)loadData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"a"] = @"square";
    dic[@"c"] = @"topic";
    
    [PPNetworkHelper GET:QRGURL parameters:dic success:^(id responseObject) {
        
        NSArray *square_list = responseObject[@"square_list"];
        
        
        if(!kArrayIsEmpty(square_list)){
            
            [square_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Square_list *mod = [Square_list mj_objectWithKeyValues:obj];
                [self.imageData addObject:mod];
            }];
            
            self.footView.data = self.imageData;
            
            [self.tableView reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@---error",error);
        
    }];
    
    
}


/**
 moon
 */
- (void)moon{
    
    NSLog(@"moon---");
    
}

/**
 setting
 */
- (void)setting{
    
    NSLog(@"setting---");
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44 + Margen;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Cell = @"Cell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(!cell){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil]firstObject];
        
    }

    if(indexPath.section == 0){
        
        cell.textLabel.text = @"登录/注册";
        
    }else{
        
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}


@end
