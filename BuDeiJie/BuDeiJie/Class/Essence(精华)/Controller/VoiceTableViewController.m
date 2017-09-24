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

#import "WMPlayer.h"

static NSString  * const VoiceTableViewControllerId = @"VoiceTableViewController";

@interface VoiceTableViewController ()<VoiceTableViewCellDelegate,WMPlayerDelegate>{
    
//    EssenceModelF *currentModf; // 上次选中 voice
//    NSInteger index; // 上次选中 index
    
    WMPlayer *wmPlayer;

    NSIndexPath *currentIndexPath;

}

/**数据 data**/
@property (nonatomic,strong) NSMutableArray * data;

/**第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。**/
@property (nonatomic,copy) NSString * maxtime;
/** voice 播放 **/
@property (nonatomic,strong) AVPlayerManager * playerManager;

@property(nonatomic,retain)VoiceTableViewCell *currentCell;

@end

@implementation VoiceTableViewController

//-(AVPlayerManager *)playerManager
//{
//    if (!_playerManager) {
//        _playerManager = [AVPlayerManager sharedManager];
//        _playerManager.delegate = self;
//    }
//    return _playerManager;
//}

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
    
    [self.tableView registerClass:[VoiceTableViewCell class] forCellReuseIdentifier:VoiceTableViewControllerId];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = BaseColor;
    
    [self setRefresh];
    
    __weak typeof(self) weakSelf = self;

//    [[NSNotificationCenter defaultCenter]addObserverForName:AVPlayerItemDidPlayToEnd object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        NSInteger test = 0;
//        currentModf.mod.playerState = NO;
//        currentModf.mod.value = NO;
//        currentModf = nil;
//        index = test;
//        [weakSelf.tableView reloadData];
//
//    }];
    
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
    
    cell.delegate = self;
    
    EssenceModelF *modF = self.data[indexPath.row];
    
    cell.modf = modF;
    
    cell.indexPath = indexPath.row;
    
    if (wmPlayer&&wmPlayer.superview) {
        if (indexPath.row==currentIndexPath.row) {
            [cell.image1.butType.superview sendSubviewToBack:cell.image1.butType];
        }else{
            [cell.image1.butType.superview bringSubviewToFront:cell.image1.butType];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]&&currentIndexPath!=nil) {//复用
            
//            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
//                wmPlayer.hidden = NO;
//            }else{
//                wmPlayer.hidden = YES;
//                [cell.image1.butType.superview bringSubviewToFront:cell.image1.butType];
//            }
            
        }else{
            if ([cell.image1.aImageView.subviews containsObject:wmPlayer]) {
                [cell.image1.aImageView addSubview:wmPlayer];
                
                [wmPlayer play];
                wmPlayer.hidden = NO;
            }
            
        }
    }
    
    return cell;
    
}
#pragma mark -- VoiceTableViewCellDelegate

- (void)voicePlayerWithIndexPath:(UIButton *)sends{
    
    NSLog(@"%ld----indexPath",sends.tag);
    
    currentIndexPath = [NSIndexPath indexPathForRow:sends.tag inSection:0];
    NSLog(@"currentIndexPath.row = %ld",currentIndexPath.row);
    
    UIView *cellView = [sends superview];
    while (![cellView isKindOfClass:[UITableViewCell class]])
    {
        cellView =  [cellView superview];
        NSLog(@"0000");
    }
    self.currentCell = (VoiceTableViewCell *)cellView;
    
    EssenceModelF *model = [self.data objectAtIndex:sends.tag];
    
    if (wmPlayer) {
        [self releaseWMPlayer];
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.image1.aImageView.bounds];
        wmPlayer.delegate = self;
        //关闭音量调节的手势
        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        wmPlayer.URLString = model.mod.voiceuri;
        wmPlayer.titleLabel.text = model.mod.text;
        [wmPlayer.voiceImageView sd_setImageWithURL:[NSURL URLWithString:model.mod.image1] placeholderImage:[UIImage imageNamed:@""]];

        //        [wmPlayer play];
        NSLog(@"22222");
    }else{
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.image1.aImageView.bounds];
        wmPlayer.delegate = self;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        //关闭音量调节的手势
        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.titleLabel.text = model.mod.text;
        wmPlayer.URLString = model.mod.voiceuri;
        [wmPlayer.voiceImageView sd_setImageWithURL:[NSURL URLWithString:model.mod.image1] placeholderImage:[UIImage imageNamed:@""]];
        NSLog(@"33333");
    }
    NSLog(@"44444");
    [self.currentCell.image1.aImageView addSubview:wmPlayer];
    [self.currentCell.image1.aImageView bringSubviewToFront:wmPlayer];
    [self.currentCell.image1.butType.superview sendSubviewToBack:self.currentCell.image1.butType];
    [self.tableView reloadData];

    
}

/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    
    
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    
    [wmPlayer pause];
    
    
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    
    
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}

- (void)dealloc{
    
    NSLog(@"%@ deallo=======c",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
    
}

-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
    VoiceTableViewCell *currentCell = (VoiceTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.image1.butType.superview bringSubviewToFront:currentCell.image1.butType];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
}
///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"didClickedCloseButton");
    VoiceTableViewCell *currentCell = (VoiceTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.image1.butType.superview bringSubviewToFront:currentCell.image1.butType];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
    
}
@end
