//
//  PictureTableViewCell.m
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//
#import "PictureTableViewCell.h"

#import "EssenceModelF.h"

#import "EssenceModel.h"

#import "PictureBottomView.h"

@interface PictureTableViewCell ()

/** <#class#>*/
@property(nonatomic,strong) UIImageView  *image1;

/** <#class#>*/
@property(nonatomic,strong) PictureBottomView  *bottom;

/** <#class#>*/
@property(nonatomic,strong) UIImageView  *gif;

@end

@implementation PictureTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        
        UIImageView *aImageView = [[UIImageView alloc] init];
        aImageView.backgroundColor = kRandomColor;
        aImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:aImageView];
        self.image1 = aImageView;
        
        PictureBottomView *view = [PictureBottomView createPictureBottomView];
        [self addSubview:view];
        self.bottom = view;

        UIImageView *bImageView = [[UIImageView alloc] init];
        bImageView.backgroundColor = [UIColor redColor];
        bImageView.image = [UIImage imageNamed:@"common-gif"];
        [self.contentView addSubview:bImageView];
        self.gif = bImageView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clikePictureView:)];
        [self.image1 addGestureRecognizer:tap];

    }
    return self;
}


- (void)setModf:(EssenceModelF *)modf{
    
    [super setModF:modf];
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:modf.mod.image1] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

    self.bottom.hidden = [modf.mod.is_gif intValue];
    self.gif.hidden = ![modf.mod.is_gif intValue];

}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat h =  [self.modF.mod.height doubleValue] / [self.modF.mod.width doubleValue] * (kScreenWidth - Margen * 2);
    
    self.image1.contentMode = UIViewContentModeScaleAspectFill;
    self.image1.clipsToBounds = YES;

    
    if(h >= kScreenHeight){
        
        h = 200;
        self.image1.contentMode = UIViewContentModeTop;
        self.image1.clipsToBounds = YES;

    }
    
    self.image1.X = Margen;
    self.image1.Y = CGRectGetMaxY(self.modF.textF) + Margen;
    self.image1.width = kScreenWidth - Margen * 2;
    self.image1.height = h;
    
    
    self.bottom.frame = CGRectMake(Margen, CGRectGetMaxY(self.image1.frame) - 43, self.image1.width, 43);

    self.gif.frame = CGRectMake(Margen, CGRectGetMaxY(self.modF.textF) + Margen, 30, 30);

}
- (void)clikePictureView:(UITapGestureRecognizer *)sends{
    
    NSLog(@"查看大图");
    
    if([self.delegate respondsToSelector:@selector(PictureTableViewCellClikePictureWithIndexPath:)]){
        
        [self.delegate PictureTableViewCellClikePictureWithIndexPath:self.indexPath];
    }
}

@end
