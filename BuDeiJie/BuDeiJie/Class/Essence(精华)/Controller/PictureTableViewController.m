//
//  PictureTableViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//
#import "PictureTableViewCell.h"

#import "EssenceModelF.h"

#import "EssenceModel.h"


#import "PictureTableViewController.h"

#import "PictureViewController.h"

#import "GifPictureViewController.h"

static NSString  * const PictureTableViewControllerId = @"PictureTableViewController";

@interface PictureTableViewController ()<PictureTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray * data;

/**第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。**/
@property (nonatomic,copy) NSString * maxtime;

@end

@implementation PictureTableViewController
-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(Nav + TitleH, 0, TabBarH, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = BaseColor;
    
    
    [self setRefresh];
    
    
}

- (void)setRefresh{
    
    __block typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf moreData];
        
    }];
    
    //自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

/**
 最新数据
 */
- (void)loadData{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"newlist";
    dic[@"type"] = @"10";
    dic[@"c"] = @"data";
    
    __block typeof(self) weakSelf = self;
    
    [PPNetworkHelper GET:QRGURL parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@--responseObject",responseObject);

        [self.data removeAllObjects];
        
        NSDictionary *info = responseObject[@"info"];
        
        NSArray *list = responseObject[@"list"];
        

        if(!kArrayIsEmpty(list)){
            
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                EssenceModelF *modf = [[EssenceModelF alloc] init];
                
                EssenceModel *mod = [EssenceModel mj_objectWithKeyValues:obj];
                modf.mod = mod;
                [weakSelf.data addObject:modf];
                
            }];
        }
        
        if(!kDictIsEmpty(info)){
            
            weakSelf.maxtime = info[@"maxtime"];
        }
        
        [weakSelf.tableView reloadData];
        
        [weakSelf endRefresh];
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
    }];
    
}

/**
 更多数据
 */
- (void)moreData{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"list";
    dic[@"type"] = @"10";
    dic[@"c"] = @"data";
    dic[@"maxtime"] = self.maxtime;
    
    __block typeof(self) weakSelf = self;
    
    [PPNetworkHelper GET:QRGURL parameters:dic success:^(id responseObject) {
        
        NSDictionary *info = responseObject[@"info"];
        
        NSArray *list = responseObject[@"list"];
        
        if(!kArrayIsEmpty(list)){
            
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                EssenceModelF *modf = [[EssenceModelF alloc] init];
                EssenceModel *mod = [EssenceModel mj_objectWithKeyValues:obj];
                modf.mod = mod;
                [weakSelf.data addObject:modf];
                
            }];
        }
        
        if(!kDictIsEmpty(info)){
            
            weakSelf.maxtime = info[@"maxtime"];
        }
        
        [weakSelf endRefresh];
        
        [weakSelf.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
    }];
    
}

- (void)endRefresh{
    
    if(self.tableView.mj_header){
        
        [self.tableView.mj_header endRefreshing];
    }
    
    if(self.tableView.mj_footer){
        
        [self.tableView.mj_footer endRefreshing];
    }
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EssenceModelF *modf = self.data[indexPath.row];
    
    return modf.CellH + 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PictureTableViewControllerId];
    
    if(!cell){
        
        cell = [[PictureTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PictureTableViewControllerId];
    }
    
    cell.backgroundColor = kRandomColor;
    cell.indexPath = indexPath.row;
    cell.delegate = self;
    EssenceModelF *modF = self.data[indexPath.row];
    
    cell.modf = modF;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EssenceModelF *modf = self.data[indexPath.row];

    NSLog(@"%@--indexPath--%@ -- %@",modf.mod.image1,modf.mod.width,modf.mod.height);
    
}

#pragma mark -- PictureTableViewCellDelegate

- (void)PictureTableViewCellClikePictureWithIndexPath:(NSInteger)indexPath{
    
    EssenceModelF *modf = self.data[indexPath];
       

    NSLog(@"%@---modf.mod.image1 --%@ --- %@",modf.mod.image1,modf.mod.width,modf.mod.height);

    if([modf.mod.height intValue] > kScreenHeight){
        
        PictureViewController *picture = [[PictureViewController alloc] initWithNibName:@"PictureViewController" bundle:nil];
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:picture];
        picture.url = modf.mod.image1;
        [self presentViewController:na animated:YES completion:nil];

    }else{
        
        GifPictureViewController *gif = [[GifPictureViewController alloc] initWithNibName:@"GifPictureViewController" bundle:nil];
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:gif];
        gif.url = modf.mod.image1;
        [self presentViewController:na animated:YES completion:nil];

    }
    
       
}

@end
