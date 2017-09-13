//
//  TopTitleView.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "TopTitleView.h"

@interface TopTitleView (){
    
    UIButton *currentBut;
    
}

@property (nonatomic,strong) UIView * lineView;

@property (nonatomic,strong) UIView * titleView;

@end

@implementation TopTitleView

-(UIView *)titleView
{
    if (!_titleView) {
        
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _titleView.frame = CGRectMake(0, 0, kScreenWidth, 40);
      
    }
    return _titleView;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
        _lineView.height = 1;
        _lineView.Y = 40;

    }
    return _lineView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = BaseColor;
        
        
        [self addSubview:self.titleView];
        
        [self addSubview:self.lineView];
        
//        self.selectedIndex = 0;

    }
    return self;
}

- (void)setTopTtileData:(NSArray *)topTtileData{
    
    _topTtileData = topTtileData;
    
   CGFloat w = kScreenWidth / topTtileData.count;

  [topTtileData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      
      UIButton *but = [QRGUIKit buttonWithframe:CGRectMake(w * idx, 0, w , 40) aTag:0 addTarget:self action:@selector(clike:) aTitleColor:kRGBColor(129, 121, 118) aImage:nil aHighlightedImage:nil aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:obj];
      but.tag = idx;
      [but setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
      
      [self.titleView addSubview:but];
      
      if(idx == 0){
          
          [but.titleLabel sizeToFit];
          [self clike:but];
      }
      
//      NSInteger Index = self.selectedIndex ? self.selectedIndex : 0;
      
//      UIButton *but = self.titleView.subviews[selectedIndex];
      

  }];
    
    
   }

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    _selectedIndex = selectedIndex;
    
//    NSInteger Index = self.selectedIndex ? self.selectedIndex : 0;
    
    UIButton *but = self.titleView.subviews[selectedIndex];
    [but.titleLabel sizeToFit];
    [self clike:but];
    

}
- (void)clike:(UIButton *)sends{
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGPoint point = [self convertPoint:sends.center fromView:sends.superview];
        
        currentBut.selected = NO;
        currentBut.transform = CGAffineTransformIdentity;
        currentBut = sends;
        sends.selected = YES;
        
        self.lineView.width = sends.titleLabel.width + 10;
        self.lineView.centerX = point.x;
        
        sends.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    if([self.delegate respondsToSelector:@selector(TopTitleViewClikeTitleWithIndexPath:)]){
        
        [self.delegate TopTitleViewClikeTitleWithIndexPath:sends.tag];
    }
    
    
}


//
//- (void)layoutSubviews{
//    
//    [super layoutSubviews];
//    
//    NSLog(@"%@---",self.titleView.subviews);
//    
//    self.titleView.frame = CGRectMake(0, 0, self.width, self.height - 10);
//    
//        
////    CGFloat w = self.width / self.topTtileData.count;
////    
////    __block int index = 0;
////
////    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////       
////        obj.X = index * w;
////        obj.Y = 0;
////        obj.width = w;
////        obj.height = self.height - 10;
////
////        index ++ ;
////
////        NSLog(@"%d---index",index);
////    }];
//
//    
////    for (UIButton *obj in self.titleView.subviews) {
////        
////        obj.X = index * w;
////        obj.Y = 0;
////        obj.width = w;
////        obj.height = self.height - 10;
////
////        index ++ ;
////
////          NSLog(@"%d---index",index);
////    }
//    
//    self.lineView.height = 1;
//    self.lineView.Y = self.height - 2;
//    
//    
//}


@end
