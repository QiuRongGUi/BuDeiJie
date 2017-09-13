//
//  TopicTableViewCell.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "UIImage+Extensions.h"

#import "TopicTableViewCell.h"

#import "EssenceModel.h"
#import "EssenceModelF.h"
#import "EssenceBottonView.h"

@interface TopicTableViewCell (){
    
}

@property (nonatomic,strong) UIImageView * profile_image;

@property (nonatomic,strong) UILabel * created_at,* screen_name,* text ;

@property (nonatomic,strong) EssenceBottonView * bottomView;

@end

@implementation TopicTableViewCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 10;

    [super setFrame:frame];
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.profile_image = imageView;
        
        UILabel *al1 = [[UILabel alloc] init];
        al1.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:al1];
        self.screen_name = al1;
        
        
        UILabel *al2 = [[UILabel alloc] init];
        al2.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:al2];
        self.created_at = al2;
        
        UILabel *al3 = [[UILabel alloc] init];
        al3.numberOfLines = 0;
        al3.font = [UIFont systemFontOfSize:15];
        al3.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:al3];
        self.text = al3;
        
        
        
        EssenceBottonView *eView = [[EssenceBottonView alloc] init];
        [self.contentView addSubview:eView];
        self.bottomView = eView;
        
    }
    return self;
}

- (void)setModF:(EssenceModelF *)modF{
    
    _modF = modF;
    
//    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:modF.mod.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:modF.mod.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(! image) return ; // 判断图片加载失败处理
        
        UIImage *aImage = [UIImage imageWithRadiusImage:image];
        
        self.profile_image.image = aImage;
    }];
    
    self.created_at.text = modF.mod.created_at;
    self.screen_name.text = modF.mod.screen_name;
    self.text.text = modF.mod.text;
    
    [self.bottomView.dingBut setTitle:modF.mod.ding forState:UIControlStateNormal];
    [self.bottomView.hateBut setTitle:modF.mod.hate forState:UIControlStateNormal];
    [self.bottomView.repostBut setTitle:modF.mod.repost forState:UIControlStateNormal];
    [self.bottomView.commentBut setTitle:modF.mod.comment forState:UIControlStateNormal];
    
    self.profile_image.frame = modF.profile_imageF;
    self.screen_name.frame = modF.screen_nameF;
    self.created_at.frame = modF.created_atF;
    self.text.frame = modF.textF;
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bottomView.frame = CGRectMake(0, self.contentView.height - 45, kScreenWidth, 45);

}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
