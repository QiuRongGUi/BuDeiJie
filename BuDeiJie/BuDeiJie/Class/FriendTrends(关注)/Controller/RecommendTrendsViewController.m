//
//  RecommendTrendsViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "RecommendTrendsViewController.h"


#import "TrendsCategoryModel.h"

#import "UserGroupModel.h"

#import "TrendsCategoryTableViewCell.h"
#import "GroupTableViewCell.h"

@interface RecommendTrendsViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray <TrendsCategoryModel *> *CategoryData;

@property (nonatomic,strong) NSMutableArray <UserGroupModel *> *rightData;

@property (weak, nonatomic) IBOutlet UITableView *leftTable;

@property (weak, nonatomic) IBOutlet UITableView *rightTable;

@property (nonatomic,strong) TrendsCategoryModel * currentModel;

@property (nonatomic,assign) int page;

@end

@implementation RecommendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    self.leftTable.tableFooterView = [[UIView alloc] init];
    
    [self loadLeftData];

    
}

- (void)setRefresh{
    
    __weak typeof(self) weakSelf = self;
    
    self.rightTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        weakSelf.page = 1;
        [weakSelf loadNewDataWithModelID];
        
    }];
    
    [self.rightTable.mj_header beginRefreshing];
    
    self.rightTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page ++;
        [weakSelf loadNewDataWithModelID];

    }];
    
}

/**
 “推荐关注”后右侧板块显示的用户数据内容
 */
- (void)loadLeftData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"category";
    dic[@"c"] = @"subscribe";
    
    __weak typeof(self) weakSelf = self;
    
    [PPNetworkHelper GET:QRGURL parameters:dic success:^(id responseObject) {
       
        NSLog(@"%@---responseObject",responseObject);
        
        NSArray *list = responseObject[@"list"];
        weakSelf.CategoryData = [TrendsCategoryModel mj_objectArrayWithKeyValuesArray:list];
        
        weakSelf.currentModel = [weakSelf.CategoryData firstObject];

        [weakSelf.leftTable reloadData];
        
        [weakSelf setRefresh]; // right 刷新
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 获取“推荐关注”中左侧标签每个标签对应的推荐用户组
 */
- (void)loadNewDataWithModelID{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"list";
    dic[@"c"] = @"subscribe";
    dic[@"category_id"] = self.currentModel.ID;
    dic[@"page"] = [NSString stringWithFormat:@"%d",self.page];

    __weak typeof(self) weakSelf = self;

    [PPNetworkHelper GET:QRGURL parameters:dic success:^(id responseObject) {
        
//        NSLog(@"%@---responseObject",responseObject);
        
        NSArray *list = responseObject[@"list"];
        
        NSLog(@"%ld---liist",list.count);
        [weakSelf endRefresh];

        if(!kArrayIsEmpty(list)){
            
            if(weakSelf.page == 1){
                
                if(list.count < 20){
                    
                    [weakSelf.rightTable.mj_footer endRefreshingWithNoMoreData];
                }

                weakSelf.rightData = [UserGroupModel mj_objectArrayWithKeyValuesArray:list];
                
            }else{
                
                if(list.count > 0){
                    
                    NSArray *array = [UserGroupModel mj_objectArrayWithKeyValuesArray:list];
                    [self.rightData addObjectsFromArray:array];
                    if(list.count < 20){
                        
                        [weakSelf.rightTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
              
            }
        }else{
            weakSelf.page --;
        }
        
        [weakSelf.rightTable reloadData];
        
    } failure:^(NSError *error) {
        weakSelf.page --;
        [weakSelf endRefresh];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败！"];

    }];
}

- (void)endRefresh{
    
    if([self.rightTable.mj_header isRefreshing]){
        
        [self.rightTable.mj_header endRefreshing];
    }
    
    if([self.rightTable.mj_footer isRefreshing]){
        
        [self.rightTable.mj_footer endRefreshing];
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isEqual:self.leftTable]){
     return 50 + 1;
    }else{
        return 77 + 1;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([tableView isEqual:self.leftTable]){
        
       return self.CategoryData.count;

    }else{
        
        return self.rightData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if([tableView isEqual:self.leftTable]){
        static NSString *tableStr = @"leftCell";
        
        TrendsCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableStr];
        if(!cell){
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TrendsCategoryTableViewCell" owner:self options:nil]firstObject];
        }
        
        TrendsCategoryModel *mod = self.CategoryData[indexPath.row];
        cell.categare.text = mod.name;
        
        
        return cell;

    }else{
        static NSString *tableStr = @"rightCell";
        
        GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableStr];
        if(!cell){
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupTableViewCell" owner:self options:nil]firstObject];
        }
        
        UserGroupModel *mod = self.rightData[indexPath.row];
        cell.mod = mod;
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isEqual:self.leftTable]){
        
        self.currentModel = self.CategoryData[indexPath.row];
        [self setRefresh];
    }
  
}

@end
