//
//  VoiceTableViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//
#import "AVPlayerManager.h"

#import "VoiceTableViewController.h"

#import "VoiceTableViewCell.h"

#import "EssenceModelF.h"

#import "EssenceModel.h"

static NSString  * const VoiceTableViewControllerId = @"VoiceTableViewController";

@interface VoiceTableViewController ()<VoiceTableViewCellDelegate,KSAudioPlayerManagerDelegate>{
    
    EssenceModelF *currentModf; // 上次选中 voice
    NSInteger index; // 上次选中 index

}

/**数据 data**/
@property (nonatomic,strong) NSMutableArray * data;

/**第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。**/
@property (nonatomic,copy) NSString * maxtime;
/** voice 播放 **/
@property (nonatomic,strong) AVPlayerManager * playerManager;
@end

@implementation VoiceTableViewController

-(AVPlayerManager *)playerManager
{
    if (!_playerManager) {
        _playerManager = [AVPlayerManager sharedManager];
        _playerManager.delegate = self;
    }
    return _playerManager;
}

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
    
    __weak typeof(self) weakSelf = self;

    [[NSNotificationCenter defaultCenter]addObserverForName:AVPlayerItemDidPlayToEnd object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSInteger test = 0;
        currentModf.mod.playerState = NO;
        currentModf.mod.value = NO;
        currentModf = nil;
        index = test;
        [weakSelf.tableView reloadData];

    }];
    
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
    dic[@"type"] = @"31";
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
    dic[@"type"] = @"31";
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
    
    return modf.CellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    VoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VoiceTableViewControllerId];
    
    if(!cell){
        
        cell = [[VoiceTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VoiceTableViewControllerId];
    }
    
    cell.delegate = self;
    
    EssenceModelF *modF = self.data[indexPath.row];
    
    cell.modf = modF;
    
    cell.indexPath = indexPath.row;
    
    return cell;
    
}
#pragma mark -- VoiceTableViewCellDelegate

- (void)voicePlayerWithIndexPath:(NSInteger)aIndexPath{
    
    
    EssenceModelF *modf = self.data[aIndexPath];
    
    

    if(index == aIndexPath){
        
        NSLog(@"0000");
        
    }else{
        Voice *vMod = [[Voice alloc] init];
        vMod.index = 0;
        vMod.audioFileURL = [NSURL URLWithString:modf.mod.voiceuri];
        self.playerManager.currentVoice = vMod;

    }
    
    index = aIndexPath;
    
    
    if(currentModf){
        
        if(currentModf == modf){
            
        }else{
            currentModf.mod.playerState = NO;

        }
    }else{
        
    }

    if(modf.mod.playerState){
        
        [self.playerManager pause];
        NSLog(@"1111");
        
    }else{
        
        [self.playerManager play];
        NSLog(@"0000");

    }
    modf.mod.playerState = ! modf.mod.playerState;
    
    currentModf = modf;
    
    [self.tableView reloadData];

    
    
}

- (void)voicePlayerUpdateProgressWithSlider:(UISlider *)slider cell:(VoiceTableViewCell *)cell{
    
    NSLog(@"%f---slider.value",slider.value);
    [self.playerManager setupCurrentTimeWithSilderValue:slider.value completion:nil];
    
}
#pragma  mark -- KSAudioPlayerManagerDelegate

- (void)updateProgressWithPlayer:(AVPlayer *)player{
    
    NSTimeInterval current = CMTimeGetSeconds(player.currentItem.currentTime);
    NSTimeInterval total = CMTimeGetSeconds(player.currentItem.duration);
    
    NSLog(@"%.2f",current / total);
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    
    VoiceTableViewCell  *cell = [self.tableView cellForRowAtIndexPath:path];
    
//    cell.image1.progress.progress = current / total;
    
//    cell.image1.viceoSlider.value = current / total;
    
    cell.modf.mod.progress = current / total;
    
//    cell.modf.mod.value = current / total;
    
//    cell.modf.mod.progress = 0.73;
//    cell.modf.mod.value = 0.73;

//    [self.tableView reloadData];
    
    
    
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEnd object:nil];
    
}
@end
