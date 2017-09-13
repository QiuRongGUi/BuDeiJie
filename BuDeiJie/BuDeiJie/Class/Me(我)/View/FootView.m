//
//  FootView.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//
#import "QRG.pch"

#import "FootView.h"

#import "FootContentCollectionViewCell.h"

static NSString *Cell = @"cellId";

@interface FootView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    NSInteger dataCound;
    
}

@property (nonatomic,strong) UICollectionView * coll;

@end


@implementation FootView



- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        
        
        
        self.backgroundColor = [UIColor redColor];
        
        
        
        
    }
    
    return self;
}

- (void)CreateUI{
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, dataCound * kScreenWidth / 4) collectionViewLayout:flow];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    
    self.coll = collectionView;
    
//    [self.coll registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.coll registerNib:[UINib nibWithNibName:@"FootContentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:Cell];
    
    
    self.height = CGRectGetMaxY(self.coll.frame);
    
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat w = kScreenWidth / 4;
    
    return CGSizeMake(w, w);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.data.count;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FootContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell forIndexPath:indexPath];
    
    cell.mod = self.data[indexPath.item];
    
    return cell;
}



- (void)setData:(NSArray *)data{
    
    _data = data;
    
    if(data.count % 4 == 0){
        
        dataCound = data.count /4;
        
    }else{
        
        dataCound = data.count /4 + 1;
        
    }
    
    [self CreateUI];
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld----size",indexPath.item);
    
    
    
}

@end;

