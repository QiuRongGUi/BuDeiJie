//
//  EssenceBottonView.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "EssenceBottonView.h"

@interface EssenceBottonView()
@property (nonatomic,strong) UIImageView * line;
@end

@implementation EssenceBottonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
//    
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-content-line"]];
//        
//        self.image = [UIImage imageNamed:@"cell-content-line"];
//        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line"]];
        
        self.line = imageView;
        [self addSubview:self.line];
        
        self.dingBut = [QRGUIKit buttonWithframe:CGRectZero aTag:1 addTarget:self action:@selector(clikeBottom:) aTitleColor:BaseColor aImage:@"mainCellDing" aHighlightedImage:@"mainCellDingClick" aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:@"1"];
        
        self.hateBut = [QRGUIKit buttonWithframe:CGRectZero aTag:2 addTarget:self action:@selector(clikeBottom:) aTitleColor:BaseColor aImage:@"mainCellCai" aHighlightedImage:@"mainCellCaiClick" aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:@"1"];
        

        self.repostBut = [QRGUIKit buttonWithframe:CGRectZero aTag:3 addTarget:self action:@selector(clikeBottom:) aTitleColor:BaseColor aImage:@"mainCellShare" aHighlightedImage:@"mainCellShareClick" aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:@"1"];
        

        self.commentBut = [QRGUIKit buttonWithframe:CGRectZero aTag:4 addTarget:self action:@selector(clikeBottom:) aTitleColor:BaseColor aImage:@"mainCellComment" aHighlightedImage:@"mainCellCommentClick" aSelectedImage:nil aBackgroundImage:nil aFontOfSize:15 aTitle:@"1"];
        
        
        
        [self addSubview:self.dingBut];
        [self addSubview:self.hateBut];
        [self addSubview:self.repostBut];
        [self addSubview:self.commentBut];
        
        CGFloat w = kScreenWidth / 4;
        
        for(int i = 1;i<4 ;i++){
            
            UIImageView *buttonline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-button-line"]];
            buttonline.contentMode = UIViewContentModeCenter;
            buttonline.X = i * w;
            buttonline.Y = 0;
            buttonline.height = 44;
            buttonline.width = 1;
            [self addSubview:buttonline];
            
        }
        
    }
    
    return self;
}

- (void)clikeBottom:(UIButton *)sends{
    
    switch (sends.tag) {
        case 1:
            NSLog(@"顶 -- ");
            break;
            
        case 2:
            NSLog(@"踩 --");
            break;

        case 3:
            NSLog(@"转发 -- ");
            break;

        case 4:
            NSLog(@"评论 -- ");
            break;

        default:
            break;
    }
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat w = kScreenWidth / 4;
    
    self.line.frame = CGRectMake(0, 0, self.width, 1);
    self.dingBut.frame = CGRectMake(w * 0, 1, w, self.height);
    self.hateBut.frame = CGRectMake(w * 1, 1, w, self.height);
    self.repostBut.frame = CGRectMake(w * 2, 1, w, self.height);
    self.commentBut.frame = CGRectMake(w * 3, 1, w, self.height);
}
@end
