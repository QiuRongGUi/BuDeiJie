//
//  VideoTableViewController.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "KrVideoPlayerController.h"

#import "VideoViewController.h"

#import "VideoTableViewController.h"

#import "VoiceTableViewCell.h"

#import "EssenceModelF.h"

#import "EssenceModel.h"

//#import "KrVideoPlayerController.h"  // 视频

static NSString  * const VideoTableViewControllerId = @"VideoTableViewController";

@interface VideoTableViewController ()<VoiceTableViewCellDelegate>{
    
    EssenceModelF *currentModf; // 上次选中 voice
}
/**视频**/
@property (nonatomic, strong) KrVideoPlayerController  *videoController;


@property (nonatomic,strong) NSMutableArray * data;

/**第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。**/
@property (nonatomic,copy) NSString * maxtime;

///**视频**/
//@property (nonatomic, strong) KrVideoPlayerController  *kRvideo;

@end

@implementation VideoTableViewController

-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

//-(KrVideoPlayerController *)kRvideo
//{
//    if (!_kRvideo) {
//        _kRvideo = [[KrVideoPlayerController alloc] init];
//        __weak typeof(self)weakSelf = self;
//        [_kRvideo setDimissCompleteBlock:^{
//            _kRvideo = nil;
//        }];
//        [_kRvideo setWillBackOrientationPortrait:^{
//            [weakSelf toolbarHidden:NO];
//        }];
//        [_kRvideo setWillChangeToFullscreenMode:^{
//            [weakSelf toolbarHidden:YES];
//        }];
//        
//        _kRvideo.view.backgroundColor = [UIColor redColor];
//        
//        [self.tableView addSubview:_kRvideo.view];
//        
////        [self addSubview:self.kRvideo.view];
////        [_kRvideo showInWindow];
//
//    }
//    return _kRvideo;
//}
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
    dic[@"type"] = @"41";
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
    dic[@"type"] = @"41";
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
    
    
    VoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoTableViewControllerId];
    
    if(!cell){
        
        cell = [[VoiceTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VideoTableViewControllerId];
    }
    
    cell.delegate = self;
    
    EssenceModelF *modF = self.data[indexPath.row];
    
    cell.modf = modF;
    
    cell.indexPath = indexPath.row;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    EssenceModelF *modf = self.data[indexPath.row];
    
    
    NSLog(@"%@---modf.mod.videouri",modf.mod.videouri);
    
    VideoViewController *video= [[VideoViewController alloc] init];
    video.str = modf.mod.videouri;
    [self.navigationController pushViewController:video animated:YES];
    
}
#pragma mark -- VoiceTableViewCellDelegate

- (void)videoPlayerWithIndexPath:(NSInteger)aIndexPath tableViewCell:(VoiceTableViewCell *)cell
{
    
   
//    
//
//    if(currentModf){
//        
//        if(currentModf == modf){
//            
//        }else{
//            currentModf.mod.playerState = NO;
//        }
//    }
//    
//    if(modf.mod.playerState){
//        
//        NSLog(@"1111");
//        
//    }else{
//        
//        
//        NSLog(@"0000");
//        
//        
////        
//        NSIndexPath *path = [NSIndexPath indexPathForRow:aIndexPath inSection:0];
////
//        VoiceTableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:path];
//
//        cell.kRVideo.view.hidden = NO;
//        cell.image1.hidden = YES;
//
//        cell.kRVideo.contentURL = [NSURL URLWithString:modf.mod.videouri];
//
////        cell.image1.alpha = 0.1;
////
////        [cell insertSubview:cell.kRVideo.view aboveSubview:cell.image1];
//        
//    }
//    modf.mod.playerState = ! modf.mod.playerState;
//    
//    currentModf = modf;
//    
//    [self.tableView reloadData];
    
    
    
//    NSLog(@"%@---",NSStringFromCGRect(cell.image1.frame));
    
//    CGRect rect = [self.tableView  convertRect:cell.image1.frame fromView:cell];
//
//    NSLog(@"%@---rect",NSStringFromCGRect(rect));

//    self.kRvideo.view.frame = cell.image1.frame;
//    
//    self.kRvideo.contentURL = [NSURL URLWithString:modf.mod.videouri];
    

//    CGRect rect = [self.view.superview convertRect:cell.frame fromView:cell];
    
    

//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//    for (UIView *aView in window.subviews) {
//        
//        if([aView isKindOfClass:NSClassFromString(@"MPMovieView")]){
//            
//            [aView removeFromSuperview];
//        }
//    }
    
    EssenceModelF *modf = self.data[aIndexPath];


//    CGRect rect = [window convertRect:cell.image1.frame fromView:cell];
//
//    NSLog(@"%@----rect",NSStringFromCGRect(rect));
//    
    
//    UIView *aView = [UIView new];
//    aView.frame = rect;
//    aView.backgroundColor = [UIColor redColor];
//    [window addSubview:aView];
    
    [self.videoController dismiss];
    
    self.videoController = [[KrVideoPlayerController alloc] initWithFrame:cell.image1.bounds];
    
    self.videoController.view.backgroundColor = [UIColor redColor];
    [self addVideoPlayerWithURL:[NSURL URLWithString:modf.mod.videouri]];

    [cell.image1 addSubview:self.videoController.view];
    
    [cell bringSubviewToFront:self.videoController.view];

    NSLog(@"%@----bounds",NSStringFromCGRect(cell.image1.bounds));
    
 
   
}


- (void)addVideoPlayerWithURL:(NSURL *)url{
    
//    if (!self.videoController) {
//        self.videoController = [[KrVideoPlayerController alloc] init];
//        __weak typeof(self)weakSelf = self;
//        [self.videoController setDimissCompleteBlock:^{
//            weakSelf.videoController = nil;
//        }];
//        [self.videoController setWillBackOrientationPortrait:^{
//            [weakSelf toolbarHidden:NO];
//        }];
//        [self.videoController setWillChangeToFullscreenMode:^{
//            [weakSelf toolbarHidden:YES];
//        }];
//        //        [self addSubview:self.videoController.view];
//        
//        [self.videoController showInWindow];
//        
//    }
    
//    self.videoController = [[KrVideoPlayerController alloc] init];
    
    __weak typeof(self)weakSelf = self;
    [self.videoController setDimissCompleteBlock:^{
        weakSelf.videoController = nil;
    }];
    [self.videoController setWillBackOrientationPortrait:^{
        [weakSelf toolbarHidden:NO];
    }];
    [self.videoController setWillChangeToFullscreenMode:^{
        [weakSelf toolbarHidden:YES];
    }];
    
    
//    [self.videoController showInWindow];
    

    self.videoController.contentURL = url;
    
}

////隐藏navigation tabbar 电池栏
//- (void)toolbarHidden:(BOOL)Bool{
//    
////    if([self.delegate respondsToSelector:@selector(VideoHeaderViewPlayChangeWidthState:)]){
////        [self.delegate VideoHeaderViewPlayChangeWidthState:Bool];
////    }
//}

- (void)toolbarHidden:(BOOL)state{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"%f---contentOffset",scrollView.contentOffset.y);
    
}
@end
